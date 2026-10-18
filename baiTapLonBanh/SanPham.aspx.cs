using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace baiTapLonBanh
{
    public partial class SanPham : System.Web.UI.Page
    {
        // Thư mục chứa ảnh bánh, tính từ thư mục gốc của website.
        // "~/"        -> ảnh nằm cùng chỗ với các file .aspx (ví dụ ~/YOGURT-1.png)
        // "~/Images/" -> ảnh nằm trong thư mục Images
        private const string ThuMucAnh = "~/";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string loai = Request.QueryString["loai"];

                List<SanPhamBanh> danhSachSanPhamBanh =
                    Application["DanhSachSanPham"] as List<SanPhamBanh>;

                if (danhSachSanPhamBanh == null)
                {
                    return;
                }

                List<SanPhamBanh> danhSachHienThi =
                    new List<SanPhamBanh>();

                foreach (SanPhamBanh x in danhSachSanPhamBanh)
                {
                    if (string.IsNullOrEmpty(loai))
                    {
                        danhSachHienThi.Add(x);
                    }
                    else if (loai == "banh_kem" &&
    (x.loaiBanh == "Bánh Kem" ||
     x.loaiBanh == "Bánh Sinh Nhật" ||
     x.loaiBanh == "Bánh Mousse"))
                    {
                        danhSachHienThi.Add(x);
                    }
                    else if (loai == "banh_tuoi" &&
         x.loaiBanh == "Bánh Tươi")
                    {
                        danhSachHienThi.Add(x);
                    }
                    else if (loai == "banh_mi" &&
                             x.loaiBanh == "Bánh Mì")
                    {
                        danhSachHienThi.Add(x);
                    }
                }

                rptDanhSachBanh.DataSource = danhSachHienThi;
                rptDanhSachBanh.DataBind();
            }
        }
        protected string LayClassSanPham(string loaiBanh)
        {
            string loaiBanhClass = "";
            string nhomClass = "";

            switch (loaiBanh)
            {
                case "Bánh Mousse":
                    loaiBanhClass = "banh_mousse";
                    nhomClass = "banh_kem";
                    break;

                case "Bánh Sinh Nhật":
                    loaiBanhClass = "banh_sinh_nhat";
                    nhomClass = "banh_kem";
                    break;

                case "Bánh Kem":
                    nhomClass = "banh_kem";
                    break;

                case "Bánh Tươi":
                    nhomClass = "banh_tuoi";
                    break;

                case "Bánh Mì":
                    nhomClass = "banh_mi";
                    break;
            }

            return ("the_san_pham " + loaiBanhClass + " " + nhomClass)
                .Replace("  ", " ")
                .Trim();
        }
    }
}