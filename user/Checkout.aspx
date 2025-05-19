<%@ Page Title="" Language="C#" MasterPageFile="~/user/User.master" AutoEventWireup="true" CodeFile="Checkout.aspx.cs" Inherits="user_Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .order-summary {
            max-width: 700px;
            margin: auto;
            padding: 30px;
            border: 1px solid #ddd;
            border-radius: 10px;
            font-family: Arial;
        }

        .order-summary h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .order-summary table {
            width: 100%;
            border-collapse: collapse;
        }

        .order-summary table th,
        .order-summary table td {
            padding: 10px;
            border: 1px solid #ccc;
        }

        .order-summary .total {
            text-align: right;
            font-weight: bold;
            padding-top: 10px;
        }

        .success {
            color: green;
            font-weight: bold;
        }

        .error {
            color: red;
            font-weight: bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="container mt-5">
    <h2 class="mb-4">Your Order Summary</h2>

    <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
        <div class="alert alert-danger fw-bold">
            Your cart is empty.
        </div>
    </asp:Panel>

    <asp:Panel ID="pnlOrder" runat="server" Visible="false">
        <asp:GridView ID="gvOrder" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover">
            <Columns>
                <asp:TemplateField HeaderText="Image">
                    <ItemTemplate>
                        <img src='<%# Eval("ImagePath") %>' alt="Wheel Image" class="img-thumbnail" style="width: 70px; height: 70px;" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Name" HeaderText="Wheel Name" />
                <asp:BoundField DataField="Brand" HeaderText="Brand" />
                <asp:BoundField DataField="Size" HeaderText="Size" />
                <asp:BoundField DataField="Quantity" HeaderText="Qty" />
                <asp:BoundField DataField="Price" HeaderText="Price (₹)" DataFormatString="{0:N2}" />
                <asp:BoundField DataField="Total" HeaderText="Total (₹)" DataFormatString="{0:N2}" />
            </Columns>
        </asp:GridView>

        <div class="text-end mt-3">
            <asp:Label ID="lblTotal" runat="server" CssClass="fs-4 fw-semibold text-success"></asp:Label><br /><br />
            <asp:Button ID="btnOrderStatus" runat="server" Text="Check Order Status" CssClass="btn btn-primary mt-3" OnClick="btnOrderStatus_Click" />

        </div>
    </asp:Panel>
</div>

</asp:Content>

