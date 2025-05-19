<%@ Page Title="Manage Wheels" Language="C#" MasterPageFile="~/admin/admin.master" AutoEventWireup="true" CodeFile="ManageWheels.aspx.cs" Inherits="admin_ManageWheels" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial;
            background-color: #f4f4f4;
            margin: 40px;
        }

        .container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            width: 600px;
            margin: auto;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            font-weight: bold;
        }

        input[type="text"], input[type="number"], input[type="file"] {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
        }

        .btn {
            padding: 10px 20px;
            background: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            margin-top: 10px;
        }

        .gridview-container {
            margin-top: 40px;
        }

        .gridview-style {
            width: 100%;
            border-collapse: collapse;
        }

        .gridview-style th, .gridview-style td {
            border: 1px solid #ddd;
            padding: 10px;
        }

        .gridview-style th {
            background-color: #007BFF;
            color: white;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="container">
            <h2>Manage Wheels</h2>

            <div class="form-group">
                <label>Name:</label>
                <asp:TextBox ID="txtName" runat="server" />
            </div>
            <div class="form-group">
                <label>Brand:</label>
                <asp:TextBox ID="txtBrand" runat="server" />
            </div>
            <div class="form-group">
                <label>Size:</label>
                <asp:TextBox ID="txtSize" runat="server" />
            </div>
            <div class="form-group">
                <label>Price:</label>
                <asp:TextBox ID="txtPrice" runat="server" />
            </div>
            <div class="form-group">
                <label>Stock Quantity:</label>
                <asp:TextBox ID="txtStock" runat="server" />
            </div>
            <div class="form-group">
                <label>Image Upload:</label>
                <asp:FileUpload ID="fileUpload" runat="server" />
            </div>
            <asp:Button ID="btnSubmit" runat="server" CssClass="btn" Text="Add Wheel" OnClick="btnSubmit_Click" />

            <!-- GridView to Display Wheels -->
            <div class="gridview-container">
                <h3>All Wheels</h3>
                <asp:GridView ID="GridViewWheels" runat="server"
    CssClass="gridview-style" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" 
                    DataKeyNames="WheelID">

    <Columns>
        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
        <asp:BoundField DataField="WheelID" HeaderText="WheelID" ReadOnly="True" 
            InsertVisible="False" SortExpression="WheelID" />

        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
        <asp:BoundField DataField="Brand" HeaderText="Brand" SortExpression="Brand" />
        <asp:BoundField DataField="Size" HeaderText="Size" SortExpression="Size" />
        <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
        <asp:BoundField DataField="StockQuantity" HeaderText="StockQuantity" 
            SortExpression="StockQuantity" />
        <asp:ImageField DataAlternateTextField="ImagePath" 
            DataImageUrlField="ImagePath" HeaderText="image">
            <ControlStyle Height="50px" Width="50px" />
            <ItemStyle Height="50px" Width="50px" />
        </asp:ImageField>
    </Columns>
</asp:GridView>



                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                    SelectCommand="SELECT * FROM [tbl_Wheels]" 
                    DeleteCommand="DELETE FROM [tbl_Wheels] WHERE [WheelID] = @WheelID" 
                    InsertCommand="INSERT INTO [tbl_Wheels] ([Name], [Brand], [Size], [Price], [StockQuantity], [ImagePath]) VALUES (@Name, @Brand, @Size, @Price, @StockQuantity, @ImagePath)" 
                    UpdateCommand="UPDATE [tbl_Wheels] SET [Name] = @Name, [Brand] = @Brand, [Size] = @Size, [Price] = @Price, [StockQuantity] = @StockQuantity, [ImagePath] = @ImagePath WHERE [WheelID] = @WheelID">
                    <DeleteParameters>
                        <asp:Parameter Name="WheelID" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="Name" Type="String" />
                        <asp:Parameter Name="Brand" Type="String" />
                        <asp:Parameter Name="Size" Type="String" />
                        <asp:Parameter Name="Price" Type="Decimal" />
                        <asp:Parameter Name="StockQuantity" Type="Int32" />
                        <asp:Parameter Name="ImagePath" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Name" Type="String" />
                        <asp:Parameter Name="Brand" Type="String" />
                        <asp:Parameter Name="Size" Type="String" />
                        <asp:Parameter Name="Price" Type="Decimal" />
                        <asp:Parameter Name="StockQuantity" Type="Int32" />
                        <asp:Parameter Name="ImagePath" Type="String" />
                        <asp:Parameter Name="WheelID" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>



            </div>
        </div>
</asp:Content>
