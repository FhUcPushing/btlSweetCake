using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace baiTapLonBanh
{
    public partial class ChiTietSanPham : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string idChiTietSanPham = Request.QueryString["id"];
            List<SanPhamBanh> danhSachSanPham = (List<SanPhamBanh>)Application["DanhSachSanPham"];
            SanPhamBanh banhTimThay = null;
            foreach (SanPhamBanh x in danhSachSanPham)
            {
                if (x.maBanh == idChiTietSanPham)
                {
                    banhTimThay = x;
                    break;
                }
            }
            if (banhTimThay != null)
            {
                tenBanh.InnerText = banhTimThay.tenBanh;
                giaBanh.InnerText = banhTimThay.giaBanh.ToString("N0") + "đ";
                moTa.InnerText = banhTimThay.moTa;
                loaiBanh.InnerText = banhTimThay.loaiBanh;
                anhBanh.Src = banhTimThay.anhBanh;
                thongTinBanh.Visible = true;
                thongBaoLoi.Visible = false;
            }
            else
            {
                thongTinBanh.Visible = false;
                thongBaoLoi.Visible = true;
            }
        }
    }
}