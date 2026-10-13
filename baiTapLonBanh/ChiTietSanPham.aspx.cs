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
                giaBanh.InnerText =
                    banhTimThay.giaBanh.ToString("N0") + "đ";
                moTa.InnerText = banhTimThay.moTa;
                loaiBanh.InnerText = banhTimThay.loaiBanh;
                anhBanh.Src = banhTimThay.anhBanh;

                danhSachGoiY.Controls.Clear();

                int soLuongGoiY = 0;

                foreach (SanPhamBanh x in danhSachSanPham)
                {
                    if (x.maBanh == banhTimThay.maBanh)
                    {
                        continue;
                    }
                    if (soLuongGoiY >= 3)
                    {
                        break;
                    }

                    HtmlGenericControl newDiv = new HtmlGenericControl("div");

                    newDiv.Attributes["class"] = "the_san_pham goi_y_card";

                    HtmlGenericControl newImg = new HtmlGenericControl("img");

                    newImg.Attributes["src"] = ResolveUrl("~/" + x.anhBanh);
                    newImg.Attributes["alt"] = x.tenBanh;
                    // Ảnh lỗi: hiện khung 🧁 thay thế (giống trang Sản phẩm)
                    newImg.Attributes["onerror"] = "this.parentNode.classList.add('khong-anh');";

                    newDiv.Controls.Add(newImg);

                    HtmlGenericControl newP1 =
                        new HtmlGenericControl("p");

                    newP1.Attributes["class"] = "ten_banh";
                    newP1.InnerText = x.tenBanh;

                    newDiv.Controls.Add(newP1);

                    HtmlGenericControl newP2 =
                        new HtmlGenericControl("p");

                    newP2.InnerText =
                        x.giaBanh.ToString("N0") + "đ";

                    newDiv.Controls.Add(newP2);

                    HtmlGenericControl newA =
                        new HtmlGenericControl("a");

                    newA.Attributes["href"] =
                        "ChiTietSanPham.aspx?id=" + x.maBanh;

                    newA.InnerText = "Xem bánh";

                    newDiv.Controls.Add(newA);

                    danhSachGoiY.Controls.Add(newDiv);

                    soLuongGoiY++;
                }

                khuVucGoiY.Visible = soLuongGoiY > 0;
            }
            else
            {
                thongTinBanh.Visible = false;
                thongBaoLoi.Visible = true;
                khuVucGoiY.Visible = false;
            }
        }
        // Hiện thông báo dưới nút mua hàng.
        // thanhCong = true -> màu xanh (tự ẩn sau 10 giây bằng CSS), false -> màu hồng báo lỗi
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

            // Kiểm tra số lượng
            int soLuong;

            if (!int.TryParse(soLuongBanh.Value, out soLuong) || soLuong < 1)
            {
                HienThongBao("Vui lòng nhập số lượng hợp lệ.", false);
                return;
            }
            List<SanPhamBanh> danhSachSanPham =
                Application["DanhSachSanPham"] as List<SanPhamBanh>;
            bool timThay = false;

            if (danhSachSanPham != null)
            {
                foreach (SanPhamBanh x in danhSachSanPham)
                {
                    if (x.maBanh == maBanh)
                    {
                        timThay = true;
                        break;
                    }
                }
            }

            if (!timThay)
            {
                HienThongBao("Không tìm thấy sản phẩm.", false);
                return;
            }
            Dictionary<string, int> gioHang =
                Session["GioHang"] as Dictionary<string, int>;

            if (gioHang == null)
            {
                gioHang = new Dictionary<string, int>();
            }

            // Nếu bánh đã có trong giỏ thì cộng số lượng
            if (gioHang.ContainsKey(maBanh))
            {
                gioHang[maBanh] += soLuong;
            }
            else
            {
                gioHang.Add(maBanh, soLuong);
            }

            // Lưu giỏ hàng vào Session
            Session["GioHang"] = gioHang;

            HienThongBao("Bạn đã thêm vào giỏ hàng thành công!", true);
        }
        protected void btnMuaNgay_ServerClick(object sender, EventArgs e)
        {
            string maBanh = Request.QueryString["id"];
            int soLuong;

            // Kiểm tra số lượng
            if (!int.TryParse(soLuongBanh.Value, out soLuong)
                || soLuong < 1)
            {
                HienThongBao("Vui lòng nhập số lượng hợp lệ.", false);
                return;
            }

            // Kiểm tra bánh tồn tại
            List<SanPhamBanh> danhSachSanPham =
                Application["DanhSachSanPham"] as List<SanPhamBanh>;

            bool timThay = false;

            if (danhSachSanPham != null)
            {
                foreach (SanPhamBanh banh in danhSachSanPham)
                {
                    if (banh.maBanh == maBanh)
                    {
                        timThay = true;
                        break;
                    }
                }
            }

            if (!timThay)
            {
                Response.Redirect("SanPham.aspx");
                return;
            }

            // Lấy giỏ hàng hiện tại
            Dictionary<string, int> gioHang =
                Session["GioHang"] as Dictionary<string, int>;

            if (gioHang == null)
            {
                gioHang = new Dictionary<string, int>();
            }

            // Thêm bánh và số lượng đã chọn
            if (gioHang.ContainsKey(maBanh))
            {
                gioHang[maBanh] += soLuong;
            }
            else
            {
                gioHang.Add(maBanh, soLuong);
            }

            Session["GioHang"] = gioHang;

            // Chuyển đến trang đặt hàng
            Response.Redirect("DatHang.aspx");
        }
    }
}