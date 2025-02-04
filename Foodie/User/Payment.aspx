<%@ Page Title="Order Payment" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="Foodie.User.Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .rounded {
            border-radius: 1rem;
        }

        .nav-pills .nav-link {
            color: #555;
        }

        .nav-pills .nav-link.active {
            color: white;
        }

        .bold {
            font-weight: bold;
        }

        .card {
            padding: 40px 50px;
            border-radius: 20px;
            border: none;
            box-shadow: 1px 5px 10px 1px rgba(0, 0, 0, 0.2);
        }
    </style>
    <script>
        
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById("<%= lblMsg.ClientID %>").style.display = "none";
            }, seconds * 1000);
        };
        /*For tooltip*/
        $(function () {
            $('[data-toggle="tooltip"]').tooltip()
        })
    </script>

    <%--Function for preventing back button--%>
    <script type="text/javascript">
        function DisableBackButton() {
            window.history.forward()
        }
        DisableBackButton();
        window.onload = DisableBackButton;
        window.onpageshow = function (evt) { if (evt.persisted) DisableBackButton() }
        window.onunload = function () { void (0) }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="book_section" style="background-image: url('../Images/payment-bg.png'); width: 100%; height: 100%; background-repeat: no-repeat; 
        background-size: auto; background-attachment: fixed; background-position: left;">

        <div class="container py-5">
            <div class="align-self-end">
                <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
            </div>
            
            <div class="row mb-4">
                <div class="col-lg-8 mx-auto text-center">
                    <h1 class="display-6">Order Payment</h1>
                </div>
            </div>
            
            <div class="row pb-5">
                <div class="col-lg-6 mx-auto">
                    <div class="card">
                        <div class="card-header">
                            <div class="bg-white shadow-sm pt-4 pl-2 pr-2 pb-2">
                                <ul role="tablist" class="nav bg-light nav-pills rounded nav-fill mb-3">
                                    <li class="nav-item"><a data-toggle="pill" href="#credit-card" class="nav-link active"><i class="fa fa-credit-card mr-2"></i>Credit Card</a></li>
                                    <li class="nav-item"><a data-toggle="pill" href="#paypal" class="nav-link"><i class="fa fa-money mr-2"></i>Cash On Delivery</a></li>
                                </ul>
                            </div>
                        </div>
                        
                        <div class="tab-content">
                            <!-- Credit Card Payment Form -->
                            <div id="credit-card" class="tab-pane fade show active pt-3">
                                <div role="form">
                                    <div class="form-group">
                                        <label for="txtName">
                                            <h6>Card Owner</h6>
                                        </label>
                                        <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Name is required" ControlToValidate="txtName" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="card" />
                                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Card Owner Name"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label for="txtCardNo">
                                            <h6>Card Number</h6>
                                        </label>
                                        <asp:RequiredFieldValidator ID="rfvCardNo" runat="server" ErrorMessage="Card number is required" ControlToValidate="txtCardNo" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="card" />
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Card Number must be 16 digits" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="[0-9]{16}" ControlToValidate="txtCardNo" ValidationGroup="card" />
                                        <div class="input-group">
                                            <asp:TextBox ID="txtCardNo" runat="server" CssClass="form-control" placeholder="Valid card number" TextMode="Number"></asp:TextBox>
                                            <div class="input-group-append">
                                                <span class="input-group-text text-muted">
                                                    <i class="fa fa-cc-visa mx-1"></i>
                                                    <i class="fa fa-cc-mastercard mx-1"></i>
                                                    <i class="fa fa-cc-amex mx-1"></i>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-sm-8">
                                            <div class="form-group">
                                                <label><h6>Expiration Date</h6></label>
                                                <asp:RequiredFieldValidator ID="rfvExpMonth" runat="server" ErrorMessage="Expiry month is required" ControlToValidate="txtExpMonth" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="card" />
                                                <asp:TextBox ID="txtExpMonth" runat="server" CssClass="form-control" placeholder="MM" TextMode="Number"></asp:TextBox>
                                                <asp:TextBox ID="txtExpYear" runat="server" CssClass="form-control" placeholder="YYYY" TextMode="Number"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="form-group mb-4">
                                                <label><h6>CVV</h6></label>
                                                <asp:RequiredFieldValidator ID="rfvCvv" runat="server" ErrorMessage="CVV is required" ControlToValidate="txtCvv" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="card" />
                                                <asp:TextBox ID="txtCvv" runat="server" CssClass="form-control" placeholder="CVV" TextMode="Number"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="txtAddress">
                                            <h6>Delivery Address</h6>
                                        </label>
                                        <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ErrorMessage="Address is required" ControlToValidate="txtAddress" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="card" />
                                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Delivery Address" TextMode="MultiLine" ValidationGroup="card"></asp:TextBox>
                                    </div>

                                    <div class="card-footer">
                                        <asp:LinkButton ID="lbCardSubmit" runat="server" CssClass="subscribe btn btn-info btn-block shadow-sm" ValidationGroup="card" OnClick="lbCardSubmit_Click">Confirm Payment</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                            

                            
                            <div id="paypal" class="tab-pane fade pt-3">
                                <div class="form-group">
                                    <label for="txtCODAddress">
                                        <h6>Delivery Address</h6>
                                    </label>
                                    <asp:TextBox ID="txtCODAddress" runat="server" CssClass="form-control" placeholder="Delivery Address" TextMode="MultiLine"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvCODAddress" runat="server" ErrorMessage="Address is required" ForeColor="Red" ControlToValidate="txtCODAddress" Display="Dynamic" SetFocusOnError="true" ValidationGroup="cod" />
                                </div>

                                <p>
                                    <asp:LinkButton ID="lbCodSubmit" runat="server" CssClass="btn btn-info" ValidationGroup="cod" OnClick="lbCodSubmit_Click">
                                        <i class="fa fa-cart-arrow-down mr-2"></i>Confirm Order</asp:LinkButton>
                                </p>
                                <p class="text-muted">
                                    Note: At the time of receiving your order, you need to make the full payment. After completing the payment process, you can check your updated order status.
                                </p>
                            </div>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
