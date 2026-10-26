using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace baiTapLonBanh
{
    public partial class QuanLySanPham : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Kiểm tra đăng nhập
            NguoiDung taiKhoan =
                Session["TaiKhoan"] as NguoiDung;

            if (taiKhoan == null)
            {
                Response.Redirect(
                    ResolveUrl("~/DangNhap.aspx"), false);

                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // Chỉ Admin được quản lý sản phẩm
            if (taiKhoan.VaiTro != "Admin")
            {
                Response.Redirect(
                    ResolveUrl("~/TrangChu.aspx"), false);

                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                HienThiSanPham();

                if (Request.QueryString["them"] == "thanhcong")
                {
                    lblThongBao.Text = "Thêm sản phẩm thành công!";
                    lblThongBao.CssClass = "admin-message thanh-cong";
                }
                else if (Request.QueryString["sua"] == "thanhcong")
                {
                    lblThongBao.Text = "Cập nhật sản phẩm thành công!";
                    lblThongBao.CssClass = "admin-message thanh-cong";
                }
            }
        }

        private void HienThiSanPham()
        {
            List<SanPhamBanh> dsBanh =
                new List<SanPhamBanh>();

            Application.Lock();

            try
            {
                List<SanPhamBanh> danhSachGoc =
                    Application["DanhSachSanPham"]
                    as List<SanPhamBanh>;

                if (danhSachGoc != null)
                {
                    dsBanh = new List<SanPhamBanh>(
                        danhSachGoc);
                }
            }
            finally
            {
                Application.UnLock();
            }

            gvSanPham.DataSource = dsBanh;
            gvSanPham.DataBind();

            pnlKhongCoBanh.Visible =
                dsBanh.Count == 0;

            gvSanPham.Visible =
                dsBanh.Count > 0;
        }
        protected void gvSanPham_RowCommand(
    object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "XoaSanPham")
            {
                return;
            }

            // Kiểm tra quyền Admin
            NguoiDung taiKhoan =
                Session["TaiKhoan"] as NguoiDung;

            if (taiKhoan == null)
            {
                Response.Redirect(
                    ResolveUrl("~/DangNhap.aspx"), false);

                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (taiKhoan.VaiTro != "Admin")
            {
                Response.Redirect(
                    ResolveUrl("~/TrangChu.aspx"), false);

                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // Lấy mã bánh cần xóa
            string maBanh = Convert.ToString(e.CommandArgument);

            if (string.IsNullOrWhiteSpace(maBanh))
            {
                lblThongBao.Text = "Mã sản phẩm không hợp lệ.";
                lblThongBao.CssClass = "admin-message that-bai";
                return;
            }

            bool timThay = false;
            bool daDuocDat = false;
            bool daXoa = false;

            Application.Lock();

            try
            {
                List<SanPhamBanh> dsBanh =
                    Application["DanhSachSanPham"] as List<SanPhamBanh>;

                List<DonHang> dsDonHang =
                    Application["DanhSachDonHang"] as List<DonHang>;

                if (dsBanh != null)
                {
                    SanPhamBanh banhCanXoa = null;

                    // Tìm sản phẩm theo mã
                    foreach (SanPhamBanh banh in dsBanh)
                    {
                        if (banh.maBanh == maBanh)
                        {
                            banhCanXoa = banh;
                            break;
                        }
                    }

                    if (banhCanXoa != null)
                    {
                        timThay = true;

                        // Kiểm tra sản phẩm đã xuất hiện trong đơn hàng chưa
                        if (dsDonHang != null)
                        {
                            foreach (DonHang don in dsDonHang)
                            {
                                if (don.Dong != null)
                                {
                                    foreach (ChiTietDon chiTiet in don.Dong)
                                    {
                                        if (chiTiet.maBanh == maBanh)
                                        {
                                            daDuocDat = true;
                                            break;
                                        }
                                    }
                                }

                                if (daDuocDat)
                                {
                                    break;
                                }
                            }
                        }

                        // Chỉ xóa nếu sản phẩm chưa được đặt hàng
                        if (!daDuocDat)
                        {
                            dsBanh.Remove(banhCanXoa);

                            Application["DanhSachSanPham"] = dsBanh;

                            daXoa = true;
                        }
                    }
                }
            }
            finally
            {
                Application.UnLock();
            }

            // Hiển thị kết quả
            if (daXoa)
            {
                lblThongBao.Text = "Xóa sản phẩm thành công!";
                lblThongBao.CssClass = "admin-message thanh-cong";
            }
            else if (daDuocDat)
            {
                lblThongBao.Text =
                    "Không thể xóa sản phẩm vì sản phẩm đã xuất hiện trong lịch sử đơn hàng.";

                lblThongBao.CssClass = "admin-message that-bai";
            }
            else if (!timThay)
            {
                lblThongBao.Text =
                    "Không tìm thấy sản phẩm cần xóa.";

                lblThongBao.CssClass = "admin-message that-bai";
            }

            // Cập nhật lại danh sách sau thao tác
            HienThiSanPham();
        }
    }
}