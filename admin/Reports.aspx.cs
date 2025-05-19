using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class admin_Reports : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadReportData();
        }
    }

    private void LoadReportData()
    {
        // Total Orders
        lblTotalOrders.Text = ExecuteScalar("SELECT COUNT(*) FROM tbl_Orders");

        // Total Customers
        lblTotalCustomers.Text = ExecuteScalar("SELECT COUNT(*) FROM tbl_Users");

        // Total Wheels
        lblTotalWheels.Text = ExecuteScalar("SELECT COUNT(*) FROM tbl_Wheels");

        // Total Revenue
        lblTotalRevenue.Text = ExecuteScalar("SELECT ISNULL(SUM(TotalAmount), 0) FROM tbl_Orders");
    }

    private string ExecuteScalar(string query)
    {
        SqlCommand cmd = new SqlCommand(query, con);
        con.Open();
        object result = cmd.ExecuteScalar();
        con.Close();
        return result.ToString();
    }
}
