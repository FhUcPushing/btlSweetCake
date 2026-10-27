using System;
using baiTapLonBanh;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace baiTapLonBanh
{
    public partial class QuanTri : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Lấy tài khoản đang đăng nhập
            NguoiDung taiKhoan =
                Session["TaiKhoan"] as NguoiDung;

            // Chưa đăng nhập
            if (taiKhoan == null)
            {
                Response.Redirect(ResolveUrl("~/DangNhap.aspx"), false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // Không phải quản trị viên
            if (taiKhoan.VaiTro != "Admin")
            {
                Response.Redirect(ResolveUrl("~/TrangChu.aspx"), false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // Hiển thị tên quản trị viên
            if (!IsPostBack)
            {
                HienThiDonHang();
            }
        }
        private void HienThiDonHang()
        {
            List<DonHang> dsDon = new List<DonHang>();

            // Lấy danh sách đơn hàng
            Application.Lock();

            try
            {
                List<DonHang> danhSachGoc =
                    Application["DanhSachDonHang"] as List<DonHang>;

                if (danhSachGoc != null)
                {
                    foreach (DonHang don in danhSachGoc)
                    {
                        dsDon.Add(don);
                    }
                }
            }
            finally
            {
                Application.UnLock();
            }

            // Sắp xếp đơn hàng mới nhất lên đầu
            for (int i = 0; i < dsDon.Count - 1; i++)
            {
                for (int j = i + 1; j < dsDon.Count; j++)
                {
                    if (dsDon[i].NgayDat < dsDon[j].NgayDat)
                    {
                        DonHang tam = dsDon[i];

                        dsDon[i] = dsDon[j];
                        dsDon[j] = tam;
                    }
                }
            }

            // Hiển thị danh sách đơn hàng
            gvDonHang.DataSource = dsDon;
            gvDonHang.DataBind();

            pnlKhongCoDon.Visible = dsDon.Count == 0;
            gvDonHang.Visible = dsDon.Count > 0;
        }
        protected void gvDonHang_RowDataBound(
    object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Lấy trạng thái của đơn hàng
                string trangThai = Convert.ToString(
                    DataBinder.Eval(e.Row.DataItem, "TrangThai"));

                // Nếu đơn đã hủy thì đánh dấu hàng
                if (trangThai == "Đã hủy")
                {
                    e.Row.CssClass = "don-da-huy";
                }

                // Hiển thị đúng trạng thái trong ô chọn
                DropDownList ddl =
                    e.Row.FindControl("ddlTrangThai") as DropDownList;

                if (ddl != null &&
                    ddl.Items.FindByValue(trangThai) != null)
                {
                    ddl.SelectedValue = trangThai;
                }
            }
        }
        protected void gvDonHang_RowCommand(
    object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "CapNhatTrangThai")
            {
                return;
            }

            // Kiểm tra quyền một lần nữa khi xử lý thao tác
            NguoiDung taiKhoan =
                Session["TaiKhoan"] as NguoiDung;

            if (taiKhoan == null)
            {
                Response.Redirect(ResolveUrl("~/DangNhap.aspx"), false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (taiKhoan.VaiTro != "Admin")
            {
                Response.Redirect(ResolveUrl("~/TrangChu.aspx"), false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // Lấy mã đơn và trạng thái Admin chọn
            string maDon = Convert.ToString(e.CommandArgument);

            GridViewRow row =
                ((Control)e.CommandSource).NamingContainer as GridViewRow;

            if (row == null)
            {
                return;
            }

            DropDownList ddl =
                row.FindControl("ddlTrangThai") as DropDownList;

            if (ddl == null)
            {
                return;
            }

            string trangThaiMoi = ddl.SelectedValue;
            bool daCapNhat = false;

            // Tìm và cập nhật đúng đơn hàng
            Application.Lock();

            try
            {
                List<DonHang> dsDon =
                    Application["DanhSachDonHang"] as List<DonHang>;

                if (dsDon != null)
                {
                    foreach (DonHang don in dsDon)
                    {
                        if (don.MaDon == maDon)
                        {
                            don.TrangThai = trangThaiMoi;
                            daCapNhat = true;
                            break;
                        }
                    }
                }
            }
            finally
            {
                Application.UnLock();
            }

            // Thông báo và tải lại bảng
            if (daCapNhat)
            {
                lblThongBao.Text = "Cập nhật trạng thái đơn hàng thành công!";
                lblThongBao.CssClass = "admin-message thanh-cong";
            }
            else
            {
                lblThongBao.Text = "Không tìm thấy đơn hàng cần cập nhật.";
                lblThongBao.CssClass = "admin-message that-bai";
            }

            HienThiDonHang();
        }
    }
}