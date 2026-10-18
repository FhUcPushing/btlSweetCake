using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using baiTapLonBanh;
namespace baiTapLonBanh
{
    public partial class ChiTietSanPham : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string idChiTietSanPham = Request.QueryString["id"];

            List<SanPhamBanh> danhSachSanPham =
                (List<SanPhamBanh>)Application["DanhSachSanPham"];

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
                thongTinBanh.Visible = true;
                thongBaoLoi.Visible = false;

                tenBanh.InnerText = banhTimThay.tenBanh;
                giaBanh.InnerText = banhTimThay.giaBanh.ToString("N0") + "đ";
                moTa.InnerText = banhTimThay.moTa;
                loaiBanh.InnerText = banhTimThay.loaiBanh;
                anhBanh.Src = banhTimThay.anhBanh;

                List<SanPhamBanh> danhSachBanhGoiY = new List<SanPhamBanh>();

                foreach (SanPhamBanh x in danhSachSanPham)
                {
                    if (x.maBanh == banhTimThay.maBanh)
                    {
                        continue;
                    }
                    if (danhSachBanhGoiY.Count >= 3)
                    {
                        break;
                    }
                    danhSachBanhGoiY.Add(x);
                }
                rptDanhSachGoiY.DataSource = danhSachBanhGoiY;
                rptDanhSachGoiY.DataBind();

                khuVucGoiY.Visible = danhSachBanhGoiY.Count > 0;
            }
            else
            {
                thongTinBanh.Visible = false;
                thongBaoLoi.Visible = true;
                khuVucGoiY.Visible = false;
            }
        }
        private void HienThongBao(string noiDung, bool thanhCong)
        {
            string icon = thanhCong
                ? "<i class=\"fa-solid fa-circle-check\"></i> "
                : "<i class=\"fa-solid fa-circle-exclamation\"></i> ";

            thongBaoGioHang.InnerHtml = icon + HttpUtility.HtmlEncode(noiDung);
            thongBaoGioHang.Attributes["class"] = "thong_bao_gio_hang " + (thanhCong ? "thanh_cong" : "loi");
            thongBaoGioHang.Visible = true;
        }

        protected void btnThemVaoGio_ServerClick(object sender, EventArgs e)
        {
            string maBanh = Request.QueryString["id"];
            int soLuong;

            if (!int.TryParse(soLuongBanh.Value, out soLuong) || soLuong < 1)
            {
                HienThongBao("Vui lòng nhập số lượng hợp lệ.", false);
                return;
            }
            bool check = ThemBanhVaoGio(maBanh, soLuong);
            if (check) {
                HienThongBao("Bạn đã thêm vào giỏ hàng thành công!", true);
            }
            else
            {
                HienThongBao("Không tìm thấy sản phẩm!", false);
            }
        }
        protected void btnMuaNgay_ServerClick(object sender, EventArgs e)
        {
            string maBanh = Request.QueryString["id"];
            int soLuong;
            if (!int.TryParse(soLuongBanh.Value, out soLuong)
                || soLuong < 1)
            {
                HienThongBao("Vui lòng nhập số lượng hợp lệ.", false);
                return;
            }
            bool check = ThemBanhVaoGio(maBanh, soLuong);
            if (check)
            {
                Response.Redirect("DatHang.aspx");
            }
            else
            {
                HienThongBao("Không tìm thấy sản phẩm!", false);
            }
        }
        protected bool ThemBanhVaoGio(string maBanh, int soLuong)
        {
            List<SanPhamBanh> danhSachBanh = Application["DanhSachSanPham"] as List<SanPhamBanh>;
            foreach(SanPhamBanh x in danhSachBanh)
            {
                if(x.maBanh == maBanh)
                {
                    Dictionary<string, int> gioHang = Session["GioHang"] as Dictionary<string, int>;
                    if(gioHang == null)
                    {
                        gioHang = new Dictionary<string, int>();
                    }
                    if (gioHang.ContainsKey(maBanh))
                    {
                        gioHang[maBanh] = gioHang[maBanh] + soLuong;
                    }
                    else
                    {
                        gioHang.Add(maBanh, soLuong);
                    }
                    Session["GioHang"] = gioHang;
                    return true;
                }
            }
            return false;
        }
    }
}