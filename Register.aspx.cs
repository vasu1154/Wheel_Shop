using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnRegister_Click(object sender, EventArgs e)
    {
        string name = txtName.Text.Trim();
        string email = txtEmail.Text.Trim();
        string password = txtPassword.Text.Trim();
        string confirmPassword = txtConfirmPassword.Text.Trim();
        string contact = txtContact.Text.Trim();
        string address = txtAddress.Text.Trim();

        if (password != confirmPassword)
        {
            Response.Write("<script>alert('Passwords do not match!');</script>");
            return;
        }

        string connStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=Z:\Projects\Asp.Net\AWMS\App_Data\AWMS.mdf;Integrated Security=True;User Instance=True";
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "INSERT INTO tbl_Users (Name, Email, Password, ContactNo, Address) VALUES (@Name, @Email, @Password, @ContactNo, @Address)";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@Name", name);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@Password", password);
            cmd.Parameters.AddWithValue("@ContactNo", contact);
            cmd.Parameters.AddWithValue("@Address", address);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        Response.Write("<script>alert('Registration successful! Redirecting to Login.'); window.location='Login.aspx';</script>");
    }
}