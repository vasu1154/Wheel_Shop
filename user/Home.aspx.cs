using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class user_Home : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindDropdowns();
            BindWheels(); // Load all initially
        }
    }

    private void BindDropdowns()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            // Brand Dropdown
            SqlDataAdapter daBrand = new SqlDataAdapter("SELECT DISTINCT Brand FROM tbl_Wheels", con);
            DataTable dtBrand = new DataTable();
            daBrand.Fill(dtBrand);
            ddlBrand.DataSource = dtBrand;
            ddlBrand.DataTextField = "Brand";
            ddlBrand.DataValueField = "Brand";
            ddlBrand.DataBind();
            ddlBrand.Items.Insert(0, new ListItem("All Brands", ""));

            // Size Dropdown
            SqlDataAdapter daSize = new SqlDataAdapter("SELECT DISTINCT Size FROM tbl_Wheels", con);
            DataTable dtSize = new DataTable();
            daSize.Fill(dtSize);
            ddlSize.DataSource = dtSize;
            ddlSize.DataTextField = "Size";
            ddlSize.DataValueField = "Size";
            ddlSize.DataBind();
            ddlSize.Items.Insert(0, new ListItem("All Sizes", ""));
        }
    }

    private void BindWheels(string brand = "", string size = "")
    {
        string query = "SELECT WheelID, Brand, Size, Price, ImagePath FROM tbl_Wheels WHERE 1=1";

        if (!string.IsNullOrEmpty(brand))
            query += " AND Brand = @Brand";

        if (!string.IsNullOrEmpty(size))
            query += " AND Size = @Size";

        using (SqlConnection con = new SqlConnection(conStr))
        using (SqlCommand cmd = new SqlCommand(query, con))
        {
            if (!string.IsNullOrEmpty(brand))
                cmd.Parameters.AddWithValue("@Brand", brand);
            if (!string.IsNullOrEmpty(size))
                cmd.Parameters.AddWithValue("@Size", size);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rptWheels.DataSource = dt;
            rptWheels.DataBind();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string brand = ddlBrand.SelectedValue;
        string size = ddlSize.SelectedValue;
        BindWheels(brand, size);
    }
}
