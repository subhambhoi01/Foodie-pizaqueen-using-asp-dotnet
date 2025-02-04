using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Foodie.Admin
{
    public partial class Product : Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["breadCrum"] = "Product";
                if (Session["admin"] == null)
                {
                    Response.Redirect("../User/Login.aspx");
                }
                else
                {
                    getProducts();
                }
            }
            lblMsg.Visible = false;
        }

        protected void btnAddOrUpdate_Click(object sender, EventArgs e)
        {
            string imagePath = string.Empty, fileExtension = string.Empty;
            int productId = Convert.ToInt32(hdnId.Value);

            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Product_Crud", con)
            {
                CommandType = CommandType.StoredProcedure
            };

            string action = productId == 0 ? "INSERT" : "UPDATE";
            cmd.Parameters.AddWithValue("@Action", action);
            cmd.Parameters.AddWithValue("@ProductsId", productId);
            cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
            cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
            cmd.Parameters.AddWithValue("@Price", txtPrice.Text.Trim());
            cmd.Parameters.AddWithValue("@Quantity", txtQuantity.Text.Trim());
            cmd.Parameters.AddWithValue("@CategoryId", ddlCategory.SelectedValue);
            cmd.Parameters.AddWithValue("@IsActive", cbIsActive.Checked);

            // Image Upload Handling
            string uploadFolderPath = Server.MapPath("~/Images/Product/");
            if (!Directory.Exists(uploadFolderPath))
            {
                Directory.CreateDirectory(uploadFolderPath);
            }

            if (fuProductImage.HasFile)
            {
                string[] validExtensions = { ".jpg", ".jpeg", ".png", ".gif" };
                fileExtension = Path.GetExtension(fuProductImage.FileName).ToLower();

                if (Array.Exists(validExtensions, ext => ext == fileExtension))
                {
                    imagePath = "~/Images/Product/" + Guid.NewGuid().ToString() + fileExtension;
                    fuProductImage.SaveAs(Server.MapPath(imagePath));
                    cmd.Parameters.AddWithValue("@ImageUrl", imagePath);
                }
                else
                {
                    lblMsg.Text = "Invalid image format. Only .jpg, .jpeg, .png, .gif are allowed.";
                    lblMsg.Visible = true;
                    return;
                }
            }
            else
            {
                cmd.Parameters.AddWithValue("@ImageUrl", imgProduct.ImageUrl ?? (object)DBNull.Value);
            }

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                lblMsg.Text = productId == 0 ? "Product added successfully!" : "Product updated successfully!";
                lblMsg.Visible = true;
                getProducts();
                btnClear_Click(sender, e);
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Error: " + ex.Message;
                lblMsg.Visible = true;
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtName.Text = "";
            txtDescription.Text = "";
            txtPrice.Text = "";
            txtQuantity.Text = "";
            ddlCategory.SelectedIndex = 0;
            cbIsActive.Checked = false;
            hdnId.Value = "0";
            imgProduct.Visible = false;
            imgProduct.ImageUrl = "";
        }

        private void getProducts()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            sda = new SqlDataAdapter("SELECT * FROM Products", con);
            dt = new DataTable();
            sda.Fill(dt);
            rProduct.DataSource = dt;
            rProduct.DataBind();
        }

        protected void rProduct_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int productId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Edit")
            {
                con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("SELECT * FROM Products WHERE ProductsId = @ProductsId", con);
                cmd.Parameters.AddWithValue("@ProductsId", productId);
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    hdnId.Value = row["ProductsId"].ToString();
                    txtName.Text = row["Name"].ToString();
                    txtDescription.Text = row["Description"].ToString();
                    txtPrice.Text = row["Price"].ToString();
                    txtQuantity.Text = row["Quantity"].ToString();
                    ddlCategory.SelectedValue = row["CategoryId"].ToString();
                    cbIsActive.Checked = Convert.ToBoolean(row["IsActive"]);

                    imgProduct.ImageUrl = row["ImageUrl"]?.ToString();
                    imgProduct.Visible = !string.IsNullOrEmpty(imgProduct.ImageUrl);
                }
            }
            else if (e.CommandName == "Delete")
            {
                con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("DELETE FROM Products WHERE ProductsId = @ProductsId", con);
                cmd.Parameters.AddWithValue("@ProductsId", productId);

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    getProducts();
                    lblMsg.Text = "Product deleted successfully!";
                    lblMsg.Visible = true;
                }
                catch (Exception ex)
                {
                    lblMsg.Text = "Error: " + ex.Message;
                    lblMsg.Visible = true;
                }
            }
        }
    }
}
