document.addEventListener("DOMContentLoaded", function () {
    // 1. Lấy các phần tử HTML
    var nutMousse = document.getElementById("banh_mousse");
    var nutSinhNhat = document.getElementById("banh_sinh_nhat");
    var nutTatCa = document.getElementById("tat_ca_loai_banh");

    var danhSachBanh = document.getElementsByClassName("the_san_pham");
    var oTimKiem = document.getElementById("timKiemBanh");
    var selectSoLuong = document.getElementById("soLuongHienThi");
    var selectSapXep = document.getElementById("sapXepSanPham");
    var phanTrang = document.getElementById("phanTrang");

    // 2. Lưu trạng thái hiện tại
    var loaiDangChon = "";
    var tuKhoaDangTim = "";
    var soLuongHienThi = selectSoLuong.value;
    var trangHienTai = 1;

    // 3. Hàm lọc, sắp xếp và phân trang sản phẩm
    function locSanPham() {
        // Chuyển danh sách HTML thành mảng để sắp xếp
        var mangBanh = Array.prototype.slice.call(danhSachBanh);

        // Sắp xếp theo ngày tạo
        mangBanh.sort(function (a, b) {
            var ngayA = new Date(
                a.getAttribute("data-ngay-tao")
            ).getTime();

            var ngayB = new Date(
                b.getAttribute("data-ngay-tao")
            ).getTime();

            if (selectSapXep.value === "newest") {
                return ngayB - ngayA;
            }

            return ngayA - ngayB;
        });

        // Cập nhật thứ tự Product Card trong HTML
        if (mangBanh.length > 0) {
            var noiChuaBanh = mangBanh[0].parentNode;

            for (var j = 0; j < mangBanh.length; j++) {
                noiChuaBanh.appendChild(mangBanh[j]);
            }
        }

        // Lọc theo loại bánh và từ khóa tìm kiếm
        var mangLoc = [];

        for (var i = 0; i < mangBanh.length; i++) {
            var card = mangBanh[i];

            var dungLoai =
                loaiDangChon === "" ||
                card.classList.contains(loaiDangChon);

            var phanTuTen =
                card.getElementsByClassName("ten_banh")[0];

            var tenBanh = phanTuTen
                ? phanTuTen.innerText.toLowerCase()
                : "";

            var dungTuKhoa = tenBanh.includes(tuKhoaDangTim);

            if (dungLoai && dungTuKhoa) {
                mangLoc.push(card);
            }
        }

        // Tính số sản phẩm mỗi trang và tổng số trang
        var soMoiTrang;

        if (soLuongHienThi === "all") {
            soMoiTrang = mangLoc.length;
        } else {
            soMoiTrang = parseInt(soLuongHienThi, 10);
        }

        var soTrang = soMoiTrang > 0
            ? Math.ceil(mangLoc.length / soMoiTrang)
            : 1;

        // Đảm bảo trang hiện tại hợp lệ
        if (trangHienTai > soTrang) {
            trangHienTai = soTrang;
        }

        // Ẩn tất cả sản phẩm trước
        for (var k = 0; k < mangBanh.length; k++) {
            mangBanh[k].style.display = "none";
        }

        // Hiện sản phẩm thuộc trang hiện tại
        var batDau = (trangHienTai - 1) * soMoiTrang;
        var ketThuc = Math.min(
            batDau + soMoiTrang,
            mangLoc.length
        );

        for (var m = batDau; m < ketThuc; m++) {
            mangLoc[m].style.display = "";
        }

        // Tạo nút phân trang
        var html = "";

        if (mangLoc.length > 0 && soTrang > 1) {
            // Nút trang trước
            if (trangHienTai > 1) {
                html +=
                    '<button type="button" data-page="' +
                    (trangHienTai - 1) +
                    '">&lt;</button>';
            }

            // Các nút số trang
            for (var p = 1; p <= soTrang; p++) {
                html +=
                    '<button type="button" data-page="' +
                    p +
                    '" class="' +
                    (p === trangHienTai ? "active" : "") +
                    '">' +
                    p +
                    '</button>';
            }

            // Nút trang tiếp theo
            if (trangHienTai < soTrang) {
                html +=
                    '<button type="button" data-page="' +
                    (trangHienTai + 1) +
                    '">&gt;</button>';
            }
        }

        phanTrang.innerHTML = html;
    }

    // 4. Bấm Bánh Mousse
    nutMousse.onclick = function () {
        loaiDangChon = "banh_mousse";
        trangHienTai = 1;

        nutMousse.classList.add("active");
        nutSinhNhat.classList.remove("active");
        nutTatCa.classList.remove("active");

        locSanPham();
    };

    // 5. Bấm Bánh Sinh Nhật
    nutSinhNhat.onclick = function () {
        loaiDangChon = "banh_sinh_nhat";
        trangHienTai = 1;

        nutSinhNhat.classList.add("active");
        nutMousse.classList.remove("active");
        nutTatCa.classList.remove("active");

        locSanPham();
    };

    // 6. Bấm Tất cả
    nutTatCa.onclick = function () {
        loaiDangChon = "";
        trangHienTai = 1;

        nutTatCa.classList.add("active");
        nutMousse.classList.remove("active");
        nutSinhNhat.classList.remove("active");

        locSanPham();
    };

    // 7. Tìm kiếm khi nhập nội dung
    oTimKiem.oninput = function () {
        tuKhoaDangTim = oTimKiem.value.trim().toLowerCase();
        trangHienTai = 1;

        locSanPham();
    };

    // 8. Thay đổi số lượng sản phẩm hiển thị
    selectSoLuong.onchange = function () {
        soLuongHienThi = selectSoLuong.value;
        trangHienTai = 1;

        locSanPham();
    };

    // 9. Thay đổi thứ tự sắp xếp
    selectSapXep.onchange = function () {
        trangHienTai = 1;

        locSanPham();
    };

    // 10. Xử lý khi bấm nút phân trang
    phanTrang.onclick = function (e) {
        var nut = e.target.closest("button[data-page]");

        if (nut) {
            trangHienTai = parseInt(
                nut.getAttribute("data-page"),
                10
            );

            locSanPham();
        }
    };

    // 11. Mặc định chọn Tất cả và hiển thị sản phẩm
    nutTatCa.classList.add("active");
    locSanPham();
});