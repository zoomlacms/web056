<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Invoice.aspx.cs" Inherits="ZoomLaCMS.Cart.Comp.Invoice" EnableViewState="false"%>
<div class="indent" runat="server">
    <label>
        <input type="radio" name="invoice_rad" value="0" onclick="$('#invoice_div').hide();" checked="checked" />不开发票</label>
    <label>
        <input type="radio" name="invoice_rad" value="1" onclick="$('#invoice_div').show();" />需要发票</label><br />
    <div id="invoice_div">
        <ul class="addresssul indent padding0">
            <asp:repeater id="Invoice_RPT" runat="server">
                        <ItemTemplate>
                            <li>
                                <label class="normalw"><input class="invoice_item_rad" name="invoice_item_rad" type="radio" value='<%#Eval("Detail") %>' data-head="<%#Eval("Head") %>" /><%#Eval("Head") %></label>
                            </li>
                        </ItemTemplate>
                        <FooterTemplate> 
                                <li><label class="normalw"><input class="invoice_item_rad" name="invoice_item_rad" type="radio" value='' data-head=""/>使用新发票</label></li>
                        </FooterTemplate>
                    </asp:repeater>
        </ul>
        <div>
            <div>
                <input type="text" id="InvoTitle_T" name="InvoTitle_T" class="form-control text_400 margin_t5" maxlength="50" placeholder="发票抬头（个人或公司名称）" />
            </div>
            <div>
                <input type="text" id="InvoUserCode_T" name="InvoUserCode_T" class="form-control text_400 margin_t5" maxlength="50" placeholder="纳税人识别号或统一社会信用代码" />
            </div>
            <div>
                <div>
                    <label>
                        <input type="radio" value="明细" name="invUseType_rad" />明细</label>
                    <label>
                        <input type="radio" value="办公用品" name="invUseType_rad" />办公用品</label>
                    <label>
                        <input type="radio" value="电脑配件" name="invUseType_rad" />电脑配件</label>
                    <label>
                        <input type="radio" value="食品" name="invUseType_rad" />食品</label>
                    <label>
                        <input type="radio" value="服装服饰" name="invUseType_rad" />服装服饰</label>
                    <label>
                        <input type="radio" value="酒水餐饮" name="invUseType_rad" />酒水餐饮</label>
                </div>
                <textarea id="Invoice_T" name="Invoice_T" class="form-control invoice_t" maxlength="180" placeholder="在此输入发票开具科目明细"></textarea>
                <a href="http://www.gsxt.gov.cn" target="_blank">(查询统一社会信用代码)</a>
            </div>
        </div>
    </div>
</div>
<script>
    var invHelper = {};
    invHelper.init = function () {
        $("input[name='invUseType_rad']").click(function () {
            var $text = $("#Invoice_T");
            if (this.value != "明细") { $text.hide(); $text.text(this.value); }
            else { $text.text(""); $text.show(); }
        });
        $("input[name='invUseType_rad']:first").click();
        //-----
        //加载最近一次的发票数据
        if ($(".invoice_item_rad").length > 0) {
            $(".invoice_item_rad").click(function () {
                $("#InvoTitle_T").val($(this).data("head"));
                $("#Invoice_T").val($(this).val());
            });
            $(".invoice_item_rad:first").click();
        }
    }
    invHelper.init();
</script>