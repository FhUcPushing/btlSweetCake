<%@ Page Title="Trang chủ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TrangChu.aspx.cs" Inherits="baiTapLonBanh.TrangChu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/TrangChu.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">
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


    <!-- SAN PHAM NOI BAT -->
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

            <article class="product">
                <div class="product-image">
                    <img src="banh1.jpg" alt="Bánh mousse Hawaii" />
                    <span class="product-badge">Nổi bật</span>
                    <span class="product-heart"><i class="fa-solid fa-heart"></i></span>
                </div>
                <div class="product-info">
                    <h3>Bánh mousse Hawaii</h3>
                    <p class="product-desc">Mousse mềm mịn, vị ngọt dịu.</p>
                    <div class="product-bottom">
                        <span class="price">450.000đ</span>
                        <button type="button" class="add-cart"
                            onclick="thongBaoGioHang('Bánh mousse Hawaii')"
                            aria-label="Thêm bánh mousse Hawaii vào giỏ">
                            <i class="fa-solid fa-plus"></i>
                        </button>
                    </div>
                </div>
            </article>

            <article class="product">
                <div class="product-image">
                    <img src="banh2.jpg" alt="Bánh kem Mật ngọt" />
                    <span class="product-heart"><i class="fa-solid fa-heart"></i></span>
                </div>
                <div class="product-info">
                    <h3>Bánh kem Mật ngọt</h3>
                    <p class="product-desc">Ngọt ngào cho ngày đặc biệt.</p>
                    <div class="product-bottom">
                        <span class="price">380.000đ</span>
                        <button type="button" class="add-cart"
                            onclick="thongBaoGioHang('Bánh kem Mật ngọt')"
                            aria-label="Thêm bánh kem Mật ngọt vào giỏ">
                            <i class="fa-solid fa-plus"></i>
                        </button>
                    </div>
                </div>
            </article>

            <article class="product">
                <div class="product-image">
                    <img src="images/banh3.jpg" alt="Bánh mousse Chanh leo" />
                    <span class="product-heart"><i class="fa-solid fa-heart"></i></span>
                </div>
                <div class="product-info">
                    <h3>Bánh mousse Chanh leo</h3>
                    <p class="product-desc">Chua ngọt hài hòa, tươi mát.</p>
                    <div class="product-bottom">
                        <span class="price">450.000đ</span>
                        <button type="button" class="add-cart"
                            onclick="thongBaoGioHang('Bánh mousse Chanh leo')"
                            aria-label="Thêm bánh mousse Chanh leo vào giỏ">
                            <i class="fa-solid fa-plus"></i>
                        </button>
                    </div>
                </div>
            </article>

            <article class="product">
                <div class="product-image">
                    <img src="images/banh4.jpg" alt="Bánh kem Vàng anh" />
                    <span class="product-heart"><i class="fa-solid fa-heart"></i></span>
                </div>
                <div class="product-info">
                    <h3>Bánh kem Vàng anh</h3>
                    <p class="product-desc">Xinh xắn cho những dịp vui.</p>
                    <div class="product-bottom">
                        <span class="price">380.000đ</span>
                        <button type="button" class="add-cart"
                            onclick="thongBaoGioHang('Bánh kem Vàng anh')"
                            aria-label="Thêm bánh kem Vàng anh vào giỏ">
                            <i class="fa-solid fa-plus"></i>
                        </button>
                    </div>
                </div>
            </article>

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

            <article class="product">
                <div class="product-image">
                    <img src="images/banh5.jpg"
                         alt="Bánh mì hấp xúc xích phô mai" />
                    <span class="product-heart"><i class="fa-solid fa-heart"></i></span>
                </div>
                <div class="product-info">
                    <h3>Bánh mì hấp xúc xích phô mai</h3>
                    <p class="product-desc">Thơm béo, hấp dẫn trong từng miếng.</p>
                    <div class="product-bottom">
                        <span class="price">25.000đ</span>
                        <button type="button" class="add-cart"
                            onclick="thongBaoGioHang('Bánh mì hấp xúc xích phô mai')"
                            aria-label="Thêm bánh mì vào giỏ">
                            <i class="fa-solid fa-plus"></i>
                        </button>
                    </div>
                </div>
            </article>

            <article class="product">
                <div class="product-image">
                    <img src="images/banh6.jpg" alt="Pizza gà nướng kiểu Thái" />
                    <span class="product-heart"><i class="fa-solid fa-heart"></i></span>
                </div>
                <div class="product-info">
                    <h3>Pizza gà nướng kiểu Thái</h3>
                    <p class="product-desc">Đậm đà với hương vị độc đáo.</p>
                    <div class="product-bottom">
                        <span class="price">49.000đ</span>
                        <button type="button" class="add-cart"
                            onclick="thongBaoGioHang('Pizza gà nướng kiểu Thái')"
                            aria-label="Thêm pizza vào giỏ">
                            <i class="fa-solid fa-plus"></i>
                        </button>
                    </div>
                </div>
            </article>

            <article class="product">
                <div class="product-image">
                    <img src="images/banh7.jpg" alt="Bánh mì xúc xích đại" />
                    <span class="product-heart"><i class="fa-solid fa-heart"></i></span>
                </div>
                <div class="product-info">
                    <h3>Bánh mì xúc xích đại</h3>
                    <p class="product-desc">Bữa ăn nhẹ tiện lợi, thơm ngon.</p>
                    <div class="product-bottom">
                        <span class="price">39.000đ</span>
                        <button type="button" class="add-cart"
                            onclick="thongBaoGioHang('Bánh mì xúc xích đại')"
                            aria-label="Thêm bánh mì xúc xích vào giỏ">
                            <i class="fa-solid fa-plus"></i>
                        </button>
                    </div>
                </div>
            </article>

            <article class="product">
                <div class="product-image">
                    <img src="images/banh8.jpg" alt="Bánh croissant bơ" />
                    <span class="product-heart"><i class="fa-solid fa-heart"></i></span>
                </div>
                <div class="product-info">
                    <h3>Bánh croissant bơ</h3>
                    <p class="product-desc">Vỏ bánh giòn xốp, thơm lừng vị bơ.</p>
                    <div class="product-bottom">
                        <span class="price">29.000đ</span>
                        <button type="button" class="add-cart"
                            onclick="thongBaoGioHang('Bánh croissant bơ')"
                            aria-label="Thêm bánh croissant bơ vào giỏ">
                            <i class="fa-solid fa-plus"></i>
                        </button>
                    </div>
                </div>
            </article>
        </div>
    </section>


    <!-- GIOI THIEU VA CAM NHAN -->
    <section class="story-section">
        <div class="story-card">
            <div class="story-photo">
                <img src="images/baiviet1.jpg" alt="Những chiếc bánh ngọt SweetCake" />
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

            <article class="news-item">
                <div class="news-image">
                    <img src="images/baiviet1.jpg" alt="Ngọt ngào gửi trao" />
                </div>
                <div class="news-content">
                    <span class="news-category"><i class="fa-solid fa-heart"></i> Câu chuyện ngọt ngào</span>
                    <h3>NGỌT NGÀO GỬI TRAO BÁNH KEM CHO NGÀY ĐẶC BIỆT</h3>
                    <p>Một chiếc bánh kem có thể trở thành món quà yêu thương dành cho những người thân yêu.</p>
                </div>
            </article>

            <article class="news-item">
                <div class="news-image">
                    <img src="images/baiviet2.jpg" alt="Mua 1 tặng 1 bánh Trung Thu" />
                </div>
                <div class="news-content">
                    <span class="news-category"><i class="fa-solid fa-gift"></i> Ưu đãi</span>
                    <h3>MUA 1 TẶNG 1 BÁNH TRUNG THU SWEETCAKE</h3>
                    <p>Chương trình từ 25/09 đến 10/10/2026 theo nội dung ưu đãi của cửa hàng.</p>
                </div>
            </article>

            <article class="news-item">
                <div class="news-image">
                    <img src="images/baiviet3.jpg" alt="Bánh Trung Thu ưu đãi 15%" />
                </div>
                <div class="news-content">
                    <span class="news-category"><i class="fa-solid fa-tag"></i> Khuyến mãi</span>
                    <h3>BÁNH TRUNG THU SWEETCAKE 2026 - ƯU ĐÃI 15%</h3>
                    <p>Khám phá bộ sưu tập bánh Trung Thu với chương trình ưu đãi đặc biệt.</p>
                </div>
            </article>

            <article class="news-item">
                <div class="news-image">
                    <img src="images/baiviet4.jpg" alt="Ưu đãi hộp quà Trung Thu" />
                </div>
                <div class="news-content">
                    <span class="news-category"><i class="fa-solid fa-gift"></i> Quà tặng</span>
                    <h3>ƯU ĐÃI 20% HỘP QUÀ TRUNG THU</h3>
                    <p>Hộp quà đẹp mắt và sang trọng để gửi trao lời chúc đến gia đình, bạn bè.</p>
                </div>
            </article>

            <article class="news-item">
                <div class="news-image">
                    <img src="images/baiviet5.jpg" alt="Mua 3 tính tiền 2" />
                </div>
                <div class="news-content">
                    <span class="news-category"><i class="fa-solid fa-percent"></i> Ưu đãi đặc biệt</span>
                    <h3>MUA 3 TÍNH TIỀN 2</h3>
                    <p>Thêm niềm vui với chương trình ưu đãi dành cho khách hàng.</p>
                </div>
            </article>

            <article class="news-item">
                <div class="news-image">
                    <img src="images/baiviet6.jpg" alt="12 hương vị cao cấp" />
                </div>
                <div class="news-content">
                    <span class="news-category"><i class="fa-solid fa-moon"></i> Bộ sưu tập</span>
                    <h3>12 HƯƠNG VỊ CAO CẤP TUYỂN CHỌN</h3>
                    <p>Khám phá những hương vị bánh Trung Thu đặc biệt dành cho mùa trăng.</p>
                </div>
            </article>

        </div>
    </section>


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
</asp:Content>

