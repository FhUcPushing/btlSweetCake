<%@ Page Title="Quản lý sản phẩm"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="QuanLySanPham.aspx.cs"
    Inherits="baiTapLonBanh.QuanLySanPham" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="<%= ResolveUrl("~/CSS/QuanTri.css") %>"
          rel="stylesheet" />

</asp:Content>

<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">

    <div class="container admin-orders">

        <h1>Quản lý sản phẩm</h1>
        <a href="<%= ResolveUrl("~/ThemSanPham.aspx") %>"
   class="admin-detail-link">
    <i class="fa-solid fa-plus"></i>
    Thêm bánh
</a>
        <p>Danh sách các loại bánh của SweetCake</p>

        <asp:Label ID="lblThongBao"
            runat="server"
            CssClass="admin-message">
        </asp:Label>

        <asp:Panel ID="pnlKhongCoBanh"
            runat="server"
            Visible="false">

            <p>Hiện chưa có sản phẩm nào.</p>

        </asp:Panel>

        <div class="admin-table-wrap">

            <asp:GridView ID="gvSanPham"
                runat="server"
                AutoGenerateColumns="false"
                DataKeyNames="maBanh"
                CssClass="admin-order-table"
                GridLines="None"
                OnRowCommand="gvSanPham_RowCommand">

                <Columns>

                    <asp:BoundField
                        DataField="maBanh"
                        HeaderText="Mã bánh" />

                    <asp:TemplateField HeaderText="Ảnh">
                        <ItemTemplate>
                            <asp:Image
                                runat="server"
                                ImageUrl='<%# ResolveUrl("~/" + Convert.ToString(Eval("anhBanh"))) %>'
                                AlternateText='<%# Convert.ToString(Eval("tenBanh")) %>'
                                CssClass="admin-product-image" />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField
                        DataField="tenBanh"
                        HeaderText="Tên bánh" />

                    <asp:BoundField
                        DataField="loaiBanh"
                        HeaderText="Loại bánh" />

                    <asp:BoundField
                        DataField="giaBanh"
                        HeaderText="Giá"
                        DataFormatString="{0:N0} đ" />

                    <asp:BoundField
                        DataField="ngayTao"
                        HeaderText="Ngày tạo"
                        DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:TemplateField HeaderText="Thao tác">
    <ItemTemplate>
        <asp:HyperLink
            ID="lnkSua"
            runat="server"
            NavigateUrl='<%# "~/SuaSanPham.aspx?id=" + Server.UrlEncode(Convert.ToString(Eval("maBanh"))) %>'
            CssClass="admin-detail-link">
            <i class="fa-solid fa-pen-to-square"></i>
            Sửa
        </asp:HyperLink>
        <asp:Button
    ID="btnXoa"
    runat="server"
    Text="Xóa"
    CssClass="admin-delete-btn"
    CommandName="XoaSanPham"
    CommandArgument='<%# Eval("maBanh") %>'
    OnClientClick="return confirm('Em có chắc chắn muốn xóa sản phẩm này không?');"
    CausesValidation="false" />
    </ItemTemplate>

</asp:TemplateField>
                </Columns>

            </asp:GridView>

        </div>

        <div class="admin-actions">
            <a href="<%= ResolveUrl("~/QuanTri.aspx") %>"
               class="admin-detail-link">
                <i class="fa-solid fa-arrow-left"></i>
                Quay lại quản trị
            </a>
        </div>

    </div>

</asp:Content>