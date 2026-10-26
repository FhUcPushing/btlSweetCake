
<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    MaintainScrollPositionOnPostback="true"
    CodeBehind="ChiTietTinTuc.aspx.cs"
    Inherits="baiTapLonBanh.ChiTietTinTuc" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/ChiTietTinTuc.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="news-detail-page">

        <!-- CHI TIẾT BÀI VIẾT -->
        <section id="thongTinTinTuc" runat="server"
            visible="false" class="chi_tiet_tin_tuc">

            <!-- Ảnh bài viết -->
            <div class="khung_anh_tin_tuc">
                <img id="anhTinTuc"
                     runat="server"
                     class="anh_tin_tuc_chinh"
                     src="images/baiviet1.jpg"
                     alt="Ảnh bài viết"
                     onerror="this.parentNode.classList.add('khong-anh');" />
            </div>

            <!-- Nội dung bài viết -->
            <div class="noi_dung_tin_tuc">

                <p id="loaiTinTuc" runat="server" class="loai_tin_tuc"></p>

                <h1 id="tieuDeTinTuc" runat="server"
                    class="tieu_de_tin_tuc"></h1>

                <div class="thong_tin_ngay_dang">
                    <span id="ngayDang" runat="server"></span>
                    <span id="thoiGianDoc" runat="server"></span>
                </div>

                <p id="moTaTinTuc" runat="server"
                    class="mo_ta_tin_tuc"></p>

                <div id="noiDungTinTuc" runat="server"
                    class="noi_dung_chi_tiet">
                </div>

            </div>

        </section>

        <!-- THÔNG BÁO KHÔNG TÌM THẤY -->
        <p id="thongBaoLoi" runat="server"
            visible="false" class="thong_bao_loi">
            Không tìm thấy bài viết
        </p>

        <!-- BÀI VIẾT LIÊN QUAN -->
        <section id="khuVucBaiVietLienQuan" runat="server"
            class="bai-viet-lien-quan">

            <div class="bai-viet-header">
                <h2>CÓ THỂ BẠN CŨNG QUAN TÂM</h2>

                <a href="TinTuc.aspx" class="nut-xem-them">
                    Xem thêm
                    <i class="fa-solid fa-arrow-right"></i>
                </a>
            </div>

            <p id="thongBaoBaiViet" runat="server"
                visible="false" class="thong_bao_gio_hang"></p>

            <div class="danh-sach-bai-viet">

                <asp:Repeater ID="rptBaiVietLienQuan" runat="server">
                    <ItemTemplate>

                        <div class="the_bai_viet">

                            <a class="bai_viet_anh"
                               href='ChiTietTinTuc.aspx?id=<%# HttpUtility.UrlEncode(Convert.ToString(Eval("MaTinTuc"))) %>'>

                                <img src='<%# ResolveUrl("~/" + Eval("AnhTinTuc")) %>'
                                     alt='<%# Eval("TieuDe") %>'
                                     onerror="this.parentNode.classList.add('khong-anh');" />

                            </a>

                            <div class="bai_viet_noi_dung">

                                <span class="bai_viet_loai">
                                    <%# Eval("LoaiTinTuc") %>
                                </span>

                                <a class="bai_viet_tieu_de"
                                   href='ChiTietTinTuc.aspx?id=<%# HttpUtility.UrlEncode(Convert.ToString(Eval("MaTinTuc"))) %>'>
                                    <%# Eval("TieuDe") %>
                                </a>

                                <p class="bai_viet_mo_ta">
                                    <%# Eval("MoTa") %>
                                </p>

                                <a class="nut_doc_them"
                                   href='ChiTietTinTuc.aspx?id=<%# HttpUtility.UrlEncode(Convert.ToString(Eval("MaTinTuc"))) %>'>
                                    Đọc thêm
                                    <i class="fa-solid fa-arrow-right"></i>
                                </a>

                            </div>

                        </div>

                    </ItemTemplate>
                </asp:Repeater>

            </div>

        </section>

    </div>

</asp:Content>
