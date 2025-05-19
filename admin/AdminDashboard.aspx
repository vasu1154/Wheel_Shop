<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.master" AutoEventWireup="true" CodeFile="AdminDashboard.aspx.cs" Inherits="admin_AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style>
       body {
    margin: 0;
    padding: 0;
    font-family: 'Segoe UI', sans-serif;
    background-color: #f4f4f4;
}

.admin-container {
    max-width: 1100px;
    margin: 20px auto;
    padding: 20px;
}

.header {
    background-color: #2c3e50;
    color: white;
    padding: 20px;
    border-radius: 10px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.header h1 {
    margin: 0;
}

.logout-btn {
    background-color: #e74c3c;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.dashboard-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
    gap: 20px;
    margin-top: 30px;
}

.card {
    background-color: white;
    border-radius: 15px;
    padding: 20px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    transition: transform 0.2s ease;
    text-align: center;
}

.card:hover {
    transform: scale(1.03);
}

.card h2 {
    margin-top: 0;
    color: #2c3e50;
}

.card p {
    color: #7f8c8d;
}

.card a {
    display: inline-block;
    margin-top: 15px;
    padding: 8px 15px;
    background-color: #2980b9;
    color: white;
    text-decoration: none;
    border-radius: 5px;
}

.card a:hover {
    background-color: #3498db;
}

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="admin-container">
            <div class="header">
                <h1>Admin Dashboard</h1>
                <asp:Label ID="lblWelcome" runat="server" Text="Welcome, Admin!"></asp:Label>
                
            </div>

            <div class="dashboard-grid">
                <div class="card">
                    <h2>Manage Wheels</h2>
                    <p>Add, update, delete wheels</p>
                    <a href="ManageWheels.aspx">Go</a>
                </div>


                <div class="card">
                    <h2>Manage Orders</h2>
                    <p>Approve and process orders</p>
                    <a href="ManageOrders.aspx">Go</a>
                </div>

                <div class="card">
                    <h2>Manage Customers</h2>
                    <p>View user details & history</p>
                    <a href="ManageCustomers.aspx">Go</a>
                </div>

                <div class="card">
                    <h2>Reports</h2>
                    <p>Sales & Stock Reports</p>
                    <a href="Reports.aspx">Go</a>
                </div>
            </div>
        </div>
</asp:Content>

