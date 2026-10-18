using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace baiTapLonBanh
{
    public partial class TrangChu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                List<SanPhamBanh> danhSach = Application["DanhSachSanPham"] as List<SanPhamBanh>;
                List<SanPhamBanh> sanPhamNoiBat = new List<SanPhamBanh>();
                foreach(SanPhamBanh x in danhSach)
                {
                    if(sanPhamNoiBat.Count < 4 && (x.loaiBanh=="Bánh Mousse"||x.loaiBanh=="Bánh Kem"||x.loaiBanh=="Bánh Sinh Nhật"))
                    {
                        sanPhamNoiBat.Add(x);
                    }
                }
                rptSanPhamNoiBat.DataSource = sanPhamNoiBat;
                rptSanPhamNoiBat.DataBind();
                List<SanPhamBanh> danhSachBanhTuoi = new List<SanPhamBanh>();
                foreach(SanPhamBanh x in danhSach)
                {
                    if(danhSachBanhTuoi.Count < 4 && x.loaiBanh=="Bánh Tươi") 
                    {
                        danhSachBanhTuoi.Add(x);
                    }
                }
                rptBanhTuoi.DataSource = danhSachBanhTuoi;
                rptBanhTuoi.DataBind();
                
            }
        }

        protected void btnThemVaoGio_Command(object sender, CommandEventArgs e)
        {
            string maBanh = e.CommandArgument.ToString();

            Dictionary<string, int> gioHang =
                Session["GioHang"] as Dictionary<string, int>;

            if (gioHang == null)
            {
                gioHang = new Dictionary<string, int>();
            }

            if (gioHang.ContainsKey(maBanh))
            {
                gioHang[maBanh] = gioHang[maBanh] + 1;
            }
            else
            {
                gioHang.Add(maBanh, 1);
            }

            Session["GioHang"] = gioHang;

            lblThongBaoGioHang.Text = "Thêm vào giỏ hàng thành công!";
            lblThongBaoGioHang.Visible = true;
        }

    }
}