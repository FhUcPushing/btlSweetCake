<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TinTuc.aspx.cs" Inherits="baiTapLonBanh.TinTuc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">

    <link href="<%= ResolveUrl("~/CSS/TinTuc.css") %>"
          rel="stylesheet" />

    <!-- BANNER TIN TUC -->
    <section class="news-banner">
        <div class="news-banner-content">
            <span class="news-subtitle">GÓC NHÀ SWEETCAKE</span>
            <h1>TIN TỨC &amp; SỰ KIỆN</h1>
            <p>
                Cùng SweetCake khám phá thế giới bánh ngọt,
                những câu chuyện thú vị và bí quyết làm bánh mỗi ngày.
            </p>
        </div>
    </section>

    <!-- NOI DUNG TIN TUC -->
    <section class="news-page">

        <div class="news-heading">
           
            <span class="news-heading-line"></span>
        </div>

        <!-- DANH SACH BAI VIET -->
        <div class="news-grid">

            <!-- BAI VIET 1 -->
            <article class="news-card">
    <a href="ChiTietTinTuc.aspx?id=1" class="news-image">
        <img src="image/TinTuc/banh1_TT.jpg"
             alt="Bánh kem sinh nhật" />
        <span class="news-category">BÍ QUYẾT</span>
    </a>

    <div class="news-info">
        <div class="news-meta">
            <span><i class="fa-regular fa-calendar"></i> 10/10/2026</span>
            <span><i class="fa-regular fa-clock"></i> 5 phút đọc</span>
        </div>

        <h3>
            <a href="ChiTietTinTuc.aspx?id=1">
                Bí quyết chọn bánh kem hoàn hảo cho ngày sinh nhật
            </a>
        </h3>

        <p>
            Một chiếc bánh kem đẹp không chỉ làm bữa tiệc thêm
            ý nghĩa mà còn thể hiện tình cảm dành cho người thân.
            Cùng khám phá cách chọn bánh phù hợp nhé!
        </p>

        <a href="ChiTietTinTuc.aspx?id=1" class="news-read-more">
            Xem thêm <i class="fa-solid fa-arrow-right"></i>
        </a>
    </div>
</article>

            <!-- BAI VIET 2 -->
            <article class="news-card">
    <a href="ChiTietTinTuc.aspx?id=2" class="news-image">
        <img src="image/TinTuc/banh11_TT.jpg"
             alt="Bánh ngọt trang trí đẹp" />
        <span class="news-category">KIẾN THỨC</span>
    </a>

    <div class="news-info">
        <div class="news-meta">
            <span><i class="fa-regular fa-calendar"></i> 08/10/2026</span>
            <span><i class="fa-regular fa-clock"></i> 4 phút đọc</span>
        </div>

        <h3>
            <a href="ChiTietTinTuc.aspx?id=2">
                Cách bảo quản bánh kem luôn tươi ngon tại nhà
            </a>
        </h3>

        <p>
            Bảo quản đúng cách giúp bánh giữ được hương vị,
            kết cấu mềm mịn và lớp kem hấp dẫn.
            Tìm hiểu những lưu ý quan trọng khi bảo quản bánh.
        </p>

        <a href="ChiTietTinTuc.aspx?id=2" class="news-read-more">
            Xem thêm <i class="fa-solid fa-arrow-right"></i>
        </a>
    </div>
</article>

            <!-- BAI VIET 3 -->
            <article class="news-card">
    <a href="ChiTietTinTuc.aspx?id=3" class="news-image">
        <img src="image/TinTuc/banh7_TT.jpg"
             alt="Cupcake nhiều màu sắc" />
        <span class="news-category">CẢM HỨNG</span>
    </a>

    <div class="news-info">
        <div class="news-meta">
            <span><i class="fa-regular fa-calendar"></i> 05/10/2026</span>
            <span><i class="fa-regular fa-clock"></i> 3 phút đọc</span>
        </div>

        <h3>
            <a href="ChiTietTinTuc.aspx?id=3">
                Cupcake nhỏ xinh – Món quà ngọt ngào cho mọi dịp
            </a>
        </h3>

        <p>
            Những chiếc cupcake xinh xắn với màu sắc đáng yêu
            sẽ là lựa chọn tuyệt vời cho tiệc sinh nhật,
            buổi hẹn hò hay những dịp đặc biệt.
        </p>

        <a href="ChiTietTinTuc.aspx?id=3" class="news-read-more">
            Xem thêm <i class="fa-solid fa-arrow-right"></i>
        </a>
    </div>
