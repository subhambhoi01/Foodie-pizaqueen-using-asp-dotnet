<%@ Page Title="User Registration" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="Foodie.User.Registration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .error { color: red; display: block; margin-bottom: 5px; }
        .form-control:hover::placeholder { color: gray; font-style: italic; }
        .btn-register { background-color: green; color: white; padding: 10px 20px; border: none; }
        .login-link { margin-left: 10px; color: blue; cursor: pointer; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <h2>User Registration</h2>
                <asp:Label ID="lblMsg" runat="server" CssClass="alert" Visible="false"></asp:Label>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="form_container">
                        <div>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter Full Name" ToolTip="Full Name"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Name is required" ControlToValidate="txtName" CssClass="error"></asp:RequiredFieldValidator>
                        </div>

                        <div>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter Username" ToolTip="Username"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ErrorMessage="Username is required" ControlToValidate="txtUsername" CssClass="error"></asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="cvUsername" runat="server" OnServerValidate="CustomUsernameValidator_ServerValidate" ErrorMessage="Username already exists!" CssClass="error" ForeColor="Red"></asp:CustomValidator>
                        </div>

                        <div>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter Email" ToolTip="Email"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Email is required" ControlToValidate="txtEmail" CssClass="error"></asp:RequiredFieldValidator>
                        </div>

                        <div>
                            <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" placeholder="Enter Mobile Number" ToolTip="Mobile Number"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ErrorMessage="Mobile No. is required" ControlToValidate="txtMobile" CssClass="error"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form_container">
                        <div>
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Enter Address" ToolTip="Address" TextMode="MultiLine"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ErrorMessage="Address is required" ControlToValidate="txtAddress" CssClass="error"></asp:RequiredFieldValidator>
                        </div>

                        <div>
                            <asp:TextBox ID="txtZipCode" runat="server" CssClass="form-control" placeholder="Enter Post/Zip Code" ToolTip="Zip Code"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvZipCode" runat="server" ErrorMessage="Post/Zip Code is required" ControlToValidate="txtZipCode" CssClass="error"></asp:RequiredFieldValidator>
                        </div>

                        <div>
                            <asp:FileUpload ID="fuProfilePic" runat="server" CssClass="form-control" ToolTip="Upload Profile Picture" />
                        </div>

                        <div>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter Password" ToolTip="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="Password is required" ControlToValidate="txtPassword" CssClass="error"></asp:RequiredFieldValidator>
                        </div>

                        <div class="pt-3">
                            <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-register" OnClick="btnRegister_Click" />
                            <span class="login-link">Already registered? <a href="Login.aspx">Login here</a>.</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
