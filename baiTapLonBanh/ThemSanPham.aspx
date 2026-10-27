<%@ Page Title="Thêm sản phẩm"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="ThemSanPham.aspx.cs"
    Inherits="baiTapLonBanh.ThemSanPham" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="<%= ResolveUrl("~/CSS/QuanTri.css") %>"
          rel="stylesheet" />

</asp:Content>

<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">

    <div class="container admin-orders admin-add-product">

        <h1>Thêm sản phẩm mới</h1>
        <p>Nhập thông tin bánh để thêm vào cửa hàng SweetCake.</p>

        <asp:Label ID="lblThongBao"
            runat="server"
            CssClass="admin-message">
        </asp:Label>

        <div class="admin-product-form">

            <div class="admin-form-group">
                <label for="txtTenBanh">Tên bánh</label>

                <asp:TextBox ID="txtTenBanh"
                    runat="server"
                    ClientIDMode="Static"
                    MaxLength="100"
                    placeholder="Ví dụ: Bánh Mousse Dâu Tây">
                </asp:TextBox>

                <asp:Label ID="loiTenBanh"
                    runat="server"
                    ClientIDMode="Static"
                    CssClass="admin-field-error">
                </asp:Label>
            </div>

            <div class="admin-form-group">
                <label for="txtGiaBanh">Giá bán (VNĐ)</label>

                <asp:TextBox ID="txtGiaBanh"
                    runat="server"
                    ClientIDMode="Static"
                    TextMode="Number"
                    placeholder="Ví dụ: 100000">
                </asp:TextBox>

                <asp:Label ID="loiGiaBanh"
                    runat="server"
                    ClientIDMode="Static"
                    CssClass="admin-field-error">
                </asp:Label>
            </div>

            <div class="admin-form-group">
                <label for="ddlLoaiBanh">Loại bánh</label>

                <asp:DropDownList ID="ddlLoaiBanh"
                    runat="server"
                    ClientIDMode="Static">

                    <asp:ListItem Value="">
                        -- Chọn loại bánh --
                    </asp:ListItem>

                    <asp:ListItem Value="Bánh Mousse">
                        Bánh Mousse
                    </asp:ListItem>

                    <asp:ListItem Value="Bánh Sinh Nhật">
                        Bánh Sinh Nhật
                    </asp:ListItem>

                    <asp:ListItem Value="Bánh Kem">
                        Bánh Kem
                    </asp:ListItem>

                    <asp:ListItem Value="Bánh Tươi">
                        Bánh Tươi
                    </asp:ListItem>

                    <asp:ListItem Value="Bánh Mì">
                        Bánh Mì
                    </asp:ListItem>

                </asp:DropDownList>

                <asp:Label ID="loiLoaiBanh"
                    runat="server"
                    ClientIDMode="Static"
                    CssClass="admin-field-error">
                </asp:Label>
            </div>

            <div class="admin-form-group">
                <label for="txtMoTa">Mô tả sản phẩm</label>

                <asp:TextBox ID="txtMoTa"
                    runat="server"
                    ClientIDMode="Static"
                    TextMode="MultiLine"
                    Rows="4"
                    MaxLength="500"
                    placeholder="Nhập mô tả ngắn về chiếc bánh...">
                </asp:TextBox>

                <asp:Label ID="loiMoTa"
                    runat="server"
                    ClientIDMode="Static"
                    CssClass="admin-field-error">
                </asp:Label>
            </div>

            <div class="admin-form-group">
                <label for="fuAnhBanh">Ảnh sản phẩm</label>

                <asp:FileUpload ID="fuAnhBanh"
                    runat="server"
                    ClientIDMode="Static" />

                <small>
                    Chấp nhận JPG, JPEG, PNG hoặc WEBP.
                    Dung lượng tối đa 5 MB.
                </small>

                <asp:Label ID="loiAnhBanh"
                    runat="server"
                    ClientIDMode="Static"
                    CssClass="admin-field-error">
                </asp:Label>
            </div>

            <div class="admin-product-actions">

                <asp:Button ID="btnThem"
                    runat="server"
                    Text="Thêm sản phẩm"
                    CssClass="admin-btn"
                    OnClick="btnThem_Click"
                    CausesValidation="false" />

                <a href="<%= ResolveUrl("~/QuanLySanPham.aspx") %>"
                   class="admin-detail-link">
                    Quay lại danh sách
                </a>

            </div>

        </div>

    </div>

    <script src="<%= ResolveUrl("~/JS/ThemSanPham.js") %>" defer="defer"></script>

</asp:Content>