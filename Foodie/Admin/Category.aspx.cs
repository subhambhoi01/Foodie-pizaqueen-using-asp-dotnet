using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

namespace Foodie.Admin
{
    public partial class Category : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                Session["breadCrum"] = "Category";
                getCategories();
            }
            lblMsg.Visible = false;
        }

        protected void btnAddOrUpdate_Click(object sender, EventArgs e)
        {
            string imagePath = string.Empty, fileExtension = string.Empty;
            bool isValidToExecute = false;

            int categoryId = Convert.ToInt32(hdnId.Value);

            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Category_Crud", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            string action = categoryId == 0 ? "INSERT" : "UPDATE";
            cmd.Parameters.AddWithValue("@Action", action);
            cmd.Parameters.AddWithValue("@CategoryId", categoryId);
            cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
            cmd.Parameters.AddWithValue("@IsActive", cbIsActive.Checked);

            if (fuCategoryImage.HasFile)
            {
                if (Utils.IsValidExtension(fuCategoryImage.FileName)) // Validate file extension
                {
                    try
                    {
                        // Generate unique file name
                        Guid obj = Guid.NewGuid();
                        fileExtension = Path.GetExtension(fuCategoryImage.FileName);
                        imagePath = "Images/Category/" + obj.ToString() + fileExtension;

                        // Ensure the directory exists
                        string folderPath = Server.MapPath("~/Images/Category/");
                        if (!Directory.Exists(folderPath))
                        {
                            Directory.CreateDirectory(folderPath); // Create folder if it doesn't exist
                        }

                        // Save the file to the server
                        string fullPath = Path.Combine(folderPath, obj.ToString() + fileExtension);
                        fuCategoryImage.PostedFile.SaveAs(fullPath);

                        // Save relative path to database
                        cmd.Parameters.AddWithValue("@ImageUrl", imagePath);
                        isValidToExecute = true;
                    }
                    catch (Exception ex)
                    {
                        lblMsg.Visible = true;
                        lblMsg.Text = "Error while uploading the file: " + ex.Message;
                        lblMsg.CssClass = "alert alert-danger";
                        isValidToExecute = false;
                    }
                }
                else
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Please select a valid image file (.jpg, .jpeg, .png).";
                    lblMsg.CssClass = "alert alert-danger";
                    isValidToExecute = false;
                }
            }
            else
            {
                isValidToExecute = true; // If no file is uploaded, continue with other parameters
            }


            if (isValidToExecute)
            {
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();

                    lblMsg.Visible = true;
                    lblMsg.Text = categoryId == 0 ? "Category added successfully." : "Category updated successfully.";
                    lblMsg.CssClass = "alert alert-success";
                    getCategories();
                    clear();
                }
                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "An error occurred: " + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";
                }
                finally
                {
                    con.Close();
                }
            }
        }

        private void getCategories()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Category_Crud", con)
            {
                CommandType = CommandType.StoredProcedure
            };
            cmd.Parameters.AddWithValue("@Action", "SELECT");

            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);

            // Debugging code to log ImageUrl for each row
            foreach (DataRow row in dt.Rows)
            {
                System.Diagnostics.Debug.WriteLine("ImageUrl: " + row["ImageUrl"]);
            }

            if (dt.Rows.Count > 0)
            {
                rCategory.DataSource = dt;
                rCategory.DataBind();
            }
            else
            {
                rCategory.DataSource = null;
                rCategory.DataBind();
            }
        }





        private void clear()
        {
            txtName.Text = string.Empty;
            cbIsActive.Checked = false;
            hdnId.Value = "0";
            imgCategory.ImageUrl = string.Empty;
            btnAddOrUpdate.Text = "Add";
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            clear();
        }
    }
}
