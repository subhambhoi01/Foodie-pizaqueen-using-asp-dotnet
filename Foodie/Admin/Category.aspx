<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Category.aspx.cs" Inherits="Foodie.Admin.Category" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
        /*For disappearing alert message*/
        window.onload = function () {
            var seconds = 8;
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID%>").style.display = "none";
            }, seconds * 1000);
        };
    </script>
     <script>
         function ImagePreview(input) {
             if (input.files && input.files[0]) {
                 var reader = new FileReader();
                 reader.onload = function (e) {
                     $('#<%= imgCategory.ClientID %>').attr('src', e.target.result).width(200).height(200);
                 };
                 reader.readAsDataURL(input.files[0]);
             }
         }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="pcoded-inner-content pt-0">
        <div class"align-align-self-end">
            <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
        </div>
        <div class="main-body">
            <div class="page-wrapper">

                <div class="page-body">
                    <div class="row">

                                        <div class="col-sm-6 col-md-4 col-lg-4">

                                            <h4 class="sub-title">Category</h4>

                                            <div class="form-group">
                                                <label for="txtName">Category Name</label>
                                                <div>
                                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter Category Name" required="required"></asp:TextBox>
                                                    <asp:HiddenField ID="hdnId" runat="server" Value="0" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="fuCategoryImage">Category Image</label>
                                                <div>
                                                    <asp:FileUpload ID="fuCategoryImage" runat="server" CssClass="form-control" onchange="ImagePreview(this);" />
                                                </div>
                                            </div>

                                            <div class="form-check pl-4">
                                                <asp:CheckBox ID="cbIsActive" runat="server" Text="&nbsp; IsActive" CssClass="form-check-input" />
                                            </div>

                                            <div class="pb-5">
                                                <asp:Button ID="btnAddOrUpdate" runat="server" Text="Add" CssClass="btn btn-primary"
                                                    OnClick ="btnAddOrUpdate_Click"/>
                                                &nbsp;
        <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-primary" CausesValidation="false" OnClick ="btnClear_Click" />
                                            </div>

                                            <asp:Image ID="imgCategory" runat="server" CssClass="img-thumbnail" />

                                        </div>

                                    </div>
                                </div>
                <div class="col-sm-6 col-md-8 col-lg-8 mobile-inputs">

                                            <h4 class="sub-title">Category Lists</h4>
                    <div class ="card-block table-border-style">
                        <div class ="table-responsive ">
                            <asp:Repeater ID="rCategory" runat="server">
                             <HeaderTemplate>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Image</th>
                    <th>IsActive</th>
                    <th>CreatedDate</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
    </HeaderTemplate>
     <ItemTemplate>
        <tr>
            <td><%# Eval("Name") %></td>
            <td>
                <img src='<%# ResolveUrl(Eval("ImageUrl").ToString()) %>' alt="Category Image" width="100" height="100" />
            </td>
            <td><%# Eval("IsActive") %></td>
            <td><%# Eval("CreatedDate", "{0:yyyy-MM-dd}") %></td>
            <td>Actions</td>
        </tr>
    </ItemTemplate>
                                </asp:Repeater>
                        </div>
                    </div>

                    </div>

                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
