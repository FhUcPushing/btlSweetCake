<%@ Page Title="Trang chủ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TrangChu.aspx.cs" Inherits="baiTapLonBanh.TrangChu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/TrangChu.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">
    <!-- BANNER CHINH -->
    <asp:Label
    ID="lblThongBaoGioHang"
    runat="server"
    CssClass="thong-bao-gio-hang"
    Visible="false">
</asp:Label>
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
                    <img src='<%# Eval("anhBanh") %>'
                         alt='<%# Eval("tenBanh") %>' />

                    <span class="product-heart">
                        <i class="fa-solid fa-heart"></i>
                    </span>
                </div>

                <div class="product-info">

                    <h3><%# Eval("tenBanh") %></h3>

                    <p class="product-desc">
                        <%# Eval("moTa") %>
                    </p>

                    <div class="product-bottom">

                        <span class="price">
                            <%# Eval("giaBanh", "{0:N0}") %>đ
                        </span>

                        <asp:LinkButton
    ID="btnThemVaoGio"
    runat="server"
    CssClass="add-cart"
    CommandArgument='<%# Eval("maBanh") %>'
    OnCommand="btnThemVaoGio_Command"
    CausesValidation="false"
    ToolTip="Thêm vào giỏ hàng">

    <i class="fa-solid fa-plus"></i>

</asp:LinkButton>

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
        <img src='<%# Eval("anhBanh") %>'
             alt='<%# Eval("tenBanh") %>' />
        <span class="product-heart"><i class="fa-solid fa-heart"></i></span>
    </div>
    <div class="product-info">
        <h3><%#Eval("tenBanh") %></h3>
        <p class="product-desc"><%#Eval("moTa") %></p>
        <div class="product-bottom">
            <span class="price"><%#Eval("giaBanh","{0:N0}") %>đ</span>
            <asp:LinkButton
    ID="btnThemVaoGio"
    runat="server"
    CssClass="add-cart"
    CommandArgument='<%# Eval("maBanh") %>'
    OnCommand="btnThemVaoGio_Command"
    CausesValidation="false"
    ToolTip="Thêm vào giỏ hàng">

    <i class="fa-solid fa-plus"></i>

</asp:LinkButton>
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

            <article class="news-item">
                <div class="news-image">
                    <img src="image/TrangChu/baiviet4_TC.jpg" alt="Ngọt ngào gửi trao" />
                </div>
                <div class="news-content">
                    <span class="news-category"><i class="fa-solid fa-heart"></i> Câu chuyện ngọt ngào</span>
                    <h3>NGỌT NGÀO GỬI TRAO BÁNH KEM CHO NGÀY ĐẶC BIỆT</h3>
                    <p>Một chiếc bánh kem có thể trở thành món quà yêu thương dành cho những người thân yêu.</p>
                </div>
            </article>

            <article class="news-item">
                <div class="news-image">
                    <img src="image/TrangChu/banhtrungthu_TC.jpg" alt="Mua 1 tặng 1 bánh Trung Thu" />
                </div>
                <div class="news-content">
                    <span class="news-category"><i class="fa-solid fa-gift"></i> Ưu đãi</span>
                    <h3>MUA 1 TẶNG 1 BÁNH TRUNG THU SWEETCAKE</h3>
                    <p>Chương trình từ 25/09 đến 10/10/2026 theo nội dung ưu đãi của cửa hàng.</p>
                </div>
            </article>

            <article class="news-item">
                <div class="news-image">
                    <img src="image/TrangChu/banhtrungthu2_TC.jpg" alt="Bánh Trung Thu ưu đãi 15%" />
                </div>
                <div class="news-content">
                    <span class="news-category"><i class="fa-solid fa-tag"></i> Khuyến mãi</span>
                    <h3>BÁNH TRUNG THU SWEETCAKE 2026 - ƯU ĐÃI 15%</h3>
                    <p>Khám phá bộ sưu tập bánh Trung Thu với chương trình ưu đãi đặc biệt.</p>
                </div>
            </article>

            <article class="news-item">
                <div class="news-image">
                    <img src="image/TrangChu/hop_TC.jpg" alt="Ưu đãi hộp quà Trung Thu" />
                </div>
                <div class="news-content">
                    <span class="news-category"><i class="fa-solid fa-gift"></i> Quà tặng</span>
                    <h3>ƯU ĐÃI 20% HỘP QUÀ TRUNG THU</h3>
                    <p>Hộp quà đẹp mắt và sang trọng để gửi trao lời chúc đến gia đình, bạn bè.</p>
                </div>
            </article>

            <article class="news-item">
                <div class="news-image">
                    <img src="image/TrangChu/baiviet5_TC.jpg" alt="Mua 3 tính tiền 2" />
                </div>
                <div class="news-content">
                    <span class="news-category"><i class="fa-solid fa-percent"></i> Ưu đãi đặc biệt</span>
                    <h3>MUA 3 TÍNH TIỀN 2</h3>
                    <p>Thêm niềm vui với chương trình ưu đãi dành cho khách hàng.</p>
                </div>
            </article>

            <article class="news-item">
                <div class="news-image">
                    <img src="image/TrangChu/banhtrungthu3_TC.jpg" alt="12 hương vị cao cấp" />
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

