<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SanPham.aspx.cs" Inherits="baiTapLonBanh.SanPham" %>
<asp:Content ID="ProductPageHead"
    ContentPlaceHolderID="head"
    runat="server">

   <link href="CSS/SanPham.css" rel="stylesheet" type="text/css" />

</asp:Content>
<asp:Content ID="Content1"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">
    <div class="container product-page">

        <section class="product-hero">
            <h1>Sản phẩm</h1>
            <p>Khám phá các loại bánh của SweetCake</p>
            <img src="product-banner.png" alt="ảnh banner sản phẩm"/>
        </section>
        <!-- Loại bánh -->
        <section class="product-category-section">
            <h2>Loại bánh</h2>
            <ul class="category-list">
                <li id="tat_ca_loai_banh"><a href="#">Tất cả</a></li>
                <li id="banh_kem"><a href="#">Bánh kem</a></li>
                <li id="banh_mousse"><a href="#">Bánh mousse</a></li>
                <li id="banh_sinh_nhat"><a href="#">Bánh sinh nhật</a></li>
            </ul>
        </section>
        <!-- Tìm kiếm -->
        <section class="product-search-section">
            <h2>Tìm kiếm</h2>
            <input type="text" id="timKiemBanh" placeholder="Nhập tên bánh..." /> 
        </section>
        <!-- Chọn số lượng và sắp xếp -->
        <section class="product-toolbar">
            <label for="soLuongHienThi">Xem</label>
            <select id="soLuongHienThi">
                <option value="1">1</option>
                <option value="6">6</option>
                <option value="9">9</option>
                <option value="12">12</option>
                <option value="all">All</option>
            </select>
            <label for="sapXepSanPham">Sắp xếp theo:</label>
            <select id="sapXepSanPham">
                <option value="newest">Mới nhất</option>
                <option value="oldest">Cũ nhất</option>
            </select>
        </section>
        <!-- Danh sách bánh -->
        <section class="product-list-section">
            <h2>Danh sách bánh</h2>
            <div id="danhSachBanh" runat="server">
            </div>
        </section>
        <section class="product-pagination-section">
            <div id="phanTrang" class="phan_trang"></div>
        </section>
    </div>
    <script src="JS/SanPham.js"></script>
</asp:Content>
