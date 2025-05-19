<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.master" AutoEventWireup="true" CodeFile="ManageOrders.aspx.cs" Inherits="admin_ManageOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style>
        .container {
            max-width: 1000px;
            margin: 20px auto;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        .gridview {
            width: 100%;
            border-collapse: collapse;
        }

        .gridview th, .gridview td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }

        .gridview th {
            background-color: #2c3e50;
            color: white;
        }

        .btn-action {
            background-color: #27ae60;
            color: white;
            padding: 5px 10px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }

        .btn-action:hover {
            background-color: #2ecc71;
        }

        .status-dropdown {
            padding: 5px;
            border-radius: 5px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="container">
        <h2>Manage Orders</h2>

        <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False" CssClass="gridview" 
            OnRowCommand="gvOrders_RowCommand" DataKeyNames="OrderID">
            <Columns>
                <asp:BoundField DataField="OrderID" HeaderText="Order ID" />
                <asp:BoundField DataField="UserName" HeaderText="Customer" />
                <asp:BoundField DataField="OrderDate" HeaderText="Date" DataFormatString="{0:dd-MM-yyyy}" />
                <asp:BoundField DataField="TotalAmount" HeaderText="Amount" DataFormatString="₹{0:N2}" />
                <asp:BoundField DataField="Status" HeaderText="Status" />

                <asp:TemplateField HeaderText="Change Status">
                    <ItemTemplate>
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="status-dropdown">
                            <asp:ListItem Text="Pending" />
                            <asp:ListItem Text="Shipped" />
                            <asp:ListItem Text="Delivered" />
                        </asp:DropDownList>
                        <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn-action"
                            CommandName="UpdateStatus" CommandArgument='<%# Eval("OrderID") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>

