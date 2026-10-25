<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeBehind="ChiTietSanPham.aspx.cs" Inherits="baiTapLonBanh.ChiTietSanPham" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/ChiTietSanPham.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="product-page">

        <section id="thongTinBanh" runat="server" visible="false" class="chi_tiet_san_pham">

            <div class="khung_anh_banh">
                <img id="anhBanh"
                     runat="server"
                     class="anh_banh_chinh"
                     src="image/SanPham/banh3_SP.jpg"
                     alt="Ảnh sản phẩm"
                     onerror="this.parentNode.classList.add('khong-anh');" />
            </div>

            <div class="noi_dung_banh">
                <p id="loaiBanh" runat="server" class="loai_banh"></p>

                <h1 id="tenBanh" runat="server" class="ten_banh_chi_tiet"></h1>

                <p id="giaBanh" runat="server" class="gia_banh"></p>

                <p id="moTa" runat="server" class="mo_ta_banh"></p>

                <ul id="thongTinChiTiet" runat="server" class="thong_tin_chi_tiet"></ul>

                <!-- Chọn size: chỉ hiện với các loại bánh kem / mousse / sinh nhật -->
                <div id="khuVucSize" runat="server" visible="false" class="chon_size">
                    <p class="nhan_nho">Chọn size bánh</p>

                    <div class="danh_sach_size">
                        <asp:Repeater ID="rptSize" runat="server">
                            <ItemTemplate>
                                <label class="size_item">
                                    <input type="radio"
                                           name="size"
                                           value='<%# Eval("Ma") %>'
                                           data-gia='<%# Eval("Gia") %>'
                                           <%# (bool)Eval("DaChon") ? "checked=\"checked\"" : "" %> />
                                    <span class="size_noi_dung">
                                        <b><%# Eval("Ten") %></b>
                                        <small><%# Eval("SoNguoi") %></small>
                                        <em><%# DinhDangGia(Eval("Gia")) %></em>
                                    </span>
                                </label>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <p class="ghi_chu_tang">
                        <i class="fa-solid fa-utensils"></i> Đã tặng kèm dao, dĩa cắt bánh
                    </p>
                </div>

                <div class="chon_so_luong">
                    <label for="soLuongBanh">Số lượng:</label>

                    <button type="button" id="giamSoLuong" aria-label="Giảm số lượng">−</button>

                    <input type="number"
                           id="soLuongBanh"
                           runat="server"
                           ClientIDMode="Static"
                           value="1"
                           min="1"
                           max="99" />

                    <button type="button" id="tangSoLuong" aria-label="Tăng số lượng">+</button>
                </div>

                <p class="tam_tinh">Tạm tính: <strong id="tamTinhGiaTri"></strong></p>

                <div class="hanh_dong_mua_hang">
                    <button id="btnMuaNgay"
                            runat="server"
                            type="submit"
                            onserverclick="btnMuaNgay_ServerClick">
                        <i class="fa-solid fa-bag-shopping"></i> Mua ngay
                    </button>
                    <button id="btnThemVaoGio"
                            runat="server"
                            type="submit"
                            class="nut_phu"
                            onserverclick="btnThemVaoGio_ServerClick">
                        <i class="fa-solid fa-cart-plus"></i> Thêm vào giỏ hàng
                    </button>
                </div>

                <p id="thongBaoGioHang" runat="server" visible="false" class="thong_bao_gio_hang"></p>
            </div>

        </section>

        <p id="thongBaoLoi" runat="server" visible="false" class="thong_bao_loi">
            Không tìm thấy sản phẩm
        </p>

        <section id="khuVucGoiY" runat="server" class="goi-y-san-pham">

            <div class="goi-y-header">
                <h2>CÓ LẼ BẠN CŨNG SẼ THÍCH</h2>
                <a href="SanPham.aspx" class="nut-xem-them">Xem thêm <i class="fa-solid fa-arrow-right"></i>
                </a>
            </div>

            <p id="thongBaoGoiY" runat="server" visible="false" class="thong_bao_gio_hang"></p>

            <div class="danh-sach-goi-y">
                <asp:Repeater ID="rptDanhSachGoiY" runat="server" OnItemCommand="rptDanhSachGoiY_ItemCommand">
                    <ItemTemplate>
                        <div class="the_san_pham">

                            <a class="goi_y_anh" href='ChiTietSanPham.aspx?id=<%# HttpUtility.UrlEncode(Convert.ToString(Eval("maBanh"))) %>'>
                                <img src='<%# ResolveUrl("~/" + Eval("anhBanh")) %>'
                                     alt='<%# Eval("tenBanh") %>'
                                     onerror="this.parentNode.classList.add('khong-anh');" />
                            </a>

                            <button type="button" class="nut_yeu_thich" aria-label="Yêu thích">
                                <i class="fa-solid fa-heart"></i>
                            </button>

                            <div class="goi_y_noi_dung">
                                <a class="goi_y_ten" href='ChiTietSanPham.aspx?id=<%# HttpUtility.UrlEncode(Convert.ToString(Eval("maBanh"))) %>'>
                                    <%# Eval("tenBanh") %>
                                </a>

                                <div class="goi_y_hang_duoi">
                                    <p class="goi_y_gia"><%# DinhDangGia(Eval("giaBanh")) %></p>

                                    <div class="goi_y_hanh_dong">
                                        <asp:LinkButton runat="server"
                                                        CssClass="nut_mua_ngay"
                                                        CommandName="muaNgay"
                                                        CommandArgument='<%# Eval("maBanh") %>'>
                                            Mua ngay
                                        </asp:LinkButton>

                                        <asp:LinkButton runat="server"
                                                        CssClass="nut_gio_hang"
                                                        CommandName="themGio"
                                                        CommandArgument='<%# Eval("maBanh") %>'
                                                        ToolTip="Thêm vào giỏ hàng">
                                            <i class="fa-solid fa-cart-shopping"></i>
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

        </section>
    </div>
    <script src="JS/ChiTietSanPham.js?v=3"></script>
</asp:Content>
