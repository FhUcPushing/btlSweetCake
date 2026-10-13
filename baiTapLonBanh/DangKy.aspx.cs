using baiTapLonBanh;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace baiTapLonBanh
{
    public partial class DangKy : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) return;

            string fullname = Request.Form["fullname"]?.Trim();
            string username = Request.Form["username"]?.Trim();
            string password = Request.Form["password"]?.Trim();
            string confirmPassword = Request.Form["confirm_password"]?.Trim();

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                divThongBao.InnerHtml = "<div class='message error'>Vui lòng nhập đầy đủ thông tin!</div>";
                return;
            }

            if (password != confirmPassword)
            {
                divThongBao.InnerHtml = "<div class='message error'>Mật khẩu xác nhận không khớp!</div>";
                return;
            }

            NguoiDung userMoi = null;
            string loi = null;

            // Khóa Application chỉ trong lúc thêm tài khoản.
            // Phải mở khóa TRƯỚC khi chuyển trang (Response.Redirect ném ThreadAbortException,
            // nếu còn khóa thì cả website sẽ bị treo).
            Application.Lock();
            try
            {
                List<NguoiDung> dsTaiKhoan = Application["DanhSachNguoiDung"] as List<NguoiDung>;

                if (dsTaiKhoan == null)
                {
                    dsTaiKhoan = new List<NguoiDung>();
                }

                if (dsTaiKhoan.Exists(u => u.TenDangNhap.Equals(username, StringComparison.OrdinalIgnoreCase)))
                {
                    loi = "Tên đăng nhập này đã được sử dụng!";
                }
                else
                {
                    userMoi = new NguoiDung
                    {
                        HoTen = fullname,
                        TenDangNhap = username,
                        MatKhau = password
                    };

                    dsTaiKhoan.Add(userMoi);
                    Application["DanhSachNguoiDung"] = dsTaiKhoan;
                }
            }
            finally
            {
                Application.UnLock();
            }

            if (loi != null)
            {
                divThongBao.InnerHtml = "<div class='message error'>" + loi + "</div>";
                return;
            }

            // Đăng ký thành công: đăng nhập luôn rồi về trang chủ
            Session["TaiKhoan"] = userMoi;
            Session["TenHienThi"] = userMoi.TenDangNhap;

            Response.Redirect("Default.aspx");
        }
    }
}