</article>

            <!-- BAI VIET 4 -->
           <article class="news-card">
    <a href="ChiTietTinTuc.aspx?id=4" class="news-image">
        <img src="image/TinTuc/banh9_TT.jpg"
             alt="Bánh chocolate" />
        <span class="news-category">BÍ QUYẾT</span>
    </a>

    <div class="news-info">
        <div class="news-meta">
            <span><i class="fa-regular fa-calendar"></i> 02/10/2026</span>
            <span><i class="fa-regular fa-clock"></i> 5 phút đọc</span>
        </div>

        <h3>
            <a href="ChiTietTinTuc.aspx?id=4">
                Chocolate và bánh ngọt: Sự kết hợp không thể bỏ lỡ
            </a>
        </h3>

        <p>
            Từ vị đắng nhẹ của chocolate đen đến vị ngọt
            béo của chocolate sữa, mỗi sự kết hợp đều
            mang lại một trải nghiệm riêng biệt.
        </p>

        <a href="ChiTietTinTuc.aspx?id=4" class="news-read-more">
            Xem thêm <i class="fa-solid fa-arrow-right"></i>
        </a>
    </div>
</article>

            <!-- BAI VIET 5 -->
           <article class="news-card">
    <a href="ChiTietTinTuc.aspx?id=5" class="news-image">
        <img src="image/TinTuc/banh3_TT.jpg"
             alt="Bánh ngọt trang trí" />
        <span class="news-category">SỰ KIỆN</span>
    </a>

    <div class="news-info">
        <div class="news-meta">
            <span><i class="fa-regular fa-calendar"></i> 28/09/2026</span>
            <span><i class="fa-regular fa-clock"></i> 4 phút đọc</span>
        </div>

        <h3>
            <a href="ChiTietTinTuc.aspx?id=5">
                Gợi ý những mẫu bánh ngọt dành tặng người thương
            </a>
        </h3>

        <p>
            Một chiếc bánh được lựa chọn cẩn thận sẽ giúp
            bạn gửi gắm lời yêu thương trong ngày kỷ niệm,
            ngày sinh nhật hoặc những dịp đáng nhớ.
        </p>

        <a href="ChiTietTinTuc.aspx?id=5" class="news-read-more">
            Xem thêm <i class="fa-solid fa-arrow-right"></i>
        </a>
    </div>
</article>
            <!-- BAI VIET 6 -->
            <article class="news-card">
    <a href="ChiTietTinTuc.aspx?id=6" class="news-image">
        <img src="image/TinTuc/banh8_TT.jpg"
             alt="Bánh mì mới nướng" />
        <span class="news-category">GÓC BẾP</span>
    </a>

    <div class="news-info">
        <div class="news-meta">
            <span><i class="fa-regular fa-calendar"></i> 25/09/2026</span>
            <span><i class="fa-regular fa-clock"></i> 6 phút đọc</span>
        </div>

        <h3>
            <a href="ChiTietTinTuc.aspx?id=6">
                Khám phá những nguyên liệu tạo nên chiếc bánh thơm ngon
            </a>
        </h3>

        <p>
            Chất lượng nguyên liệu góp phần tạo nên hương vị
            đặc trưng của mỗi chiếc bánh. Cùng tìm hiểu
            những thành phần quen thuộc trong nghệ thuật làm bánh.
        </p>

        <a href="ChiTietTinTuc.aspx?id=6" class="news-read-more">
            Xem thêm <i class="fa-solid fa-arrow-right"></i>
        </a>
    </div>
</article>
        </div>

    </section>

    <!-- LOI MOI CUOI TRANG (giong khung "Tham gia gia dinh SweetCake") -->
    <section class="news-cta-wrap">
        <div class="news-cta">
            <div class="news-cta-icon">
                <i class="fa-solid fa-heart"></i>
            </div>

            <div class="news-cta-copy">
                <h2>Trao ngọt ngào, gửi yêu thương</h2>
                <p>
                    Khám phá bộ sưu tập bánh thơm ngon và tìm chiếc bánh
                    hoàn hảo cho những khoảnh khắc đặc biệt của bạn.
                </p>
            </div>

            <a href="SanPham.aspx" class="news-cta-button">
                Khám phá sản phẩm <i class="fa-solid fa-arrow-right"></i>
            </a>
        </div>
    </section>

</asp:Content>
