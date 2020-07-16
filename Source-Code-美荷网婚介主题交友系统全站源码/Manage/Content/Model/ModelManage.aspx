<%@ Page Language="C#" MasterPageFile="~/Manage/I/Default.master" AutoEventWireup="true" CodeBehind="ModelManage.aspx.cs" Inherits="ZoomLaCMS.Manage.Content.ModelManage" %>
<asp:Content ContentPlaceHolderID="head" Runat="Server"><title><%=Resources.L.模型管理 %></title></asp:Content>
<asp:Content ContentPlaceHolderID="Content" Runat="Server">
<ZL:ExGridView ID="EGV" runat="server" AutoGenerateColumns="False" DataKeyNames="ModelID" PageSize="20" OnRowDataBound="Egv_RowDataBound" 
        OnPageIndexChanging="Egv_PageIndexChanging" IsHoldState="false" OnRowCommand="Egv_RowCommand" 
        AllowPaging="True" AllowSorting="True" CssClass="table table-striped table-bordered table-hover" 
        EnableTheming="False" EnableModelValidation="True" EmptyDataText="<%$Resources:L,暂无模型信息 %>">
        <Columns>
            <asp:TemplateField HeaderText="<%$Resources:L,操作 %>" ItemStyle-CssClass="td_m">
                <ItemTemplate>
                    <div class="option_area dropdown" >
                    <a class="option_style" href="javascript:;" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-bars"></i><%=Resources.L.操作 %><span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu"> 
                    <li><a href="ModelField.aspx?ModelID=<%#Eval("ModelID") %>&ModelType=<%:ModelType %>" class="option_style"><i class="fa fa-align-justify"></i>字段</a></li>
                    <li><a href="AddEditModel.aspx?ModelID=<%#Eval("ModelID") %>&ModelType=<%:ModelType %>" class="option_style"><i class="fa fa-pencil"></i><%=Resources.L.编辑 %></a></li>
                    <li><asp:LinkButton runat="server" class="option_style" CommandName="Copy" CommandArgument='<%# Eval("ModelID")%>' Enabled='<%#GetEnabled(Eval("SysModel").ToString()) %>'><i class="fa fa-paste"></i><%=Resources.L.复制 %></asp:LinkButton></li>  
                    <li><asp:LinkButton runat="server" class="option_style" CommandName="Del2" CommandArgument='<%# Eval("ModelID") %>' OnClientClick="return confirm('确实要删除此模型吗？');"><i class="fa fa-trash-o"></i><%=Resources.L.删除 %></asp:LinkButton></li> 
                    <li><a href="ModelData.aspx?ID=<%#Eval("ModelID") %>" class="option_style"><i class="fa fa-database"></i>数据</a></li>            
                    </ul>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ID" ItemStyle-CssClass="td_s">
                <ItemTemplate>
                    <strong><%# Eval("ModelID") %></strong>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="<%$Resources:L,模型名称 %>">
                <ItemTemplate>
                    <%#GetModelIcon() %>
                    <strong><%# Eval("ModelName")%></strong>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="<%$Resources:L,表名 %>" ItemStyle-CssClass="td_l">
                <ItemTemplate>
                    <strong><%# Eval("TableName")%></strong>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="<%$Resources:L,项目名称 %>" ItemStyle-CssClass="td_m">
                <ItemTemplate>
                    <strong><%# Eval("ItemName")%></strong>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="<%$Resources:L,模型描述 %>" DataField="Description" HeaderStyle-Width="30%" />           
        </Columns>
    </ZL:ExGridView>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<style type="text/css">.allchk_l {display:none;}</style>
<link href="/Plugins/Third/alert/sweetalert.css" rel="stylesheet" />
<script src="/Plugins/Third/alert/sweetalert.min.js?v=1"></script>
<script>
function getinfo(id) {
	location.href = "AddEditModel.aspx?ModelID=" + id + '&ModelType=<%=ModelType %>';
}
//function confirmDel() {
//    swal({
//        title: "删除模型", "text": '<input type="button" />  <span style="color:red;"></span>', html: true,
//        type: "info",
//        showCancelButton: true,
//        confirmButtonColor: "#DD6B55",
//        confirmButtonText: "确定",
//        closeOnConfirm: false
//    }, function () { $("#Refund_Btn").click(); });
//}
HideColumn("1,4,5");
</script>
</asp:Content>