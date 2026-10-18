using baiTapLonBanh;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace baiTapLonBanh
{
    public partial class DangNhap : System.Web.UI.Page
    {
        public string savedUser = "";
        public string savedPass = "";
        public bool isRemembered = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            // ĐĂNG XUẤT: bấm nút đăng xuất ở header (DangNhap.aspx?dangxuat=1)
            if (!IsPostBack && Request.QueryString["dangxuat"] == "1")
            {
                Session.Remove("TaiKhoan");
                Session.Remove("TenHienThi");
                Response.Redirect("TrangChu.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // 1. KHI MỞ TRANG: Đọc Cookie trực tiếp bằng C#
                if (Request.Cookies["SweetCakeUser"] != null && Request.Cookies["SweetCakePass"] != null)
                {
                    savedUser = Request.Cookies["SweetCakeUser"].Value;
                    savedPass = Request.Cookies["SweetCakePass"].Value;
                    isRemembered = true;
                }
            }
            else
            {
                // 2. KHI BẤM ĐĂNG NHẬP (POSTBACK)
                string username = Request.Form["username"]?.Trim();
                string password = Request.Form["password"]?.Trim();
                string remember = Request.Form["remember"];

                List<NguoiDung> dsTaiKhoan = Application["DanhSachNguoiDung"] as List<NguoiDung>;

                NguoiDung userFound = null;

                if (dsTaiKhoan != null)
                {
                    // Dùng vòng lặp foreach tìm tài khoản
                    foreach (NguoiDung u in dsTaiKhoan)
                    {
                        if (u.TenDangNhap == username && u.MatKhau == password)
                        {
                            userFound = u;
                            break; // Tìm thấy thì dừng vòng lặp ngay
                        }
                    }
                }

                if (userFound != null)
                {
                    Session["TaiKhoan"] = userFound;
                    Session["TenHienThi"] = userFound.TenDangNhap; // hiển thị "Xin chào, ..." ở header

                    // Xử lý Cookie
                    if (remember == "true")
                    {
                        Response.Cookies["SweetCakeUser"].Value = username;
                        Response.Cookies["SweetCakeUser"].Expires = DateTime.Now.AddDays(30);

                        Response.Cookies["SweetCakePass"].Value = password;
                        Response.Cookies["SweetCakePass"].Expires = DateTime.Now.AddDays(30);
                    }
                    else
                    {
                        if (Request.Cookies["SweetCakeUser"] != null)
                            Response.Cookies["SweetCakeUser"].Expires = DateTime.Now.AddDays(-1);

                        if (Request.Cookies["SweetCakePass"] != null)
                            Response.Cookies["SweetCakePass"].Expires = DateTime.Now.AddDays(-1);
                    }

                    Response.Redirect("TrangChu.aspx");
                }
                else
                {
                    divThongBao.InnerHtml = "<div class='message error'>Mật khẩu hoặc tên đăng nhập không đúng!</div>";
                }
            }
        }
    }
}