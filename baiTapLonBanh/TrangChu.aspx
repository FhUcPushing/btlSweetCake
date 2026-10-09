<%@ Page Title="Trang chủ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TrangChu.aspx.cs" Inherits="baiTapLonBanh.TrangChu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/TrangChu.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="home">
        <div class="container">
            <h1>Chào mừng đến với SweetCake</h1>
        </div>
    </section>
    <section class="banner">
        <img src="anhbanner.jpg" alt="Banner SweetCake" />
    </section>
    <section class="products">
        <h2>SẢN PHẨM NỔI BẬT</h2>

        <div class="product-list">
            <div class="product">
                <img src="sanphamnb1.jpg" alt="Bánh mousse Hawaii" />
                <h3>Bánh mousse Hawaii</h3>
                <p class="price">450.000đ</p>
                <button type="button">Thêm vào giỏ</button>
            </div>

            <div class="product">
                <img src="images/banh2.jpg" alt="Bánh kem Mật ngọt" />
                <h3>Bánh kem Mật ngọt</h3>
                <p class="price">380.000đ</p>
                <button type="button">Thêm vào giỏ</button>
            </div>

            <div class="product">
                <img src="images/banh3.jpg" alt="Bánh mousse Chanh leo" />
                <h3>Bánh mousse Chanh leo</h3>
                <p class="price">450.000đ</p>
                <button type="button">Thêm vào giỏ</button>
            </div>

            <div class="product">
                <img src="images/banh4.jpg" alt="Bánh kem Vàng anh" />
                <h3>Bánh kem Vàng anh</h3>
                <p class="price">380.000đ</p>
                <button type="button">Thêm vào giỏ</button>
            </div>
        </div>
    </section>

    <section class="products">
        <h2>BÁNH TƯƠI</h2>

        <div class="product-list">
            <div class="product">
                <img src="images/banh5.jpg" alt="Bánh mì hấp xúc xích phô mai" />
                <h3>Bánh mì hấp xúc xích phô mai</h3>
                <p class="price">25.000đ</p>
                <button type="button">Thêm vào giỏ</button>
            </div>

            <div class="product">
                <img src="images/banh6.jpg" alt="Pizza gà nướng kiểu Thái" />
                <h3>Pizza gà nướng kiểu Thái</h3>
                <p class="price">49.000đ</p>
                <button type="button">Thêm vào giỏ</button>
            </div>

            <div class="product">
                <img src="images/banh7.jpg" alt="Bánh mì xúc xích đại" />
                <h3>Bánh mì xúc xích đại</h3>
                <p class="price">39.000đ</p>
                <button type="button">Thêm vào giỏ</button>
            </div>
        </div>
    </section>

    <section class="news">
        <h2>Bài viết mới nhất</h2>

        <div class="news-list">
            <div class="news-item">
                <img src="images/baiviet1.jpg" alt="Ngọt ngào gửi trao" />
                <div class="news-content">
                    <h3>GỌT NGÀO GỬI TRAO BÁNH KEM CHO NGÀY ĐẶC BIỆT</h3>
                    <p>
                        Một chiếc bánh kem đôi khi không chỉ dành cho sinh nhật.
                        Đó có thể là món quà ngọt ngào dành cho những người thân yêu.
                    </p>
                </div>
            </div>

            <div class="news-item">
                <img src="images/baiviet2.jpg" alt="Mua 1 tặng 1 bánh Trung Thu" />
                <div class="news-content">
                    <h3>MUA 1 TẶNG 1 BÁNH TRUNG THU SWEETCAKE</h3>
                    <p>
                        Áp dụng từ 25/09 - 10/10/2026 tại các cửa hàng
                        SWEETCAKE. Trung thu vui hơn với nhiều ưu đãi hấp dẫn.
                    </p>
                </div>
            </div>

            <div class="news-item">
                <img src="images/baiviet3.jpg" alt="Bánh Trung Thu SweetCake" />
                <div class="news-content">
                    <h3>BÁNH TRUNG THU SWEETCAKE 2026 ƯU ĐÃI 15%</h3>
                    <p>
                        Mùa trăng thêm tròn vẹn với ưu đãi giảm 15% bánh
                        Trung Thu SweetCake.
                    </p>
                </div>
            </div>

            <div class="news-item">
                <img src="images/baiviet4.jpg" alt="Ưu đãi hộp quà Trung Thu" />
                <div class="news-content">
                    <h3>ƯU ĐÃI 20% HỘP QUÀ TRUNG THU</h3>
                    <p>
                        Những hộp quà Trung Thu đẹp mắt, sang trọng,
                        phù hợp để dành tặng người thân và bạn bè.
                    </p>
                </div>
            </div>

            <div class="news-item">
                <img src="images/baiviet5.jpg" alt="Mua 3 tính tiền 2" />
                <div class="news-content">
                    <h3>MUA 3 TÍNH TIỀN 2</h3>
                    <p>
                        Chương trình ưu đãi hấp dẫn dành cho khách hàng
                        trong mùa Trung Thu.
                    </p>
                </div>
            </div>

            <div class="news-item">
                <img src="images/baiviet6.jpg" alt="12 hương vị cao cấp" />
                <div class="news-content">
                    <h3>12 HƯƠNG VỊ CAO CẤP TUYỂN CHỌN</h3>
                    <p>
                        Khám phá những hương vị bánh Trung Thu đặc biệt
                        được tuyển chọn dành cho mùa trăng năm nay.
                    </p>
                </div>
            </div>
        </div>
    </section>

</asp:Content>