using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;

namespace baiTapLonBanh
{
    public partial class SuaSanPham : System.Web.UI.Page
    {
        private bool LaAdmin()
        {
            NguoiDung tk = Session["TaiKhoan"] as NguoiDung;

            return tk != null && tk.VaiTro == "Admin";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Kiểm tra quyền truy cập
            if (!LaAdmin())
            {
                string trang = Session["TaiKhoan"] == null
                    ? "~/DangNhap.aspx"
                    : "~/TrangChu.aspx";

                Response.Redirect(ResolveUrl(trang), false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                string ma = Request.QueryString["id"];
                SanPhamBanh banh = TimSanPham(ma);

                if (banh == null)
                {
                    Response.Redirect(
                        ResolveUrl("~/QuanLySanPham.aspx"), false);

                    Context.ApplicationInstance.CompleteRequest();
                    return;
                }

                // Hiển thị dữ liệu hiện tại
                lblMaBanh.Text = Server.HtmlEncode(banh.maBanh);
                txtTenBanh.Text = banh.tenBanh;
                txtGiaBanh.Text =
                    banh.giaBanh.ToString(CultureInfo.InvariantCulture);
                txtMoTa.Text = banh.moTa ?? "";

                if (ddlLoaiBanh.Items.FindByValue(banh.loaiBanh) != null)
                {
                    ddlLoaiBanh.SelectedValue = banh.loaiBanh;
                }

                imgAnhHienTai.ImageUrl =
                    ResolveUrl("~/" + banh.anhBanh);

                imgAnhHienTai.AlternateText = banh.tenBanh;
            }
        }

        private SanPhamBanh TimSanPham(string ma)
        {
            SanPhamBanh ketQua = null;

            Application.Lock();

            try
            {
                List<SanPhamBanh> ds =
                    Application["DanhSachSanPham"] as List<SanPhamBanh>;

                if (ds != null)
                {
                    foreach (SanPhamBanh banh in ds)
                    {
                        if (banh.maBanh == ma)
                        {
                            ketQua = banh;
                            break;
                        }
                    }
                }
            }
            finally
            {
                Application.UnLock();
            }

            return ketQua;
        }

        private bool LoaiBanhHopLe(string loai)
        {
            return loai == "Bánh Mousse"
                || loai == "Bánh Sinh Nhật"
                || loai == "Bánh Kem"
                || loai == "Bánh Tươi"
                || loai == "Bánh Mì";
        }

        private void XoaLoi()
        {
            loiTenBanh.Text = "";
            loiGiaBanh.Text = "";
            loiLoaiBanh.Text = "";
            loiMoTa.Text = "";
            loiAnhBanh.Text = "";
            lblThongBao.Text = "";
        }

        protected void btnCapNhat_Click(object sender, EventArgs e)
        {
            // Kiểm tra quyền khi gửi yêu cầu cập nhật
            if (!LaAdmin())
            {
                Response.Redirect(
                    ResolveUrl("~/DangNhap.aspx"), false);

                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            XoaLoi();

            string ma = Request.QueryString["id"];
            SanPhamBanh banhCu = TimSanPham(ma);

            if (banhCu == null)
            {
                lblThongBao.Text = "Không tìm thấy sản phẩm cần sửa.";
                lblThongBao.CssClass = "admin-message that-bai";
                return;
            }

            string ten = (txtTenBanh.Text ?? "").Trim();
            string moTa = (txtMoTa.Text ?? "").Trim();
            string loai = ddlLoaiBanh.SelectedValue;

            decimal gia;

            bool hopLe = true;

            // Kiểm tra tên bánh
            if (ten.Length < 2 || ten.Length > 100)
            {
                loiTenBanh.Text =
                    "Tên bánh phải có từ 2 đến 100 ký tự.";
                hopLe = false;
            }

            // Kiểm tra giá
            if (!decimal.TryParse(
                    txtGiaBanh.Text.Trim(),
                    NumberStyles.AllowDecimalPoint,
                    CultureInfo.InvariantCulture,
                    out gia)
                || gia <= 0
                || gia > 1000000000m)
            {
                loiGiaBanh.Text = "Giá bán không hợp lệ.";
                hopLe = false;
            }

            // Kiểm tra loại
            if (!LoaiBanhHopLe(loai))
            {
                loiLoaiBanh.Text = "Vui lòng chọn loại bánh hợp lệ.";
                hopLe = false;
            }

            // Mô tả có thể để trống để giữ cách hiển thị mặc định
            if (moTa.Length > 500 ||
                (moTa.Length > 0 && moTa.Length < 5))
            {
                loiMoTa.Text =
                    "Mô tả để trống hoặc có từ 5 đến 500 ký tự.";
                hopLe = false;
            }

            string duoiAnh = "";

            if (fuAnhBanh.HasFile)
            {
                duoiAnh = Path.GetExtension(
                    fuAnhBanh.FileName).ToLowerInvariant();

                if (duoiAnh != ".jpg" &&
                    duoiAnh != ".jpeg" &&
                    duoiAnh != ".png" &&
                    duoiAnh != ".webp")
                {
                    loiAnhBanh.Text =
                        "Chỉ chấp nhận ảnh JPG, JPEG, PNG hoặc WEBP.";
                    hopLe = false;
                }
                else if (fuAnhBanh.PostedFile.ContentLength <= 0 ||
                         fuAnhBanh.PostedFile.ContentLength >
                         5 * 1024 * 1024)
                {
                    loiAnhBanh.Text =
                        "Ảnh phải lớn hơn 0 và không vượt quá 5 MB.";
                    hopLe = false;
                }
            }

            if (!hopLe)
            {
                lblThongBao.Text =
                    "Vui lòng kiểm tra lại thông tin sản phẩm.";
                lblThongBao.CssClass = "admin-message that-bai";
                return;
            }

            // Nếu không tải ảnh mới thì giữ ảnh cũ
            string anhMoi = banhCu.anhBanh;
            string duongDanAnhMoi = "";

            try
            {
                // Lưu ảnh mới nếu Admin đã chọn ảnh
                if (fuAnhBanh.HasFile)
                {
                    string thuMucAnh =
                        Server.MapPath("~/image/SanPham/");

                    if (!Directory.Exists(thuMucAnh))
                    {
                        Directory.CreateDirectory(thuMucAnh);
                    }

                    string tenFile =
                        "sp_" + Guid.NewGuid().ToString("N") + duoiAnh;

                    duongDanAnhMoi =
                        Path.Combine(thuMucAnh, tenFile);

                    fuAnhBanh.SaveAs(duongDanAnhMoi);

                    anhMoi = "image/SanPham/" + tenFile;
                }

                bool daCapNhat = false;

                Application.Lock();

                try
                {
                    List<SanPhamBanh> ds =
                        Application["DanhSachSanPham"]
                        as List<SanPhamBanh>;

                    if (ds != null)
                    {
                        // Tạo danh sách mới để thay đổi đồng bộ
                        List<SanPhamBanh> dsMoi =
                            new List<SanPhamBanh>(ds);

                        for (int i = 0; i < dsMoi.Count; i++)
                        {
                            if (dsMoi[i].maBanh == ma)
                            {
                                SanPhamBanh banhSua =
                                    new SanPhamBanh
                                    {
                                        maBanh = dsMoi[i].maBanh,
                                        tenBanh = ten,
                                        giaBanh = gia,
                                        anhBanh = anhMoi,
                                        moTa = moTa,
                                        loaiBanh = loai,
                                        ngayTao = dsMoi[i].ngayTao
                                    };

                                dsMoi[i] = banhSua;

                                Application["DanhSachSanPham"] = dsMoi;

                                daCapNhat = true;
                                break;
                            }
                        }
                    }
                }
                finally
                {
                    Application.UnLock();
                }

                if (!daCapNhat)
                {
                    if (!string.IsNullOrEmpty(duongDanAnhMoi) &&
                        File.Exists(duongDanAnhMoi))
                    {
                        File.Delete(duongDanAnhMoi);
                    }

                    lblThongBao.Text =
                        "Không tìm thấy sản phẩm cần cập nhật.";

                    lblThongBao.CssClass = "admin-message that-bai";
                    return;
                }
            }
            catch (Exception)
            {
                // Dọn ảnh mới nếu cập nhật thất bại
                try
                {
                    if (!string.IsNullOrEmpty(duongDanAnhMoi) &&
                        File.Exists(duongDanAnhMoi))
                    {
                        File.Delete(duongDanAnhMoi);
                    }
                }
                catch
                {
                    // Bỏ qua lỗi dọn file.
                }

                lblThongBao.Text =
                    "Không thể cập nhật sản phẩm. Em hãy kiểm tra lại thư mục ảnh.";

                lblThongBao.CssClass = "admin-message that-bai";
                return;
            }

            // Quay về danh sách sau khi cập nhật thành công
            Response.Redirect(
                ResolveUrl("~/QuanLySanPham.aspx?sua=thanhcong"),
                false);

            Context.ApplicationInstance.CompleteRequest();
        }
    }
}