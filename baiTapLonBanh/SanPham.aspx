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

        <!-- BANNER ĐẦU TRANG -->
        <section class="product-hero">
            <img src="product-banner.png" alt="ảnh banner sản phẩm"/>
            <span class="product-kicker">BỘ SƯU TẬP SWEETCAKE</span>
            <h1>Sản phẩm</h1>
            <p>Khám phá các loại bánh của SweetCake</p>
        </section>

        <!-- LOẠI BÁNH: hình tròn, icon ở giữa, tên ở dưới.
             "Tất cả" là vòng tròn đầu tiên. Giữ nguyên id của từng thẻ li
             (SanPham.js dùng id này để lọc; mục đang chọn được thêm class "active" -> hồng). -->
        <section class="product-category-section">
            <h2>Loại bánh</h2>
            <ul class="category-list">
                <li id="tat_ca_loai_banh" class="active">
                    <a href="#">
                        <span class="category-icon"><i class="fa-solid fa-table-cells-large"></i></span>
                        <span class="category-name">Tất cả</span>
                    </a>
                </li>
                <li id="banh_kem">
                    <a href="#">
                        <span class="category-icon"><i class="fa-solid fa-cake-candles"></i></span>
                        <span class="category-name">Bánh kem</span>
                    </a>
                </li>
                <li id="banh_tuoi">
                    <a href="#">
                        <span class="category-icon"><i class="fa-solid fa-cookie-bite"></i></span>
                        <span class="category-name">Bánh tươi</span>
                    </a>
                </li>
                <li id="banh_mi">
                    <a href="#">
                        <span class="category-icon"><i class="fa-solid fa-bread-slice"></i></span>
                        <span class="category-name">Bánh mì</span>
                    </a>
                </li>
            </ul>
        </section>

        <section class="product-search-section">
            <h2>Tìm kiếm</h2>
            <input type="text" id="timKiemBanh" placeholder="Nhập tên bánh..." /> 
        </section>

        <section class="product-toolbar">
            <label for="soLuongHienThi">Xem</label>
            <select id="soLuongHienThi">
                <option value="1">1</option>
                <option value="6">6</option>
                <option value="9" selected="selected">9</option>
                <option value="12">12</option>
                <option value="all">All</option>
            </select>
            <label for="sapXepSanPham">Sắp xếp theo:</label>
            <select id="sapXepSanPham">
                <option value="newest">Mới nhất</option>
                <option value="oldest">Cũ nhất</option>
            </select>
        </section>

        <section class="product-list-section">
            <h2>Danh sách bánh</h2>
            <!-- ClientIDMode="Static": giữ nguyên id "danhSachBanh" khi chạy (không bị ASP.NET đổi tên),
                 nên CSS dạng lưới và file JS đều tìm thấy khung này -->
            <div id="danhSachBanh" runat="server" ClientIDMode="Static" class="danh-sach-banh">
            </div>
        </section>
        <section class="product-pagination-section">
            <div id="phanTrang" class="phan_trang"></div>
        </section>
    </div>
    <script src="JS/SanPham.js"></script>

    <!-- XEM 1 SAN PHAM: khung ngang to. Xem 6 / 9 / 12 / All: khung nho theo luoi -->
    <script>
        (function () {
            var chon = document.getElementById("soLuongHienThi");
            var danhSach = document.getElementById("danhSachBanh");

            if (!chon || !danhSach) return;

            function capNhatKieuKhung() {
                danhSach.classList.toggle("xem-1", chon.value === "1");
            }

            chon.addEventListener("change", capNhatKieuKhung);
            capNhatKieuKhung();
        })();
    </script>
</asp:Content>
