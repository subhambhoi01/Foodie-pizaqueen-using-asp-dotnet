using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Foodie.Admin
{
    public partial class OrderStatus : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOrders();
            }
        }

        // Load Orders into GridView
        private void LoadOrders()
        {
            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT OrderNo, OrderDate, Status FROM Orders";
                SqlDataAdapter adapter = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                gvOrderStatus.DataSource = dt;
                gvOrderStatus.DataBind();
            }
        }

        // Handle Row Editing for changing the status
        protected void gvOrderStatus_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvOrderStatus.EditIndex = e.NewEditIndex;
            LoadOrders();
        }

        // Update the Status in Database on RowUpdating
        protected void gvOrderStatus_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string orderNo = gvOrderStatus.DataKeys[e.RowIndex].Value.ToString();
            string newStatus = ((DropDownList)gvOrderStatus.Rows[e.RowIndex].FindControl("ddlStatusEdit")).SelectedValue;

            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "UPDATE Orders SET Status = @Status WHERE OrderNo = @OrderNo";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@OrderNo", orderNo);
                cmd.Parameters.AddWithValue("@Status", newStatus);
                conn.Open();
                cmd.ExecuteNonQuery();
                gvOrderStatus.EditIndex = -1;
                LoadOrders();
            }
        }

        // Handle DropDown SelectedIndexChanged event
        protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddlStatus = (DropDownList)sender;
            string selectedStatus = ddlStatus.SelectedValue;

            // Optionally, display or update message
            lblMessage.Text = "You selected: " + selectedStatus;
            lblMessage.Visible = true;

            // Optionally, save the updated status to the database or perform any other logic
        }

        // Handle Row Deleting for the orders
        protected void gvOrderStatus_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string orderNo = gvOrderStatus.DataKeys[e.RowIndex].Value.ToString();

            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "DELETE FROM Orders WHERE OrderNo = @OrderNo";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@OrderNo", orderNo);
                conn.Open();
                cmd.ExecuteNonQuery();
                LoadOrders();
            }
        }
        // Cancel Editing
        protected void gvOrderStatus_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvOrderStatus.EditIndex = -1; // Exit the edit mode
            LoadOrders(); // Reload orders without changes
        }

    }
}
