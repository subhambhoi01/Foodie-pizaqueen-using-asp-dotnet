using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Foodie.User
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    LoadCartItems();
                }
            }
        }

        private void LoadCartItems()
        {
            string connString = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("Cart_Crud", con))
                {
                    cmd.Parameters.AddWithValue("@Action", "GET");
                    cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    rptCartItems.DataSource = dt;
                    rptCartItems.DataBind();

                    
                    decimal grandTotal = 0;
                    foreach (DataRow row in dt.Rows)
                    {
                        grandTotal += Convert.ToDecimal(row["TotalPrice"]);
                    }
                    lblGrandTotal.Text = grandTotal.ToString("F2");
                }
            }
        }

        protected void btnRemove_Click(object sender, EventArgs e)
        {
            Button btnRemove = (Button)sender;
            int cartId = Convert.ToInt32(btnRemove.CommandArgument);

            string connString = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("Cart_Crud", con))
                {
                    cmd.Parameters.AddWithValue("@Action", "DELETE");
                    cmd.Parameters.AddWithValue("@CartId", cartId);
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

            
            LoadCartItems();
        }

        protected void btnUpdateCart_Click(object sender, EventArgs e)
        {
            foreach (RepeaterItem item in rptCartItems.Items)
            {
                HiddenField hfCartId = (HiddenField)item.FindControl("hfCartId");
                TextBox txtQuantity = (TextBox)item.FindControl("txtQuantity");

                if (hfCartId != null && txtQuantity != null)
                {
                    int cartId = Convert.ToInt32(hfCartId.Value);
                    int newQuantity = Convert.ToInt32(txtQuantity.Text);

                    string connString = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
                    using (SqlConnection con = new SqlConnection(connString))
                    {
                        using (SqlCommand cmd = new SqlCommand("Cart_Crud", con))
                        {
                            cmd.Parameters.AddWithValue("@Action", "UPDATE");
                            cmd.Parameters.AddWithValue("@CartId", cartId);
                            cmd.Parameters.AddWithValue("@Quantity", newQuantity);
                            cmd.CommandType = CommandType.StoredProcedure;
                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                        }
                    }
                }
            }

            
            LoadCartItems();
        }

        protected void btnContinueShopping_Click(object sender, EventArgs e)
        {
            Response.Redirect("Menu.aspx");
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            Session["grandTotalPrice"] = lblGrandTotal.Text;
            Response.Redirect("Payment.aspx");
        }
    }
}
