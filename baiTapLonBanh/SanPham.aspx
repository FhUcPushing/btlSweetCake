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
            <img src="product-banner.png" alt="ảnh banner sản phẩm"/>
            <span class="product-kicker">BỘ SƯU TẬP SWEETCAKE</span>
            <h1>Sản phẩm</h1>
            <p>Khám phá các loại bánh của SweetCake</p>
        </section>
        <section class="product-category-section">
            <h2>Loại bánh</h2>
            <ul class="category-list">
                <li id="tat_ca_loai_banh"
    class='<%= string.IsNullOrEmpty(Request.QueryString["loai"]) ? "active" : "" %>'>
                    <a href="SanPham.aspx">
                        <span class="category-icon"><i class="fa-solid fa-table-cells-large"></i></span>
                        <span class="category-name">Tất cả</span>
                    </a>
                </li>
                            <li id="banh_kem"
    class='<%= Request.QueryString["loai"] == "banh_kem" ? "active" : "" %>'>
                    <a href="?loai=banh_kem">
                        <span class="category-icon"><i class="fa-solid fa-cake-candles"></i></span>
                        <span class="category-name">Bánh kem</span>
                    </a>
                </li>
                            <li id="banh_tuoi"
    class='<%= Request.QueryString["loai"] == "banh_tuoi" ? "active" : "" %>'>
                    <a href="?loai=banh_tuoi">
                        <span class="category-icon"><i class="fa-solid fa-cookie-bite"></i></span>
                        <span class="category-name">Bánh tươi</span>
                    </a>
                </li>
                            <li id="banh_mi"
    class='<%= Request.QueryString["loai"] == "banh_mi" ? "active" : "" %>'>
                    <a href="?loai=banh_mi">
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
            <div id="danhSachBanh" runat="server"
     ClientIDMode="Static"
     class="danh-sach-banh">

    

<asp:Repeater ID="rptDanhSachBanh" runat="server">
    <ItemTemplate>

        <article class='<%# LayClassSanPham(Eval("loaiBanh").ToString()) %>'
                 data-ngay-tao='<%# Eval("ngayTao", "{0:yyyy-MM-dd}") %>'>

            <img src='<%# ResolveUrl("~/" + Eval("anhBanh")) %>'
                 alt='<%# Eval("tenBanh") %>'
                 onerror="this.parentNode.classList.add('khong-anh');" />

            <p class="ten_banh">
                <%# Eval("tenBanh") %>
            </p>

            <p class="gia_banh">
                <%# Eval("giaBanh", "{0:N0}") %>đ
            </p>

            <a href='ChiTietSanPham.aspx?id=<%# Eval("maBanh") %>'>
                Xem bánh
            </a>

        </article>

    </ItemTemplate>
</asp:Repeater>



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
