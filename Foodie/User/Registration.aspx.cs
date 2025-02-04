using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Foodie.User
{
    public partial class Registration : Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMsg.Visible = false;
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string name = txtName.Text.Trim();
                string username = txtUsername.Text.Trim();
                string email = txtEmail.Text.Trim();
                string mobile = txtMobile.Text.Trim();
                string address = txtAddress.Text.Trim();
                string zipCode = txtZipCode.Text.Trim();
                string password = txtPassword.Text.Trim();
                string profilePicPath = UploadProfilePicture();

                using (SqlConnection con = new SqlConnection(conStr))
                {
                    using (SqlCommand cmd = new SqlCommand("User_Crud", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Action", "INSERT"); 

                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Mobile", mobile);
                        cmd.Parameters.AddWithValue("@Address", address);
                        cmd.Parameters.AddWithValue("@PosteCode", zipCode);
                        cmd.Parameters.AddWithValue("@Password", password);
                        cmd.Parameters.AddWithValue("@ImageUrl", profilePicPath);

                        SqlParameter outputParam = new SqlParameter("@UserId", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.Add(outputParam);

                        try
                        {
                            con.Open();
                            cmd.ExecuteNonQuery();
                            int userId = Convert.ToInt32(outputParam.Value);

                            if (userId > 0)
                            {
                                lblMsg.Text = "Registration is successful! <b><a href='Login.aspx'>Click here</a></b> to login.";
                                lblMsg.CssClass = "alert alert-success";
                                lblMsg.Visible = true;
                                Response.AddHeader("REFRESH", "2; URL=Registration.aspx");
                                ClearFields();
                            }
                            else
                            {
                                lblMsg.Text = "Error occurred. Please try again.";
                                lblMsg.CssClass = "alert alert-danger";
                                lblMsg.Visible = true;
                            }
                        }
                        catch (SqlException ex)
                        {
                            
                            lblMsg.Text = "Database error: " + ex.Message;
                            lblMsg.CssClass = "alert alert-danger";
                            lblMsg.Visible = true;
                        }
                        catch (Exception ex)
                        {
                            
                            lblMsg.Text = "An unexpected error occurred: " + ex.Message;
                            lblMsg.CssClass = "alert alert-danger";
                            lblMsg.Visible = true;
                        }

                    }
                }
            }
        }

        private string UploadProfilePicture()
        {
            if (fuProfilePic.HasFile)
            {
                string fileExt = Path.GetExtension(fuProfilePic.FileName).ToLower();
                string[] allowedExt = { ".jpg", ".jpeg", ".png", ".gif" };
                if (Array.Exists(allowedExt, ext => ext == fileExt))
                {
                    string fileName = Guid.NewGuid() + fileExt;
                    string filePath = "~/Uploads/ProfilePictures/" + fileName;
                    fuProfilePic.SaveAs(Server.MapPath(filePath));
                    return filePath;
                }
                else
                {
                    lblMsg.Text = "Only .jpg, .jpeg, .png, .gif files are allowed!";
                    lblMsg.CssClass = "alert alert-warning";
                    lblMsg.Visible = true;
                }
            }
            return null;
        }

        private void ClearFields()
        {
            txtName.Text = "";
            txtUsername.Text = "";
            txtEmail.Text = "";
            txtMobile.Text = "";
            txtAddress.Text = "";
            txtZipCode.Text = "";
            txtPassword.Text = "";
        }

        // Custom validation for username uniqueness
        protected void CustomUsernameValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string username = txtUsername.Text.Trim();

            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Username = @Username", con))
                {
                    cmd.Parameters.AddWithValue("@Username", username);

                    con.Open();
                    int count = Convert.ToInt32(cmd.ExecuteScalar());
                    con.Close();

                    if (count > 0)
                    {
                        args.IsValid = false;
                    }
                    else
                    {
                        args.IsValid = true;
                    }
                }
            }
        }
    }
}
