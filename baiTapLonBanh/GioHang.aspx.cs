using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace baiTapLonBanh
{
    public class SanPhamTrongGio
    {
        public string khoa { get; set; }
        public string tenBanh { get; set; }
        public string anhBanh { get; set; }
        public decimal giaBanh { get; set; }
        public int soLuong { get; set; }
        public decimal thanhTien { get; set; }
    }
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
            // Lấy danh sách sản phẩm
            List<SanPhamBanh> danhSachSanPham =
                new List<SanPhamBanh>();

            Application.Lock();

            try
            {
                List<SanPhamBanh> ds =
                    Application["DanhSachSanPham"] as List<SanPhamBanh>;

                if (ds != null)
                {
                    foreach (SanPhamBanh banh in ds)
                    {
                        danhSachSanPham.Add(banh);
                    }
                }
            }
            finally
            {
                Application.UnLock();
            }

            // Lấy giỏ hàng của người dùng hiện tại
            Dictionary<string, int> gioHang =
                Session["GioHang"] as Dictionary<string, int>;

            if (danhSachSanPham.Count == 0 ||
                gioHang == null ||
                gioHang.Count == 0)
            {
                panelGioHang.Visible = false;
                thongBaoRong.Visible = true;
                return;
            }

            // Tạo danh sách sản phẩm để hiển thị
            List<SanPhamTrongGio> sanPhamTrongGio =
                new List<SanPhamTrongGio>();

            decimal tongTien = 0;

            foreach (KeyValuePair<string, int> item in gioHang)
            {
                // Tách mã bánh và size
                string maBanh;
                string maSize;

                GioHangKey.Tach(
                    item.Key, out maBanh, out maSize);

                // Tìm bánh trong danh sách sản phẩm
                SanPhamBanh banhTimThay = null;

                foreach (SanPhamBanh banh in danhSachSanPham)
                {
                    if (banh.maBanh == maBanh)
                    {
                        banhTimThay = banh;
                        break;
                    }
                }

                // Bỏ qua nếu không tìm thấy bánh
                if (banhTimThay == null)
                {
                    continue;
                }

                // Tạo tên bánh, kèm size nếu có
                string tenBanh = banhTimThay.tenBanh;

                if (!string.IsNullOrEmpty(maSize))
                {
                    tenBanh += " (" + GioHangKey.TenSize(maSize) + ")";
                }

                // Tính giá và thành tiền
                decimal giaBanh =
                    GioHangKey.DonGia(banhTimThay, maSize);

                decimal thanhTien = giaBanh * item.Value;

                // Tạo dòng sản phẩm trong giỏ
                SanPhamTrongGio dong = new SanPhamTrongGio();

                dong.khoa = item.Key;
                dong.tenBanh = tenBanh;
                dong.anhBanh = banhTimThay.anhBanh;
                dong.giaBanh = giaBanh;
                dong.soLuong = item.Value;
                dong.thanhTien = thanhTien;

                sanPhamTrongGio.Add(dong);

                // Cộng vào tổng tiền
                tongTien += thanhTien;
            }

            // Kiểm tra sau khi tìm bánh
            if (sanPhamTrongGio.Count == 0)
            {
                panelGioHang.Visible = false;
                thongBaoRong.Visible = true;
                return;
            }

            // Hiển thị danh sách sản phẩm
            rptGioHang.DataSource = sanPhamTrongGio;
            rptGioHang.DataBind();

            // Hiển thị tổng tiền
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