<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.master" AutoEventWireup="true" CodeFile="ManageUsers.aspx.cs" Inherits="admin_ManageUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
        }  
        .card {
            border-radius: 10px;
        }
        .btn-action {
            margin-right: 5px;
        }
        .editable {
            border: 1px solid #ccc;
            background: #fff;
            padding: 5px;
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="content" align="center">
        <div class="container-fluid">
            <h2 class="mb-4">Manage Users</h2>

            <!-- Search Bar -->
            <div class="input-group mb-3">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search users"></asp:TextBox>
                <button id="Button1" type="submit" class="btn btn-primary" runat="server" onserverclick="btnSearch_Click">
                    <i class="fas fa-search"></i>
                </button>
            </div>

            <!-- Users Table -->
            <div class="card">
                <div class="card-header bg-dark text-white">
                    <h5>Registered Users</h5>
                </div>
                <div class="card-body">
                    <asp:GridView ID="gvUsers" runat="server" CssClass="table table-bordered table-hover"
                        AutoGenerateColumns="False" DataKeyNames="UserID" OnRowEditing="gvUsers_RowEditing"
                        OnRowCancelingEdit="gvUsers_RowCancelingEdit" OnRowUpdating="gvUsers_RowUpdating"
                        OnRowDeleting="gvUsers_RowDeleting">
                        <Columns>
                            <asp:BoundField DataField="UserID" HeaderText="ID" ReadOnly="True" />
                            <asp:TemplateField HeaderText="Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEditName" runat="server" CssClass="form-control"
                                        Text='<%# Eval("Name") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Email">
                                <ItemTemplate>
                                    <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEditEmail" runat="server" CssClass="form-control"
                                        Text='<%# Eval("Email") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Contact No">
                                <ItemTemplate>
                                    <asp:Label ID="lblContact" runat="server" Text='<%# Eval("ContactNo") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEditContact" runat="server" CssClass="form-control"
                                        Text='<%# Eval("ContactNo") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Address">
                                <ItemTemplate>
                                    <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEditAddress" runat="server" CssClass="form-control"
                                        Text='<%# Eval("Address") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField ShowEditButton="True" ButtonType="Button" />
                            <asp:CommandField ShowDeleteButton="True" ButtonType="Button" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>


</asp:Content>

