<%@ Page Title="Trang chủ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TrangChu.aspx.cs" Inherits="baiTapLonBanh.TrangChu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="<%= ResolveUrl("~/CSS/TrangChu.css") %>"
      rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">

    <!-- Thông báo thêm giỏ hàng: JS hiện / ẩn (xem JS/TrangChu.js), data-url là địa chỉ xử lý thêm giỏ -->
    <div id="thongBaoGioHang"
         class="thong-bao-gio-hang an-thong-bao"
         role="status"
         aria-live="polite"
         data-url='<%= ResolveUrl("~/ThemGioHang.ashx") %>'></div>

    <!-- BANNER CHINH -->
    <section class="cake-hero">
        <img class="hero-bg" src="product-banner.png"
             alt="Bộ sưu tập bánh ngọt SweetCake" />

        <div class="hero-overlay"></div>

        <div class="hero-inner">
            <div class="hero-copy">

                <div class="hero-actions">
                    <a href="#san-pham" class="btn-primary">
                        <i class="fa-solid fa-cake-candles"></i>
                        Khám phá ngay
                        <i class="fa-solid fa-arrow-right"></i>
                    </a>
                </div>

                <div class="hero-points">
                    <div>
                        <i class="fa-solid fa-leaf"></i>
                        <span>Nguyên liệu chọn lọc</span>
                    </div>
                    <div>
                        <i class="fa-solid fa-heart"></i>
                        <span>Làm bánh bằng yêu thương</span>
                    </div>
                    <div>
                        <i class="fa-solid fa-gift"></i>
                        <span>Quà tặng ngọt ngào</span>
                    </div>
                </div>

            </div>
        </div>
    </section>


    <section class="products section-wrap" id="san-pham">
        <div class="section-title">
            <div>
                <h2>Sản phẩm nổi bật <i class="fa-solid fa-heart"></i></h2>
                <p>Những chiếc bánh ngọt ngào được yêu thích tại SweetCake.</p>
            </div>
            <a href="SanPham.aspx" class="view-all">
                Xem tất cả <i class="fa-solid fa-arrow-right"></i>
            </a>
        </div>

        <div class="product-list">

            <asp:Repeater ID="rptSanPhamNoiBat" runat="server">
                <ItemTemplate>

                    <article class="product">

                       <div class="product-image">
  <a href='<%# ResolveUrl("~/ChiTietSanPham.aspx") + "?id=" + Server.UrlEncode(Convert.ToString(Eval("maBanh"))) %>'>
    <img src='<%# ResolveUrl("~/" + Convert.ToString(Eval("anhBanh"))) %>'
     alt='<%# HttpUtility.HtmlAttributeEncode(Convert.ToString(Eval("tenBanh"))) %>' />
</a>

    <span class="product-heart">
        <i class="fa-solid fa-heart"></i>
    </span>
</div>

                        <div class="product-info">

                <h3>
    <a class="ten-banh-link"
       href='<%# ResolveUrl("~/ChiTietSanPham.aspx") + "?id=" + Server.UrlEncode(Convert.ToString(Eval("maBanh"))) %>'>
        <%# Eval("tenBanh") %>
    </a>
