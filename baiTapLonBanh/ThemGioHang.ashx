<%@ WebHandler Language="C#" Class="ThemGioHang" %>

using System;
using System.Collections.Generic;
using System.Web;
using System.Web.SessionState;

// Thêm 1 bánh vào giỏ hàng (Session["GioHang"]) mà không cần tải lại trang.
// SanPham.js gọi bằng fetch (POST, tham số maBanh).
public class ThemGioHang : IHttpHandler, IRequiresSessionState
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";

        string maBanh = (context.Request.Form["maBanh"] ?? "").Trim();

        if (context.Request.HttpMethod != "POST" || maBanh == "" || maBanh.Length > 50)
        {
            context.Response.StatusCode = 400;
            context.Response.Write("{\"ok\":false}");
            return;
        }

        Dictionary<string, int> gioHang =
            context.Session["GioHang"] as Dictionary<string, int>;

        if (gioHang == null)
        {
            gioHang = new Dictionary<string, int>();
        }

        if (gioHang.ContainsKey(maBanh))
            gioHang[maBanh]++;
        else
            gioHang.Add(maBanh, 1);

        context.Session["GioHang"] = gioHang;

        context.Response.Write("{\"ok\":true,\"soLuong\":" + gioHang[maBanh] + "}");
    }

    public bool IsReusable
    {
        get { return false; }
    }
}
