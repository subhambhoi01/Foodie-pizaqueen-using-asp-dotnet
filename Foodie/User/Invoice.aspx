<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Invoice.aspx.cs" Inherits="Foodie.User.Invoice" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <title>Order Invoice</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f7f7f7;
            padding: 20px;
        }

        .celebration-message {
            text-align: center;
            padding: 20px;
            background-color: #4CAF50;
            color: white;
            font-size: 24px;
            font-weight: bold;
            border-radius: 5px;
            margin-bottom: 30px;
        }

        .order-details {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin: 20px 0;
        }

        .order-details h3 {
            margin-bottom: 20px;
            font-size: 22px;
            color: #333;
        }

        .order-details p {
            font-size: 18px;
            color: #555;
            margin: 5px 0;
        }

        .btn {
            display: inline-block;
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 18px;
            margin-top: 20px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #45a049;
        }

        /* Confetti Animation */
        .confetti {
            position: absolute;
            top: 0;
            left: 50%;
            z-index: 999;
            pointer-events: none;
            visibility: hidden;
        }

        @keyframes confetti-animation {
            0% {
                transform: translateY(-1000px) rotate(45deg);
            }
            100% {
                transform: translateY(1000px) rotate(45deg);
            }
        }

        .confetti .confetti-piece {
            position: absolute;
            top: 0;
            width: 10px;
            height: 10px;
            background-color: red;
            animation: confetti-animation 2s ease-out infinite;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="celebration-message" id="celebrationMessage">
            🎉 Order Placed Successfully! 🎉
        </div>

        <div class="order-details">
            <h3>Order Invoice</h3>
            <p><strong>Order Number:</strong> <asp:Label ID="lblOrderNo" runat="server" Text="OrderNo"></asp:Label></p>
            <p><strong>Order Date:</strong> <asp:Label ID="lblOrderDate" runat="server" Text="OrderDate"></asp:Label></p>
            <p><strong>Status:</strong> <asp:Label ID="lblStatus" runat="server" Text="Status"></asp:Label></p>
            <p><strong>Total Price:</strong> ₹<asp:Label ID="lblTotalAmount" runat="server" Text="TotalAmount"></asp:Label></p>

            <a href="javascript:void(0)" class="btn" id="btnDownload" onclick="downloadInvoice()">Download Invoice</a>
        </div>

        <div id="confettiContainer" class="confetti"></div>

        
        <asp:HiddenField ID="hfOrderNo" runat="server" />
        <asp:HiddenField ID="hfOrderDate" runat="server" />
        <asp:HiddenField ID="hfStatus" runat="server" />
        <asp:HiddenField ID="hfTotalAmount" runat="server" />

    </form>

    <script>
        
        function triggerConfetti() {
            const container = document.getElementById("confettiContainer");

            for (let i = 0; i < 50; i++) {
                let confetti = document.createElement("div");
                confetti.className = "confetti-piece";
                confetti.style.backgroundColor = getRandomColor();
                confetti.style.left = `${Math.random() * 100}vw`;
                confetti.style.animationDuration = `${Math.random() * 1 + 2}s`;
                container.appendChild(confetti);
            }

            setTimeout(() => {
                container.innerHTML = ''; 
            }, 3000); 
        }

        
        function getRandomColor() {
            const colors = ['red', 'green', 'blue', 'orange', 'purple', 'yellow'];
            return colors[Math.floor(Math.random() * colors.length)];
        }

        
        window.onload = function () {
            triggerConfetti();
            // Set Order Details from Hidden Fields
            document.getElementById('lblOrderNo').innerText = "<%= hfOrderNo.Value %>";
            document.getElementById('lblOrderDate').innerText = "<%= hfOrderDate.Value %>";
            document.getElementById('lblStatus').innerText = "<%= hfStatus.Value %>";
            document.getElementById('lblTotalAmount').innerText = "₹" + "<%= hfTotalAmount.Value %>";
        };

        
        function downloadInvoice() {
            alert("Invoice Download feature coming soon!");
        }
    </script>
</body>

</html>
