using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace Foodie.User
{
    public partial class Payment : System.Web.UI.Page
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
                    int userId = Convert.ToInt32(Session["UserId"]);
                    LoadUserProfile(userId);
                }
            }
        }

        private void LoadUserProfile(int userId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand("SELECT Name, Mobile, Address FROM Users WHERE UserId = @UserId", conn);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        txtName.Text = reader["Name"].ToString();
                        txtAddress.Text = reader["Address"].ToString();
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("Error: " + ex.Message);
                }
            }
        }

        protected void lbCardSubmit_Click(object sender, EventArgs e)
        {
            ProcessOrder("Credit Card");
        }

        protected void lbCodSubmit_Click(object sender, EventArgs e)
        {
            ProcessOrder("Cash On Delivery");
        }

        private void ProcessOrder(string paymentMethod)
        {
            string connStr = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();

                    
                    SqlCommand paymentCmd = new SqlCommand("SELECT PaymentId FROM dbo.Payment WHERE PaymentMode = @PaymentMode", conn);
                    paymentCmd.Parameters.AddWithValue("@PaymentMode", paymentMethod);

                    object result = paymentCmd.ExecuteScalar();

                    if (result == null || Convert.IsDBNull(result))
                    {
                        
                        Response.Write("Error: No PaymentId found for PaymentMode: " + paymentMethod);
                        return;
                    }

                    int paymentId = Convert.ToInt32(result);

                   
                    string orderNo = "ORD" + DateTime.Now.Ticks.ToString();

                    
                    SqlCommand cmd = new SqlCommand("sp_AddOrder", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@OrderNo", orderNo);
                    cmd.Parameters.AddWithValue("@UserId", Convert.ToInt32(Session["UserId"]));
                    cmd.Parameters.AddWithValue("@Status", "Pending");
                    cmd.Parameters.AddWithValue("@PaymentId", paymentId);
                    cmd.Parameters.AddWithValue("@OrderDate", DateTime.Now);

                    int orderId = Convert.ToInt32(cmd.ExecuteScalar()); // Get new OrderId

                    
                    SqlCommand cartCmd = new SqlCommand("SELECT ProductsId, Quantity FROM Carts WHERE UserId = @UserId", conn);
                    cartCmd.Parameters.AddWithValue("@UserId", Convert.ToInt32(Session["UserId"]));

                    SqlDataReader reader = cartCmd.ExecuteReader();
                    while (reader.Read())
                    {
                        int productId = Convert.ToInt32(reader["ProductsId"]);
                        int quantity = Convert.ToInt32(reader["Quantity"]);

                        
                        SqlCommand orderDetailCmd = new SqlCommand("sp_AddOrderDetails", conn);
                        orderDetailCmd.CommandType = CommandType.StoredProcedure;

                        orderDetailCmd.Parameters.AddWithValue("@OrderNo", orderNo);
                        orderDetailCmd.Parameters.AddWithValue("@ProductsId", productId);
                        orderDetailCmd.Parameters.AddWithValue("@Quantity", quantity);
                        orderDetailCmd.Parameters.AddWithValue("@UserId", Convert.ToInt32(Session["UserId"]));
                        orderDetailCmd.Parameters.AddWithValue("@Status", "Pending");
                        orderDetailCmd.Parameters.AddWithValue("@PaymentId", paymentId);
                        orderDetailCmd.Parameters.AddWithValue("@OrderDate", DateTime.Now);

                        orderDetailCmd.ExecuteNonQuery();
                    }
                    reader.Close();

                    // Clear Cart after Order
                    SqlCommand clearCartCmd = new SqlCommand("DELETE FROM Carts WHERE UserId = @UserId", conn);
                    clearCartCmd.Parameters.AddWithValue("@UserId", Convert.ToInt32(Session["UserId"]));
                    clearCartCmd.ExecuteNonQuery();

                    
                    Response.Redirect("Invoice.aspx?OrderId=" + orderId);
                }
                catch (Exception ex)
                {
                    
                    Response.Write("Error: " + ex.Message);
                }
            }
        }
    }
}
