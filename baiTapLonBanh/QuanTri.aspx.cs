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

          
            if (!IsPostBack)
            {
                HienThiDonHang();
            }
        }
        private void HienThiDonHang()
        {
            List<DonHang> dsDon = new List<DonHang>();

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
                string trangThai = Convert.ToString(
                    DataBinder.Eval(e.Row.DataItem, "TrangThai"));

               
                if (trangThai == "Đã hủy")
                {
                    e.Row.CssClass = "don-da-huy";
                }

                
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