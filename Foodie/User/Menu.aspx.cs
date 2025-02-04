using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace Foodie.User
{
    public partial class Menu : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["FoodieDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProducts();
            }
        }

        private void LoadProducts(string category = "All")
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT p.ProductsId, p.Name, p.Description, p.Price, p.ImageUrl, c.CategoryName FROM Products p INNER JOIN Category c ON p.CategoryId = c.CategoryId";
                if (category != "All")
                {
                    query += " WHERE c.CategoryName = @Category";
                }
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    if (category != "All")
                    {
                        cmd.Parameters.AddWithValue("@Category", category);
                    }
                    con.Open();
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    rptProducts.DataSource = dt;
                    rptProducts.DataBind();
                }
            }
        }

        protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "addToCart")
            {
                int productId = Convert.ToInt32(e.CommandArgument);
                AddToCart(productId);
            }
        }

        private void AddToCart(int productId)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);
            using (SqlConnection con = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand("INSERT INTO Carts (UserId, ProductsId, Quantity) VALUES (@UserId, @ProductsId, 1)", con))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@ProductsId", productId);
                    
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        protected void FilterCategory_Click(object sender, EventArgs e)
        {
            string category = (sender as LinkButton).CommandArgument;
            LoadProducts(category);
        }
    }
}
