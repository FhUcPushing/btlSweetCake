using baiTapLonBanh;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static baiTapLonBanh.SanPham;
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
            var sanPhamTrongGio = gioHang
    .Select(kv =>
    {
        string ma, size;
        GioHangKey.Tach(kv.Key, out ma, out size);
        SanPhamBanh b = danhSachSanPham.FirstOrDefault(x => x.maBanh == ma);
        return new { kv, b, size };
    })
    .Where(x => x.b != null)
    .Select(x => new
    {
        khoa = x.kv.Key,
        tenBanh = x.b.tenBanh + (x.size != null ? " (" + GioHangKey.TenSize(x.size) + ")" : ""),
        anhBanh = x.b.anhBanh,
        giaBanh = GioHangKey.DonGia(x.b, x.size),
        soLuong = x.kv.Value,
        thanhTien = GioHangKey.DonGia(x.b, x.size) * x.kv.Value
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
                gioHang.Remove(maBanh);   // maBanh ở đây chính là khóa "mã|size"
            }

            Session["GioHang"] = gioHang;

            // Cập nhật lại số lượng và tổng tiền
            HienThiGioHang();
        }
    }
}