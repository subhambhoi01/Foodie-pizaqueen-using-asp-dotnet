<%@ Page Title="Manage Order Status" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="OrderStatus.aspx.cs" Inherits="Foodie.Admin.OrderStatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .grid-view {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .grid-view th, .grid-view td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }

        .grid-view th {
            background-color: #4CAF50;
            color: white;
        }

        .grid-view td {
            background-color: #f9f9f9;
        }

        .grid-view td:hover {
            background-color: #f1f1f1;
        }

        .status-dropdown {
            width: 120px;
            padding: 5px;
        }

        
        .status-delivered {
            color: green;
            font-weight: bold;
        }

        .status-processing {
            color: orange;
            font-weight: bold;
        }

        .status-pending {
            color: red;
            font-weight: bold;
        }

        .status-column {
            text-transform: capitalize;
        }

        .action-buttons {
            text-align: center;
        }

        .action-buttons a {
            text-decoration: none;
            color: #fff;
            background-color: #007BFF;
            padding: 5px 10px;
            border-radius: 5px;
        }

        .action-buttons a:hover {
            background-color: #0056b3;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Order Status Management</h2>
<asp:GridView ID="gvOrderStatus" runat="server" AutoGenerateColumns="False" OnRowEditing="gvOrderStatus_RowEditing" OnRowUpdating="gvOrderStatus_RowUpdating" OnRowDeleting="gvOrderStatus_RowDeleting" CssClass="grid-view" DataKeyNames="OrderNo">
    <Columns>
        <asp:BoundField DataField="OrderNo" HeaderText="Order No" SortExpression="OrderNo" />
        <asp:BoundField DataField="OrderDate" HeaderText="Order Date" SortExpression="OrderDate" />
        <asp:BoundField DataField="Status" HeaderText="Current Status" SortExpression="Status" ItemStyle-CssClass="status-column" />
        <asp:TemplateField HeaderText="Update Status">
            <ItemTemplate>
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="status-dropdown" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged" AutoPostBack="True">
                    <asp:ListItem Value="Pending">Pending</asp:ListItem>
                    <asp:ListItem Value="Processing">Processing</asp:ListItem>
                    <asp:ListItem Value="Delivered">Delivered</asp:ListItem>
                </asp:DropDownList>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:DropDownList ID="ddlStatusEdit" runat="server" CssClass="status-dropdown">
                    <asp:ListItem Value="Pending">Pending</asp:ListItem>
                    <asp:ListItem Value="Processing">Processing</asp:ListItem>
                    <asp:ListItem Value="Delivered">Delivered</asp:ListItem>
                </asp:DropDownList>
            </EditItemTemplate>
        </asp:TemplateField>
        <asp:CommandField ShowDeleteButton="True" />
    </Columns>
</asp:GridView>


    <asp:Label ID="lblMessage" runat="server" ForeColor="Green" Visible="false"></asp:Label>
</asp:Content>
