<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeBehind="ChiTietSanPham.aspx.cs" Inherits="baiTapLonBanh.ChiTietSanPham" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/ChiTietSanPham.css?v=3" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content1"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">
    <div class="container product-page">

        <section id="thongTinBanh"
                 runat="server"
                 visible="false"
                 class="chi_tiet_san_pham">

            <div class="khung_anh_banh">
                <img id="anhBanh"
                     runat="server"
                     class="anh_banh_chinh"
                     src="image/SanPham/banh3_SP.ipg"
                     alt="Ảnh sản phẩm" />
            </div>

            <div class="noi_dung_banh">
                <h2 id="loaiBanh" runat="server" class="loai_banh"></h2>

                <h1 id="tenBanh" runat="server" class="ten_banh_chi_tiet"></h1>

                <p id="moTa" runat="server" class="mo_ta_banh"></p>

                <p id="giaBanh" runat="server" class="gia_banh"></p>

                <div class="chon_so_luong">
                    <label for="soLuongBanh">Số lượng:</label>

                    <button type="button" id="giamSoLuong">−</button>

                    <input type="number"
                           id="soLuongBanh"
                           runat="server"
                           ClientIDMode="Static"
                           value="1"
                           min="1" />

                    <button type="button" id="tangSoLuong">+</button>
                </div>

                <div class="hanh_dong_mua_hang">
                    <button id="btnThemVaoGio"
                            runat="server"
                            type="submit"
                            onserverclick="btnThemVaoGio_ServerClick">
                        <i class="fa-solid fa-cart-shopping"></i> Thêm vào giỏ hàng
                    </button>
                    <a id="btnMuaNgay"
                       runat="server"
                       onserverclick="btnMuaNgay_ServerClick">
                        Mua ngay
                    </a>
                </div>

                <p id="thongBaoGioHang" runat="server" visible="false" class="thong_bao_gio_hang"></p>
            </div>

        </section>

        <p id="thongBaoLoi" runat="server" visible="false"
           class="thong_bao_loi">
            Không tìm thấy sản phẩm
        </p>

        <section id="khuVucGoiY"
                 runat="server"
                 class="goi-y-san-pham">

            <div class="goi-y-header">
                <h2>CÓ LẼ BẠN CŨNG SẼ THÍCH</h2>
                <a href="SanPham.aspx" class="nut-xem-them">
                    Xem thêm <i class="fa-solid fa-arrow-right"></i>
                </a>
            </div>

            <div id="danhSachGoiY"
                 runat="server"
                 class="danh-sach-goi-y">
            </div>

        </section>
    </div>
    <script src="JS/ChiTietSanPham.js"></script>
</asp:Content>
