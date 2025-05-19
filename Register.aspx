<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="../Assest/bootsrap/bootstrap-5.3.3-dist/css/bootstrap.rtl.min.css" />
    <script type="text/javascript" src="../Assest/bootsrap/bootstrap-5.3.3-dist/js/bootstrap.min.js"></script>
    <style>
        body {
            background: linear-gradient(135deg, #667eea, #764ba2);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Poppins', sans-serif;
        }
        .register-container {
            max-width: 450px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            animation: fadeIn 0.5s ease-in-out;
            color: white;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .form-control {
            background: rgba(255, 255, 255, 0.2);
            border: none;
            padding: 12px;
            color: #fff;
            transition: 0.3s ease;
        }
        .form-control:focus {
            background: rgba(255, 255, 255, 0.3);
            outline: none;
            box-shadow: none;
        }
        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }
        .btn-primary {
            background: #ff6f61;
            border: none;
            padding: 12px;
            transition: 0.3s;
        }
        .btn-primary:hover {
            background: #e64a45;
        }
        .login-link {
            color: #fff;
            text-align: center;
            display: block;
            margin-top: 15px;
            font-size: 14px;
            transition: 0.3s;
        }
        .login-link:hover {
            color: #ffcf56;
            text-decoration: underline;
        }
        .input-group-text {
            background: rgba(255, 255, 255, 0.2);
            border: none;
            color: #fff;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="register-container text-white">
                <h3 class="text-center mb-4">Create an Account</h3>

                <div class="mb-3 input-group">
                    <span class="input-group-text"><i class="bi bi-person"></i></span>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Full Name" required></asp:TextBox>
                </div>

                <div class="mb-3 input-group">
                    <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="Email Address" required></asp:TextBox>
                </div>

                <div class="mb-3 input-group">
                    <span class="input-group-text"><i class="bi bi-lock"></i></span>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Password" required></asp:TextBox>
                </div>

                <div class="mb-3 input-group">
                    <span class="input-group-text"><i class="bi bi-lock"></i></span>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Confirm Password" required></asp:TextBox>
                </div>

                <div class="mb-3 input-group">
                    <span class="input-group-text"><i class="bi bi-telephone"></i></span>
                    <asp:TextBox ID="txtContact" runat="server" CssClass="form-control" TextMode="Phone" placeholder="Contact Number" required></asp:TextBox>
                </div>

                <div class="mb-3 input-group">
                    <span class="input-group-text"><i class="bi bi-geo-alt"></i></span>
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" placeholder="Address" required></asp:TextBox>
                </div>

                <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-primary w-100" OnClick="btnRegister_Click" />

                <!-- Already have an account? Link -->
                <a href="Login.aspx" class="login-link">Already have an account? Log in</a>
            </div>
        </div>
    </form>
</body>
</html>
