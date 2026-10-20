<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="baiTapLonBanh.DangNhap" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/DangNhapvaDangKy.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="auth-container">
        <div class="brand-header">
            <h2>🍰 Đăng Nhập</h2>
            <p>Chào mừng bạn quay lại với SweetCake!</p>
        </div>

        
<div class="form-group">
    <label for="username">Tên đăng nhập</label>
    <input type="text"
           id="username"
           name="username"
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
    <input type="password"
           id="password"
           name="password"
           placeholder="Nhập mật khẩu"
           required="required"
           aria-describedby="loiPassword" />

    <span id="loiPassword"
          class="field-error"
          runat="server"
          ClientIDMode="Static"
          aria-live="polite"></span>
</div>

        <div class="form-group remember-me">
    <label>
        <input type="checkbox" id="chkRemember" name="remember" value="true" />
        <span>Ghi nhớ mật khẩu</span>
    </label>
</div>

        <button type="submit" class="btn-submit">Đăng Nhập</button>
        <div id="divThongBao" runat="server"></div>

        <div class="auth-footer">
            Chưa có tài khoản? <a href="DangKy.aspx">Đăng ký ngay</a>
        </div>
    </div>
    <script src="JS/DangNhap.js"> </script>
</asp:Content>

