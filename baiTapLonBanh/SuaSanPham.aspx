<%@ Page Title="Sửa sản phẩm"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="SuaSanPham.aspx.cs"
    Inherits="baiTapLonBanh.SuaSanPham" %>

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

        <h1>Sửa sản phẩm</h1>
        <p>Cập nhật thông tin bánh của SweetCake.</p>

        <asp:Label ID="lblThongBao"
            runat="server"
            CssClass="admin-message">
        </asp:Label>

        <div class="admin-product-form">

            <div class="admin-form-group">
                <label>Mã bánh</label>
                <asp:Label ID="lblMaBanh"
                    runat="server">
                </asp:Label>
            </div>

            <div class="admin-form-group">
                <label for="txtTenBanh">Tên bánh</label>

                <asp:TextBox ID="txtTenBanh"
                    runat="server"
                    ClientIDMode="Static"
                    MaxLength="100">
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
                    TextMode="Number">
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
                <label for="txtMoTa">Mô tả</label>

                <asp:TextBox ID="txtMoTa"
                    runat="server"
                    ClientIDMode="Static"
                    TextMode="MultiLine"
                    Rows="4"
                    MaxLength="500">
                </asp:TextBox>

                <asp:Label ID="loiMoTa"
                    runat="server"
                    ClientIDMode="Static"
                    CssClass="admin-field-error">
                </asp:Label>
            </div>

            <div class="admin-form-group">
                <label>Ảnh hiện tại</label>

                <asp:Image ID="imgAnhHienTai"
                    runat="server"
                    CssClass="admin-current-image"
                    AlternateText="Ảnh sản phẩm hiện tại" />
            </div>

            <div class="admin-form-group">
                <label for="fuAnhBanh">Thay ảnh mới (không bắt buộc)</label>

                <asp:FileUpload ID="fuAnhBanh"
                    runat="server"
                    ClientIDMode="Static" />

                <small>
                    JPG, JPEG, PNG hoặc WEBP; tối đa 5 MB.
                    Không chọn ảnh mới thì giữ ảnh cũ.
                </small>

                <asp:Label ID="loiAnhBanh"
                    runat="server"
                    ClientIDMode="Static"
                    CssClass="admin-field-error">
                </asp:Label>
            </div>

            <div class="admin-product-actions">

                <asp:Button ID="btnCapNhat"
                    runat="server"
                    Text="Lưu thay đổi"
                    CssClass="admin-btn"
                    OnClick="btnCapNhat_Click"
                    CausesValidation="false" />

                <a href="<%= ResolveUrl("~/QuanLySanPham.aspx") %>"
                   class="admin-detail-link">
                    Quay lại
                </a>

            </div>

        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var form = document.getElementById("form1");
            var ten = document.getElementById("txtTenBanh");
            var gia = document.getElementById("txtGiaBanh");
            var loai = document.getElementById("ddlLoaiBanh");
            var moTa = document.getElementById("txtMoTa");
            var anh = document.getElementById("fuAnhBanh");

            function baoLoi(id, noiDung) {
                document.getElementById(id).textContent = noiDung;
            }

            if (form) {
                form.addEventListener("submit", function (e) {
                    var hopLe = true;

                    baoLoi("loiTenBanh", "");
                    baoLoi("loiGiaBanh", "");
                    baoLoi("loiLoaiBanh", "");
                    baoLoi("loiMoTa", "");
                    baoLoi("loiAnhBanh", "");

                    var tenBanh = ten.value.trim();
                    var giaBanh = Number(gia.value);
                    var moTaBanh = moTa.value.trim();

                    if (tenBanh.length < 2 || tenBanh.length > 100) {
                        baoLoi("loiTenBanh",
                            "Tên bánh phải có từ 2 đến 100 ký tự.");
                        hopLe = false;
                    }

                    if (gia.value.trim() === "" ||
                        !Number.isFinite(giaBanh) ||
                        giaBanh <= 0 ||
                        giaBanh > 1000000000) {
                        baoLoi("loiGiaBanh", "Giá bán không hợp lệ.");
                        hopLe = false;
                    }

                    if (loai.value === "") {
                        baoLoi("loiLoaiBanh", "Vui lòng chọn loại bánh.");
                        hopLe = false;
                    }

                    if (moTaBanh.length > 500 ||
                        (moTaBanh.length > 0 && moTaBanh.length < 5)) {
                        baoLoi("loiMoTa",
                            "Mô tả để trống hoặc có từ 5 đến 500 ký tự.");
                        hopLe = false;
                    }

                    if (anh.files && anh.files.length > 0) {
                        var file = anh.files[0];

                        if (!/\.(jpg|jpeg|png|webp)$/i.test(file.name)) {
                            baoLoi("loiAnhBanh",
                                "Ảnh phải là JPG, JPEG, PNG hoặc WEBP.");
                            hopLe = false;
                        }

                        if (file.size <= 0 ||
                            file.size > 5 * 1024 * 1024) {
                            baoLoi("loiAnhBanh",
                                "Ảnh phải lớn hơn 0 và không vượt quá 5 MB.");
                            hopLe = false;
                        }
                    }

                    if (!hopLe) {
                        e.preventDefault();
                    }
                });
            }
        });
    </script>

</asp:Content>