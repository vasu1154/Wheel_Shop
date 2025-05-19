using System;
using System.Web.UI;

public partial class user_User : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["UserID"] != null)
            {
                lnkLoginLogout.Text = "Logout";
            }
            else
            {
                lnkLoginLogout.Text = "Login";
            }
        }
    }


    protected void btnLogout_Click(object sender, EventArgs e)
    {
        
    }
    protected void lnkLoginLogout_Click(object sender, EventArgs e)
    {
        if (Session["UserID"] != null)
        {
            Session.Clear();
            Response.Redirect("~/Login.aspx");
        }
        else
        {
            Response.Redirect("~/Login.aspx");
        }
    }
}
