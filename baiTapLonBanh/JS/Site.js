function laDienThoai() {
    return window.matchMedia("(max-width: 600px)").matches;
}
function toggleMobileMenu() {
    var menu = document.getElementById("mainNav");
    var nutMenu = document.querySelector(".menu-toggle");
    var khungTimKiem = document.getElementById("headerSearch");

    if (!menu || !nutMenu) return;

    // Mở menu thì đóng ô tìm kiếm
    if (khungTimKiem) khungTimKiem.classList.remove("is-open");

    var dangMo = menu.classList.toggle("is-open");

    nutMenu.setAttribute("aria-expanded", dangMo ? "true" : "false");
    nutMenu.setAttribute("aria-label", dangMo ? "Đóng menu" : "Mở menu");

    var icon = nutMenu.querySelector("i");
    if (icon) {
        icon.className = dangMo
            ? "fa-solid fa-xmark"
            : "fa-solid fa-bars";
    }
}

// XỬ LÝ KHI BẤM ICON TÌM KIẾM
function xuLyTimKiem() {
    var khungTimKiem = document.getElementById("headerSearch");
    var oTimKiem = document.getElementById("txtTimKiem");

    if (!khungTimKiem || !oTimKiem) return;

    // Điện thoại: lần bấm đầu mở ô nhập để gõ chữ
    if (laDienThoai() && !khungTimKiem.classList.contains("is-open")) {
        // đóng menu nếu đang mở
        var menu = document.getElementById("mainNav");
        if (menu && menu.classList.contains("is-open")) toggleMobileMenu();

        khungTimKiem.classList.add("is-open");
        oTimKiem.focus();
        return;
    }

    // Ô đang mở nhưng chưa gõ gì: điện thoại thì đóng lại
    if (laDienThoai() && !oTimKiem.value.trim()) {
        khungTimKiem.classList.remove("is-open");
        return;
    }

    // Đã có chữ thì thực hiện tìm
    timKiemBanh();
}

// TÌM KIẾM BÁNH
function timKiemBanh() {
    var oTimKiem = document.getElementById("txtTimKiem");

    if (!oTimKiem) return;

    var tuKhoa = oTimKiem.value.trim();

    if (!tuKhoa) {
        alert("Cậu hãy nhập tên bánh cần tìm nhé!");
        oTimKiem.focus();
        return;
    }

    var trangChu = '<%= ResolveUrl("~/Default.aspx") %>';

    var sanPhams = document.querySelectorAll(".product");

    // Nếu trang hiện tại có danh sách sản phẩm thì lọc
    if (sanPhams.length > 0) {
        var dem = 0;

        sanPhams.forEach(function (sanPham) {
            var ten = sanPham.querySelector("h3");

            var phuHop = ten &&
                ten.textContent
                    .toLocaleLowerCase("vi")
                    .includes(tuKhoa.toLocaleLowerCase("vi"));

            sanPham.style.display = phuHop ? "" : "none";

            if (phuHop) dem++;
        });

        var khuVuc = document.getElementById("san-pham");

        if (khuVuc) {
            khuVuc.scrollIntoView({
                behavior: "smooth",
                block: "start"
            });
        }

        if (dem === 0) {
            alert("Không tìm thấy bánh phù hợp!");
        }

        return;
    }

    // Nếu đang ở trang khác thì chuyển về trang chủ
    window.location.href =
        trangChu + "?q=" + encodeURIComponent(tuKhoa);
}

document.addEventListener("DOMContentLoaded", function () {

    // ĐÁNH DẤU MENU THEO TRANG ĐANG MỞ
    // Chuẩn hóa đường dẫn: bỏ .aspx, bỏ "/default", bỏ dấu "/" cuối
    // để /Default, /Default.aspx và / đều là trang chủ,
    // /SanPham và /SanPham.aspx đều là trang sản phẩm.
    function chuanHoaDuongDan(p) {
        p = p.toLowerCase().replace(/\.aspx$/, "");
        if (p.endsWith("/default")) p = p.slice(0, -8);
        p = p.replace(/\/+$/, "");
        return p || "/";
    }

    var duongDanHienTai = chuanHoaDuongDan(window.location.pathname);

    document.querySelectorAll("#mainNav a").forEach(function (muc) {
        var duongDanMenu = chuanHoaDuongDan(new URL(muc.href).pathname);

        if (duongDanMenu === duongDanHienTai) {
            muc.classList.add("active");
            muc.setAttribute("aria-current", "page");
        } else {
            muc.classList.remove("active");
            muc.removeAttribute("aria-current");
        }
    });

    var oTimKiem = document.getElementById("txtTimKiem");

    if (oTimKiem) {
        oTimKiem.addEventListener("keydown", function (event) {
            if (event.key === "Enter") {
                event.preventDefault();
                timKiemBanh();
            }
        });
    }

    // Bấm ra ngoài thì đóng ô tìm kiếm (điện thoại)
    document.addEventListener("click", function (event) {
        var khungTimKiem = document.getElementById("headerSearch");

        if (khungTimKiem && laDienThoai() &&
            !khungTimKiem.contains(event.target)) {
            khungTimKiem.classList.remove("is-open");
        }
    });

    // TỪ KHÓA TRÊN URL (?q=...)
    var params = new URLSearchParams(window.location.search);

    var tuKhoaURL = params.get("q");

    if (tuKhoaURL && oTimKiem) {
        oTimKiem.value = tuKhoaURL;

        var sanPhams = document.querySelectorAll(".product");

        if (sanPhams.length > 0) {
            var dem = 0;

            sanPhams.forEach(function (sanPham) {
                var ten = sanPham.querySelector("h3");

                var phuHop = ten &&
                    ten.textContent
                        .toLocaleLowerCase("vi")
                        .includes(tuKhoaURL.toLocaleLowerCase("vi"));

                sanPham.style.display = phuHop ? "" : "none";

                if (phuHop) dem++;
            });

            if (dem === 0) {
                alert("Không tìm thấy bánh phù hợp!");
            }
        }
    }
});

// ĐÓNG MENU KHI CHUYỂN VỀ GIAO DIỆN MÁY TÍNH
window.addEventListener("resize", function () {
    if (window.innerWidth > 600) {
        var menu = document.getElementById("mainNav");
        var nutMenu = document.querySelector(".menu-toggle");
        var khungTimKiem = document.getElementById("headerSearch");

        if (menu) menu.classList.remove("is-open");
        if (khungTimKiem) khungTimKiem.classList.remove("is-open");

        if (nutMenu) {
            nutMenu.setAttribute("aria-expanded", "false");

            var icon = nutMenu.querySelector("i");

            if (icon) {
                icon.className = "fa-solid fa-bars";
            }
        }
    }
});