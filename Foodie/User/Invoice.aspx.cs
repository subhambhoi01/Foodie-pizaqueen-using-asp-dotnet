using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Foodie.User
{
    public partial class Invoice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] == null)
                {
                    Response.Redirect("Login.aspx");
                }

                
                string orderId = Request.QueryString["OrderId"];
                if (string.IsNullOrEmpty(orderId))
                {
                    Response.Write("Error: OrderId not provided.");
                    return;
                }

                // Fetch Order Details
                LoadOrderDetails(orderId);
            }
        }

        private void LoadOrderDetails(string orderId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();

                   
                    string query = @"
                SELECT o.OrderNo, o.OrderDate, o.Status, 
                       SUM(od.Quantity * p.Price) AS TotalAmount
                FROM Orders o
                JOIN OrderDetails od ON o.OrderNo = od.OrderNo
                JOIN Products p ON od.ProductsId = p.ProductsId
                WHERE o.OrderNo = @OrderNo
                GROUP BY o.OrderNo, o.OrderDate, o.Status";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@OrderNo", orderId); // Ensure this is correct

                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        
                        hfOrderNo.Value = reader["OrderNo"].ToString();
                        hfOrderDate.Value = Convert.ToDateTime(reader["OrderDate"]).ToString("dd-MMM-yyyy");
                        hfStatus.Value = reader["Status"].ToString();
                        hfTotalAmount.Value = reader["TotalAmount"].ToString();

                        
                        lblOrderNo.Text = hfOrderNo.Value;
                        lblOrderDate.Text = hfOrderDate.Value;
                        lblStatus.Text = hfStatus.Value;
                        lblTotalAmount.Text = "₹" + hfTotalAmount.Value;
                    }
                    else
                    {
                        Response.Write("Error: Order details not found.");
                    }
                }
                catch (SqlException sqlEx)
                {
                    Response.Write("SQL Error: " + sqlEx.Message);
                }
                catch (Exception ex)
                {
                    Response.Write("Error: " + ex.Message);
                }
            }
        }

    }
}
