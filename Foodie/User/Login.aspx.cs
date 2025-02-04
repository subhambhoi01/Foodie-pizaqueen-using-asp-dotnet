using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Foodie.User
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] != null)
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            
            if (username == "Admin" && password == "123")
            {
                Session["admin"] = username;
                Response.Redirect("../Admin/Dashboard.aspx");
            }
            else
            {
                string connString = ConfigurationManager.ConnectionStrings["cs"]?.ConnectionString; // FIXED

                if (string.IsNullOrEmpty(connString))
                {
                    lblMsg.Text = "Database connection error!";
                    lblMsg.CssClass = "alert alert-danger";
                    return;
                }

                using (SqlConnection con = new SqlConnection(connString))
                {
                    using (SqlCommand cmd = new SqlCommand("User_Crud", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Action", "SELECT4LOGIN");
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@Password", password);

                        SqlDataAdapter sda = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            Session["UserId"] = dt.Rows[0]["UserId"].ToString();
                            Session["Username"] = dt.Rows[0]["Username"].ToString();
                            Response.Redirect("Default.aspx");
                        }
                        else
                        {
                            lblMsg.Text = "Invalid Username or Password!";
                            lblMsg.CssClass = "alert alert-danger";
                        }
                    }
                }
            }
        }
    }
}
