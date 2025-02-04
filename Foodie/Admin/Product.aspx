<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="Foodie.Admin.Product" %>
<%@ Import Namespace="Foodie" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
        window.onload = function () {
            var seconds = 8;
            setTimeout(function () {
                document.getElementById("<%= lblMsg.ClientID %>").style.display = "none";
            }, seconds * 1000);
        };

        $(document).ready(function () {
            function ImagePreview(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#<%= imgProduct.ClientID %>').attr('src', e.target.result).width(200).height(200);
                    };
                    reader.readAsDataURL(input.files[0]);
                }
            }

            $('#<%= fuProductImage.ClientID %>').change(function () {
                ImagePreview(this);
            });

            
            $(".toggle-details").click(function () {
                $(this).closest("tr").next(".product-details").toggle();
            });

            
            $("#txtSearch").on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $("#tblProducts tbody tr").filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pcoded-inner-content pt-0">
        <div class="main-body">
            <div class="page-wrapper">
                <div class="page-body">
                    <div class="row">
                        <div class="col-sm-6 col-md-4 col-lg-4">
                            <h4 class="sub-title">Product</h4>

                            <div class="form-group">
                                <label for="txtName">Product Name</label>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter Product Name"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Name is required" ForeColor="Red" Display="Dynamic" ControlToValidate="txtName" />
                            </div>

                            <div class="form-group">
                                <label for="txtDescription">Product Description</label>
                                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" placeholder="Enter Product Description"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label for="txtPrice">Product Price</label>
                                <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" placeholder="Enter Product Price"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label for="txtQuantity">Product Quantity</label>
                                <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control" placeholder="Enter Product Quantity"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label for="fuProductImage">Product Image</label>
                                <asp:FileUpload ID="fuProductImage" runat="server" CssClass="form-control" />
                                <asp:Image ID="imgProduct" runat="server" Width="200" Height="200" />
                            </div>

                            <div class="form-group">
                                <label for="ddlCategory">Category</label>
                                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="CategoryId">
                                    <asp:ListItem Text="Select Category" Value="0" />
                                </asp:DropDownList>
                            </div>

                            <div class="form-check">
                                <asp:CheckBox ID="cbIsActive" runat="server" Text="Is Active" CssClass="form-check-input" />
                            </div>

                            <div class="pb-5">
                                <asp:Button ID="btnAddOrUpdate" runat="server" Text="Add" CssClass="btn btn-primary" OnClick="btnAddOrUpdate_Click" />
                                <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary" CausesValidation="false" OnClick="btnClear_Click" />
                            </div>
                        </div>

                        <div class="col-sm-6 col-md-8 col-lg-8">
                            <h4 class="sub-title">Product List</h4>

                            <!-- Search Box -->
                            <div class="form-group">
                                <input type="text" id="txtSearch" class="form-control" placeholder="Search by product name..." />
                            </div>

                            <div class="card-block table-border-style">
                                <div class="table-responsive">
                                    <asp:Repeater ID="rProduct" runat="server" OnItemCommand="rProduct_ItemCommand">
                                        <HeaderTemplate>
                                            <table id="tblProducts" class="table table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>Name</th>
                                                        <th>Image</th>
                                                        <th>Is Active</th>
                                                        <th>Created Date</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <span class="toggle-details" style="cursor:pointer; color:blue;">+</span> 
                                                    <%# Eval("Name") %>
                                                </td>
                                                <td><img src='<%# ResolveUrl(Eval("ImageUrl").ToString()) %>' width="100" height="100" /></td>
                                                <td><%# Eval("IsActive") %></td>
                                                <td><%# Eval("CreatedDate", "{0:yyyy-MM-dd}") %></td>
                                                <td>
                                                    <asp:LinkButton ID="btnEdit" runat="server" CommandArgument='<%# Eval("ProductsId") %>' CommandName="Edit" Text="Edit" CssClass="btn btn-sm btn-warning" />
                                                    <asp:LinkButton ID="btnDelete" runat="server" CommandArgument='<%# Eval("ProductsId") %>' CommandName="Delete" Text="Delete" CssClass="btn btn-sm btn-danger" OnClientClick="return confirm('Are you sure?');" />
                                                </td>
                                            </tr>
                                            <tr class="product-details" style="display:none;">
                                                <td colspan="5">
                                                    <strong>Description:</strong> <%# Eval("Description") %> <br />
                                                    <strong>Quantity:</strong> <%# Eval("Quantity") %>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </tbody>
                                            </table>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <asp:Label ID="lblMsg" runat="server" CssClass="alert" Visible="false"></asp:Label>
        <asp:HiddenField ID="hdnId" runat="server" Value="0" />
        
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cs %>" SelectCommand="SELECT [CategoryId], [Name] FROM [Categories]"></asp:SqlDataSource>
</asp:Content>
