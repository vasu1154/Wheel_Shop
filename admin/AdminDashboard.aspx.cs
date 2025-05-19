using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class admin_AdminDashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null)
        {
            Response.Redirect("~/login.aspx"); // Redirect if not logged in
        }
        if (!IsPostBack)
        {
            lblWelcome.Text = "Welcome, " + Session["AdminID"].ToString() + "!";
        }
    }
    
}