</h3>

                            <div class="product-bottom">

                                <span class="price">
                                    <%# Eval("giaBanh", "{0:N0}") %>đ
                                </span>

                                <div class="product-actions">
                                    <asp:HyperLink ID="lnkMuaNgay" runat="server"
                                        CssClass="buy-now"
                                        NavigateUrl='<%# "DatHang.aspx?maBanh=" + Server.UrlEncode(Convert.ToString(Eval("maBanh"))) %>'>
                                        Mua ngay
                                    </asp:HyperLink>

                                    <!-- Thêm vào giỏ: không tải lại trang, xử lý bằng JS -->
                                    <button type="button"
                                            class="add-cart"
                                            data-ma-banh='<%# HttpUtility.HtmlAttributeEncode(Convert.ToString(Eval("maBanh"))) %>'
                                            title="Thêm vào giỏ hàng"
                                            aria-label="Thêm vào giỏ hàng">
                                        <i class="fa-solid fa-cart-shopping"></i>
                                    </button>
                                </div>

                            </div>
                        </div>

                    </article>

                </ItemTemplate>
            </asp:Repeater>

        </div>
    </section>


    <!-- THANH LOI ICH -->
    <section class="benefits">
        <div class="benefits-intro">
            <span class="section-kicker">DỊCH VỤ CỦA CHÚNG TÔI</span>
            <h2>Ngọt ngào trọn vẹn hơn</h2>
            <p>Chăm chút từng chiếc bánh để niềm vui của bạn thêm trọn vẹn.</p>
        </div>

        <div class="benefit-item">
            <i class="fa-solid fa-leaf"></i>
            <h3>Nguyên liệu chọn lọc</h3>
            <p>Chú trọng chất lượng trong từng chiếc bánh.</p>
        </div>

        <div class="benefit-item">
            <i class="fa-solid fa-cake-candles"></i>
            <h3>Bánh tươi mỗi ngày</h3>
            <p>Đa dạng hương vị cho mọi dịp đặc biệt.</p>
        </div>

        <div class="benefit-item">
            <i class="fa-solid fa-truck-fast"></i>
            <h3>Giao hàng tiện lợi</h3>
            <p>Giúp món quà ngọt ngào đến gần bạn hơn.</p>
        </div>

        <div class="benefit-item">
            <i class="fa-solid fa-headset"></i>
            <h3>Tư vấn tận tâm</h3>
            <p>Cùng bạn chọn chiếc bánh phù hợp.</p>
        </div>
    </section>


    <!-- BANH TUOI -->
    <section class="products fresh-section section-wrap" id="banh-tuoi">
        <div class="section-title">
            <div>
                <span class="section-kicker">TƯƠI NGON MỖI NGÀY</span>
                <h2>Bánh tươi <i class="fa-solid fa-bread-slice"></i></h2>
                <p>Món ngon nhỏ xinh cho bữa sáng và giờ nghỉ ngọt ngào.</p>
            </div>
            <a href="SanPham.aspx" class="view-all">
                Xem tất cả <i class="fa-solid fa-arrow-right"></i>
            </a>
        </div>

        <div class="product-list">

            <asp:Repeater ID="rptBanhTuoi" runat="server">
                <ItemTemplate>

                    <article class="product">
                        <div class="product-image">
  <a href='<%# ResolveUrl("~/ChiTietSanPham.aspx") + "?id=" + Server.UrlEncode(Convert.ToString(Eval("maBanh"))) %>'>
    <img src='<%# ResolveUrl("~/" + Convert.ToString(Eval("anhBanh"))) %>'
     alt='<%# HttpUtility.HtmlAttributeEncode(Convert.ToString(Eval("tenBanh"))) %>' />
</a>

    <span class="product-heart">
        <i class="fa-solid fa-heart"></i>
    </span>
</div>
                        <div class="product-info">
                        <h3>
    <a class="ten-banh-link"
       href='<%# ResolveUrl("~/ChiTietSanPham.aspx") + "?id=" + Server.UrlEncode(Convert.ToString(Eval("maBanh"))) %>'>
        <%# Eval("tenBanh") %>
    </a>
