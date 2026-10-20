<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DangKy.aspx.cs" Inherits="baiTapLonBanh.DangKy" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/DangNhapvaDangKy.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Nhúng CSS riêng dùng chung cho Đăng Nhập / Đăng Ký -->
        <div class="dangky-layout">

    <!-- Cột bên trái: Form đăng ký -->
    <div class="dangky-form">
        <div class="auth-container">

            <div class="brand-header">
                <h2>✨ Đăng Ký Tài Khoản</h2>
                <p>Trở thành thành viên của SweetCake ngay hôm nay!</p>
            </div>

            <div class="form-group">
                <label for="fullname">Họ và tên</label>
                <input type="text" id="fullname" name="fullname"
                       placeholder="Nhập họ và tên"
                       required="required"
                       aria-describedby="loiFullname" />

                <span id="loiFullname"
                      class="field-error"
                      runat="server"
                      ClientIDMode="Static"
                      aria-live="polite"></span>
            </div>

            <div class="form-group">
                <label for="username">Tên đăng nhập</label>
                <input type="text" id="username" name="username"
                       placeholder="Nhập tên đăng nhập"
                       required="required"
                       aria-describedby="loiUsername" />

                <span id="loiUsername"
                      class="field-error"
                      runat="server"
                      ClientIDMode="Static"
                      aria-live="polite"></span>
            </div>

            <div class="form-group">
                <label for="password">Mật khẩu</label>
                <input type="password" id="password" name="password"
                       placeholder="Nhập mật khẩu"
                       required="required"
                       aria-describedby="loiPassword" />

                <span id="loiPassword"
                      class="field-error"
                      runat="server"
                      ClientIDMode="Static"
                      aria-live="polite"></span>
            </div>

            <div class="form-group">
                <label for="confirm_password">Xác nhận mật khẩu</label>
                <input type="password"
                       id="confirm_password"
                       name="confirm_password"
                       placeholder="Nhập lại mật khẩu"
                       required="required"
                       aria-describedby="loiConfirmPassword" />

                <span id="loiConfirmPassword"
                      class="field-error"
                      runat="server"
                      ClientIDMode="Static"
                      aria-live="polite"></span>
            </div>

            <button type="submit" class="btn-submit">Đăng Ký</button>

            <div class="auth-footer">
                Đã có tài khoản?
                <a href="DangNhap.aspx">Đăng nhập ngay</a>
            </div>

        </div>
    </div>
    <div class="dangky-thongbao">
        <div id="divThongBao" runat="server"></div>
    </div>

</div> 

<script src="JS/DangKy.js"></script>

</asp:Content>
