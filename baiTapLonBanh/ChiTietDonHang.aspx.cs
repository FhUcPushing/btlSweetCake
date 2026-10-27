using System;
using System.Collections.Generic;
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
            bool laAdmin = nd.VaiTro == "Admin";
            string ma = Request.QueryString["ma"];
            DonHang don = null;

            List<DonHang> dsDon = Application["DanhSachDonHang"] as List<DonHang>;
            if (dsDon != null && !string.IsNullOrEmpty(ma))
            {
                Application.Lock();
                try
                {

                    foreach (DonHang d in dsDon)
                    {
                        if (d.MaDon == ma &&
                            (laAdmin || d.TenDangNhap == nd.TenDangNhap))
                        {
                            don = d;
                            break;
                        }
                    }
                    if (laAdmin)
                    {
                        lnkQuayLai.HRef = ResolveUrl("~/QuanTri.aspx");
                        litQuayLai.Text = "Quản lý đơn hàng";
                    }
                    else
                    {
                        lnkQuayLai.HRef =
                            ResolveUrl("~/TaiKhoan.aspx?tab=donhang");

                        litQuayLai.Text = "Đơn hàng của tôi";
                    }
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
            // Chỉ cho hủy đơn khi còn chờ xác nhận
            btnHuyDon.Visible =
    !laAdmin &&
    don.TrangThai == "Chờ xác nhận";
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
        protected void btnHuyDon_Click(object sender, EventArgs e)
        {
            // Kiểm tra người dùng đã đăng nhập
            NguoiDung nd = Session["TaiKhoan"] as NguoiDung;

            if (nd == null)
            {
                Response.Redirect(
                    ResolveUrl("~/DangNhap.aspx"), false);

                Context.ApplicationInstance.CompleteRequest();
                return;
            }
            // Admin không sử dụng chức năng hủy đơn dành cho khách hàng
            if (nd.VaiTro == "Admin")
            {
                btnHuyDon.Visible = false;

                lblThongBaoHuy.Text =
                    "Quản trị viên không sử dụng chức năng hủy đơn của khách hàng.";

                lblThongBaoHuy.CssClass =
                    "ct-thong-bao that-bai";

                return;
            }
            string ma = Request.QueryString["ma"];

            if (string.IsNullOrWhiteSpace(ma))
            {
                lblThongBaoHuy.Text =
                    "Không tìm thấy mã đơn hàng.";

                lblThongBaoHuy.CssClass =
                    "ct-thong-bao that-bai";

                return;
            }

            bool timThay = false;
            bool daHuy = false;
            bool saiTrangThai = false;

            // Tìm và cập nhật đơn hàng
            Application.Lock();

            try
            {
                List<DonHang> dsDon =
                    Application["DanhSachDonHang"] as List<DonHang>;

                if (dsDon != null)
                {
                    foreach (DonHang don in dsDon)
                    {
                        // Chỉ chủ đơn mới được hủy
                        if (don.MaDon == ma &&
                            don.TenDangNhap == nd.TenDangNhap)
                        {
                            timThay = true;

                            // Chỉ hủy khi còn chờ xác nhận
                            if (don.TrangThai == "Chờ xác nhận")
                            {
                                don.TrangThai = "Đã hủy";
                                daHuy = true;
                            }
                            else
                            {
                                saiTrangThai = true;
                            }

                            break;
                        }
                    }
                }
            }
            finally
            {
                Application.UnLock();
            }

            // Hiển thị kết quả
            if (daHuy)
            {
                litTrangThai.Text = "Đã hủy";
                btnHuyDon.Visible = false;

                lblThongBaoHuy.Text =
                    "Đơn hàng đã được hủy thành công!";

                lblThongBaoHuy.CssClass =
                    "ct-thong-bao thanh-cong";
            }
            else if (timThay && saiTrangThai)
            {
                btnHuyDon.Visible = false;

                lblThongBaoHuy.Text =
                    "Không thể hủy vì đơn hàng không còn ở trạng thái Chờ xác nhận.";

                lblThongBaoHuy.CssClass =
                    "ct-thong-bao that-bai";
            }
            else
            {
                lblThongBaoHuy.Text =
                    "Không tìm thấy đơn hàng hoặc bạn không có quyền hủy đơn này.";

                lblThongBaoHuy.CssClass =
                    "ct-thong-bao that-bai";
            }
        }
    }
}