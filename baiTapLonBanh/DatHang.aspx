<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DatHang.aspx.cs" Inherits="baiTapLonBanh.DatHang" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/DatHang.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container product-page">
    <h1>Thông tin đặt hàng</h1>

    <section class="thong-tin-nguoi-nhan">
        <h2>Thông tin người nhận</h2>

        <div>
            <label for="txtHoTen">Họ và tên:</label>
            <asp:TextBox ID="txtHoTen" runat="server" />
        </div>

        <div>
            <label for="txtSoDienThoai">Số điện thoại:</label>
            <asp:TextBox ID="txtSoDienThoai" runat="server" />
        </div>

        <div>
            <label for="txtDiaChi">Địa chỉ nhận hàng:</label>
            <asp:TextBox ID="txtDiaChi" runat="server" />
        </div>

        <div>
            <label for="txtGhiChu">Ghi chú:</label>
            <asp:TextBox
                ID="txtGhiChu"
                runat="server"
                TextMode="MultiLine"
                Rows="3" />
        </div>
    </section>

    <section class="thong-tin-don-hang">
        <h2>Đơn hàng của bạn</h2>

        <div id="danhSachDonHang" runat="server">
        </div>

        <p>
            Tổng tiền:
            <asp:Literal ID="litTongTien" runat="server" />
        </p>
    </section>

    <asp:Button
        ID="btnXacNhanDatHang"
        runat="server"
        Text="Xác nhận đặt hàng"
        OnClick="btnXacNhanDatHang_Click" />

    <asp:Label
        ID="lblThongBao"
        runat="server"
        Visible="false" />
</div>
</asp:Content>
