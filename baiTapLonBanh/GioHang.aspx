<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GioHang.aspx.cs" Inherits="baiTapLonBanh.GioHang" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/GioHang.css?v=1" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container product-page gio-hang-page">

        <h1>Giỏ hàng của bạn</h1>

        <!-- Giỏ hàng trống -->
        <asp:Panel ID="thongBaoRong" runat="server" Visible="false" CssClass="gio-hang-rong">
            <div class="rong-icon"><i class="fa-solid fa-cart-shopping"></i></div>
            <p>Giỏ hàng của bạn đang trống.</p>
            <a href="SanPham.aspx" class="nut-hong">
                <i class="fa-solid fa-arrow-left"></i> Tiếp tục mua hàng
            </a>
        </asp:Panel>

        <!-- Giỏ hàng có sản phẩm -->
        <asp:Panel ID="panelGioHang" runat="server" Visible="false">

            <div class="bang-gio-hang-khung">
                <table class="bang-gio-hang">
                    <thead>
                        <tr>
                            <th>Sản phẩm</th>
                            <th>Đơn giá</th>
                            <th>Số lượng</th>
                            <th>Thành tiền</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>

                    <tbody>
                        <asp:Repeater ID="rptGioHang"
                            runat="server"
                            OnItemCommand="rptGioHang_ItemCommand">

                            <ItemTemplate>
                                <tr>
                                    <td class="cot-san-pham">
                                        <div class="san-pham-o">
                                            <div class="anh-nho">
                                                <img src='<%# ResolveUrl("~/" + Eval("anhBanh")) %>'
                                                     alt='<%# Eval("tenBanh") %>'
                                                     onerror="this.parentNode.classList.add('khong-anh');" />
                                            </div>
                                            <span class="ten-banh-gio"><%# Eval("tenBanh") %></span>
                                        </div>
                                    </td>

                                    <td data-label="Đơn giá">
                                        <%# string.Format("{0:N0}đ", Eval("giaBanh")) %>
                                    </td>

                                    <td data-label="Số lượng">
                                        <div class="so-luong-gio">
                                            <asp:Button
                                                ID="btnGiam"
                                                runat="server"
                                                Text="−"
                                                CssClass="nut-sl"
                                                CommandName="giam"
                                                CommandArgument='<%# Eval("khoa") %>' />

                                            <span class="so-luong-so"><%# Eval("soLuong") %></span>

                                            <asp:Button
                                                ID="btnTang"
                                                runat="server"
                                                Text="+"
                                                CssClass="nut-sl"
                                                CommandName="tang"
                                                CommandArgument='<%# Eval("khoa") %>' />
                                        </div>
                                    </td>

                                    <td data-label="Thành tiền" class="cot-thanh-tien">
                                        <%# string.Format("{0:N0}đ", Eval("thanhTien")) %>
                                    </td>

                                    <td data-label="Thao tác">
                                        <asp:LinkButton
                                            ID="btnXoa"
                                            runat="server"
                                            CssClass="nut-xoa"
                                            CommandName="xoa"
                                            CommandArgument='<%# Eval("khoa") %>'>
                                            <i class="fa-solid fa-trash-can"></i> Xóa
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>

            <div class="tong-ket-gio">
                <span class="tong-nhan">Tổng tiền:</span>
                <span class="tong-so"><asp:Literal ID="litTongTien" runat="server" /></span>
            </div>
            <p class="ghi-chu-gio">Phí vận chuyển và mã giảm giá sẽ được tính ở bước đặt hàng.</p>

            <div class="hanh-dong-gio">
                <a href="SanPham.aspx" class="nut-hong nut-vien">
                    <i class="fa-solid fa-arrow-left"></i> Tiếp tục mua hàng
                </a>
                <a href="DatHang.aspx" class="nut-hong">
                    Tiến hành đặt hàng <i class="fa-solid fa-arrow-right"></i>
                </a>
            </div>

        </asp:Panel>

    </div>
</asp:Content>
