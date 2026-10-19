using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using baiTapLonBanh;

namespace baiTapLonBanh
{
    public partial class DatHang : System.Web.UI.Page
    {
        // ================== CẤU HÌNH (sửa ở đây) ==================
        private const decimal PhiShipMacDinh = 30000m;   // phí giao hàng
        private const decimal MienPhiShipTu = 500000m;   // đơn từ mức này thì miễn phí ship

        // Mã giảm giá có sẵn (dùng thử):
        //   SWEET10  -> giảm 10% tiền bánh
        //   FREESHIP -> miễn phí vận chuyển
        //   CHAO20K  -> giảm 20,000đ
        // ==========================================================

        // Một dòng sản phẩm trong đơn (Repeater đọc các thuộc tính này)
        public class DongGioHang
        {
            public string maBanh { get; set; }
            public string tenBanh { get; set; }
            public string anhBanh { get; set; }
            public decimal giaBanh { get; set; }
            public int soLuong { get; set; }
            public decimal thanhTien { get; set; }
        }

        private class TienDonHang
        {
            public decimal TamTinh;
            public decimal PhiShip;
            public decimal GiamGia;
            public decimal TongCong;
        }

        // Mã giảm giá đang áp dụng (giữ qua các lần bấm nút)
        private string MaDangDung
        {
            get { return ViewState["MaGiamGia"] as string ?? ""; }
            set { ViewState["MaGiamGia"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Không cho chọn ngày nhận trong quá khứ
            ngayNhan.Attributes["min"] = DateTime.Today.ToString("yyyy-MM-dd");

            if (!IsPostBack)
            {
                // Lấy mã bánh từ nút Mua ngay ở trang chủ
                string maBanh = Request.QueryString["maBanh"];

                if (!string.IsNullOrEmpty(maBanh))
                {
                    // Lấy danh sách sản phẩm
                    List<SanPhamBanh> danhSachSanPham =
                        Application["DanhSachSanPham"] as List<SanPhamBanh>;

                    // Tìm bánh theo mã
                    SanPhamBanh banhDuocChon = null;

                    if (danhSachSanPham != null)
                    {
                        banhDuocChon = danhSachSanPham.Find(
                            p => p.maBanh == maBanh
                        );
                    }

                    if (banhDuocChon != null)
                    {
                        // Lấy giỏ hàng hiện tại
                        Dictionary<string, int> gioHang =
                            Session["GioHang"] as Dictionary<string, int>;

                        if (gioHang == null)
                        {
                            gioHang = new Dictionary<string, int>();
                        }

                        // Thêm bánh đã chọn vào giỏ hàng
                        if (gioHang.ContainsKey(maBanh))
                        {
                            gioHang[maBanh] += 1;
                        }
                        else
                        {
                            gioHang.Add(maBanh, 1);
                        }

                        Session["GioHang"] = gioHang;
                    }
                }

                // Chỉ chuyển về giỏ hàng nếu thực sự không có sản phẩm
                if (LayGioHang().Count == 0)
                {
                    Response.Redirect("GioHang.aspx");
                    return;
                }

                // Hiển thị tóm tắt đơn hàng
                HienThiTomTat();
            }
        }

        // Dùng trong .aspx để giữ lại lựa chọn thanh toán sau khi bấm nút
        protected string DaChon(string giaTri)
        {
            string dangChon = Request.Form["thanhToan"] ?? "cod";
            return dangChon == giaTri ? "checked=\"checked\"" : "";
        }

        // ---------- Lấy giỏ hàng ----------
        private List<DongGioHang> LayGioHang()
        {
            List<DongGioHang> ketQua = new List<DongGioHang>();

            List<SanPhamBanh> danhSachSanPham =
                Application["DanhSachSanPham"] as List<SanPhamBanh>;
            Dictionary<string, int> gioHang =
                Session["GioHang"] as Dictionary<string, int>;

            if (danhSachSanPham == null || gioHang == null)
            {
                return ketQua;
            }

            foreach (SanPhamBanh b in danhSachSanPham)
            {
                if (gioHang.ContainsKey(b.maBanh))
                {
                    ketQua.Add(new DongGioHang
                    {
                        maBanh = b.maBanh,
                        tenBanh = b.tenBanh,
                        anhBanh = b.anhBanh,
                        giaBanh = b.giaBanh,
                        soLuong = gioHang[b.maBanh],
                        thanhTien = b.giaBanh * gioHang[b.maBanh]
                    });
                }
            }
            return ketQua;
        }

        // ---------- Tính tiền ----------
        private TienDonHang TinhTien(List<DongGioHang> dong, string maGiamGia)
        {
            TienDonHang t = new TienDonHang();
            t.TamTinh = dong.Sum(d => d.thanhTien);
            t.PhiShip = t.TamTinh >= MienPhiShipTu ? 0m : PhiShipMacDinh;
            t.GiamGia = TinhGiamGia(maGiamGia, t.TamTinh, t.PhiShip);
            t.TongCong = Math.Max(0m, t.TamTinh + t.PhiShip - t.GiamGia);
            return t;
        }

        private decimal TinhGiamGia(string ma, decimal tamTinh, decimal phiShip)
        {
            switch (ma)
            {
                case "SWEET10": return Math.Round(tamTinh * 0.10m, 0);
                case "FREESHIP": return phiShip;
                case "CHAO20K": return Math.Min(20000m, tamTinh);
                default: return 0m;
            }
        }

        // Mô tả mã giảm giá; trả về null nếu mã không tồn tại
        private string MoTaMa(string ma)
        {
            switch (ma)
            {
                case "SWEET10": return "giảm 10% tiền bánh";
                case "FREESHIP": return "miễn phí vận chuyển";
                case "CHAO20K": return "giảm 20,000đ";
                default: return null;
            }
        }

        private static string Tien(decimal so)
        {
            return so.ToString("N0") + "đ";
        }

        // ---------- Hiển thị phần tóm tắt bên phải ----------
        private void HienThiTomTat()
        {
            List<DongGioHang> dong = LayGioHang();
            TienDonHang t = TinhTien(dong, MaDangDung);

            rptTomTat.DataSource = dong;
            rptTomTat.DataBind();

            litTamTinh.Text = Tien(t.TamTinh);
            litPhiShip.Text = t.PhiShip == 0m ? "Miễn phí" : Tien(t.PhiShip);
            litGiamGia.Text = t.GiamGia > 0m ? "-" + Tien(t.GiamGia) : "0đ";
            litTongCong.Text = Tien(t.TongCong);

            if (t.PhiShip == 0m)
            {
                ghiChuShip.InnerText = "Đơn của bạn được miễn phí vận chuyển.";
            }
            else
            {
                ghiChuShip.InnerText = string.Format(
                    "Mua thêm {0} để được miễn phí vận chuyển.",
                    Tien(MienPhiShipTu - t.TamTinh));
            }
        }

        // ---------- Nút "Áp dụng" mã giảm giá ----------
        protected void btnApDungMa_Click(object sender, EventArgs e)
        {
            string ma = txtMaGiamGia.Text.Trim().ToUpperInvariant();
            txtMaGiamGia.Text = ma;

            if (ma.Length == 0)
            {
                MaDangDung = "";
                thongBaoMa.Visible = false;
            }
            else if (MoTaMa(ma) != null)
            {
                MaDangDung = ma;
                thongBaoMa.InnerHtml = "<i class=\"fa-solid fa-circle-check\"></i> Đã áp dụng mã "
                    + HttpUtility.HtmlEncode(ma) + ": " + MoTaMa(ma) + ".";
                thongBaoMa.Attributes["class"] = "thong-bao-ma thanh-cong";
                thongBaoMa.Visible = true;
            }
            else
            {
                MaDangDung = "";
                thongBaoMa.InnerHtml = "<i class=\"fa-solid fa-circle-exclamation\"></i> Mã giảm giá không hợp lệ.";
                thongBaoMa.Attributes["class"] = "thong-bao-ma loi";
                thongBaoMa.Visible = true;
            }

            HienThiTomTat();
        }

        // ---------- Nút "Xác nhận đặt hàng" ----------
        protected void btnXacNhanDatHang_Click(object sender, EventArgs e)
        {
            List<DongGioHang> dong = LayGioHang();
            if (dong.Count == 0)
            {
                Response.Redirect("GioHang.aspx");
                return;
            }

            List<string> loi = new List<string>();

            // 1. Người nhận
            string hoTen = txtHoTen.Text.Trim();
            string sdt = Regex.Replace(txtSoDienThoai.Text.Trim(), @"[\s\.\-]", "");
            string email = txtEmail.Text.Trim();
            string diaChi = txtDiaChi.Text.Trim();
            string ghiChu = txtGhiChu.Text.Trim();

            if (hoTen.Length < 2)
            {
                loi.Add("Vui lòng nhập họ và tên người nhận.");
            }
            if (!Regex.IsMatch(sdt, @"^0\d{9}$"))
            {
                loi.Add("Số điện thoại phải gồm 10 chữ số và bắt đầu bằng 0.");
            }
            if (email.Length > 0 && !Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                loi.Add("Email chưa đúng định dạng.");
            }
            if (diaChi.Length < 8)
            {
                loi.Add("Vui lòng nhập địa chỉ nhận hàng đầy đủ.");
            }

            // 2. Thời gian nhận hàng
            DateTime ngay;
            bool coNgay = DateTime.TryParseExact(ngayNhan.Value, "yyyy-MM-dd",
                CultureInfo.InvariantCulture, DateTimeStyles.None, out ngay);

            if (!coNgay)
            {
                loi.Add("Vui lòng chọn ngày nhận hàng.");
            }
            else if (ngay.Date < DateTime.Today)
            {
                loi.Add("Ngày nhận hàng không được ở trong quá khứ.");
            }

            int gioBatDau;
            if (!int.TryParse(ddlGio.SelectedValue, out gioBatDau))
            {
                loi.Add("Vui lòng chọn khung giờ nhận hàng.");
            }
            else if (coNgay && ngay.Date == DateTime.Today && gioBatDau <= DateTime.Now.Hour)
            {
                loi.Add("Khung giờ nhận hàng đã qua, vui lòng chọn khung giờ khác.");
            }

            // 4. Thanh toán
            string maThanhToan = Request.Form["thanhToan"] ?? "cod";
            string tenThanhToan;
            switch (maThanhToan)
            {
                case "cod": tenThanhToan = "Thanh toán khi nhận hàng (COD)"; break;
                case "chuyenkhoan": tenThanhToan = "Chuyển khoản ngân hàng"; break;
                case "momo": tenThanhToan = "Ví MoMo"; break;
                default:
                    tenThanhToan = "";
                    loi.Add("Vui lòng chọn phương thức thanh toán.");
                    break;
            }

            // Có lỗi -> báo lại, giữ nguyên dữ liệu đã nhập
            if (loi.Count > 0)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("<strong><i class=\"fa-solid fa-circle-exclamation\"></i> Vui lòng kiểm tra lại:</strong><ul>");
                foreach (string s in loi)
                {
                    sb.Append("<li>").Append(HttpUtility.HtmlEncode(s)).Append("</li>");
                }
                sb.Append("</ul>");

                khungLoi.InnerHtml = sb.ToString();
                khungLoi.Visible = true;
                HienThiTomTat();
                return;
            }

            // Hợp lệ -> xác nhận đơn
            TienDonHang t = TinhTien(dong, MaDangDung);
            string maDon = "DH" + DateTime.Now.ToString("yyyyMMddHHmmss");

            litMaDon.Text = maDon;
            litNguoiNhan.Text = HttpUtility.HtmlEncode(hoTen) + " - " + HttpUtility.HtmlEncode(sdt);
            litDiaChi.Text = HttpUtility.HtmlEncode(diaChi);
            litThoiGian.Text = ngay.ToString("dd/MM/yyyy") + ", " + ddlGio.SelectedItem.Text;
            litThanhToan.Text = tenThanhToan;
            litTongThanhToan.Text = Tien(t.TongCong);

            // Giữ mã đơn gần nhất như bản cũ
            Session["DonHangGanNhat"] = maDon;

            // Đặt xong thì làm trống giỏ hàng
            Session.Remove("GioHang");

            pnlDatHang.Visible = false;
            pnlThanhCong.Visible = true;
        }
    }
}