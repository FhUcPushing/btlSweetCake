<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DatHang.aspx.cs" Inherits="baiTapLonBanh.DatHang" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/DatHang.css?v=1" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container product-page dat-hang-page">

        <h1>Đặt hàng</h1>

        <!-- ================= FORM ĐẶT HÀNG ================= -->
        <asp:Panel ID="pnlDatHang" runat="server">

            <div id="khungLoi" runat="server" visible="false" class="dat-hang-loi"></div>

            <div class="dat-hang-luoi">

                <!-- ===== CỘT TRÁI: THÔNG TIN ===== -->
                <div class="dat-hang-trai">

                    <!-- 1. Thông tin người nhận -->
                    <section class="khoi-dat-hang">
                        <h2><span class="so-buoc">1</span> Thông tin người nhận</h2>

                        <div class="hai-cot">
                            <div class="o-truong">
                                <label class="nhan-o" for="<%= txtHoTen.ClientID %>">Họ và tên <span class="bat-buoc">*</span></label>
                                <asp:TextBox ID="txtHoTen" runat="server" CssClass="o-nhap" MaxLength="60" placeholder="Nguyễn Văn A" />
                            </div>
                            <div class="o-truong">
                                <label class="nhan-o" for="<%= txtSoDienThoai.ClientID %>">Số điện thoại <span class="bat-buoc">*</span></label>
                                <asp:TextBox ID="txtSoDienThoai" runat="server" CssClass="o-nhap" MaxLength="15" placeholder="0901 234 567" />
                            </div>
                        </div>

                        <div class="o-truong">
                            <label class="nhan-o" for="<%= txtEmail.ClientID %>">Email (không bắt buộc)</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="o-nhap" MaxLength="100" placeholder="email@example.com" />
                        </div>

                        <div class="o-truong">
                            <label class="nhan-o" for="<%= txtDiaChi.ClientID %>">Địa chỉ nhận hàng <span class="bat-buoc">*</span></label>
                            <asp:TextBox ID="txtDiaChi" runat="server" CssClass="o-nhap" MaxLength="200" placeholder="Số nhà, đường, phường/xã, quận/huyện, tỉnh/thành phố" />
                        </div>
                    </section>

                    <!-- 2. Thời gian nhận hàng -->
                    <section class="khoi-dat-hang">
                        <h2><span class="so-buoc">2</span> Thời gian nhận hàng</h2>

                        <div class="hai-cot">
                            <div class="o-truong">
                                <label class="nhan-o" for="<%= ngayNhan.ClientID %>">Ngày nhận <span class="bat-buoc">*</span></label>
                                <input type="date" id="ngayNhan" runat="server" class="o-nhap" />
                            </div>
                            <div class="o-truong">
                                <label class="nhan-o" for="<%= ddlGio.ClientID %>">Khung giờ <span class="bat-buoc">*</span></label>
                                <asp:DropDownList ID="ddlGio" runat="server" CssClass="o-nhap">
                                    <asp:ListItem Value="" Text="-- Chọn khung giờ --" />
                                    <asp:ListItem Value="8" Text="08:00 - 10:00" />
                                    <asp:ListItem Value="10" Text="10:00 - 12:00" />
                                    <asp:ListItem Value="12" Text="12:00 - 14:00" />
                                    <asp:ListItem Value="14" Text="14:00 - 16:00" />
                                    <asp:ListItem Value="16" Text="16:00 - 18:00" />
                                    <asp:ListItem Value="18" Text="18:00 - 20:00" />
                                </asp:DropDownList>
                            </div>
                        </div>
                    </section>

                    <!-- 3. Lưu ý về đơn hàng -->
                    <section class="khoi-dat-hang">
                        <h2><span class="so-buoc">3</span> Lưu ý về đơn hàng</h2>

                        <div class="o-truong">
                            <asp:TextBox ID="txtGhiChu" runat="server" TextMode="MultiLine" Rows="4" MaxLength="300"
                                CssClass="o-nhap" placeholder="Ví dụ: ghi chữ lên bánh, không lấy nến, gọi trước khi giao..." />
                        </div>
                    </section>

                    <!-- 4. Phương thức thanh toán -->
                    <section class="khoi-dat-hang">
                        <h2><span class="so-buoc">4</span> Phương thức thanh toán</h2>

                        <div class="danh-sach-thanh-toan">
                            <label class="the-thanh-toan">
                                <input type="radio" name="thanhToan" value="cod" <%= DaChon("cod") %> />
                                <span class="tt-bieu-tuong"><i class="fa-solid fa-money-bill-wave"></i></span>
                                <span class="tt-noi-dung">
                                    <strong>Thanh toán khi nhận hàng (COD)</strong>
                                    <small>Trả tiền mặt khi nhận bánh.</small>
                                </span>
                            </label>

                            <label class="the-thanh-toan">
                                <input type="radio" name="thanhToan" value="chuyenkhoan" <%= DaChon("chuyenkhoan") %> />
                                <span class="tt-bieu-tuong"><i class="fa-solid fa-building-columns"></i></span>
                                <span class="tt-noi-dung">
                                    <strong>Chuyển khoản ngân hàng</strong>
                                    <small>Thông tin tài khoản sẽ được gửi sau khi xác nhận đơn.</small>
                                </span>
                            </label>

                            <label class="the-thanh-toan">
                                <input type="radio" name="thanhToan" value="momo" <%= DaChon("momo") %> />
                                <span class="tt-bieu-tuong"><i class="fa-solid fa-wallet"></i></span>
                                <span class="tt-noi-dung">
                                    <strong>Ví MoMo</strong>
                                    <small>Thanh toán nhanh bằng ví điện tử.</small>
                                </span>
                            </label>
                        </div>
                    </section>

                </div>

                <!-- ===== CỘT PHẢI: TÓM TẮT ĐƠN HÀNG ===== -->
                <aside class="dat-hang-phai">
                    <div class="tom-tat">
                        <h2>Đơn hàng của bạn</h2>

                        <div class="tt-danh-sach">
                            <asp:Repeater ID="rptTomTat" runat="server">
                                <ItemTemplate>
                                    <div class="tt-dong">
                                        <div class="tt-anh">
                                            <img src='<%# ResolveUrl("~/" + Eval("anhBanh")) %>'
                                                 alt='<%# Eval("tenBanh") %>'
                                                 onerror="this.parentNode.classList.add('khong-anh');" />
                                        </div>
                                        <div class="tt-ten">
                                            <%# Eval("tenBanh") %>
                                            <span>Số lượng: <%# Eval("soLuong") %></span>
                                        </div>
                                        <div class="tt-gia"><%# string.Format("{0:N0}đ", Eval("thanhTien")) %></div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>

                        <!-- Mã giảm giá -->
                        <asp:Panel ID="pnlMaGiamGia" runat="server" DefaultButton="btnApDungMa" CssClass="khung-ma">
                            <label class="nhan-o" for="<%= txtMaGiamGia.ClientID %>">Mã giảm giá</label>
                            <div class="hang-ma">
                                <asp:TextBox ID="txtMaGiamGia" runat="server" CssClass="o-nhap" MaxLength="20" placeholder="Nhập mã giảm giá" />
                                <asp:Button ID="btnApDungMa" runat="server" Text="Áp dụng"
                                    CssClass="nut-ap-dung" CausesValidation="false" OnClick="btnApDungMa_Click" />
                            </div>
                            <p id="thongBaoMa" runat="server" visible="false"></p>
                        </asp:Panel>

                        <!-- Các khoản tiền -->
                        <div class="tt-hang">
                            <span>Tạm tính</span>
                            <span><asp:Literal ID="litTamTinh" runat="server" /></span>
                        </div>
                        <div class="tt-hang">
                            <span>Phí vận chuyển</span>
                            <span><asp:Literal ID="litPhiShip" runat="server" /></span>
                        </div>
                        <p id="ghiChuShip" runat="server" class="ghi-chu-ship"></p>
                        <div class="tt-hang tt-giam">
                            <span>Giảm giá</span>
                            <span><asp:Literal ID="litGiamGia" runat="server" /></span>
                        </div>
                        <div class="tt-hang tt-tong">
                            <span>Tổng cộng</span>
                            <span><asp:Literal ID="litTongCong" runat="server" /></span>
                        </div>

                        <asp:LinkButton ID="btnXacNhanDatHang" runat="server" CssClass="nut-hong nut-day"
                            OnClick="btnXacNhanDatHang_Click">
                            <i class="fa-solid fa-circle-check"></i> Xác nhận đặt hàng
                        </asp:LinkButton>

                        <a href="GioHang.aspx" class="quay-lai-gio">
                            <i class="fa-solid fa-arrow-left"></i> Quay lại giỏ hàng
                        </a>
                    </div>
                </aside>

            </div>
        </asp:Panel>

        <!-- ================= ĐẶT HÀNG THÀNH CÔNG ================= -->
        <asp:Panel ID="pnlThanhCong" runat="server" Visible="false" CssClass="dat-hang-thanh-cong">
            <div class="tc-icon"><i class="fa-solid fa-circle-check"></i></div>
            <h2>Đặt hàng thành công!</h2>
            <p class="tc-loi-cam-on">
                Cảm ơn bạn đã tin tưởng SweetCake. Mã đơn hàng của bạn là
                <strong><asp:Literal ID="litMaDon" runat="server" /></strong>
            </p>

            <dl class="tc-chi-tiet">
                <div><dt>Người nhận</dt><dd><asp:Literal ID="litNguoiNhan" runat="server" /></dd></div>
                <div><dt>Địa chỉ</dt><dd><asp:Literal ID="litDiaChi" runat="server" /></dd></div>
                <div><dt>Thời gian nhận</dt><dd><asp:Literal ID="litThoiGian" runat="server" /></dd></div>
                <div><dt>Thanh toán</dt><dd><asp:Literal ID="litThanhToan" runat="server" /></dd></div>
                <div class="tc-tong"><dt>Tổng thanh toán</dt><dd><asp:Literal ID="litTongThanhToan" runat="server" /></dd></div>
            </dl>

            <a href="SanPham.aspx" class="nut-hong">
                <i class="fa-solid fa-cake-candles"></i> Tiếp tục mua sắm
            </a>
        </asp:Panel>

    </div>
</asp:Content>
