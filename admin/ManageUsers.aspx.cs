using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_ManageUsers : System.Web.UI.Page
{
    private string connStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=Z:\Projects\Asp.Net\AWMS\App_Data\AWMS.mdf;Integrated Security=True;User Instance=True";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null)
        {
            Response.Redirect("login.aspx"); // Redirect if not logged in
        }

        if (!IsPostBack)
        {
            LoadUsers();
        }
    }

    // Method to load users from the database into the GridView, with optional search query
    private void LoadUsers(string searchQuery = "")
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            string query = "SELECT UserID, Name, Email, ContactNo, Address FROM tbl_Users";

            // If there's a search query, filter the users by Name or Email
            if (!string.IsNullOrEmpty(searchQuery))
            {
                query += " WHERE Name LIKE @Search OR Email LIKE @Search";
            }

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                if (!string.IsNullOrEmpty(searchQuery))
                {
                    cmd.Parameters.AddWithValue("@Search", "%" + searchQuery + "%");
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvUsers.DataSource = dt;
                gvUsers.DataBind();
            }
        }
    }

    // Search button click handler
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadUsers(txtSearch.Text.Trim()); // Load users based on the search query
    }

    // Handling RowCommand for Edit and Delete actions in GridView
    protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int userId = Convert.ToInt32(e.CommandArgument); // Get the user ID from the command argument

        if (e.CommandName == "EditUser")
        {
            // Redirect to EditUser.aspx page with the UserID as a query string parameter
            Response.Redirect("EditUser.aspx?UserID=" + userId);
        }
        else if (e.CommandName == "DeleteUser")
        {
            // Delete the user from the database
            DeleteUser(userId);
            LoadUsers(); // Reload the list of users after deletion
        }
    }

    // Method to delete a user by UserID
    private void DeleteUser(int userId)
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            string query = "DELETE FROM tbl_Users WHERE UserID = @UserID";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.ExecuteNonQuery(); // Execute the delete query
            }
        }
    }

    // Handle GridView editing functionality
    protected void gvUsers_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvUsers.EditIndex = e.NewEditIndex; // Enable editing mode
        LoadUsers(); // Reload users to reflect edit mode
    }

    // Handle cancel editing in GridView
    protected void gvUsers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvUsers.EditIndex = -1; // Cancel editing
        LoadUsers(); // Reload users to exit edit mode
    }

    // Handle updating a user's information in GridView
    protected void gvUsers_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        int userId = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value); // Get the UserID
        string name = ((TextBox)gvUsers.Rows[e.RowIndex].FindControl("txtEditName")).Text; // Get the new Name
        string email = ((TextBox)gvUsers.Rows[e.RowIndex].FindControl("txtEditEmail")).Text; // Get the new Email
        string contact = ((TextBox)gvUsers.Rows[e.RowIndex].FindControl("txtEditContact")).Text; // Get the new ContactNo
        string address = ((TextBox)gvUsers.Rows[e.RowIndex].FindControl("txtEditAddress")).Text; // Get the new Address

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            string query = "UPDATE tbl_Users SET Name=@Name, Email=@Email, ContactNo=@Contact, Address=@Address WHERE UserID=@UserID";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Contact", contact);
                cmd.Parameters.AddWithValue("@Address", address);
                cmd.ExecuteNonQuery(); // Execute the update query
            }
        }

        gvUsers.EditIndex = -1; // Exit edit mode
        LoadUsers(); // Reload the list of users
    }

    // Handle deleting a user from GridView
    protected void gvUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int userId = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value); // Get the UserID
        DeleteUser(userId); // Delete the user
        LoadUsers(); // Reload users after deletion
    }
}
