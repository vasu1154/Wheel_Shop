<%@ Page Title="" Language="C#" MasterPageFile="~/user/User.master" AutoEventWireup="true" CodeFile="ProductDetails.aspx.cs" Inherits="user_ProductDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style>
        body {
            background-color: #f4f6f9;
            font-family: 'Segoe UI', sans-serif;
        }
        .container {
            padding-top: 50px;
            padding-bottom: 50px;
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
        }
        .wheel-img {
            width: 100%;
            max-height: 400px;
            object-fit: contain;
            border-radius: 15px 0 0 15px;
        }
        .product-title {
            font-size: 28px;
            font-weight: 600;
        }
        .product-info label {
            font-weight: 500;
            color: #333;
        }
        .product-info span {
            font-weight: 600;
            display: block;
            margin-bottom: 8px;
        }
        .price-tag {
            font-size: 24px;
            color: #28a745;
            font-weight: bold;
        }
        .stock-status {
            font-size: 16px;
            margin-bottom: 20px;
        }
        .btn-custom {
            padding: 10px 25px;
            font-size: 16px;
            border-radius: 25px;
        }
        .back-link {
            text-decoration: none;
            font-size: 14px;
            color: #007bff;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<div class="container">
        <a href="Home.aspx" class="back-link mb-3 d-block">&larr; Back to Home</a>

        <asp:Panel ID="pnlDetails" runat="server" Visible="false">
            <div class="card overflow-hidden">
                <div class="row g-0">
                    <div class="col-md-5">
                        <asp:Image ID="imgWheel" runat="server" CssClass="wheel-img" />
                    </div>
                    <div class="col-md-7">
                        <div class="card-body">
                            <h2 class="product-title"><asp:Label ID="lblName" runat="server" /></h2>
                            <div class="product-info">
                                <label>Brand:</label>
                                <span><asp:Label ID="lblBrand" runat="server" /></span>

                                <label>Size:</label>
                                <span><asp:Label ID="lblSize" runat="server" /></span>

                                <label>Price:</label>
                                <span class="price-tag"><asp:Label ID="lblPrice" runat="server" /></span>

                                <label>In Stock:</label>
                                <span class="stock-status"><asp:Label ID="lblStock" runat="server" /></span>
                            </div>

                            <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" CssClass="btn btn-outline-primary btn-custom me-2" OnClick="btnAddToCart_Click" />
                            <asp:Button ID="btnBuyNow" runat="server" Text="Buy Now" CssClass="btn btn-success btn-custom" OnClick="btnBuyNow_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>

        <asp:Label ID="lblError" runat="server" CssClass="text-danger mt-4 d-block" Visible="false" />
    </div>
</asp:Content>