</h3>
                            <div class="product-bottom">
                                <span class="price"><%# Eval("giaBanh","{0:N0}") %>đ</span>
                                <div class="product-actions">
                                    <asp:HyperLink ID="lnkMuaNgay" runat="server"
                                        CssClass="buy-now"
                                        NavigateUrl='<%# "DatHang.aspx?maBanh=" + Server.UrlEncode(Convert.ToString(Eval("maBanh"))) %>'>
                                        Mua ngay
                                    </asp:HyperLink>

                                    <!-- Thêm vào giỏ: không tải lại trang, xử lý bằng JS -->
                                    <button type="button"
                                            class="add-cart"
                                            data-ma-banh='<%# HttpUtility.HtmlAttributeEncode(Convert.ToString(Eval("maBanh"))) %>'
                                            title="Thêm vào giỏ hàng"
                                            aria-label="Thêm vào giỏ hàng">
                                        <i class="fa-solid fa-cart-shopping"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </article>

                </ItemTemplate>
            </asp:Repeater>

        </div>
    </section>


    <!-- GIOI THIEU VA CAM NHAN -->
    <section class="story-section">
        <div class="story-card">
            <div class="story-photo">
                <img src="image/TrangChu/cacloai_TC.jpg" alt="Những chiếc bánh ngọt SweetCake" />
            </div>
            <div class="story-copy">
                <span class="section-kicker">VÌ SAO CHỌN SWEETCAKE?</span>
                <h2>Hơn cả một chiếc bánh</h2>
                <p>
                    Chúng tôi tin rằng những điều nhỏ bé có thể tạo nên
                    niềm vui lớn. Mỗi chiếc bánh là một lời chúc ngọt ngào
                    dành cho những người bạn yêu quý.
                </p>
                <a href="GioiThieu.aspx" class="text-link">
                    Tìm hiểu về chúng tôi
                    <i class="fa-solid fa-arrow-right"></i>
                </a>
                <div class="story-icons">
                    <span><i class="fa-solid fa-leaf"></i> Chọn lọc</span>
                    <span><i class="fa-solid fa-heart"></i> Tận tâm</span>
                    <span><i class="fa-solid fa-gift"></i> Ý nghĩa</span>
                </div>
            </div>
        </div>

        <div class="testimonial-card">
            <span class="section-kicker">LỜI YÊU THƯƠNG</span>
            <h2>Khách hàng nói gì?</h2>
            <div class="quote-icon"><i class="fa-solid fa-quote-left"></i></div>
            <p class="quote-text">
                Bánh rất đẹp, vị ngọt vừa phải và được chuẩn bị chỉn chu.
                Mình rất thích phong cách nhẹ nhàng của SweetCake!
            </p>
            <div class="customer">
                <span class="customer-avatar">
                    <i class="fa-solid fa-user"></i>
                </span>
                <div>
                    <strong>Khách hàng SweetCake</strong>
                    <div class="stars">
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="news" id="bai-viet">
        <div class="section-title">
            <div>
                <span class="section-kicker">CHUYỆN NHÀ SWEETCAKE</span>
                <h2>Bài viết mới nhất <i class="fa-regular fa-newspaper"></i></h2>
                <p>Tin tức, bộ sưu tập bánh và những ưu đãi dành cho bạn.</p>
            </div>
        </div>

        <div class="news-list">

            <!-- BÀI VIẾT 1 -->
<article class="news-item">
    <div class="news-image">
        <a href="ChiTietTinTuc.aspx?id=7">
            <img src="image/TrangChu/baiviet4_TC.jpg" alt="Ngọt ngào gửi trao" />
        </a>
    </div>

    <div class="news-content">
        <span class="news-category">
            <i class="fa-solid fa-heart"></i> Câu chuyện ngọt ngào
        </span>

        <h3>
            <a href="ChiTietTinTuc.aspx?id=7" class="news-title-link">
                NGỌT NGÀO GỬI TRAO BÁNH KEM CHO NGÀY ĐẶC BIỆT
            </a>
        </h3>

        <p>Một chiếc bánh kem có thể trở thành món quà yêu thương dành cho những người thân yêu.</p>
    </div>
</article>

            <!-- BÀI VIẾT 2 -->
           <!-- BÀI VIẾT 2 -->
<article class="news-item">
    <div class="news-image">
        <a href="ChiTietTinTuc.aspx?id=8">
            <img src="image/TrangChu/banhtrungthu_TC.jpg"
                 alt="Mua 1 tặng 1 bánh Trung Thu" />
        </a>
    </div>

    <div class="news-content">
        <span class="news-category">
            <i class="fa-solid fa-gift"></i> Ưu đãi
        </span>

        <h3>
            <a href="ChiTietTinTuc.aspx?id=8" class="news-title-link">
                MUA 1 TẶNG 1 BÁNH TRUNG THU SWEETCAKE
            </a>
        </h3>

        <p>Chương trình từ 25/09 đến 10/10/2026 theo nội dung ưu đãi của cửa hàng.</p>
    </div>
