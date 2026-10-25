<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChiTietDonHang.aspx.cs" Inherits="baiTapLonBanh.ChiTietDonHang" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/TaiKhoan.css?v=1" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container product-page tai-khoan-page">

        <asp:Panel ID="pnlKhongTim" runat="server" Visible="false" CssClass="tk-khoi tk-rong">
            <p>Không tìm thấy đơn hàng này.</p>
            <a href="TaiKhoan.aspx?tab=donhang" class="tk-nut">Về danh sách đơn hàng</a>
        </asp:Panel>

        <asp:Panel ID="pnlChiTiet" runat="server">

            <!-- Dòng đầu: quay lại + mã đơn + trạng thái -->
            <div class="ct-dau">
                <a href="TaiKhoan.aspx?tab=donhang" class="ct-quay-lai">
                    <i class="fa-solid fa-arrow-left"></i> Đơn hàng của tôi
                </a>
                <div class="ct-tieu-de">
                    Đơn <asp:Literal ID="litMaDon" runat="server" />
                    <span class="tk-trang-thai"><asp:Literal ID="litTrangThai" runat="server" /></span>
                </div>
            </div>

            <div class="ct-luoi">

                <!-- ===== TRÁI: SẢN PHẨM ===== -->
                <section class="tk-khoi">
                    <h2>Sản phẩm</h2>
                    <div class="tk-bang-khung">
                        <table class="tk-bang tk-bang-sp">
                            <thead>
                                <tr><th>Sản phẩm</th><th>Đơn giá</th><th>SL</th><th>Thành tiền</th></tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptDong" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td class="ct-o-ten">
                                                <div class="tk-sp">
                                                    <span class="tk-anh">
                                                        <img src='<%# ResolveUrl("~/" + Eval("anhBanh")) %>' alt=''
                                                             onerror="this.parentNode.classList.add('khong-anh');" />
                                                    </span>
                                                    <strong><%# Eval("tenBanh") %></strong>
                                                </div>
                                            </td>
                                            <td data-label="Đơn giá"><%# string.Format("{0:N0}đ", Eval("donGia")) %></td>
                                            <td data-label="Số lượng"><%# Eval("soLuong") %></td>
                                            <td data-label="Thành tiền" class="tk-tien"><%# string.Format("{0:N0}đ", Eval("thanhTien")) %></td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>
                </section>

                <!-- ===== PHẢI: THÔNG TIN + TỔNG TIỀN ===== -->
                <section class="tk-khoi ct-phai">
                    <h2>Thông tin giao hàng</h2>
                    <dl class="tk-thong-tin">
                        <div><dt>Ngày đặt</dt><dd><asp:Literal ID="litNgayDat" runat="server" /></dd></div>
                        <div><dt>Người nhận</dt><dd><asp:Literal ID="litNguoiNhan" runat="server" /></dd></div>
                        <div><dt>Địa chỉ</dt><dd><asp:Literal ID="litDiaChi" runat="server" /></dd></div>
                        <div><dt>Thời gian nhận</dt><dd><asp:Literal ID="litThoiGian" runat="server" /></dd></div>
                        <div><dt>Thanh toán</dt><dd><asp:Literal ID="litThanhToan" runat="server" /></dd></div>
                        <div><dt>Ghi chú</dt><dd><asp:Literal ID="litGhiChu" runat="server" /></dd></div>
                    </dl>

                    <div class="tk-tong">
                        <div><span>Tạm tính</span><span><asp:Literal ID="litTamTinh" runat="server" /></span></div>
                        <div><span>Phí vận chuyển</span><span><asp:Literal ID="litPhiShip" runat="server" /></span></div>
                        <div><span>Giảm giá</span><span><asp:Literal ID="litGiamGia" runat="server" /></span></div>
                        <div class="tk-tong-cong"><span>Tổng cộng</span><span><asp:Literal ID="litTongCong" runat="server" /></span></div>
                    </div>
                </section>

            </div>
        </asp:Panel>
    </div>
</asp:Content>