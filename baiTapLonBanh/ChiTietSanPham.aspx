<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChiTietSanPham.aspx.cs" Inherits="baiTapLonBanh.ChiTietSanPham" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">
    <div class="container product-page">
        <section id="thongTinBanh" runat="server" visible="false">
            <img src="#" id="anhBanh" runat="server" alt="sản phẩm 2"/>
            <h2 id="loaiBanh" runat="server"></h2>
            <h1 id="tenBanh" runat="server"></h1>
            <p id="moTa" runat="server"></p>
            <p id="giaBanh" runat="server"></p>
            <label>Số lượng: </label>
            <button>[-]</button>
            <input type="number" value="1"/>
            <button>[+]</button>
            <button>Thêm vào giỏ hàng</button>
            <a href="#">Mua ngay</a>
        </section>
        <p id="thongBaoLoi" runat="server" visible="false">Không tìm thấy sản phẩm</p>
        <section>
            <h2>CÓ LẼ BẠN CŨNG SẼ THÍCH</h2>
            <a href="SanPham.aspx">VIEW ALL</a>
            <button><</button>
            <button>></button>
        </section>
        <section>
            <img src="YOGURT-1.png" alt="sản phẩm 1"/>
            <h2>Bánh Xoài</h2>
        </section>
    </div>
</asp:Content>