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
        public bool isRemembered = false;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Request.QueryString["dangxuat"] == "1")
            {
                Session.Remove("TaiKhoan");
                Session.Remove("TenHienThi");
                Response.Redirect("TrangChu.aspx");
                return;
            }

            if (!IsPostBack)
            {
                if (Request.Cookies["SweetCakeUser"] != null)
                {
                    savedUser = Request.Cookies["SweetCakeUser"].Value;
                    isRemembered = true;
                }

                if (Request.Cookies["SweetCakePass"] != null)
                {
                    Response.Cookies["SweetCakePass"].Expires =
                        DateTime.Now.AddDays(-1);
                }

                return;
            }
            loiUsername.InnerText = "";
            loiPassword.InnerText = "";
            divThongBao.InnerHtml = "";
            string username = (Request.Form["username"] ?? "").Trim();
            string password = Request.Form["password"] ?? "";
            string remember = Request.Form["remember"];

            bool duLieuHopLe = true;

            if (username == "")
            {
                loiUsername.InnerText = "Vui lòng nhập tên đăng nhập.";
                duLieuHopLe = false;
            }

            if (password == "")
            {
                loiPassword.InnerText = "Vui lòng nhập mật khẩu.";
                duLieuHopLe = false;
            }

            if (!duLieuHopLe)
            {
                return;
            }
            List<NguoiDung> dsTaiKhoan =
                Application["DanhSachNguoiDung"] as List<NguoiDung>;

            NguoiDung userFound = null;

            if (dsTaiKhoan != null)
            {
                foreach (NguoiDung u in dsTaiKhoan)
                {
                    if (u.TenDangNhap == username &&
                        u.MatKhau == password)
                    {
                        userFound = u;
                        break;
                    }
                }
            }
            if (userFound != null)
            {
                Session["TaiKhoan"] = userFound;
                Session["TenHienThi"] = userFound.TenDangNhap;
                if (Request.Cookies["SweetCakePass"] != null)
                {
                    Response.Cookies["SweetCakePass"].Expires =
                        DateTime.Now.AddDays(-1);
                }
                if (remember == "true")
                {
                    Response.Cookies["SweetCakeUser"].Value = username;
                    Response.Cookies["SweetCakeUser"].Expires =
                        DateTime.Now.AddDays(30);
                }
                else
                {
                    if (Request.Cookies["SweetCakeUser"] != null)
                    {
                        Response.Cookies["SweetCakeUser"].Expires =
                            DateTime.Now.AddDays(-1);
                    }
                }

                Response.Redirect("TrangChu.aspx");
                return;
            }
            divThongBao.InnerHtml =
                "<div class='message error'>Mật khẩu hoặc tên đăng nhập không đúng!</div>";
        }

    }
}