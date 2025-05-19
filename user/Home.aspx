<%@ Page Title="" Language="C#" MasterPageFile="~/user/User.master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="user_Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        .carousel-item img {
            height: 300px;
            object-fit: cover;
        }

        .hero-section {
            background-image: url('Assets/banner.jpg');
            background-size: cover;
            background-position: center;
            height: 300px;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }

        .hero-section h1 {
            font-size: 48px;
            font-weight: bold;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.6);
        }

        .card {
            border: none;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
            border-radius: 12px;
            transition: transform 0.2s ease;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .wheel-img {
            height: 200px;
            object-fit: contain;
            padding: 10px;
        }

        .card-body h5 {
            font-weight: 600;
        }

        .price {
            font-size: 1.2rem;
            color: #28a745;
            font-weight: 500;
        }

        .btn-view {
            background-color: #007bff;
            color: white;
        }

        .btn-view:hover {
            background-color: #0056b3;
        }

        .section-title {
            text-align: center;
            margin: 40px 0 20px;
            font-size: 32px;
            font-weight: bold;
        }

        blockquote {
            font-size: 1.2rem;
            color: #555;
        }

        .brand-logo {
            max-width: 100px;
            margin: 10px auto;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    
   <!-- 🌟 Hero Section -->
    <div class="p-5 mb-4 bg-light rounded-3 shadow">
        <div class="container-fluid py-5 d-flex align-items-center justify-content-between flex-wrap">
            <div>
                <h1 class="display-5 fw-bold text-dark">Upgrade Your Drive</h1>
                <p class="col-md-8 fs-5">Browse premium alloy wheels for all car brands – affordable, durable, and stylish!</p>
                <a href="#" class="btn btn-primary btn-lg">Find Your Wheel</a>
            </div>
            <img src="../Assest/image/download.jpeg" class="img-fluid rounded d-none d-md-block" style="max-height: 220px;" alt="Wheels">
        </div>
    </div>

    <div class="row mb-4">
            <div class="col-md-4">
                <asp:DropDownList ID="ddlBrand" runat="server" CssClass="form-control" AutoPostBack="false" />
            </div>
            <div class="col-md-4">
                <asp:DropDownList ID="ddlSize" runat="server" CssClass="form-control" AutoPostBack="false" />
            </div>
            <div class="col-md-4">
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary w-100" OnClick="btnSearch_Click" />
            </div>
        </div>


    <!-- 🛞 Product Grid -->
    <h4 class="text-secondary mb-4">Available Alloy Wheels</h4>
    <div class="row" id="wheelList">
        <asp:Repeater ID="rptWheels" runat="server">
            <ItemTemplate>
                <div class="col-md-4 mb-4">
                    <div class="card wheel-card h-100 shadow-sm">
                        <img src='<%# ResolveUrl(Eval("ImagePath").ToString()) %>' class="card-img-top" alt="Alloy Wheel" />

                        <div class="card-body">
                            <h5 class="card-title"><%# Eval("Brand") %> - <%# Eval("Size") %>"</h5>
                            <p class="card-text text-success fw-bold">₹ <%# Eval("Price") %></p>
                            <a href='ProductDetails.aspx?ID=<%# Eval("WheelID") %>' class="btn btn-sm btn-primary me-2">View Details</a>
                            <a href='AddToCart.aspx?ID=<%# Eval("WheelID") %>' class="btn btn-sm btn-outline-dark">Add to Cart</a>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <!-- 🎯 Call-To-Action / Promo Banner -->
    <div class="mt-5 p-4 bg-primary text-white rounded shadow text-center">
        <h4 class="fw-bold">Limited Time Offer</h4>
        <p class="mb-2">Get 10% off your first order – use code <strong>WHEEL10</strong> at checkout!</p>
        <a href="../Register.aspx" class="btn btn-light btn-sm">Register Now</a>
    </div>

</asp:Content>
