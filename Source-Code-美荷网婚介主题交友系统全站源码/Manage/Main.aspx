<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="ZoomLaCMS.Manage.Main" MasterPageFile="~/Manage/I/Default.master" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>快速导航</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div class="row main_nav" runat="server" id="navDiv">
<asp:Literal runat="server" ID="model_Lit" EnableViewState="false"></asp:Literal>
</div>
<asp:Literal runat="server" ID="page_Lit" EnableViewState="false"></asp:Literal>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<style>
.mysite{display:none;}
#navDiv>div{height:191px;overflow:hidden;}
#navHolder{display:none;}
</style>
</asp:Content>