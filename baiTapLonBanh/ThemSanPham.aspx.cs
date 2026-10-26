using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Web.UI;

namespace baiTapLonBanh
{
    public partial class ThemSanPham : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Mỗi lần tải trang đều phải kiểm tra quyền Admin
            if (!LaAdmin())
            {
                if (Session["TaiKhoan"] == null)
                {
                    Response.Redirect(
                        ResolveUrl("~/DangNhap.aspx"), false);
                }
                else
                {
                    Response.Redirect(
                        ResolveUrl("~/TrangChu.aspx"), false);
                }

                Context.ApplicationInstance.CompleteRequest();
                return;
            }
        }

        private bool LaAdmin()
        {
            NguoiDung taiKhoan =
                Session["TaiKhoan"] as NguoiDung;

            return taiKhoan != null &&
                   taiKhoan.VaiTro == "Admin";
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

        private bool LoaiBanhHopLe(string loai)
        {
            return loai == "Bánh Mousse"
                || loai == "Bánh Sinh Nhật"
                || loai == "Bánh Kem"
                || loai == "Bánh Tươi"
                || loai == "Bánh Mì";
        }

        private string TaoMaBanhMoi(List<SanPhamBanh> ds)
        {
            int maLonNhat = 0;

            foreach (SanPhamBanh banh in ds)
            {
                int maSo;

                if (int.TryParse(banh.maBanh, out maSo) &&
                    maSo > maLonNhat)
                {
                    maLonNhat = maSo;
                }
            }

            return (maLonNhat + 1).ToString();
        }

        protected void btnThem_Click(object sender, EventArgs e)
        {
            // Không chỉ kiểm tra ở Page_Load:
            // sự kiện thêm cũng tự kiểm tra quyền.
            if (!LaAdmin())
            {
                return;
            }

            XoaLoi();

            string tenBanh = (txtTenBanh.Text ?? "").Trim();
            string moTa = (txtMoTa.Text ?? "").Trim();
            string loaiBanh = ddlLoaiBanh.SelectedValue;

            decimal giaBanh;

            bool hopLe = true;

            // 1. Kiểm tra tên bánh
            if (tenBanh.Length < 2 || tenBanh.Length > 100)
            {
                loiTenBanh.Text =
                    "Tên bánh phải có từ 2 đến 100 ký tự.";
                hopLe = false;
            }

            // 2. Kiểm tra giá
            if (!decimal.TryParse(
                    txtGiaBanh.Text.Trim(),
                    NumberStyles.AllowDecimalPoint,
                    CultureInfo.InvariantCulture,
                    out giaBanh)
                || giaBanh <= 0
                || giaBanh > 1000000000m)
            {
                loiGiaBanh.Text =
                    "Giá bán không hợp lệ.";
                hopLe = false;
            }

            // 3. Kiểm tra loại bánh
            if (!LoaiBanhHopLe(loaiBanh))
            {
                loiLoaiBanh.Text =
                    "Vui lòng chọn loại bánh hợp lệ.";
                hopLe = false;
            }

            // 4. Kiểm tra mô tả
            if (moTa.Length < 5 || moTa.Length > 500)
            {
                loiMoTa.Text =
                    "Mô tả phải có từ 5 đến 500 ký tự.";
                hopLe = false;
            }

            // 5. Kiểm tra ảnh
            string duoiMoRong = "";

            if (!fuAnhBanh.HasFile)
            {
                loiAnhBanh.Text =
                    "Vui lòng chọn ảnh sản phẩm.";
                hopLe = false;
            }
            else
            {
                duoiMoRong = Path.GetExtension(
                    fuAnhBanh.FileName).ToLowerInvariant();

                bool dungDinhDang =
                    duoiMoRong == ".jpg"
                    || duoiMoRong == ".jpeg"
                    || duoiMoRong == ".png"
                    || duoiMoRong == ".webp";

                if (!dungDinhDang)
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
                        "Ảnh phải có dung lượng lớn hơn 0 và không vượt quá 5 MB.";
                    hopLe = false;
                }
            }

            if (!hopLe)
            {
                lblThongBao.Text =
                    "Vui lòng kiểm tra lại thông tin sản phẩm.";

                lblThongBao.CssClass =
                    "admin-message that-bai";

                return;
            }

            // Tạo tên ảnh mới để tránh trùng tên file
            string tenFile =
                "sp_" + Guid.NewGuid().ToString("N")
                + duoiMoRong;

            string thuMucAnh =
                Server.MapPath("~/image/SanPham/");

            string duongDanAnh =
                Path.Combine(thuMucAnh, tenFile);

            try
            {
                if (!Directory.Exists(thuMucAnh))
                {
                    Directory.CreateDirectory(thuMucAnh);
                }

                // Lưu ảnh vào thư mục hình sản phẩm
                fuAnhBanh.SaveAs(duongDanAnh);

                Application.Lock();

                try
                {
                    List<SanPhamBanh> ds =
                        Application["DanhSachSanPham"]
                        as List<SanPhamBanh>;

                    if (ds == null)
                    {
                        ds = new List<SanPhamBanh>();
                        Application["DanhSachSanPham"] = ds;
                    }

                    string maBanhMoi = TaoMaBanhMoi(ds);

                    SanPhamBanh sanPhamMoi =
                        new SanPhamBanh
                        {
                            maBanh = maBanhMoi,
                            tenBanh = tenBanh,
                            giaBanh = giaBanh,
                            anhBanh = "image/SanPham/" + tenFile,
                            moTa = moTa,
                            loaiBanh = loaiBanh,
                            ngayTao = DateTime.Now
                        };

                    ds.Add(sanPhamMoi);
                }
                finally
                {
                    Application.UnLock();
                }
            }
            catch (Exception)
            {
                // Nếu lưu hoặc thêm sản phẩm thất bại,
                // cố gắng xóa file ảnh đã tải lên.
                try
                {
                    if (File.Exists(duongDanAnh))
                    {
                        File.Delete(duongDanAnh);
                    }
                }
                catch
                {
                    // Không để lỗi xóa file che mất thông báo chính.
                }

                lblThongBao.Text =
                    "Không thể lưu sản phẩm. Em hãy kiểm tra quyền ghi của thư mục ảnh.";

                lblThongBao.CssClass =
                    "admin-message that-bai";

                return;
            }

            // Chuyển về danh sách để tránh thêm trùng khi nhấn F5
            Response.Redirect(
                ResolveUrl("~/QuanLySanPham.aspx?them=thanhcong"),
                false);

            Context.ApplicationInstance.CompleteRequest();
        }
    }
}