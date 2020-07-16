<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddArrive.aspx.cs" Inherits="ZoomLaCMS.Manage.Shop.Arrive.AddArrive" MasterPageFile="~/Manage/I/Default.master" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>优惠劵</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<table class="table table-striped table-bordered">
        <tr>
            <td><strong>卡别名：</strong></td>
            <td>
                <ZL:TextBox ID="txtName" runat="server" CssClass="form-control text_300" AllowEmpty="false" ValidType="String"></ZL:TextBox>
                <span class="rd_red">*</span><span class="rd_green">便于识别的名称</span>
            </td>
        </tr>
        <tr>
            <td><strong>优惠券类型：</strong></td>
            <td>
                <label>
                    <input type="radio" name="type_rad" value="0" checked="checked" />优惠券</label>
                <label>
                    <input type="radio" name="type_rad" value="1" />现金卡</label>
            </td>
        </tr>
        <tr class="view_add">
            <td><strong>编码类型：</strong></td>
            <td>
                <asp:RadioButtonList RepeatDirection="Horizontal" runat="server" ID="EcodeType">
                    <asp:ListItem Value="2" Selected="True">混淆</asp:ListItem>
                    <asp:ListItem Value="0">数字</asp:ListItem>
                    <asp:ListItem Value="1">字母</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr class="view_add">
            <td><strong>生成数量：</strong></td>
            <td>
                <ZL:TextBox ID="txtCreateNum" runat="server" CssClass="form-control text_300" AllowEmpty="false" ValidType="FloatPostive" Text="10" /><span class="rd_red">*</span></td>
        </tr>
        <tr>
            <td><strong>优惠金额：</strong></td>
            <td>
                <ZL:TextBox ID="Amount_T" runat="server" CssClass="form-control text_300" AllowEmpty="false" ValidType="FloatPostive" Text="1" /><span class="rd_red">*</span>
            </td>
        </tr>
        <tr>
            <td><strong>适用金额范围：</strong></td>
            <td>
                <div class="input-group text_300">
                    <asp:TextBox runat="server" ID="minAmount_T" class="form-control" MaxLength="10" Text="0" />
                    <span class="input-group-addon">到</span>
                    <asp:TextBox runat="server" ID="maxAmount_T" class="form-control" MaxLength="10" />
                </div>
                <div class="rd_green">*如输入(200-300)则只有200-300单价商品(或订单）才能使用，不填则代表不限制(优先匹配下方的商品绑定逻辑，如未绑定商品则此金额为订单总额限制）。</div>
        </tr>
        <tr>
            <td><strong>适用店铺：</strong></td>
            <td>
                <asp:DropDownList runat="server" ID="Store_DP" class="form-control text_300" DataTextField="Title" DataValueField="GeneralID"></asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td><strong>适用商品：</strong></td>
            <td>
                <input type="button" value="选择商品" onclick="upro.showdiag();" class="btn btn-info" runat="server" id="selpro_btn" />
                <%--    <asp:Button runat="server" ID="AddUPro_Btn" OnClick="AddUPro_Btn_Click" class="btn btn-info" Text="保存修改" />--%>
                <div id="uprolist" class="uprolist"></div>
                <asp:HiddenField runat="server" ID="UProIDS_Hid" />
                <script>
                    var upro = {};
                    upro.init = function () { $("#uprolist").load("/Common/Comp/ProductList.aspx?ProIDS=" + $("#UProIDS_Hid").val()); }
                    upro.showdiag = function () { ShowComDiag("<%:customPath2%>Shop/ProductsSelect.aspx?callback=selupro", "选择商品"); }
                    upro.del = function (btn, proid) {
                        var ids = $("#UProIDS_Hid").val();
                        ids = ids.replace("," + proid + ",", ",");
                        $("#UProIDS_Hid").val(ids);
                        $(btn).closest(".up_proitem").remove();
                    }
                    function selupro(list) {
                        list = JSON.parse(list);
                        var ids = list.GetIDS("id");
                        ids = $("#UProIDS_Hid").val() + "," + ids;
                        $("#UProIDS_Hid").val(ids);
                        $("#uprolist").load("/Common/Comp/ProductList.aspx?ProIDS=" + ids);
                    }
                    $(function () { upro.init(); })
                </script>
            </td>
        </tr>
        <tbody id="edit_body" runat="server">
            <tr>
                <td><strong>编号:</strong></td>
                <td>
                    <asp:TextBox ID="txtNo" runat="server" Enabled="false" CssClass="form-control text_md"></asp:TextBox></td>
            </tr>
            <tr>
                <td><strong>密码:</strong></td>
                <td>
                    <asp:TextBox ID="txtPwd" runat="server" Enabled="false" CssClass="form-control text_md"></asp:TextBox></td>
            </tr>
            <tr>
                <td><strong>状态:</strong></td>
                <td>
                    <asp:TextBox ID="txtState" runat="server" Enabled="false" CssClass="form-control text_md"></asp:TextBox></td>
            </tr>
            <tr>
                <td><strong>所属用户:</strong></td>
                <td>
                    <asp:TextBox ID="txtUserID" runat="server" Enabled="false" CssClass="form-control text_md"></asp:TextBox>
                </td>
            </tr>
        </tbody>
        <tr>
            <td><strong>生效时间：</strong></td>
            <td>
                <asp:TextBox ID="AgainTime_T" onclick="WdatePicker({ dateFmt: 'yyyy/MM/dd'});" runat="server" CssClass="form-control text_300" />
                <span style="line-height: 26px; color: green;">&nbsp;<i style="font-size: 26px;" class="fa fa-calendar"></i></span>
                <asp:RequiredFieldValidator ID="RV2" runat="server" ControlToValidate="AgainTime_T" ErrorMessage="生效时间不能为空!" />
            </td>
        </tr>
        <tr>
            <td><strong>到期时间:</strong></td>
            <td>
                <asp:TextBox ID="EndTime_T" onclick="WdatePicker({ dateFmt: 'yyyy/MM/dd'});" runat="server" CssClass="form-control text_300" />
                <span style="line-height: 26px; color: green;">&nbsp;<i style="font-size: 26px;" class="fa fa-calendar"></i> 默认一年有效</span>
                <font color="red"><asp:RequiredFieldValidator ID="RV3" runat="server" ControlToValidate="EndTime_T" ErrorMessage="到期时间不能为空!" />
            </font></td>
        </tr>
        <tr class="view_add">
            <td><strong>用户绑定:</strong></td>
            <td>
                <input type="button" onclick="SelUser();" class="btn btn-info" value="选择用户" />
                <div id="upro_wrap" style="width: 600px; max-height: 400px; overflow-y: auto;"></div>
            </td>
        </tr>
        <tr>
            <td><strong>是否激活:</strong></td>
            <td>
                <input type="checkbox" runat="server" id="state_chk" checked="checked" class="switchChk" />
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <asp:Button ID="EBtnSubmit" class="btn btn-primary" Text="制作优惠劵" runat="server" OnClick="EBtnSubmit_Click" />
                <a href="ArriveManage.aspx" class="btn btn-default">返回列表</a></td>
        </tr>
    </table>
<asp:HiddenField runat="server" ID="UserID_Hid" />
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<link href="/dist/css/bootstrap-switch.min.css" rel="stylesheet" />
<script src="/JS/Controls/ZL_Dialog.js"></script>
<script src="/JS/DatePicker/WdatePicker.js"></script>
<script src="/JS/Controls/ZL_Array.js"></script>
<script src="/JS/SelectCheckBox.js"></script>
<script src="/dist/js/bootstrap-switch.js"></script> 
<script>
    function closeDiag() { CloseComDiag(); }
    function SelUser() {
        comdiag.maxbtn = false;
        ShowComDiag("/Common/Dialog/SelGroup.aspx", "选择用户");
    }
    function delUser(btn, uid) {
        var $hid = $("#UserID_Hid");
        $(btn).closest("tr").remove();
        var ids = idshelp.del($hid.val(), uid);
        $hid.val(ids);
    }
    function UserFunc(list, select) {
        var ids = idshelp.merge(list.GetIDS("UserID"), $("#UserID_Hid").val());
        $("#upro_wrap").load("/common/comp/UserList.aspx?del=delUser", { "ids": ids });
        $("#UserID_Hid").val(ids);
        CloseComDiag();
    }
    $(function () {
        if ("<%:Mid%>" != "0") { $(".view_add").hide(); }
    })
</script>
</asp:Content>
