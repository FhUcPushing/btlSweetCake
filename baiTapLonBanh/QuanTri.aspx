<%@ Page Title="Quản trị SweetCake"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="QuanTri.aspx.cs"
    Inherits="baiTapLonBanh.QuanTri" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">
    <link href="<%= ResolveUrl("~/CSS/QuanTri.css") %>"
      rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">

    <div class="container">
        <h1>Khu vực quản trị SweetCake</h1>

        <p>
            Xin chào quản trị viên:
            <span id="tenAdmin" runat="server"></span>
        </p>
        <div class="admin-actions">
    <a href="<%= ResolveUrl("~/QuanLySanPham.aspx") %>"
       class="admin-detail-link">

        <i class="fa-solid fa-cake-candles"></i>
        Quản lý sản phẩm

    </a>
</div>

        <p>Đăng nhập với quyền quản trị thành công!</p>
        <div class="admin-orders">
    <h2>Quản lý đơn hàng</h2>

    <asp:Label ID="lblThongBao"
        runat="server"
        CssClass="admin-message">
    </asp:Label>

    <asp:Panel ID="pnlKhongCoDon"
        runat="server"
        Visible="false">
        <p>Hiện chưa có đơn hàng nào.</p>
    </asp:Panel>

    <div class="admin-table-wrap">
        <asp:GridView ID="gvDonHang"
            runat="server"
            AutoGenerateColumns="false"
            DataKeyNames="MaDon"
            CssClass="admin-order-table"
            GridLines="None"
            OnRowDataBound="gvDonHang_RowDataBound"
            OnRowCommand="gvDonHang_RowCommand">

            <Columns>
                <asp:BoundField
                    DataField="MaDon"
                    HeaderText="Mã đơn" />

                <asp:BoundField
                    DataField="NgayDat"
                    HeaderText="Ngày đặt"
                    DataFormatString="{0:dd/MM/yyyy HH:mm}" />

                <asp:BoundField
                    DataField="TenDangNhap"
                    HeaderText="Tài khoản khách" />

                <asp:BoundField
                    DataField="NguoiNhan"
                    HeaderText="Người nhận" />

                <asp:BoundField
                    DataField="SoDienThoai"
                    HeaderText="Số điện thoại" />

                <asp:BoundField
                    DataField="TongCong"
                    HeaderText="Tổng tiền"
                    DataFormatString="{0:N0} đ" />
                <asp:TemplateField HeaderText="Chi tiết">
    <ItemTemplate>
        <asp:HyperLink
            ID="lnkXemChiTiet"
            runat="server"
            NavigateUrl='<%# "~/ChiTietDonHang.aspx?ma=" + Server.UrlEncode(Convert.ToString(Eval("MaDon"))) %>'
            CssClass="admin-detail-link">
            Xem chi tiết
        </asp:HyperLink>
    </ItemTemplate>
</asp:TemplateField>
                <asp:TemplateField HeaderText="Trạng thái">
                    <ItemTemplate>
                        <asp:DropDownList
                            ID="ddlTrangThai"
                            runat="server"
                            CssClass="admin-select">

                            <asp:ListItem Value="Chờ xác nhận">
                                Chờ xác nhận
                            </asp:ListItem>

                            <asp:ListItem Value="Đã xác nhận">
                                Đã xác nhận
                            </asp:ListItem>

                            <asp:ListItem Value="Đang chuẩn bị">
                                Đang chuẩn bị
                            </asp:ListItem>

                            <asp:ListItem Value="Đang giao hàng">
                                Đang giao hàng
                            </asp:ListItem>

                            <asp:ListItem Value="Hoàn thành">
                                Hoàn thành
                            </asp:ListItem>

                            <asp:ListItem Value="Đã hủy">
                                Đã hủy
                            </asp:ListItem>

                        </asp:DropDownList>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Thao tác">
                    <ItemTemplate>
                        <asp:Button
                            ID="btnCapNhatTrangThai"
                            runat="server"
                            Text="Cập nhật"
                            CssClass="admin-btn"
                            CommandName="CapNhatTrangThai"
                            CommandArgument='<%# Eval("MaDon") %>'
                            CausesValidation="false" />
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>
        </asp:GridView>
    </div>
</div>
    </div>

</asp:Content>