</article>

           <!-- BÀI VIẾT 3 -->
<article class="news-item">
    <div class="news-image">
        <a href="ChiTietTinTuc.aspx?id=9">
            <img src="image/TrangChu/banhtrungthu2_TC.jpg"
                 alt="Bánh Trung Thu ưu đãi 15%" />
        </a>
    </div>

    <div class="news-content">
        <span class="news-category">
            <i class="fa-solid fa-tag"></i> Khuyến mãi
        </span>

        <h3>
            <a href="ChiTietTinTuc.aspx?id=9" class="news-title-link">
                BÁNH TRUNG THU SWEETCAKE 2026 - ƯU ĐÃI 15%
            </a>
        </h3>

        <p>Khám phá bộ sưu tập bánh Trung Thu với chương trình ưu đãi đặc biệt.</p>
    </div>
</article>
            <!-- BÀI VIẾT 4 -->
          <!-- BÀI VIẾT 4 -->
<article class="news-item">
    <div class="news-image">
        <a href="ChiTietTinTuc.aspx?id=10">
            <img src="image/TrangChu/hop_TC.jpg"
                 alt="Ưu đãi hộp quà Trung Thu" />
        </a>
    </div>

    <div class="news-content">
        <span class="news-category">
            <i class="fa-solid fa-gift"></i> Quà tặng
        </span>

        <h3>
            <a href="ChiTietTinTuc.aspx?id=10" class="news-title-link">
                ƯU ĐÃI 20% HỘP QUÀ TRUNG THU
            </a>
        </h3>

        <p>Hộp quà đẹp mắt và sang trọng để gửi trao lời chúc đến gia đình, bạn bè.</p>
    </div>
</article>

            <!-- BÀI VIẾT 5 -->
<article class="news-item">
    <div class="news-image">
        <a href="ChiTietTinTuc.aspx?id=11">
            <img src="image/TrangChu/baiviet5_TC.jpg"
                 alt="Mua 3 tính tiền 2" />
        </a>
    </div>

    <div class="news-content">
        <span class="news-category">
            <i class="fa-solid fa-percent"></i> Ưu đãi đặc biệt
        </span>

        <h3>
            <a href="ChiTietTinTuc.aspx?id=11" class="news-title-link">
                MUA 3 TÍNH TIỀN 2
            </a>
        </h3>

        <p>Thêm niềm vui với chương trình ưu đãi dành cho khách hàng.</p>
    </div>
</article>

           
           <!-- BÀI VIẾT 6 -->
<article class="news-item">
    <div class="news-image">
        <a href="ChiTietTinTuc.aspx?id=12">
            <img src="image/TrangChu/banhtrungthu3_TC.jpg"
                 alt="12 hương vị cao cấp" />
        </a>
    </div>

    <div class="news-content">
        <span class="news-category">
            <i class="fa-solid fa-moon"></i> Bộ sưu tập
        </span>

        <h3>
            <a href="ChiTietTinTuc.aspx?id=12" class="news-title-link">
                12 HƯƠNG VỊ CAO CẤP TUYỂN CHỌN
            </a>
        </h3>

        <p>Khám phá những hương vị bánh Trung Thu đặc biệt dành cho mùa trăng.</p>
        </div>
</article>

</div> <!-- Đóng news-list -->
</section> <!-- Đóng khu vực tin tức -->

<!-- UU DAI THANH VIEN -->
<section class="member-banner">
        <div class="member-icon">
            <i class="fa-solid fa-gift"></i>
        </div>
        <div class="member-copy">
            <span>ĐẶC QUYỀN DÀNH RIÊNG CHO BẠN</span>
            <h2>Tham gia gia đình SweetCake</h2>
            <p>Cùng khám phá những chiếc bánh yêu thích và ưu đãi mới.</p>
        </div>
        <a href="DangKy.aspx" class="member-button">
            Đăng ký ngay
            <i class="fa-solid fa-arrow-right"></i>
        </a>
    </section>

    <script src="<%= ResolveUrl("~/JS/TrangChu.js") %>"></script>
</asp:Content>
