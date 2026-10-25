using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace baiTapLonBanh
{
    public partial class ChiTietDonHang : System.Web.UI.Page
    {
        private static string Tien(decimal so) { return so.ToString("N0") + "đ"; }

        protected void Page_Load(object sender, EventArgs e)
        {
            NguoiDung nd = Session["TaiKhoan"] as NguoiDung;
            if (nd == null)
            {
                Response.Redirect("DangNhap.aspx");
                return;
            }

            string ma = Request.QueryString["ma"];
            DonHang don = null;

            List<DonHang> dsDon = Application["DanhSachDonHang"] as List<DonHang>;
            if (dsDon != null && !string.IsNullOrEmpty(ma))
            {
                Application.Lock();
                try
                {
                    // Chỉ chủ đơn mới xem được đơn của mình
                    don = dsDon.FirstOrDefault(d => d.MaDon == ma && d.TenDangNhap == nd.TenDangNhap);
                }
                finally { Application.UnLock(); }
            }

            if (don == null)
            {
                pnlChiTiet.Visible = false;
                pnlKhongTim.Visible = true;
                return;
            }

            litMaDon.Text = HttpUtility.HtmlEncode(don.MaDon);
            litTrangThai.Text = HttpUtility.HtmlEncode(don.TrangThai);
            litNgayDat.Text = don.NgayDat.ToString("dd/MM/yyyy HH:mm");
            litNguoiNhan.Text = HttpUtility.HtmlEncode(don.NguoiNhan) + " - " + HttpUtility.HtmlEncode(don.SoDienThoai);
            litDiaChi.Text = HttpUtility.HtmlEncode(don.DiaChi);
            litThoiGian.Text = HttpUtility.HtmlEncode(don.ThoiGianNhan);
            litThanhToan.Text = HttpUtility.HtmlEncode(don.ThanhToan);
            litGhiChu.Text = string.IsNullOrWhiteSpace(don.GhiChu) ? "Không có" : HttpUtility.HtmlEncode(don.GhiChu);

            rptDong.DataSource = don.Dong;
            rptDong.DataBind();

            litTamTinh.Text = Tien(don.TamTinh);
            litPhiShip.Text = don.PhiShip == 0m ? "Miễn phí" : Tien(don.PhiShip);
            litGiamGia.Text = don.GiamGia > 0m ? "-" + Tien(don.GiamGia) : "0đ";
            litTongCong.Text = Tien(don.TongCong);
        }
    }
}