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

        protected void Application_Start(object sender, EventArgs e)
        {
            List<SanPhamBanh> danhSachSanPham = new List<SanPhamBanh>();
            SanPhamBanh banh1 = new SanPhamBanh()
            {
                maBanh = "1",
                tenBanh = "Bánh Xoài Dừa",
                giaBanh = 100000m,
                anhBanh = "YOGURT-1.png",
                moTa = "Bánh bông lan vani kem tươi và mứt trái cây\r\n\r\n                Nhân bánh mềm xốp được bao quanh bởi một lớp kem tươi, phủ lên trên mặt bánh là lớp cốt dừa sánh mịn và mứt xoài chua ngọt",
                loaiBanh = "Bánh Mousse",
                ngayTao = new DateTime(2025, 1, 15)
            };
            SanPhamBanh banh2 = new SanPhamBanh()
            {
                maBanh = "2",
                tenBanh = "Bánh Xoài",
                giaBanh = 120000m,
                anhBanh = "FRESH-MANGO.png",
                moTa = "Bánh bông lan vani kem tươi và mứt trái cây\r\n\r\n                Nhân bánh mềm xốp được bao quanh bởi một lớp kem tươi, phủ lên trên mặt bánh là lớp cốt dừa sánh mịn và mứt xoài chua ngọt",
                loaiBanh = "Bánh Sinh Nhật",
                ngayTao = new DateTime(2025, 6, 20)
            };
            danhSachSanPham.Add(banh1);
            danhSachSanPham.Add(banh2);
            Application["DanhSachSanPham"] = danhSachSanPham;
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