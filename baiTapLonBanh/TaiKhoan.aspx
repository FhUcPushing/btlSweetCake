<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TaiKhoan.aspx.cs" Inherits="baiTapLonBanh.TaiKhoan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/TaiKhoan.css?v=1" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container product-page tai-khoan-page">
        <h1>Tài khoản của tôi</h1>

        <div class="tk-luoi">
            <!-- ===== MENU TRÁI ===== -->
            <aside class="tk-menu">
                <div class="tk-chao">
                    <i class="fa-solid fa-circle-user"></i>
                    <strong><asp:Literal ID="litHoTen" runat="server" /></strong>
                    <span>@<asp:Literal ID="litTenDN" runat="server" /></span>
                </div>
                <a href="TaiKhoan.aspx?tab=thongtin" class='<%= tab == "thongtin" ? "dang-chon" : "" %>'>
                    <i class="fa-regular fa-id-card"></i> Thông tin tài khoản
                </a>
                <a href="TaiKhoan.aspx?tab=donhang" class='<%= tab == "donhang" ? "dang-chon" : "" %>'>
                    <i class="fa-solid fa-receipt"></i> Đơn hàng của tôi
                </a>
                <a href="DangNhap.aspx?dangxuat=1" class="tk-dang-xuat">
                    <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
                </a>
            </aside>

            <!-- ===== NỘI DUNG PHẢI ===== -->
            <div class="tk-noi-dung">

                <!-- TAB: THÔNG TIN TÀI KHOẢN -->
              <asp:Panel ID="pnlThongTin" runat="server" DefaultButton="btnCapNhat">
    <section class="tk-khoi">
        <h2>Thông tin tài khoản</h2>
        <div id="msgCapNhat" runat="server" visible="false"></div>

        <div class="tk-hang">
            <div class="tk-truong">
                <label class="tk-nhan" for="<%= txtHoTen.ClientID %>">Họ và tên</label>
                <asp:TextBox ID="txtHoTen" runat="server" CssClass="tk-o" MaxLength="50" />
                <span id="loiHoTen" runat="server" class="tk-loi"></span>
            </div>
            <div class="tk-truong">
                <label class="tk-nhan" for="<%= txtTenMoi.ClientID %>">Tên đăng nhập</label>
                <asp:TextBox ID="txtTenMoi" runat="server" CssClass="tk-o" MaxLength="20" />
                <span id="loiTenDN" runat="server" class="tk-loi"></span>
            </div>
        </div>

        <p class="tk-tieu-de-nho">Đổi mật khẩu <span>(bỏ trống nếu không muốn đổi)</span></p>
        <div class="tk-hang tk-ba">
            <div class="tk-truong">
                <label class="tk-nhan" for="<%= txtMkCu.ClientID %>">Mật khẩu hiện tại</label>
                <asp:TextBox ID="txtMkCu" runat="server" TextMode="Password" CssClass="tk-o" />
                <span id="loiMkCu" runat="server" class="tk-loi"></span>
            </div>
            <div class="tk-truong">
                <label class="tk-nhan" for="<%= txtMkMoi.ClientID %>">Mật khẩu mới</label>
                <asp:TextBox ID="txtMkMoi" runat="server" TextMode="Password" CssClass="tk-o" />
                <span id="loiMkMoi" runat="server" class="tk-loi"></span>
            </div>
            <div class="tk-truong">
                <label class="tk-nhan" for="<%= txtMkLai.ClientID %>">Nhập lại mật khẩu mới</label>
                <asp:TextBox ID="txtMkLai" runat="server" TextMode="Password" CssClass="tk-o" />
                <span id="loiMkLai" runat="server" class="tk-loi"></span>
            </div>
        </div>

        <asp:Button ID="btnCapNhat" runat="server" Text="Cập nhật" CssClass="tk-nut" OnClick="btnCapNhat_Click" />
    </section>
</asp:Panel>

<script>
    // Gõ lại vào ô nào thì dòng đỏ và viền đỏ của ô đó mất đi
    document.addEventListener("DOMContentLoaded", function () {
        document.querySelectorAll(".tk-truong .tk-o").forEach(function (o) {
            o.addEventListener("input", function () {
                var loi = o.parentNode.querySelector(".tk-loi");
                if (loi) loi.textContent = "";
                o.classList.remove("tk-o-loi");
            });
        });
    });
</script>

                <!-- TAB: ĐƠN HÀNG -->
                <asp:Panel ID="pnlDonHang" runat="server">
                    <section class="tk-khoi">
                        <h2>Lịch sử đơn hàng</h2>

                        <asp:Panel ID="pnlDonRong" runat="server" Visible="false" CssClass="tk-rong">
                            <p>Bạn chưa có đơn hàng nào.</p>
                            <a href="SanPham.aspx" class="tk-nut">Mua sắm ngay</a>
                        </asp:Panel>

                        <asp:Panel ID="pnlCoDon" runat="server" Visible="false" CssClass="tk-bang-khung">
                           <table class="tk-bang tk-bang-don">
                                <thead>
                                    <tr><th>Mã đơn</th><th>Ngày đặt</th><th>Số bánh</th><th>Tổng tiền</th><th>Trạng thái</th><th></th></tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptDon" runat="server">
                                        <ItemTemplate>
    <tr>
        <td data-label="Mã đơn"><strong><%# Eval("MaDon") %></strong></td>
        <td data-label="Ngày đặt"><%# Eval("NgayDat") %></td>
        <td data-label="Số bánh"><%# Eval("SoMon") %></td>
        <td data-label="Tổng tiền" class="tk-tien"><%# string.Format("{0:N0}đ", Eval("TongCong")) %></td>
        <td data-label="Trạng thái"><span class="tk-trang-thai"><%# Eval("TrangThai") %></span></td>
        <td class="tk-hanh-dong"><a class="tk-xem" href='ChiTietDonHang.aspx?ma=<%# Eval("MaDon") %>'>Xem chi tiết</a></td>
    </tr>
</ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </asp:Panel>
                    </section>
                </asp:Panel>

            </div>
        </div>
    </div>
</asp:Content>