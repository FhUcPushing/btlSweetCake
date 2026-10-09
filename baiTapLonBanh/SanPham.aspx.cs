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
        protected void Page_Load(object sender, EventArgs e)
        {
            List<SanPhamBanh> danhSachSanPhamBanh = (List<SanPhamBanh>)Application["DanhSachSanPham"];
            foreach (SanPhamBanh x in danhSachSanPhamBanh)
            {
                string loaiBanhClass = "";
                if (x.loaiBanh == "Bánh Mousse")
                {
                    loaiBanhClass = "banh_mousse";
                }
                else if (x.loaiBanh == "Bánh Sinh Nhật")
                {
                    loaiBanhClass = "banh_sinh_nhat";
                }
                HtmlGenericControl newDiv = new HtmlGenericControl("div");
                newDiv.Attributes["class"] = "the_san_pham " + loaiBanhClass;
                newDiv.Attributes["data-ngay-tao"] = x.ngayTao.ToString("yyyy-MM-dd");

                HtmlGenericControl newImg = new HtmlGenericControl("img");
                newImg.Attributes["src"] = x.anhBanh;
                newDiv.Controls.Add(newImg);

                HtmlGenericControl newP1 = new HtmlGenericControl("p");
                newP1.Attributes["class"] = "ten_banh";
                newP1.InnerText = x.tenBanh;
                newDiv.Controls.Add(newP1);

                HtmlGenericControl newP2 = new HtmlGenericControl("p");
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