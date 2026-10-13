using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
namespace baiTapLonBanh
{
    public class Global : System.Web.HttpApplication
    {
        // Thêm 1 sản phẩm vào danh sách
        private static void ThemSanPham(List<SanPhamBanh> ds, string ma, string ten, decimal gia,
                                        string anh, string moTa, string loai, DateTime ngay)
        {
            ds.Add(new SanPhamBanh()
            {
                maBanh = ma,
                tenBanh = ten,
                giaBanh = gia,
                anhBanh = anh,
                moTa = moTa,
                loaiBanh = loai,
                ngayTao = ngay
            });
        }

        protected void Application_Start(object sender, EventArgs e)
        {
            List<SanPhamBanh> ds = new List<SanPhamBanh>();

            string moTaMau = "Bánh bông lan vani kem tươi và mứt trái cây\r\n\r\n                Nhân bánh mềm xốp được bao quanh bởi một lớp kem tươi, phủ lên trên mặt bánh là lớp cốt dừa sánh mịn và mứt xoài chua ngọt";

            // Tên loại (loaiBanh) dùng cho mục "Loại bánh":
            //   "Bánh Mousse", "Bánh Sinh Nhật", "Bánh Kem"  -> mục Bánh kem
            //   "Bánh Tươi"                                  -> mục Bánh tươi
            //   "Bánh Mì"                                    -> mục Bánh mì
            // Đổi tên ảnh (anhBanh) thành ảnh thật của từng bánh khi có.

            // ===== BÁNH KEM =====
            ThemSanPham(ds, "1", "Bánh Xoài Dừa", 100000m, "image/SanPham/xoaidua_SP.jpg", moTaMau, "Bánh Mousse", new DateTime(2025, 1, 15));
            ThemSanPham(ds, "2", "Bánh Xoài", 120000m, "image/SanPham/banhkem1_SP.jpg", moTaMau, "Bánh Sinh Nhật", new DateTime(2025, 6, 20));
            ThemSanPham(ds, "4", "Bánh Cưới 3 tầng", 500000m, "image/SanPham/banh3tang_SP.jpg", moTaMau, "Bánh Sinh Nhật", new DateTime(2025, 6, 20));
            ThemSanPham(ds, "5", "Bánh Mousse Chanh Leo", 450000m, "image/SanPham/banhchanhleo_TC.jpg", "Mousse chanh leo chua ngọt, tươi mát.", "Bánh Mousse", new DateTime(2025, 2, 10));
            ThemSanPham(ds, "6", "Bánh Mousse Socola", 420000m, "image/SanPham/tiramisu1_SP.jpg", "Mousse socola đậm đà, béo mịn.", "Bánh Mousse", new DateTime(2025, 3, 5));
            ThemSanPham(ds, "7", "Bánh Mousse Dâu Tây", 430000m, "image/SanPham/moussedau_SP.jpg", "Mousse dâu tây ngọt dịu, màu hồng xinh xắn.", "Bánh Mousse", new DateTime(2025, 4, 12));
            ThemSanPham(ds, "8", "Bánh Mousse Matcha", 440000m, "image/SanPham/matcha_SP.jpg", "Mousse trà xanh thơm nhẹ, vị ngọt thanh.", "Bánh Mousse", new DateTime(2025, 5, 18));
            ThemSanPham(ds, "9", "Bánh Kem Dâu Tươi", 380000m, "image/SanPham/bankem2_SP.jpg", "Bánh kem tươi phủ dâu, hợp tiệc sinh nhật.", "Bánh Sinh Nhật", new DateTime(2025, 7, 2));
            ThemSanPham(ds, "10", "Bánh Kem Socola", 360000m, "image/SanPham/banhkem3_SP.jpg", "Cốt bánh socola mềm, phủ kem socola.", "Bánh Sinh Nhật", new DateTime(2025, 7, 15));
            ThemSanPham(ds, "11", "Bánh Kem Trái Cây Nhiệt Đới", 400000m, "image/SanPham/banhtraicay_SP.jpg", "Kem tươi cùng xoài, kiwi và dứa.", "Bánh Sinh Nhật", new DateTime(2025, 8, 3));
            ThemSanPham(ds, "12", "Bánh Kem Cầu Vồng", 390000m, "image/SanPham/banhcauvong_SP.jpg", "Nhiều lớp bánh nhiều màu, vui mắt.", "Bánh Sinh Nhật", new DateTime(2025, 8, 21));
            ThemSanPham(ds, "13", "Bánh Kem Hoa Hồng", 450000m, "image/SanPham/banhkemhh_SP.jpg", "Trang trí hoa kem tinh tế cho ngày đặc biệt.", "Bánh Kem", new DateTime(2025, 9, 9));
            ThemSanPham(ds, "14", "Bánh Tiramisu", 350000m, "image/SanPham/tiramisu1_SP.jpg", "Tiramisu cà phê, phô mai mascarpone béo mịn.", "Bánh Kem", new DateTime(2025, 9, 25));

            // ===== BÁNH TƯƠI =====
            ThemSanPham(ds, "3", "Bánh Su Kem", 10000m, "image/SanPham/sukem_SP.jpg", moTaMau, "Bánh Tươi", new DateTime(2025, 6, 20));
            ThemSanPham(ds, "15", "Bánh Croissant Bơ", 29000m, "image/SanPham/croissant_TC.jpg", "Vỏ giòn xốp, thơm lừng vị bơ.", "Bánh Tươi", new DateTime(2025, 3, 20));
            ThemSanPham(ds, "16", "Bánh Bông Lan Trứng Muối", 35000m, "image/SanPham/bonglan_SP.jpg", "Bông lan mềm, sốt trứng muối béo mặn.", "Bánh Tươi", new DateTime(2025, 4, 8));
            ThemSanPham(ds, "17", "Bánh Cupcake Vani", 25000m, "image/SanPham/cupcakevani_SP.jpg", "Cupcake nhỏ xinh phủ kem vani.", "Bánh Tươi", new DateTime(2025, 5, 2));
            ThemSanPham(ds, "18", "Bánh Muffin Việt Quất", 27000m, "image/SanPham/banhmuffin_SP.jpg", "Muffin mềm xốp, nhân việt quất chua ngọt.", "Bánh Tươi", new DateTime(2025, 6, 11));
            ThemSanPham(ds, "19", "Bánh Tart Trứng", 22000m, "image/SanPham/banhtart_SP.jpg", "Vỏ bánh giòn, nhân trứng béo mịn.", "Bánh Tươi", new DateTime(2025, 7, 9));
            ThemSanPham(ds, "20", "Bánh Cookie Bơ", 18000m, "image/SanPham/banhcookie_SP.jpg", "Cookie giòn thơm vị bơ, ăn là mê.", "Bánh Tươi", new DateTime(2025, 8, 14));
            ThemSanPham(ds, "21", "Bánh Macaron", 15000m, "image/SanPham/banhmacaron_SP.jpg", "Macaron nhiều màu, vỏ giòn nhân mềm.", "Bánh Tươi", new DateTime(2025, 9, 1));
            ThemSanPham(ds, "22", "Bánh Flan Caramel", 20000m, "image/SanPham/bànhlan_SP.jpg", "Flan mềm mịn, caramel ngọt nhẹ.", "Bánh Tươi", new DateTime(2025, 9, 18));

            // ===== BÁNH MÌ =====
            ThemSanPham(ds, "23", "Bánh Mì Hấp Xúc Xích Phô Mai", 25000m, "image/SanPham/hotdog_TC.jpg", "Thơm béo, hấp dẫn trong từng miếng.", "Bánh Mì", new DateTime(2025, 2, 3));
            ThemSanPham(ds, "24", "Bánh Mì Xúc Xích Đại", 39000m, "image/SanPham/xucxich_TC.jpg", "Bữa ăn nhẹ tiện lợi, thơm ngon.", "Bánh Mì", new DateTime(2025, 3, 14));
            ThemSanPham(ds, "25", "Pizza Gà Nướng Kiểu Thái", 49000m, "image/SanPham/pizza_TC.jpg", "Đậm đà với hương vị độc đáo.", "Bánh Mì", new DateTime(2025, 4, 22));
            ThemSanPham(ds, "26", "Bánh Mì Bơ Tỏi", 22000m, "image/SanPham/bmbotoi_SP.jpg", "Giòn rụm, thơm mùi bơ tỏi.", "Bánh Mì", new DateTime(2025, 5, 30));
            ThemSanPham(ds, "27", "Bánh Mì Sandwich Trứng", 28000m, "image/SanPham/sanwich_SP.jpg", "Sandwich mềm kẹp trứng, rau tươi.", "Bánh Mì", new DateTime(2025, 7, 25));
            ThemSanPham(ds, "28", "Bánh Mì Que Pate", 15000m, "image/SanPham/banhmique_SP.jpg", "Bánh mì que giòn, nhân pate thơm.", "Bánh Mì", new DateTime(2025, 8, 28));

            Application["DanhSachSanPham"] = ds;
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}