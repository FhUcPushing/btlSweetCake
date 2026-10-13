<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GioHang.aspx.cs" Inherits="baiTapLonBanh.GioHang" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/GioHang.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container product-page">
    <h1>Giỏ hàng của bạn</h1>

    <asp:Panel ID="thongBaoRong" runat="server" Visible="false">
        <p>Giỏ hàng của bạn đang trống.</p>
        <a href="SanPham.aspx">Tiếp tục mua hàng</a>
    </asp:Panel>

    <asp:Panel ID="panelGioHang" runat="server" Visible="false">

        <table class="bang-gio-hang">
            <thead>
                <tr>
                    <th>Tên bánh</th>
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
                            <td><%# Eval("tenBanh") %></td>

                            <td>
                                <%# string.Format("{0:N0}đ", Eval("giaBanh")) %>
                            </td>

                            <td>
                                <asp:Button
                                    ID="btnGiam"
                                    runat="server"
                                    Text="-"
                                    CommandName="giam"
                                    CommandArgument='<%# Eval("maBanh") %>' />

                                <%# Eval("soLuong") %>

                                <asp:Button
                                    ID="btnTang"
                                    runat="server"
                                    Text="+"
                                    CommandName="tang"
                                    CommandArgument='<%# Eval("maBanh") %>' />
                            </td>

                            <td>
                                <%# string.Format("{0:N0}đ", Eval("thanhTien")) %>
                            </td>

                            <td>
                                <asp:Button
                                    ID="btnXoa"
                                    runat="server"
                                    Text="Xóa"
                                    CommandName="xoa"
                                    CommandArgument='<%# Eval("maBanh") %>' />
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>

        <h2>
            Tổng tiền:
            <asp:Literal ID="litTongTien" runat="server" />
        </h2>

        <a href="SanPham.aspx">Tiếp tục mua hàng</a>
        <a href="DatHang.aspx" class="btn-dat-hang">
    Tiến hành đặt hàng
</a>
    </asp:Panel>

</div>
</asp:Content>
