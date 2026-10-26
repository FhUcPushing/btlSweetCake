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

    <script>
        document.addEventListener("DOMContentLoaded", function () {

            var ten = document.getElementById("txtTenBanh");
            var gia = document.getElementById("txtGiaBanh");
            var loai = document.getElementById("ddlLoaiBanh");
            var moTa = document.getElementById("txtMoTa");
            var anh = document.getElementById("fuAnhBanh");

            var form = document.getElementById("form1");

            function baoLoi(id, noiDung) {
                document.getElementById(id).textContent = noiDung;
            }

            function kiemTra() {
                var hopLe = true;

                baoLoi("loiTenBanh", "");
                baoLoi("loiGiaBanh", "");
                baoLoi("loiLoaiBanh", "");
                baoLoi("loiMoTa", "");
                baoLoi("loiAnhBanh", "");

                if (ten.value.trim().length < 2 ||
                    ten.value.trim().length > 100) {

                    baoLoi("loiTenBanh",
                        "Tên bánh phải có từ 2 đến 100 ký tự.");
                    hopLe = false;
                }

                var giaTri = Number(gia.value);

                if (gia.value.trim() === "" ||
                    !Number.isFinite(giaTri) ||
                    giaTri <= 0 ||
                    giaTri > 1000000000) {

                    baoLoi("loiGiaBanh",
                        "Giá bán phải lớn hơn 0 và không vượt quá 1 tỷ đồng.");
                    hopLe = false;
                }

                if (loai.value === "") {
                    baoLoi("loiLoaiBanh",
                        "Vui lòng chọn loại bánh.");
                    hopLe = false;
                }

                if (moTa.value.trim().length < 5 ||
                    moTa.value.trim().length > 500) {

                    baoLoi("loiMoTa",
                        "Mô tả phải có từ 5 đến 500 ký tự.");
                    hopLe = false;
                }

                if (!anh.files || anh.files.length === 0) {
                    baoLoi("loiAnhBanh",
                        "Vui lòng chọn ảnh sản phẩm.");
                    hopLe = false;
                } else {
                    var file = anh.files[0];
                    var tenFile = file.name.toLowerCase();
                    var duoiHopLe = /\.(jpg|jpeg|png|webp)$/.test(tenFile);

                    if (!duoiHopLe) {
                        baoLoi("loiAnhBanh",
                            "Ảnh phải có định dạng JPG, JPEG, PNG hoặc WEBP.");
                        hopLe = false;
                    }

                    if (file.size > 5 * 1024 * 1024) {
                        baoLoi("loiAnhBanh",
                            "Ảnh không được vượt quá 5 MB.");
                        hopLe = false;
                    }
                }

                return hopLe;
            }

            if (form) {
                form.addEventListener("submit", function (e) {
                    if (!kiemTra()) {
                        e.preventDefault();
                    }
                });
            }
        });
    </script>

</asp:Content>