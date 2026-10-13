using baiTapLonBanh;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
namespace baiTapLonBanh
{
    public partial class DatHang : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            HienThiDonHang();
        }

        private void HienThiDonHang()
        {
            danhSachDonHang.Controls.Clear();

            List<SanPhamBanh> danhSachSanPham =
                Application["DanhSachSanPham"] as List<SanPhamBanh>;

            Dictionary<string, int> gioHang =
                Session["GioHang"] as Dictionary<string, int>;

            decimal tongTien = 0;

            if (danhSachSanPham != null && gioHang != null)
            {
                foreach (SanPhamBanh banh in danhSachSanPham)
                {
                    if (gioHang.ContainsKey(banh.maBanh))
                    {
                        int soLuong = gioHang[banh.maBanh];

                        if (soLuong < 1)
                        {
                            continue;
                        }

                        decimal thanhTien = banh.giaBanh * soLuong;
                        tongTien += thanhTien;

                        HtmlGenericControl dong = new HtmlGenericControl("div");
                        dong.Attributes["class"] = "don-hang-item";

                        HtmlGenericControl tenBanh = new HtmlGenericControl("p");
                        tenBanh.InnerText = banh.tenBanh + " × " + soLuong;
                        dong.Controls.Add(tenBanh);

                        HtmlGenericControl giaBanh = new HtmlGenericControl("p");
                        giaBanh.InnerText = thanhTien.ToString("N0") + "đ";
                        dong.Controls.Add(giaBanh);

                        danhSachDonHang.Controls.Add(dong);
                    }
                }
            }

            if (danhSachDonHang.Controls.Count == 0)
            {
                HtmlGenericControl thongBao = new HtmlGenericControl("p");
                thongBao.InnerText = "Giỏ hàng của bạn đang trống.";
                danhSachDonHang.Controls.Add(thongBao);
            }

            litTongTien.Text = tongTien.ToString("N0") + "đ";
        }

        protected void btnXacNhanDatHang_Click(object sender, EventArgs e)
        {
            // Kiểm tra giỏ hàng
            Dictionary<string, int> gioHang =
                Session["GioHang"] as Dictionary<string, int>;

            if (gioHang == null || gioHang.Count == 0)
            {
                lblThongBao.Text = "Giỏ hàng đang trống.";
                lblThongBao.Visible = true;
                return;
            }

            // Kiểm tra thông tin người nhận
            if (string.IsNullOrWhiteSpace(txtHoTen.Text) ||
                string.IsNullOrWhiteSpace(txtSoDienThoai.Text) ||
                string.IsNullOrWhiteSpace(txtDiaChi.Text))
            {
                lblThongBao.Text =
                    "Vui lòng nhập đầy đủ họ tên, số điện thoại và địa chỉ.";
                lblThongBao.Visible = true;
                return;
            }

            // Kiểm tra số điện thoại Việt Nam gồm 10 chữ số, bắt đầu bằng 0
            string soDienThoai = txtSoDienThoai.Text.Trim();

            if (!Regex.IsMatch(soDienThoai, @"^0\d{9}$"))
            {
                lblThongBao.Text =
                    "Số điện thoại phải gồm 10 chữ số và bắt đầu bằng 0.";
                lblThongBao.Visible = true;
                return;
            }

            // Mô phỏng xác nhận đơn hàng
            string maDonHang = "DH" + DateTime.Now.ToString("yyyyMMddHHmmss");

            Session["DonHangGanNhat"] = maDonHang;

            // Xóa giỏ sau khi đặt hàng thành công
            Session.Remove("GioHang");

            danhSachDonHang.Controls.Clear();
            danhSachDonHang.Visible = false;
            litTongTien.Visible = false;

            lblThongBao.Text =
                "Đặt hàng thành công! Mã đơn hàng của bạn là: " + maDonHang;

            lblThongBao.Visible = true;
        }
    }
}