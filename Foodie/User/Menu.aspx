<%@ Page Title="Menu" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="Foodie.User.Menu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .category-filter {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-bottom: 20px;
        }
        .category-filter a {
            padding: 10px 20px;
            border-radius: 20px;
            background-color: #ff5a5f;
            color: white;
            text-decoration: none;
            font-weight: bold;
        }
        .category-filter a:hover {
            background-color: #e04e53;
        }
        .product-box {
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
            text-align: center;
            transition: 0.3s;
        }
        .product-box:hover {
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .product-box img {
            width: 100%;
            border-radius: 10px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">
        <h2 class="text-center">Our Menu</h2>

        <!-- Category Filter -->
        <div class="category-filter">
            <asp:LinkButton runat="server" CssClass="btn btn-danger" OnClick="FilterCategory_Click" CommandArgument="All">All</asp:LinkButton>
            <asp:LinkButton runat="server" CssClass="btn btn-danger" OnClick="FilterCategory_Click" CommandArgument="Burger">Burger</asp:LinkButton>
            <asp:LinkButton runat="server" CssClass="btn btn-danger" OnClick="FilterCategory_Click" CommandArgument="Pizza">Pizza</asp:LinkButton>
            <asp:LinkButton runat="server" CssClass="btn btn-danger" OnClick="FilterCategory_Click" CommandArgument="Pasta">Pasta</asp:LinkButton>
            <asp:LinkButton runat="server" CssClass="btn btn-danger" OnClick="FilterCategory_Click" CommandArgument="Fries">Fries</asp:LinkButton>
        </div>

        <!-- Product Listing -->
        <div class="row">
            <asp:Repeater ID="rptProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
                <ItemTemplate>
                    <div class="col-md-4">
                        <div class="product-box">
                            <img src='<%# ResolveUrl("~/Images/Product/" + Eval("ImageUrl").ToString()) %>' alt='<%# Eval("Name") %>' />
                            <h5><%# Eval("Name") %></h5>
                            <p><%# Eval("Description") %></p>
                            <h6 class="text-success fw-bold">$<%# Eval("Price") %></h6>
                            <asp:LinkButton runat="server" CssClass="btn btn-warning mt-2" CommandName="addToCart" CommandArgument='<%# Eval("ProductsId") %>'>
                                <i class="fas fa-shopping-cart"></i> Add to Cart
                            </asp:LinkButton>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
