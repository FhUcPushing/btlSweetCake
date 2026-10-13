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
            List<SanPhamBanh> danhSachSanPhamBanh = Application["DanhSachSanPham"] as List<SanPhamBanh>;
            if (danhSachSanPhamBanh == null) return;

            foreach (SanPhamBanh x in danhSachSanPhamBanh)
            {
                // loaiBanhClass: loại chi tiết; nhomClass: nhóm ở mục "Loại bánh"
                // (khớp với id của thẻ li: banh_kem, banh_tuoi, banh_mi)
                string loaiBanhClass = "";
                string nhomClass = "";

                switch (x.loaiBanh)
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

                HtmlGenericControl newDiv = new HtmlGenericControl("div");
                newDiv.Attributes["class"] = ("the_san_pham " + loaiBanhClass + " " + nhomClass).Replace("  ", " ").Trim();
                newDiv.Attributes["data-ngay-tao"] = x.ngayTao.ToString("yyyy-MM-dd");

                HtmlGenericControl newImg = new HtmlGenericControl("img");
                newImg.Attributes["src"] = ResolveUrl(ThuMucAnh + x.anhBanh);
                newImg.Attributes["alt"] = x.tenBanh;
                // Ảnh lỗi (sai tên/sai thư mục): hiện khung bánh thay thế thay vì ô trống
                newImg.Attributes["onerror"] = "this.parentNode.classList.add('khong-anh');";
                newDiv.Controls.Add(newImg);

                HtmlGenericControl newP1 = new HtmlGenericControl("p");
                newP1.Attributes["class"] = "ten_banh";
                newP1.InnerText = x.tenBanh;
                newDiv.Controls.Add(newP1);

                HtmlGenericControl newP2 = new HtmlGenericControl("p");
                newP2.Attributes["class"] = "gia_banh";
                newP2.InnerText = x.giaBanh.ToString("N0") + "đ";
                newDiv.Controls.Add(newP2);

                HtmlGenericControl newA = new HtmlGenericControl("a");
                newA.Attributes["href"] = "ChiTietSanPham.aspx?id=" + x.maBanh;
                newA.InnerText = "Xem bánh";
                newDiv.Controls.Add(newA);

                danhSachBanh.Controls.Add(newDiv);
            }
        }
    }
}