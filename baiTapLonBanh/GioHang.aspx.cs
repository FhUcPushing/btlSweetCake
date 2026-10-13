using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using baiTapLonBanh;
namespace baiTapLonBanh
{
    public partial class GioHang : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HienThiGioHang();
            }
        }

        private void HienThiGioHang()
        {
            List<SanPhamBanh> danhSachSanPham =
                Application["DanhSachSanPham"] as List<SanPhamBanh>;

            Dictionary<string, int> gioHang =
                Session["GioHang"] as Dictionary<string, int>;

            if (danhSachSanPham == null ||
                gioHang == null ||
                gioHang.Count == 0)
            {
                panelGioHang.Visible = false;
                thongBaoRong.Visible = true;
                return;
            }

            // Lấy thông tin bánh và số lượng trong giỏ
            var sanPhamTrongGio = danhSachSanPham
                .Where(b => gioHang.ContainsKey(b.maBanh))
                .Select(b => new
                {
                    maBanh = b.maBanh,
                    tenBanh = b.tenBanh,
                    anhBanh = b.anhBanh,
                    giaBanh = b.giaBanh,
                    soLuong = gioHang[b.maBanh],
                    thanhTien = b.giaBanh * gioHang[b.maBanh]
                })
                .ToList();

            if (sanPhamTrongGio.Count == 0)
            {
                panelGioHang.Visible = false;
                thongBaoRong.Visible = true;
                return;
            }

            // Đưa danh sách lên Repeater
            rptGioHang.DataSource = sanPhamTrongGio;
            rptGioHang.DataBind();

            // Tính tổng tiền
            decimal tongTien = sanPhamTrongGio
                .Sum(b => b.thanhTien);

            litTongTien.Text = tongTien.ToString("N0") + "đ";

            panelGioHang.Visible = true;
            thongBaoRong.Visible = false;
        }

        protected void rptGioHang_ItemCommand(
            object source,
            RepeaterCommandEventArgs e)
        {
            Dictionary<string, int> gioHang =
                Session["GioHang"] as Dictionary<string, int>;

            if (gioHang == null)
            {
                HienThiGioHang();
                return;
            }

            string maBanh = e.CommandArgument.ToString();

            if (!gioHang.ContainsKey(maBanh))
            {
                HienThiGioHang();
                return;
            }

            if (e.CommandName == "tang")
            {
                gioHang[maBanh]++;
            }
            else if (e.CommandName == "giam")
            {
                if (gioHang[maBanh] > 1)
                {
                    gioHang[maBanh]--;
                }
            }
            else if (e.CommandName == "xoa")
            {
                gioHang.Remove(maBanh);
            }

            Session["GioHang"] = gioHang;

            // Cập nhật lại số lượng và tổng tiền
            HienThiGioHang();
        }
    }
}