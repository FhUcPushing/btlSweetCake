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

              
                SanPhamBanh banhTimThay = null;

                foreach (SanPhamBanh banh in danhSachSanPham)
                {
                    if (banh.maBanh == maBanh)
                    {
                        banhTimThay = banh;
                        break;
                    }
                }

        
                if (banhTimThay == null)
                {
                    continue;
                }

                
                string tenBanh = banhTimThay.tenBanh;

                if (!string.IsNullOrEmpty(maSize))
                {
                    tenBanh += " (" + GioHangKey.TenSize(maSize) + ")";
                }

              
                decimal giaBanh =
                    GioHangKey.DonGia(banhTimThay, maSize);

                decimal thanhTien = giaBanh * item.Value;

          
                SanPhamTrongGio dong = new SanPhamTrongGio();

                dong.khoa = item.Key;
                dong.tenBanh = tenBanh;
                dong.anhBanh = banhTimThay.anhBanh;
                dong.giaBanh = giaBanh;
                dong.soLuong = item.Value;
                dong.thanhTien = thanhTien;

                sanPhamTrongGio.Add(dong);

              
                tongTien += thanhTien;
            }

         
            if (sanPhamTrongGio.Count == 0)
            {
                panelGioHang.Visible = false;
                thongBaoRong.Visible = true;
                return;
            }

         
            rptGioHang.DataSource = sanPhamTrongGio;
            rptGioHang.DataBind();

       
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
                gioHang.Remove(maBanh); 
            }

            Session["GioHang"] = gioHang;

            
            HienThiGioHang();
        }
    }
}