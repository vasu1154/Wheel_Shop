using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

public partial class admin_ManageWheels : System.Web.UI.Page
{
    private string conStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=Z:\Projects\Asp.Net\AWMS\App_Data\AWMS.mdf;Integrated Security=True;User Instance=True";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null)
        {
            Response.Redirect("~/login.aspx");
        }

        if (!IsPostBack)
        {
            GridViewWheels.DataBind();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string name = txtName.Text.Trim();
        string brand = txtBrand.Text.Trim();
        string size = txtSize.Text.Trim();
        decimal price = Convert.ToDecimal(txtPrice.Text.Trim());
        int stock = Convert.ToInt32(txtStock.Text.Trim());
        string imagePath = "";

        if (fileUpload.HasFile)
        {
            string ext = Path.GetExtension(fileUpload.FileName).ToLower();
            if (ext == ".jpg" || ext == ".jpeg" || ext == ".png")
            {
                string fileName = Guid.NewGuid().ToString() + ext;
                string savePath = Server.MapPath("~/uploads/" + fileName);
                fileUpload.SaveAs(savePath);
                imagePath = "~/uploads/" + fileName;
            }
        }

        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = "INSERT INTO tbl_Wheels (Name, Brand, Size, Price, StockQuantity, ImagePath) VALUES (@Name, @Brand, @Size, @Price, @Stock, @ImagePath)";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Brand", brand);
                cmd.Parameters.AddWithValue("@Size", size);
                cmd.Parameters.AddWithValue("@Price", price);
                cmd.Parameters.AddWithValue("@Stock", stock);
                cmd.Parameters.AddWithValue("@ImagePath", imagePath);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        ClearForm();
        GridViewWheels.DataBind();
        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Wheel added successfully!');", true);
    }

    private void ClearForm()
    {
        txtName.Text = "";
        txtBrand.Text = "";
        txtSize.Text = "";
        txtPrice.Text = "";
        txtStock.Text = "";
    }
}
