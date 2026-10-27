<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SanPham.aspx.cs" Inherits="baiTapLonBanh.SanPham" %>
<asp:Content ID="ProductPageHead"
    ContentPlaceHolderID="head"
    runat="server">

  <link href="<%= ResolveUrl("~/CSS/SanPham.css") %>"
      rel="stylesheet" type="text/css" />

</asp:Content>
<asp:Content ID="Content1"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">


    <div class="container product-page">
        <%-- Đang tìm kiếm (?q=...) thì ẩn banner để kết quả hiện lên ngay đầu trang --%>
        <% if (TuKhoa == "") { %>
        <section class="product-hero">
            <img src="product-banner.png" alt="ảnh banner sản phẩm"/>
            <span class="product-kicker">BỘ SƯU TẬP SWEETCAKE</span>
            <h1>Sản phẩm</h1>
            <p>Khám phá các loại bánh của SweetCake</p>
        </section>
        <% } %>

        <!-- LOẠI BÁNH: mỗi mục là một đường dẫn GET (?loai=...), giữ nguyên từ khóa / xem / sắp xếp.
             Đường dẫn kết thúc bằng #khuLoaiBanh nên bấm xong trang tự cuộn tới đây (thấy icon + bộ lọc + bánh), không phải cuộn tay. -->
        <section class="product-category-section" id="khuLoaiBanh">
            <ul class="category-list">
                <li id="tat_ca_loai_banh"
                    class='<%= LoaiHienTai == "" ? "active" : "" %>'>
                    <a href='<%= TaoLienKet("", 1) %>#khuLoaiBanh'>
                        <span class="category-icon"><i class="fa-solid fa-table-cells-large"></i></span>
                        <span class="category-name">Tất cả</span>
                    </a>
                </li>
                <li id="banh_kem"
                    class='<%= LoaiHienTai == "banh_kem" ? "active" : "" %>'>
                    <a href='<%= TaoLienKet("banh_kem", 1) %>#khuLoaiBanh'>
                        <span class="category-icon"><i class="fa-solid fa-cake-candles"></i></span>
                        <span class="category-name">Bánh kem</span>
                    </a>
                </li>
                <li id="banh_tuoi"
                    class='<%= LoaiHienTai == "banh_tuoi" ? "active" : "" %>'>
                    <a href='<%= TaoLienKet("banh_tuoi", 1) %>#khuLoaiBanh'>
                        <span class="category-icon"><i class="fa-solid fa-cookie-bite"></i></span>
                        <span class="category-name">Bánh tươi</span>
                    </a>
                </li>
                <li id="banh_mi"
                    class='<%= LoaiHienTai == "banh_mi" ? "active" : "" %>'>
                    <a href='<%= TaoLienKet("banh_mi", 1) %>#khuLoaiBanh'>
                        <span class="category-icon"><i class="fa-solid fa-bread-slice"></i></span>
                        <span class="category-name">Bánh mì</span>
                    </a>
                </li>
            </ul>
        </section>

        <section class="product-list-section" id="khuDanhSach">
            <!-- Thanh đầu danh sách: tiêu đề + số sản phẩm (trái), Xem / Sắp xếp (phải).
                 Chọn xong sẽ chuyển trang bằng GET (xem SanPham.js).
                 Tìm kiếm nằm ở ô trên thanh điều hướng và gửi ?q=... tới trang này. -->
            <div class="list-head">
                <div class="list-head-title">
                    <h2>Danh sách bánh</h2>
                    <span class="count-badge"><%= TongSoBanh %> sản phẩm</span>
                </div>

                <section class="product-toolbar">
                    <label for="soLuongHienThi">Xem</label>
                    <select id="soLuongHienThi">
                        <option value="1" <%= Chon("1", XemHienTai) %>>1</option>
                        <option value="4" <%= Chon("4", XemHienTai) %>>4</option>
                        <option value="8" <%= Chon("8", XemHienTai) %>>8</option>
                        <option value="12" <%= Chon("12", XemHienTai) %>>12</option>
                        <option value="all" <%= Chon("all", XemHienTai) %>>Tất cả</option>
                    </select>

                    <label for="sapXepSanPham">Sắp xếp theo:</label>
                    <select id="sapXepSanPham">
                        <option value="newest" <%= Chon("newest", SapXepHienTai) %>>Mới nhất</option>
                        <option value="oldest" <%= Chon("oldest", SapXepHienTai) %>>Cũ nhất</option>
                    </select>
                </section>
            </div>

            <% if (TuKhoa != "") { %>
            <div class="loc-dang-chon">
                <span class="chip">
                    Từ khóa: <strong><%= HttpUtility.HtmlEncode(TuKhoa) %></strong>
                    <a href='<%= TaoLienKetBoTuKhoa() %>#khuDanhSach' aria-label="Xóa tìm kiếm" title="Xóa tìm kiếm">✕</a>
                </span>
            </div>
            <% } %>

            <% if (KhongCoBanh) { %>
            <p class="khong-co-banh">Không tìm thấy bánh phù hợp.</p>
            <% } %>

            <div id="danhSachBanh" runat="server"
                 ClientIDMode="Static" class="danh-sach-banh">

                <asp:Repeater ID="rptDanhSachBanh" runat="server">
                    <ItemTemplate>

                        <article class='the_san_pham <%# LayClassSanPham(Eval("loaiBanh").ToString()) %>'>

                            <!-- Bấm ảnh để xem chi tiết bánh -->
                            <a class="lien-ket-anh"
                               href='ChiTietSanPham.aspx?id=<%# HttpUtility.UrlEncode(Eval("maBanh").ToString()) %>'>
                                <img src='<%# ResolveUrl("~/" + Eval("anhBanh")) %>'
                                     alt='<%# HttpUtility.HtmlAttributeEncode(Convert.ToString(Eval("tenBanh"))) %>'
                                     onerror="this.closest('.the_san_pham').classList.add('khong-anh');" />
                            </a>

                            <!-- Bấm tên bánh để xem chi tiết bánh -->
                            <a class="lien-ket-ten"
                               href='ChiTietSanPham.aspx?id=<%# HttpUtility.UrlEncode(Eval("maBanh").ToString()) %>'>
                                <span class="ten_banh"><%# HttpUtility.HtmlEncode(Convert.ToString(Eval("tenBanh"))) %></span>
                            </a>

                            <p class="gia_banh">
                                <%# Eval("giaBanh", "{0:N0}") %>đ
                            </p>

                            <div class="nhom-nut-mua">
                                <!-- Mua ngay: chuyển đến trang đặt hàng -->
                                <a class="nut-mua-ngay"
                                   href='DatHang.aspx?maBanh=<%# HttpUtility.UrlEncode(Eval("maBanh").ToString()) %>'>
                                    <span>Mua ngay</span>
                                </a>

                                <!-- Thêm vào giỏ: không tải lại trang, xử lý bằng JS (xem SanPham.js) -->
                                <button type="button"
                                        class="nut-them-gio"
                                        data-ma-banh='<%# HttpUtility.HtmlAttributeEncode(Convert.ToString(Eval("maBanh"))) %>'
                                        title="Thêm vào giỏ hàng"
                                        aria-label="Thêm vào giỏ hàng">
                                    <i class="fa-solid fa-cart-shopping"></i>
                                </button>
                            </div>

                        </article>
                    </ItemTemplate>
                </asp:Repeater>

            </div>
        </section>

        <!-- PHÂN TRANG: các đường dẫn GET (?trang=2...) do SanPham.aspx.cs tạo sẵn -->
        <section class="product-pagination-section">
            <div id="phanTrang" class="phan_trang"><%= PhanTrangHtml %></div>
        </section>

    <!-- Thông báo thêm giỏ hàng: JS hiện / ẩn, data-url là địa chỉ xử lý thêm giỏ -->
    <div id="thongBaoGioHang"
         class="thong-bao-gio-hang an-thong-bao"
         role="status"
         aria-live="polite"
         data-url='<%= ResolveUrl("~/ThemGioHang.ashx") %>'></div>
    </div>
    <!-- NÚT LÊN ĐẦU TRANG -->
<button type="button"
        id="btnLenDauTrang"
        class="btn-len-dau"
        title="Lên đầu trang"
        aria-label="Lên đầu trang">
    <i class="fa-solid fa-arrow-up"></i>
</button>
    <script src="<%= ResolveUrl("~/JS/SanPham.js") %>"></script>
</asp:Content>
