<%@ Page Title="" Language="C#" MasterPageFile="~/user/User.master" AutoEventWireup="true" CodeFile="OrderStatus.aspx.cs" Inherits="user_OrderStatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <style>
        body { font-family: Arial; background: #f4f4f4; padding: 20px; }
        .order-box { background: white; border-radius: 10px; padding: 15px; margin-bottom: 20px; box-shadow: 0 2px 6px rgba(0,0,0,0.1); position: relative; }
        .order-header { font-weight: bold; font-size: 18px; color: #333; margin-bottom: 10px; }
        .order-detail { margin-bottom: 5px; color: #555; }
        .status-pending { color: orange; font-weight: bold; }
        .status-shipped { color: blue; font-weight: bold; }
        .status-delivered { color: green; font-weight: bold; }
        .status-cancelled { color: red; font-weight: bold; }
        .item-list { margin-top: 10px; border-top: 1px solid #ddd; padding-top: 10px; display: none; }
        .item-list table { width: 100%; font-size: 14px; }
        .item-list th, .item-list td { padding: 6px; text-align: left; border-bottom: 1px solid #eee; }
        .toggle-link { cursor: pointer; font-size: 14px; color: #007bff; text-decoration: underline; margin-top: 10px; display: inline-block; }
        .cancel-btn { background: #e74c3c; color: white; border: none; padding: 6px 12px; border-radius: 5px; cursor: pointer; margin-top: 10px; }
    </style>

    <script>
        function toggleDetails(id) {
            var el = document.getElementById("items_" + id);
            el.style.display = (el.style.display === "none") ? "block" : "none";
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
      <h2>Your Orders</h2>
    <asp:Literal ID="litOrders" runat="server" />
</asp:Content>

