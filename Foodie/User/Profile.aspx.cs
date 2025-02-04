using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Foodie.User
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadUserProfile();
            }
        }

        private void LoadUserProfile()
        {
            string connString = ConfigurationManager.ConnectionStrings["cs"]?.ConnectionString;

            using (SqlConnection con = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("User_Crud", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Action", "SELECT4PROFILE");
                    cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);

                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        lblName.Text = reader["Name"].ToString();
                        lblUsername.Text = reader["Username"].ToString();
                        lblEmail.Text = reader["Email"].ToString();
                        lblMobile.Text = reader["Mobile"].ToString();
                        lblAddress.Text = reader["Address"].ToString();
                        lblPostCode.Text = reader["PosteCode"].ToString();
                        lblCreatedDate.Text = Convert.ToDateTime(reader["CreatedDate"]).ToString("dd MMM yyyy");

                        string imageUrl = string.IsNullOrEmpty(reader["ImageUrl"].ToString())
                                          ? "~/Images/default-profile.png"
                                          : reader["ImageUrl"].ToString();
                        imgProfile.ImageUrl = imageUrl;
                    }
                    con.Close();
                }
            }
        }
    }
}
