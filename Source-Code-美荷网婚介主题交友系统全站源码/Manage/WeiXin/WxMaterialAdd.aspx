<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WxMaterialAdd.aspx.cs" Inherits="ZoomLaCMS.Manage.WeiXin.WxMaterialAdd" MasterPageFile="~/Manage/I/Default.Master" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>素材上传</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <table class="table table-bordered table-striped">
        <tr>
            <td class="td_m">素材类型</td>
            <td>
                <label><input type="radio" value="image" name="type_rad" checked="checked" />图片</label>
            </td>
        </tr>
        <tr>
            <td>素材</td>
            <td>
                <ZL:FileUpload runat="server" ID="ImgFile_Up" OnlyImg="true"/>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <asp:Button runat="server" ID="Save_Btn" class="btn btn-info" Text="上传素材" OnClick="Save_Btn_Click" />
                <a href="WXMaterial.aspx" class="btn btn-default">返回列表</a>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent"></asp:Content>