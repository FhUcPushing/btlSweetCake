using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace baiTapLonBanh
{
    public partial class SanPham : System.Web.UI.Page
    {
        // ==========================================================
        // TRANG SẢN PHẨM - LỌC / SẮP XẾP / PHÂN TRANG BẰNG GET (query string)
        //
        //   SanPham.aspx?loai=banh_kem&q=xoai&xem=8&sapxep=oldest&trang=2
        //
        //   loai   : banh_kem | banh_tuoi | banh_mi   (bỏ trống = tất cả)
        //   q      : từ khóa tìm theo tên bánh (không phân biệt dấu), gửi từ ô tìm kiếm trên thanh điều hướng
        //   xem    : 1 | 4 | 8 | 12 | all             (mặc định 12 bánh / trang)
        //   sapxep : newest | oldest                  (mặc định newest = mới nhất)
        //   trang  : số trang, bắt đầu từ 1
        // ==========================================================

        private static readonly string[] CacGiaTriXem = { "1", "4", "8", "12", "all" };

        // Các giá trị này được dùng trực tiếp trong SanPham.aspx
        protected string LoaiHienTai = "";
        protected string TuKhoa = "";
        protected string XemHienTai = "12";
        protected string SapXepHienTai = "newest";
        protected int TrangHienTai = 1;
        protected int TongTrang = 1;
        protected bool KhongCoBanh = false;
        protected int TongSoBanh = 0;
        protected string PhanTrangHtml = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            DocThamSo();

            List<SanPhamBanh> danhSachGoc =
                Application["DanhSachSanPham"] as List<SanPhamBanh>;

            if (danhSachGoc == null)
            {
                danhSachGoc = new List<SanPhamBanh>();
            }

            // 1. Lọc theo loại bánh và từ khóa
            string tuKhoaKhongDau = BoDau(TuKhoa);

            IEnumerable<SanPhamBanh> ketQua = danhSachGoc.Where(delegate (SanPhamBanh x)
            {
                return KhopLoai(x.loaiBanh) &&
                       (tuKhoaKhongDau == "" || BoDau(x.tenBanh).Contains(tuKhoaKhongDau));
            });

            // 2. Sắp xếp theo ngày tạo
            if (SapXepHienTai == "oldest")
            {
                ketQua = ketQua.OrderBy(x => x.ngayTao);
            }
            else
            {
                ketQua = ketQua.OrderByDescending(x => x.ngayTao);
            }

            List<SanPhamBanh> danhSachLoc = ketQua.ToList();

            // 3. Chia trang
            int soMoiTrang = XemHienTai == "all"
                ? Math.Max(danhSachLoc.Count, 1)
                : int.Parse(XemHienTai);

            TongTrang = Math.Max(1, (int)Math.Ceiling(danhSachLoc.Count / (double)soMoiTrang));

            if (TrangHienTai > TongTrang) TrangHienTai = TongTrang;
            if (TrangHienTai < 1) TrangHienTai = 1;

            List<SanPhamBanh> danhSachTrang = danhSachLoc
                .Skip((TrangHienTai - 1) * soMoiTrang)
                .Take(soMoiTrang)
                .ToList();

            // 4. Hiển thị
            danhSachBanh.Attributes["class"] =
                "danh-sach-banh" + (XemHienTai == "1" ? " xem-1" : "");

            rptDanhSachBanh.DataSource = danhSachTrang;
            rptDanhSachBanh.DataBind();

            KhongCoBanh = danhSachLoc.Count == 0;
            TongSoBanh = danhSachLoc.Count;
            PhanTrangHtml = TaoPhanTrang();
        }

        // ---------- ĐỌC THAM SỐ TRÊN URL ----------

        private void DocThamSo()
        {
            string loai = Request.QueryString["loai"];
            if (loai == "banh_kem" || loai == "banh_tuoi" || loai == "banh_mi")
            {
                LoaiHienTai = loai;
            }

            string q = (Request.QueryString["q"] ?? "").Trim();
            if (q.Length > 100) q = q.Substring(0, 100);
            TuKhoa = q;

            string xem = Request.QueryString["xem"];
            if (Array.IndexOf(CacGiaTriXem, xem) >= 0)
            {
                XemHienTai = xem;
            }

            if (Request.QueryString["sapxep"] == "oldest")
            {
                SapXepHienTai = "oldest";
            }

            int trang;
            if (int.TryParse(Request.QueryString["trang"], out trang) && trang >= 1)
            {
                TrangHienTai = trang;
            }
        }

        private bool KhopLoai(string loaiBanh)
        {
            if (LoaiHienTai == "") return true;

            if (LoaiHienTai == "banh_kem")
            {
                return loaiBanh == "Bánh Kem" ||
                       loaiBanh == "Bánh Sinh Nhật" ||
                       loaiBanh == "Bánh Mousse";
            }

            if (LoaiHienTai == "banh_tuoi") return loaiBanh == "Bánh Tươi";
            if (LoaiHienTai == "banh_mi") return loaiBanh == "Bánh Mì";

            return true;
        }

        // Bỏ dấu tiếng Việt, chữ thường: "Bánh Xoài" -> "banh xoai"
        private static string BoDau(string chuoi)
        {
            if (string.IsNullOrEmpty(chuoi)) return "";

            string chuan = chuoi.ToLowerInvariant().Replace('đ', 'd').Normalize(NormalizationForm.FormD);
            StringBuilder sb = new StringBuilder();

            foreach (char c in chuan)
            {
                if (CharUnicodeInfo.GetUnicodeCategory(c) != UnicodeCategory.NonSpacingMark)
                {
                    sb.Append(c);
                }
            }

            return sb.ToString().Normalize(NormalizationForm.FormC);
        }

        // ---------- TẠO ĐƯỜNG DẪN (GET) ----------

        // Giữ nguyên các lựa chọn hiện tại (từ khóa, xem, sắp xếp), chỉ đổi loại và trang.
        protected string TaoUrl(string loai, int trang)
        {
            List<string> thamSo = new List<string>();

            if (!string.IsNullOrEmpty(loai))
                thamSo.Add("loai=" + Uri.EscapeDataString(loai));

            if (!string.IsNullOrEmpty(TuKhoa))
                thamSo.Add("q=" + Uri.EscapeDataString(TuKhoa));

            if (XemHienTai != "12")
                thamSo.Add("xem=" + XemHienTai);

            if (SapXepHienTai != "newest")
                thamSo.Add("sapxep=" + SapXepHienTai);

            if (trang > 1)
                thamSo.Add("trang=" + trang);

            string url = ResolveUrl("~/SanPham.aspx");

            if (thamSo.Count > 0)
            {
                url += "?" + string.Join("&", thamSo);
            }

            return url;
        }

        // Dùng trong thuộc tính href của SanPham.aspx
        protected string TaoLienKet(string loai, int trang)
        {
            return HttpUtility.HtmlAttributeEncode(TaoUrl(loai, trang));
        }

        // Giống TaoLienKet nhưng bỏ từ khóa tìm kiếm (dùng cho nút "Xóa tìm kiếm")
        protected string TaoLienKetBoTuKhoa()
        {
            string cu = TuKhoa;
            TuKhoa = "";
            string ketQua = TaoLienKet(LoaiHienTai, 1);
            TuKhoa = cu;
            return ketQua;
        }

        // Trả về selected="selected" cho thẻ option đang được chọn
        protected string Chon(string giaTri, string hienTai)
        {
            return giaTri == hienTai ? "selected=\"selected\"" : "";
        }

        // ---------- PHÂN TRANG ----------

        private string TaoPhanTrang()
        {
            if (TongTrang <= 1) return "";

            StringBuilder sb = new StringBuilder();

            // Nút trang trước
            if (TrangHienTai > 1)
                sb.Append(NutTrang("&lt;", TrangHienTai - 1, false, "Trang trước"));
            else
                sb.Append("<span class=\"khoa\">&lt;</span>");

            // Các số trang (nhiều trang thì rút gọn bằng dấu ...)
            int soTruoc = 0;

            for (int p = 1; p <= TongTrang; p++)
            {
                bool hienNut = TongTrang <= 7 ||
                               p == 1 ||
                               p == TongTrang ||
                               Math.Abs(p - TrangHienTai) <= 1;

                if (!hienNut) continue;

                if (soTruoc > 0 && p - soTruoc > 1)
                {
                    sb.Append("<span class=\"dau-cham\">&hellip;</span>");
                }

                sb.Append(NutTrang(p.ToString(), p, p == TrangHienTai, "Trang " + p));
                soTruoc = p;
            }

            // Nút trang sau
            if (TrangHienTai < TongTrang)
                sb.Append(NutTrang("&gt;", TrangHienTai + 1, false, "Trang sau"));
            else
                sb.Append("<span class=\"khoa\">&gt;</span>");

            return sb.ToString();
        }

        private string NutTrang(string nhan, int trang, bool dangChon, string nhanAria)
        {
            // #khuDanhSach: bấm xong tự cuộn xuống đầu danh sách bánh
            string href = TaoLienKet(LoaiHienTai, trang) + "#khuDanhSach";

            return "<a href=\"" + href + "\"" +
                   (dangChon ? " class=\"active\" aria-current=\"page\"" : "") +
                   " aria-label=\"" + nhanAria + "\">" + nhan + "</a>";
        }

        // ---------- CLASS CHO TỪNG THẺ BÁNH ----------

        protected string LayClassSanPham(string loaiBanh)
        {
            string loaiBanhClass = "";
            string nhomClass = "";

            switch (loaiBanh)
            {
                case "Bánh Mousse":
                    loaiBanhClass = "banh_mousse";
                    nhomClass = "banh_kem";
                    break;

                case "Bánh Sinh Nhật":
                    loaiBanhClass = "banh_sinh_nhat";
                    nhomClass = "banh_kem";
                    break;

                case "Bánh Kem":
                    nhomClass = "banh_kem";
                    break;

                case "Bánh Tươi":
                    nhomClass = "banh_tuoi";
                    break;

                case "Bánh Mì":
                    nhomClass = "banh_mi";
                    break;
            }

            return (loaiBanhClass + " " + nhomClass)
                .Replace("  ", " ")
                .Trim();
        }
    }
}