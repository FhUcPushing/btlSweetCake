<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TuVan.aspx.cs" Inherits="baiTapLonBanh.TuVan" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">

<link href="CSS/TuVan.css" rel="stylesheet" type="text/css" />

<div class="huong-dan">

    <!-- TIÊU ĐỀ -->
    <div class="huong-dan-tieu-de">
        <h1>HƯỚNG DẪN MUA BÁNH</h1>
        <p>
            SweetCake hướng dẫn bạn cách đặt bánh
            nhanh chóng và dễ dàng.
        </p>
    </div>

    <!-- BƯỚC 1 -->
    <div class="buoc">
        <div class="so-buoc">01</div>

        <div class="noi-dung-buoc">
            <h2>Chọn sản phẩm</h2>
            <p>
                Truy cập mục <strong>Sản phẩm</strong> trên thanh menu
                để xem các loại bánh hiện có tại SweetCake.
            </p>
            <p>
                Bạn có thể lựa chọn sản phẩm phù hợp
                với nhu cầu và sở thích của mình.
            </p>
        </div>

        <div class="anh-buoc">
            <img src="image/TuVan/SP_TV.png" alt="Chọn sản phẩm bánh" />
        </div>
    </div>

    <!-- BƯỚC 2 -->
    <div class="buoc">
        <div class="so-buoc">02</div>

        <div class="noi-dung-buoc">
            <h2>Xem thông tin sản phẩm</h2>
            <p>
                Nhấn vào sản phẩm bạn muốn mua để xem
                hình ảnh, tên bánh, mô tả và giá bán.
            </p>
            <p>
                Kiểm tra kỹ thông tin sản phẩm trước khi
                tiến hành đặt bánh.
            </p>
        </div>

        <div class="anh-buoc">
            <img src="image/TuVan/thongtinSP_TV.png" alt="Xem thông tin sản phẩm" />
        </div>
    </div>

    <!-- BƯỚC 3 -->
    <div class="buoc">
        <div class="so-buoc">03</div>

        <div class="noi-dung-buoc">
            <h2>Thêm sản phẩm vào giỏ hàng</h2>
            <p>
                Chọn số lượng bánh muốn mua và nhấn
                <strong>Thêm vào giỏ hàng</strong>.
            </p>
            <p>
                Sản phẩm sẽ được lưu vào giỏ hàng
                để bạn kiểm tra trước khi đặt.
            </p>
        </div>

        <div class="anh-buoc">
            <img src="image/TuVan/themSP_TV.png" alt="Thêm sản phẩm vào giỏ hàng" />
        </div>
    </div>

    <!-- BƯỚC 4 -->
    <div class="buoc">
        <div class="so-buoc">04</div>

        <div class="noi-dung-buoc">
            <h2>Kiểm tra giỏ hàng</h2>
            <p>
                Nhấn vào biểu tượng <strong>Giỏ hàng</strong>
                trên thanh menu để kiểm tra các sản phẩm
                đã lựa chọn.
            </p>
            <p>
                Bạn có thể thay đổi số lượng hoặc xóa
                sản phẩm không muốn mua.
            </p>
        </div>

        <div class="anh-buoc">
            <img src="image/TuVan/gio_TV.png" alt="Kiểm tra giỏ hàng" />
        </div>
    </div>

    <!-- BƯỚC 5 -->
    <div class="buoc">
        <div class="so-buoc">05</div>

        <div class="noi-dung-buoc">
            <h2>Điền thông tin đặt hàng</h2>
            <p>
                Nhập đầy đủ các thông tin cần thiết như
                họ tên, số điện thoại, địa chỉ nhận bánh
                và phương thức thanh toán.
            </p>
        </div>

        <div class="anh-buoc">
            <img src="image/TuVan/thongtin_TV.png" alt="Điền thông tin đặt hàng" />
        </div>
    </div>

    <!-- BƯỚC 6 -->
    <div class="buoc">
        <div class="so-buoc">06</div>

        <div class="noi-dung-buoc">
            <h2>Xác nhận đơn hàng</h2>
            <p>
                Kiểm tra lại toàn bộ thông tin đơn hàng
                và nhấn <strong>Đặt hàng</strong> để hoàn tất.
            </p>
            <p>
                Sau khi đặt hàng thành công, SweetCake
                sẽ tiếp nhận và xử lý đơn hàng của bạn.
            </p>
        </div>

        <div class="anh-buoc">
            <img src="image/TuVan/xacnhan_TV.png" alt="Xác nhận đơn hàng" />
        </div>
    </div>

    <!-- LƯU Ý -->
    <div class="luu-y">
        <h2>LƯU Ý KHI ĐẶT BÁNH</h2>

        <p>
            • Vui lòng kiểm tra kỹ thông tin sản phẩm
            trước khi đặt hàng.
        </p>

        <p>
            • Kiểm tra chính xác số điện thoại và địa chỉ
            nhận bánh.
        </p>

        <p>
            • Đối với các mẫu bánh yêu cầu riêng,
            khách hàng nên liên hệ SweetCake để được tư vấn.
        </p>
    </div>

</div>

</asp:Content>