using System;
using System.Data;
using System.Data.SqlClient;

public partial class user_Checkout : System.Web.UI.Page
{
    private string conStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=Z:\Projects\Asp.Net\AWMS\App_Data\AWMS.mdf;Integrated Security=True;User Instance=True";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            int orderId;
            if (Request.QueryString["orderId"] != null && int.TryParse(Request.QueryString["orderId"], out orderId))
            {
                LoadOrder(orderId);
            }
            else
            {
                ShowEmptyPanel();
            }

        }
    }

    private void LoadOrder(int orderId)
    {
        DataTable dt = new DataTable();
        decimal total = 0;

        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = @"
                SELECT w.Name, w.Brand, w.Size, od.Quantity, od.Price, 
                       (od.Quantity * od.Price) AS Total, w.ImagePath
                FROM tbl_OrderDetails od
                INNER JOIN tbl_Wheels w ON od.WheelID = w.WheelID
                WHERE od.OrderID = @OrderID";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@OrderID", orderId);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
        }

        if (dt.Rows.Count > 0)
        {
            foreach (DataRow row in dt.Rows)
            {
                total += Convert.ToDecimal(row["Total"]);
            }

            gvOrder.DataSource = dt;
            gvOrder.DataBind();

            lblTotal.Text = "Total Amount: ₹ " + total.ToString("N2");
            pnlOrder.Visible = true;
            pnlEmpty.Visible = false;
        }
        else
        {
            ShowEmptyPanel();
        }

        Session["Cart"] = null; // Clear the cart
    }

    private void ShowEmptyPanel()
    {
        pnlOrder.Visible = false;
        pnlEmpty.Visible = true;
        lblTotal.Text = ""; // clear previous total if any
    }

    protected void btnOrderStatus_Click(object sender, EventArgs e)
    {
        int orderId;
        if (Request.QueryString["orderId"] != null && int.TryParse(Request.QueryString["orderId"], out orderId))
        {
            Response.Redirect("~/user/OrderStatus.aspx?orderId=" + orderId);
        }

    }
}
