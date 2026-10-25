using System;

namespace baiTapLonBanh
{
    public static class GioHangKey
    {
        public static bool LaBanhKem(SanPhamBanh banh)
        {
            return banh.loaiBanh == "Bánh Mousse"
                || banh.loaiBanh == "Bánh Sinh Nhật"
                || banh.loaiBanh == "Bánh Kem";
        }
        // Bánh có size: "B01|20", bánh không có size: "B01"
        public static string Tao(string maBanh, string maSize)
        {
            return string.IsNullOrEmpty(maSize) ? maBanh : maBanh + "|" + maSize;
        }

        public static void Tach(string khoa, out string maBanh, out string maSize)
        {
            int i = khoa.IndexOf('|');
            if (i < 0) { maBanh = khoa; maSize = null; }
            else { maBanh = khoa.Substring(0, i); maSize = khoa.Substring(i + 1); }
        }

        // Giá theo size: cùng công thức với trang chi tiết (hệ số 1 / 1.5 / 2, làm tròn nghìn)
        public static decimal DonGia(SanPhamBanh banh, string maSize)
        {
            if (string.IsNullOrEmpty(maSize)) return banh.giaBanh;
            decimal heSo = maSize == "24" ? 2m : (maSize == "20" ? 1.5m : 1m);
            return Math.Round(banh.giaBanh * heSo / 1000m, 0) * 1000m;
        }

        public static string TenSize(string maSize)
        {
            return maSize + "cm";
        }
    }
}