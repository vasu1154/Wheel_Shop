using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class admin_ManageOrders : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindOrders();
        }
    }

    private void BindOrders()
    {
        string query = @"
            SELECT o.OrderID, u.Name AS UserName, o.OrderDate, o.TotalAmount, o.Status
            FROM tbl_Orders o
            INNER JOIN tbl_Users u ON o.UserID = u.UserID
            ORDER BY o.OrderDate DESC";

        SqlDataAdapter da = new SqlDataAdapter(query, con);
        DataTable dt = new DataTable();
        da.Fill(dt);

        gvOrders.DataSource = dt;
        gvOrders.DataBind();
    }

    protected void gvOrders_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        if (e.CommandName == "UpdateStatus")
        {
            int orderId = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = ((System.Web.UI.WebControls.Button)e.CommandSource).NamingContainer as GridViewRow;
            string newStatus = ((System.Web.UI.WebControls.DropDownList)row.FindControl("ddlStatus")).SelectedValue;

            UpdateOrderStatus(orderId, newStatus);
            BindOrders(); // Refresh data
        }
    }

    private void UpdateOrderStatus(int orderId, string status)
    {
        string query = "UPDATE tbl_Orders SET Status = @Status WHERE OrderID = @OrderID";
        SqlCommand cmd = new SqlCommand(query, con);
        cmd.Parameters.AddWithValue("@Status", status);
        cmd.Parameters.AddWithValue("@OrderID", orderId);

        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }
}
