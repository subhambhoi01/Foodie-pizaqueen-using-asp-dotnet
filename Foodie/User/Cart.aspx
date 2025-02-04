<%@ Page Title="Your Cart" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="Foodie.User.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <h2>Your Cart</h2>

        <!-- Cart Table -->
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Product</th>
                    <th>Image</th>
                    <th>Unit Price</th>
                    <th>Quantity</th>
                    <th>Total Price</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                
                <asp:Repeater ID="rptCartItems" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("Name") %></td>
                            <td><img src='<%# ResolveUrl("~/Images/Product/" + Eval("ImageUrl")) %>' alt="<%# Eval("Name") %>" width="50" /></td>
                            <td>$<%# Eval("Price") %></td>
                            <td>
                                <asp:HiddenField ID="hfCartId" runat="server" Value='<%# Eval("CartId") %>' />
                                <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control" Text='<%# Eval("Quantity") %>' TextMode="Number" Min="1"></asp:TextBox>
                            </td>
                            <td>$<%# Eval("TotalPrice") %></td>
                            <td>
                                <asp:Button ID="btnRemove" runat="server" Text="Remove" CssClass="btn btn-danger btn-sm" CommandName="Remove" CommandArgument='<%# Eval("CartId") %>' OnClick="btnRemove_Click" />
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>

        
        <div class="d-flex justify-content-between mt-4">
            <h3>Grand Total: $<span id="lblGrandTotal"><asp:Label ID="lblGrandTotal" runat="server" Text="0.00" /></span></h3>
            <div>
                <asp:Button ID="btnUpdateCart" runat="server" Text="Update Cart" CssClass="btn btn-primary me-3" OnClick="btnUpdateCart_Click" />
                <asp:Button ID="btnContinueShopping" runat="server" Text="Continue Shopping" CssClass="btn btn-secondary me-3" OnClick="btnContinueShopping_Click" />
                <asp:Button ID="btnCheckout" runat="server" Text="Proceed to Checkout" CssClass="btn btn-success" OnClick="btnCheckout_Click" />
            </div>
        </div>
    </div>
</asp:Content>
