using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
namespace baiTapLonBanh
{
    public partial class TaiKhoan : System.Web.UI.Page
    {
        public class DonHangTaiKhoanHienThi
        {
            public string MaDon { get; set; }
            public string NgayDat { get; set; }
            public int SoMon { get; set; }
            public decimal TongCong { get; set; }
            public string TrangThai { get; set; }
        }
        protected string tab = "thongtin";

        private NguoiDung NguoiHienTai
        {
            get { return Session["TaiKhoan"] as NguoiDung; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (NguoiHienTai == null)
            {
                Response.Redirect("DangNhap.aspx");
                return;
            }

            // Hiển thị menu quản lý nếu là Admin
            pnlMenuQuanTri.Visible =
                NguoiHienTai.VaiTro == "Admin";

            tab = Request.QueryString["tab"] == "donhang"
                ? "donhang"
                : "thongtin";

            pnlThongTin.Visible = (tab == "thongtin");
            pnlDonHang.Visible = (tab == "donhang");

            if (!IsPostBack)
            {
                txtHoTen.Text = NguoiHienTai.HoTen;
                txtTenMoi.Text = NguoiHienTai.TenDangNhap;
            }
        }

        // Chạy sau các nút bấm nên tên hiển thị luôn là tên mới nhất
        protected void Page_PreRender(object sender, EventArgs e)
        {
            NguoiDung nd = NguoiHienTai;
            if (nd == null) return;

            litHoTen.Text = HttpUtility.HtmlEncode(nd.HoTen);
            litTenDN.Text = HttpUtility.HtmlEncode(nd.TenDangNhap);

            if (tab == "donhang")
            {
                HienThiDonHang(nd.TenDangNhap);
            }
        }

        private void HienThiDonHang(string tenDangNhap)
        {
            List<DonHang> cuaToi = new List<DonHang>();

            // Lấy các đơn hàng của người dùng hiện tại
            Application.Lock();

            try
            {
                List<DonHang> tatCa =
                    Application["DanhSachDonHang"] as List<DonHang>;

                if (tatCa != null)
                {
                    foreach (DonHang don in tatCa)
                    {
                        if (don.TenDangNhap == tenDangNhap)
                        {
                            cuaToi.Add(don);
                        }
                    }
                }
            }
            finally
            {
                Application.UnLock();
            }

            // Sắp xếp đơn mới nhất lên đầu
            for (int i = 0; i < cuaToi.Count - 1; i++)
            {
                for (int j = i + 1; j < cuaToi.Count; j++)
                {
                    if (cuaToi[i].NgayDat < cuaToi[j].NgayDat)
                    {
                        DonHang tam = cuaToi[i];
                        cuaToi[i] = cuaToi[j];
                        cuaToi[j] = tam;
                    }
                }
            }

            // Tạo danh sách dữ liệu để hiển thị
            List<DonHangTaiKhoanHienThi> ds =
                new List<DonHangTaiKhoanHienThi>();

            foreach (DonHang don in cuaToi)
            {
                int soMon = 0;

                if (don.Dong != null)
                {
                    foreach (ChiTietDon chiTiet in don.Dong)
                    {
                        soMon += chiTiet.soLuong;
                    }
                }

                DonHangTaiKhoanHienThi dong =
                    new DonHangTaiKhoanHienThi();

                dong.MaDon = don.MaDon;
                dong.NgayDat = don.NgayDat.ToString("dd/MM/yyyy HH:mm");
                dong.SoMon = soMon;
                dong.TongCong = don.TongCong;
                dong.TrangThai = don.TrangThai;

                ds.Add(dong);
            }

            // Hiển thị kết quả
            pnlDonRong.Visible = ds.Count == 0;
            pnlCoDon.Visible = ds.Count > 0;

            rptDon.DataSource = ds;
            rptDon.DataBind();
        }

        private void HienThongBao(HtmlGenericControl khung, string noiDung, bool thanhCong)
        {
            khung.InnerText = noiDung;
            khung.Attributes["class"] = "tk-thong-bao " + (thanhCong ? "ok" : "loi");
            khung.Visible = true;
        }

        // Đánh dấu 1 ô bị lỗi: hiện dòng đỏ bên dưới và viền đỏ
        private void DanhDauLoi(TextBox o, HtmlGenericControl dongLoi, string noiDung)
        {
            dongLoi.InnerText = noiDung;
            o.CssClass = "tk-o tk-o-loi";
        }

        // ---------- Nút Cập nhật (họ tên + tên đăng nhập + mật khẩu) ----------
        protected void btnCapNhat_Click(object sender, EventArgs e)
        {
            NguoiDung nd = NguoiHienTai;
            string hoTenMoi = Regex.Replace(txtHoTen.Text.Trim(), @"\s+", " ");
            string tenMoi = txtTenMoi.Text.Trim();
            string tenCu = nd.TenDangNhap;
            string mkCu = txtMkCu.Text;
            string mkMoi = txtMkMoi.Text;
            string mkLai = txtMkLai.Text;

            bool doiMatKhau = mkCu != "" || mkMoi != "" || mkLai != "";
            bool doiHoTen = hoTenMoi != nd.HoTen;
            bool doiTen = tenMoi != tenCu;

            // Xóa lỗi cũ
            loiHoTen.InnerText = ""; loiTenDN.InnerText = "";
            loiMkCu.InnerText = ""; loiMkMoi.InnerText = ""; loiMkLai.InnerText = "";
            txtHoTen.CssClass = txtTenMoi.CssClass = "tk-o";
            txtMkCu.CssClass = txtMkMoi.CssClass = txtMkLai.CssClass = "tk-o";
            msgCapNhat.Visible = false;

            // ----- Kiểm tra dữ liệu (báo tất cả lỗi cùng lúc) -----
            bool coLoi = false;

            if (hoTenMoi.Length < 2 || hoTenMoi.Length > 50)
            {
                DanhDauLoi(txtHoTen, loiHoTen, "Họ và tên phải từ 2 đến 50 ký tự.");
                coLoi = true;
            }
            else if (Regex.IsMatch(hoTenMoi, @"\d"))
            {
                DanhDauLoi(txtHoTen, loiHoTen, "Họ và tên không được chứa chữ số.");
                coLoi = true;
            }

            if (!Regex.IsMatch(tenMoi, @"^[A-Za-z0-9_]{4,20}$"))
            {
                DanhDauLoi(txtTenMoi, loiTenDN, "Tên đăng nhập phải có 4–20 ký tự, chỉ gồm chữ không dấu, số và dấu gạch dưới.");
                coLoi = true;
            }

            if (doiMatKhau)
            {
                if (mkCu == "")
                {
                    DanhDauLoi(txtMkCu, loiMkCu, "Vui lòng nhập mật khẩu hiện tại.");
                    coLoi = true;
                }
                else if (mkCu != nd.MatKhau)
                {
                    DanhDauLoi(txtMkCu, loiMkCu, "Mật khẩu hiện tại không đúng.");
                    coLoi = true;
                }

                if (mkMoi.Length < 8)
                {
                    DanhDauLoi(txtMkMoi, loiMkMoi, "Mật khẩu mới phải có ít nhất 8 ký tự.");
                    coLoi = true;
                }
                else if (mkMoi == mkCu)
                {
                    DanhDauLoi(txtMkMoi, loiMkMoi, "Mật khẩu mới phải khác mật khẩu hiện tại.");
                    coLoi = true;
                }
                else if (mkMoi != mkLai)
                {
                    DanhDauLoi(txtMkLai, loiMkLai, "Mật khẩu nhập lại không khớp.");
                    coLoi = true;
                }
            }

            if (coLoi) return;

            if (!doiHoTen && !doiTen && !doiMatKhau)
            {
                HienThongBao(msgCapNhat, "Bạn chưa thay đổi thông tin nào.", false);
                return;
            }

            // ----- Lưu -----
            bool biTrung = false;
            Application.Lock();
            try
            {
                if (doiTen)
                {
                    List<NguoiDung> dsNguoiDung = Application["DanhSachNguoiDung"] as List<NguoiDung>;
                    if (dsNguoiDung != null && dsNguoiDung.Exists(u =>
                            u.TenDangNhap != tenCu &&
                            u.TenDangNhap.Equals(tenMoi, StringComparison.OrdinalIgnoreCase)))
                    {
                        biTrung = true;
                    }
                }

                if (!biTrung)
                {
                    nd.HoTen = hoTenMoi;

                    if (doiTen)
                    {
                        nd.TenDangNhap = tenMoi;

                        // Đơn hàng cũ đi theo tên đăng nhập mới
                        List<DonHang> dsDon = Application["DanhSachDonHang"] as List<DonHang>;
                        if (dsDon != null)
                        {
                            foreach (DonHang d in dsDon)
                            {
                                if (d.TenDangNhap == tenCu)
                                {
                                    d.TenDangNhap = tenMoi;
                                }
                            }
                        }
                    }

                    if (doiMatKhau)
                    {
                        nd.MatKhau = mkMoi;
                    }
                }
            }
            finally
            {
                Application.UnLock();
            }

            if (biTrung)
            {
                DanhDauLoi(txtTenMoi, loiTenDN, "Tên đăng nhập này đã được sử dụng!");
                return;
            }

            if (doiTen)
            {
                Session["TenHienThi"] = tenMoi;

                // Đang "ghi nhớ đăng nhập" thì cập nhật cookie theo tên mới
                if (Request.Cookies["SweetCakeUser"] != null)
                {
                    Response.Cookies["SweetCakeUser"].Value = tenMoi;
                    Response.Cookies["SweetCakeUser"].Expires = DateTime.Now.AddDays(30);
                }
            }

            txtHoTen.Text = hoTenMoi;
            HienThongBao(msgCapNhat, "Đã cập nhật thông tin tài khoản thành công!", true);
        }
    }
}