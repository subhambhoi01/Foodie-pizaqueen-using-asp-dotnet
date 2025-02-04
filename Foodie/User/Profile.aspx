<%@ Page Title="User Profile" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Foodie.User.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .profile-container {
            max-width: 800px;
            margin: auto;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .profile-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .profile-img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #007bff;
        }
        .profile-info {
            font-size: 16px;
            font-weight: bold;
            color: #333;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="profile-container">
        <div class="profile-header">
            <asp:Image ID="imgProfile" runat="server" CssClass="profile-img" />
            <h2><asp:Label ID="lblName" runat="server"></asp:Label></h2>
            <h5>@<asp:Label ID="lblUsername" runat="server"></asp:Label></h5>
        </div>
        <hr />
        <div class="row">
            <div class="col-md-6 profile-info">Email:</div>
            <div class="col-md-6"><asp:Label ID="lblEmail" runat="server"></asp:Label></div>
        </div>
        <div class="row">
            <div class="col-md-6 profile-info">Mobile:</div>
            <div class="col-md-6"><asp:Label ID="lblMobile" runat="server"></asp:Label></div>
        </div>
        <div class="row">
            <div class="col-md-6 profile-info">Address:</div>
            <div class="col-md-6"><asp:Label ID="lblAddress" runat="server"></asp:Label></div>
        </div>
        <div class="row">
            <div class="col-md-6 profile-info">Post Code:</div>
            <div class="col-md-6"><asp:Label ID="lblPostCode" runat="server"></asp:Label></div>
        </div>
        <div class="row">
            <div class="col-md-6 profile-info">Account Created On:</div>
            <div class="col-md-6"><asp:Label ID="lblCreatedDate" runat="server"></asp:Label></div>
        </div>
    </div>
</asp:Content>
