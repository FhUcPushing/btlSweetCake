document.addEventListener("DOMContentLoaded", function () {
    // 1. Lấy các phần tử HTML
    // Các nút "Loại bánh": Tất cả, Bánh kem, Bánh tươi, Bánh mì (thẻ li trong .category-list)
    // Mỗi thẻ li có id trùng với class của thẻ bánh: banh_kem, banh_tuoi, banh_mi
    // Riêng "Tất cả" có id tat_ca_loai_banh (không lọc)
    var cacNutLoai = document.querySelectorAll(".category-list li");

    var danhSachBanh = document.getElementsByClassName("the_san_pham");
    var oTimKiem = document.getElementById("timKiemBanh");
    var selectSoLuong = document.getElementById("soLuongHienThi");
    var selectSapXep = document.getElementById("sapXepSanPham");
    var phanTrang = document.getElementById("phanTrang");
    var khungDanhSach = document.getElementById("danhSachBanh");

    // Dòng thông báo khi không có bánh phù hợp
    var thongBaoTrong = document.createElement("p");
    thongBaoTrong.className = "khong-co-banh";
    thongBaoTrong.textContent = "Không tìm thấy bánh phù hợp.";
    thongBaoTrong.style.display = "none";
    khungDanhSach.parentNode.insertBefore(thongBaoTrong, khungDanhSach);

    // 2. Lưu trạng thái hiện tại
    var loaiDangChon = "";
    var tuKhoaDangTim = "";
    var soLuongHienThi = selectSoLuong.value;
    var trangHienTai = 1;

    // Bỏ dấu tiếng Việt, chữ thường (để gõ "banh kem" vẫn tìm ra "Bánh Kem")
    function boDau(chuoi) {
        return (chuoi || "")
            .toLowerCase()
            .normalize("NFD")
            .replace(/[\u0300-\u036f]/g, "")
            .replace(/đ/g, "d");
    }

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
                ? boDau(phanTuTen.textContent)
                : "";

            var dungTuKhoa = tenBanh.indexOf(tuKhoaDangTim) !== -1;

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

        if (soTrang < 1) {
            soTrang = 1;
        }

        // Đảm bảo trang hiện tại hợp lệ
        if (trangHienTai > soTrang) {
            trangHienTai = soTrang;
        }

        if (trangHienTai < 1) {
            trangHienTai = 1;
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

        // Báo khi không có bánh nào phù hợp
        thongBaoTrong.style.display = mangLoc.length === 0 ? "" : "none";

        // Tạo nút phân trang
        var html = "";

        if (mangLoc.length > 0 && soTrang > 1) {
            // Nút trang trước (mờ đi khi đang ở trang 1)
            if (trangHienTai > 1) {
                html +=
                    '<button type="button" data-page="' +
                    (trangHienTai - 1) +
                    '">&lt;</button>';
            } else {
                html += '<button type="button" disabled>&lt;</button>';
            }

            // Các nút số trang (nhiều trang thì rút gọn bằng dấu ...)
            var soTruoc = 0;

            for (var p = 1; p <= soTrang; p++) {
                var hienNut =
                    soTrang <= 7 ||
                    p === 1 ||
                    p === soTrang ||
                    Math.abs(p - trangHienTai) <= 1;

                if (hienNut) {
                    if (soTruoc && p - soTruoc > 1) {
                        html += '<span class="dau-cham">&hellip;</span>';
                    }

                    html +=
                        '<button type="button" data-page="' +
                        p +
                        '" class="' +
                        (p === trangHienTai ? "active" : "") +
                        '">' +
                        p +
                        '</button>';

                    soTruoc = p;
                }
            }

            // Nút trang tiếp theo (mờ đi khi đang ở trang cuối)
            if (trangHienTai < soTrang) {
                html +=
                    '<button type="button" data-page="' +
                    (trangHienTai + 1) +
                    '">&gt;</button>';
            } else {
                html += '<button type="button" disabled>&gt;</button>';
            }
        }

        phanTrang.innerHTML = html;
    }

    // 4. Bấm vào một loại bánh (Tất cả / Bánh kem / Bánh tươi / Bánh mì)
    //    -> nút đó được thêm class "active" (hồng lên), các nút khác bỏ "active"

    // 5. Tìm kiếm khi nhập nội dung
    oTimKiem.oninput = function () {
        tuKhoaDangTim = boDau(oTimKiem.value.trim());
        trangHienTai = 1;

        locSanPham();
    };

    // 6. Thay đổi số lượng sản phẩm hiển thị
    selectSoLuong.onchange = function () {
        soLuongHienThi = selectSoLuong.value;
        trangHienTai = 1;

        locSanPham();
    };

    // 7. Thay đổi thứ tự sắp xếp
    selectSapXep.onchange = function () {
        trangHienTai = 1;

        locSanPham();
    };

    // 8. Xử lý khi bấm nút phân trang
    phanTrang.onclick = function (e) {
        var nut = e.target.closest("button[data-page]");

        if (nut) {
            trangHienTai = parseInt(
                nut.getAttribute("data-page"),
                10
            );

            locSanPham();

            // Cuộn lên đầu danh sách bánh
            var khuVuc = document.querySelector(".product-list-section");
            if (khuVuc) {
                khuVuc.scrollIntoView({ behavior: "smooth", block: "start" });
            }
        }
    };


    locSanPham();
});