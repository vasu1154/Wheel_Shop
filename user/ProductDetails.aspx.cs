using System;
using System.Data.SqlClient;
using System.Collections.Generic;

public partial class user_ProductDetails : System.Web.UI.Page
{
    private string conStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=Z:\Projects\Asp.Net\AWMS\App_Data\AWMS.mdf;Integrated Security=True;User Instance=True";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // 🧠 Optional greeting title
            if (Session["UserID"] != null && Session["UserName"] != null)
            {
                string username = Session["UserName"].ToString();
                Page.Title = "Welcome " + username + " - Product Detail";
            }

            string id = Request.QueryString["id"];
            if (!string.IsNullOrEmpty(id))
            {
                LoadWheelDetails(id);
            }
            else
            {
                ShowError("Invalid product ID.");
            }
        }
    }

    private void LoadWheelDetails(string id)
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = "SELECT * FROM tbl_Wheels WHERE WheelID = @WheelID";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@WheelID", id);
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                lblName.Text = rdr["Name"].ToString();
                lblBrand.Text = rdr["Brand"].ToString();
                lblSize.Text = rdr["Size"].ToString();
                lblPrice.Text = "₹ " + Convert.ToDecimal(rdr["Price"]).ToString("N2");
                lblStock.Text = rdr["StockQuantity"].ToString();
                imgWheel.ImageUrl = ResolveUrl(rdr["ImagePath"].ToString());

                pnlDetails.Visible = true;
                lblError.Visible = false;

                // Save to session (optional tracking)
                Session["LastViewedProduct"] = id;
            }
            else
            {
                ShowError("Product not found.");
            }
        }
    }

    private void ShowError(string message)
    {
        pnlDetails.Visible = false;
        lblError.Text = message;
        lblError.Visible = true;
    }

    protected void btnBuyNow_Click(object sender, EventArgs e)
    {
        string id = Request.QueryString["id"];

        if (string.IsNullOrEmpty(id))
        {
            ShowError("Invalid product ID.");
            return;
        }

        Session["BuyNowID"] = id;

        if (Session["UserID"] != null)
        {
            Response.Redirect("Checkout.aspx");
        }
        else
        {
            // Redirect to login and back to current product
            string redirectUrl = "ProductDetails.aspx?id=" + id;
            Response.Redirect("~/Login.aspx?redirect=" + Server.UrlEncode(redirectUrl));
        }
    }

    protected void btnAddToCart_Click(object sender, EventArgs e)
    {
        string id = Request.QueryString["id"];
        if (string.IsNullOrEmpty(id))
        {
            ShowError("Invalid product ID.");
            return;
        }

        Dictionary<string, int> cart = Session["Cart"] as Dictionary<string, int>;
        if (cart == null)
            cart = new Dictionary<string, int>();

        if (cart.ContainsKey(id))
            cart[id] += 1; // Increase quantity
        else
            cart[id] = 1;  // Add new item

        Session["Cart"] = cart;

        if (Session["UserID"] == null)
        {
            string redirectUrl = "ProductDetails.aspx?id=" + id;
            Response.Redirect("~/Login.aspx?redirect=" + Server.UrlEncode(redirectUrl));
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "added", "alert('Product added to cart!');", true);
            Response.Redirect("Cart.aspx");
        }
    }

}
