<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.master" AutoEventWireup="true" CodeFile="Reports.aspx.cs" Inherits="admin_Reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style>
        .report-container {
            max-width: 1000px;
            margin: 30px auto;
            padding: 30px;
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .report-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
        }

        .report-card {
            padding: 25px;
            background: #ecf0f1;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.08);
        }

        .report-card h2 {
            margin: 0;
            color: #2c3e50;
            font-size: 28px;
        }

        .report-card p {
            color: #7f8c8d;
            margin-top: 8px;
            font-size: 16px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<div class="report-container">
        <h2 style="text-align: center; margin-bottom: 30px;">System Reports</h2>
        <div class="report-grid">
            <div class="report-card">
                <h2><asp:Label ID="lblTotalOrders" runat="server" Text="0" /></h2>
                <p>Total Orders</p>
            </div>
            <div class="report-card">
                <h2><asp:Label ID="lblTotalCustomers" runat="server" Text="0" /></h2>
                <p>Total Customers</p>
            </div>
            <div class="report-card">
                <h2><asp:Label ID="lblTotalWheels" runat="server" Text="0" /></h2>
                <p>Total Wheels</p>
            </div>
            <div class="report-card">
                <h2>₹<asp:Label ID="lblTotalRevenue" runat="server" Text="0" /></h2>
                <p>Total Revenue</p>
            </div>
        </div>
    </div>
</asp:Content>

