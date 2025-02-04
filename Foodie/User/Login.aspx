<%@ Page Title="Login" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Foodie.User.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
        
        window.onload = function () {
            var seconds = 8;
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID%>").style.display = "none";
            }, seconds * 1000);
        };
    </script>
    <style>
        .login-container {
            position: relative;
            width: 100%;
            height: 450px;
            background: url('../Images/login.jpg') no-repeat center center;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-box {
            background: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 10px;
            text-align: center;
            width: 350px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
        }

        .form-control {
            margin-bottom: 10px;
        }

        .btn-login {
            width: 100%;
            padding: 10px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="login-container">
        <div class="login-box">
            <asp:Label ID="lblMsg" runat="server" CssClass="alert"></asp:Label>
            <h2 class="mb-4">Login</h2>

            <div>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter Username"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername"
                    ErrorMessage="Username is required" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small">
                </asp:RequiredFieldValidator>
            </div>

            <div>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                    ErrorMessage="Password is required" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small">
                </asp:RequiredFieldValidator>
            </div>

            <div>
                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-success btn-login"
                    OnClick="btnLogin_Click" />
            </div>

            <div class="mt-3">
                <span>New User? <a href="Registration.aspx" class="badge badge-info">Register Here</a></span>
            </div>
        </div>
    </section>
</asp:Content>
