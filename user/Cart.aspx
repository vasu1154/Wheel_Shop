<%@ Page Title="" Language="C#" MasterPageFile="~/user/User.master" AutoEventWireup="true" CodeFile="Cart.aspx.cs" Inherits="user_Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
       .cart-container {
    width: 80%;
    margin: 50px auto;
    padding: 20px;
    background: #f9f9f9;
    border-radius: 12px;
    box-shadow: 0 0 10px #ccc;
    font-family: Arial;
}

.cart-table {
    width: 100%;
    border-collapse: collapse;
}

.cart-table th, .cart-table td {
    padding: 10px;
    border-bottom: 1px solid #ddd;
    text-align: left;
}

.total-label {
    font-weight: bold;
    font-size: 18px;
    display: block;
    margin-top: 10px;
}

.checkout-btn {
    background: #28a745;
    border: none;
    padding: 10px 25px;
    color: white;
    font-size: 16px;
    cursor: pointer;
    margin-top: 20px;
    border-radius: 6px;
}

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
      <div class="cart-container">
            <h2>Your Shopping Cart</h2>
            <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="false" CssClass="cart-table">
    <Columns>
        <asp:BoundField DataField="Name" HeaderText="Product Name" />
        <asp:BoundField DataField="Brand" HeaderText="Brand" />
        <asp:BoundField DataField="Price" HeaderText="Unit Price" DataFormatString="₹ {0:N2}" />
        <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
        <asp:BoundField DataField="TotalPrice" HeaderText="Total" DataFormatString="₹ {0:N2}" />
    </Columns>
</asp:GridView>
<asp:Label ID="Label1" runat="server" CssClass="total-label" />

            <asp:Label ID="lblTotal" runat="server" CssClass="total-label"></asp:Label>
            <br />
            <asp:Button ID="btnCheckout" runat="server" Text="Proceed to Checkout" OnClick="btnCheckout_Click" CssClass="checkout-btn" />
        </div>
</asp:Content>

