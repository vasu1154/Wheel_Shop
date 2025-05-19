using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;

public partial class user_Cart : System.Web.UI.Page
{
    private string conStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=Z:\Projects\Asp.Net\AWMS\App_Data\AWMS.mdf;Integrated Security=True;User Instance=True";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["Cart"] != null && ((Dictionary<string, int>)Session["Cart"]).Count > 0)
            {
                LoadCart();
            }
            else
            {
                lblTotal.Text = "Your cart is empty.";
            }
        }
    }

    private void LoadCart()
    {
        Dictionary<string, int> cart = Session["Cart"] as Dictionary<string, int>;
        if (cart == null || cart.Count == 0)
        {
            lblTotal.Text = "Your cart is empty.";
            return;
        }

        List<string> quotedIds = new List<string>();
        foreach (string id in cart.Keys)
        {
            quotedIds.Add("'" + id + "'");
        }
        string idList = string.Join(",", quotedIds.ToArray());

        string query = "SELECT * FROM tbl_Wheels WHERE WheelID IN (" + idList + ")";
        DataTable dt = new DataTable();

        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlDataAdapter da = new SqlDataAdapter(query, con);
            da.Fill(dt);
        }

        // Add quantity & total columns
        dt.Columns.Add("Quantity", typeof(int));
        dt.Columns.Add("TotalPrice", typeof(decimal));

        decimal grandTotal = 0;

        foreach (DataRow row in dt.Rows)
        {
            string wheelID = row["WheelID"].ToString();
            int qty = cart[wheelID];
            decimal price = Convert.ToDecimal(row["Price"]);

            row["Quantity"] = qty;
            row["TotalPrice"] = price * qty;
            grandTotal += price * qty;
        }

        gvCart.DataSource = dt;
        gvCart.DataBind();

        lblTotal.Text = "Total: ₹ " + grandTotal.ToString("N2");
        Session["CartTotal"] = grandTotal;
    }


   protected void btnCheckout_Click(object sender, EventArgs e)
{
    if (Session["UserID"] == null)
    {
        Response.Redirect("~/Login.aspx?redirect=Cart.aspx");
        return;
    }

    Dictionary<string, int> cart = Session["Cart"] as Dictionary<string, int>;
    if (cart == null || cart.Count == 0)
    {
        lblTotal.Text = "Your cart is empty.";
        return;
    }

    decimal total = Session["CartTotal"] != null ? Convert.ToDecimal(Session["CartTotal"]) : 0;
    int userId = Convert.ToInt32(Session["UserID"]);

    using (SqlConnection con = new SqlConnection(conStr))
    {
        con.Open();
        SqlTransaction tran = con.BeginTransaction();

        try
        {
            // Insert order
            string orderQuery = "INSERT INTO tbl_Orders (UserID, TotalAmount) OUTPUT INSERTED.OrderID VALUES (@UserID, @TotalAmount)";
            SqlCommand cmdOrder = new SqlCommand(orderQuery, con, tran);
            cmdOrder.Parameters.AddWithValue("@UserID", userId);
            cmdOrder.Parameters.AddWithValue("@TotalAmount", total);
            int orderId = (int)cmdOrder.ExecuteScalar();

            foreach (KeyValuePair<string, int> item in cart)
            {
                string wheelID = item.Key;
                int quantity = item.Value;

                // Get price and stock
                string wheelQuery = "SELECT Price, StockQuantity FROM tbl_Wheels WHERE WheelID = @WheelID";
                SqlCommand cmdWheel = new SqlCommand(wheelQuery, con, tran);
                cmdWheel.Parameters.AddWithValue("@WheelID", wheelID);

                SqlDataReader reader = cmdWheel.ExecuteReader();
                if (reader.Read())
                {
                    decimal price = Convert.ToDecimal(reader["Price"]);
                    int stockQty = Convert.ToInt32(reader["StockQuantity"]);
                    reader.Close();

                    if (quantity > stockQty)
                    {
                        tran.Rollback();
                        lblTotal.Text = "❌ Not enough stock for Wheel ID "+ wheelID +". Available:" + stockQty + ", Requested: " + quantity;
                        return;
                    }

                    // Insert into OrderDetails
                    SqlCommand cmdDetail = new SqlCommand("INSERT INTO tbl_OrderDetails (OrderID, WheelID, Quantity, Price) VALUES (@OrderID, @WheelID, @Qty, @Price)", con, tran);
                    cmdDetail.Parameters.AddWithValue("@OrderID", orderId);
                    cmdDetail.Parameters.AddWithValue("@WheelID", wheelID);
                    cmdDetail.Parameters.AddWithValue("@Qty", quantity);
                    cmdDetail.Parameters.AddWithValue("@Price", price);
                    cmdDetail.ExecuteNonQuery();

                    // Update stock
                    SqlCommand cmdUpdateStock = new SqlCommand("UPDATE tbl_Wheels SET StockQuantity = StockQuantity - @Qty WHERE WheelID = @WheelID", con, tran);
                    cmdUpdateStock.Parameters.AddWithValue("@Qty", quantity);
                    cmdUpdateStock.Parameters.AddWithValue("@WheelID", wheelID);
                    cmdUpdateStock.ExecuteNonQuery();
                }
                else
                {
                    reader.Close();
                    tran.Rollback();
                    lblTotal.Text = "❌ Wheel with ID not found."+ wheelID;
                    return;
                }
            }

            // Commit if all good
            tran.Commit();
            Session["Cart"] = null;
            Response.Redirect("~/user/Checkout.aspx?orderId=" + orderId);

        }
        catch (Exception ex)
        {
            tran.Rollback();
            lblTotal.Text = "❌ Something went wrong while placing the order: " + ex.Message;
        }
    }
}


}
