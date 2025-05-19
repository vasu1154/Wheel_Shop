using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string emailOrUsername = txtEmail.Text.Trim();
        string password = txtPassword.Text.Trim();

        string connStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=Z:\Projects\Asp.Net\AWMS\App_Data\AWMS.mdf;Integrated Security=True;User Instance=True";
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();

            // Check if user is an Admin
            string adminQuery = "SELECT AdminID, Username FROM tbl_Admin WHERE Username = @Email AND Password = @Password";
            using (SqlCommand cmd = new SqlCommand(adminQuery, conn))
            {
                cmd.Parameters.AddWithValue("@Email", emailOrUsername);
                cmd.Parameters.AddWithValue("@Password", password);

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read()) // If admin found
                {
                    Session["AdminID"] = reader["AdminID"];
                    Session["AdminUsername"] = reader["Username"];
                    Session["Role"] = "Admin";

                    reader.Close();
                    Response.Redirect("~/admin/AdminDashboard.aspx");
                    return;
                }
                reader.Close();
            }

            // Check if user is a Registered User
            string userQuery = "SELECT UserID, Name FROM tbl_Users WHERE Email = @Email AND Password = @Password";
            using (SqlCommand cmd = new SqlCommand(userQuery, conn))
            {
                cmd.Parameters.AddWithValue("@Email", emailOrUsername);
                cmd.Parameters.AddWithValue("@Password", password);

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read()) // If user found
                {
                    Session["UserID"] = reader["UserID"];
                    Session["UserName"] = reader["Name"];
                    Session["Role"] = "User";

                    reader.Close();
                    Response.Redirect("~/user/Home.aspx");
                    return;
                }
                reader.Close();
            }

            // If no match found, show error message
            Response.Write("<script>alert('Invalid Email or Password!');</script>");
        }
    }
}