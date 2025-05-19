using System;
using System.Data.SqlClient;
using System.Text;

public partial class user_OrderStatus : System.Web.UI.Page
{
    private string conStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=Z:\Projects\Asp.Net\AWMS\App_Data\AWMS.mdf;Integrated Security=True;User Instance=True";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("~/Login.aspx?redirect=OrderStatus.aspx");
            return;
        }

        // Handle order cancellation if requested
        if (Request.Form["cancelOrderId"] != null)
        {
            int cancelId = Convert.ToInt32(Request.Form["cancelOrderId"]);
            CancelOrder(cancelId);
        }

        if (!IsPostBack)
        {
            LoadOrders();
        }
    }

    private void LoadOrders()
    {
        StringBuilder sb = new StringBuilder();
        int userId = Convert.ToInt32(Session["UserID"]);

        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = "SELECT * FROM tbl_Orders WHERE UserID = @UserID ORDER BY OrderDate DESC";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@UserID", userId);

            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();

            if (!rdr.HasRows)
            {
                sb.Append("<p>You have no orders yet.</p>");
            }
            else
            {
                while (rdr.Read())
                {
                    int orderId = Convert.ToInt32(rdr["OrderID"]);
                    string status = rdr["Status"].ToString().ToLower();
                    string statusClass = "";

                    if (status == "pending")
                        statusClass = "status-pending";
                    else if (status == "shipped")
                        statusClass = "status-shipped";
                    else if (status == "delivered")
                        statusClass = "status-delivered";
                    else if (status == "cancelled")
                        statusClass = "status-cancelled";

                    sb.Append("<div class='order-box'>");
                    sb.Append("<div class='order-header'>Order ID: " + orderId + "</div>");
                    sb.Append("<div class='order-detail'>Date: " + Convert.ToDateTime(rdr["OrderDate"]).ToString("dd MMM yyyy") + "</div>");
                    sb.Append("<div class='order-detail'>Total: ₹ " + Convert.ToDecimal(rdr["TotalAmount"]).ToString("N2") + "</div>");
                    sb.Append("<div class='order-detail " + statusClass + "'>Status: " + rdr["Status"] + "</div>");
                    sb.Append("<span class='toggle-link' onclick=\"toggleDetails('" + orderId + "')\">View Items</span>");

                    // Cancel button for pending orders
                    if (status == "pending")
                    {
                        sb.Append("<form method='post' action='OrderStatus.aspx'>");
                        sb.Append("<input type='hidden' name='cancelOrderId' value='" + orderId + "' />");
                        sb.Append("<input type='submit' value='Cancel Order' class='cancel-btn' />");
                        sb.Append("</form>");
                    }

                    // Order item details
                    sb.Append("<div id='items_" + orderId + "' class='item-list'>");
                    sb.Append("<table><tr><th>Wheel</th><th>Brand</th><th>Size</th><th>Qty</th><th>Price</th><th>Total</th></tr>");
                    sb.Append(GetOrderItemsHtml(orderId));
                    sb.Append("</table></div>");
                    sb.Append("</div>");
                }
            }
        }

        litOrders.Text = sb.ToString();
    }

    private string GetOrderItemsHtml(int orderId)
    {
        StringBuilder items = new StringBuilder();

        using (SqlConnection con = new SqlConnection(conStr))
        {
            string itemQuery = @"SELECT w.Name, w.Brand, w.Size, od.Quantity, od.Price, 
                                (od.Quantity * od.Price) AS Total
                                FROM tbl_OrderDetails od
                                INNER JOIN tbl_Wheels w ON od.WheelID = w.WheelID
                                WHERE od.OrderID = @OrderID";

            SqlCommand cmd = new SqlCommand(itemQuery, con);
            cmd.Parameters.AddWithValue("@OrderID", orderId);

            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                items.Append("<tr>");
                items.Append("<td>" + reader["Name"] + "</td>");
                items.Append("<td>" + reader["Brand"] + "</td>");
                items.Append("<td>" + reader["Size"] + "</td>");
                items.Append("<td>" + reader["Quantity"] + "</td>");
                items.Append("<td>₹ " + Convert.ToDecimal(reader["Price"]).ToString("N2") + "</td>");
                items.Append("<td>₹ " + Convert.ToDecimal(reader["Total"]).ToString("N2") + "</td>");
                items.Append("</tr>");
            }
        }

        return items.ToString();
    }

    private void CancelOrder(int orderId)
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = "UPDATE tbl_Orders SET Status = 'Cancelled' WHERE OrderID = @OrderID AND Status = 'Pending'";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@OrderID", orderId);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }
    }
}
