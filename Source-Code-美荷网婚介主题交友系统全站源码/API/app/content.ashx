<%@ WebHandler Language="C#" Class="user" %>

using System;
using System.Web;
using ZoomLa.BLL;
using ZoomLa.BLL.API;
using ZoomLa.BLL.User;
using ZoomLa.Model;
using Newtonsoft.Json;
using System.Data;
using ZoomLa.SQLDAL;
using ZoomLa.SQLDAL.SQL;
public class user :API_Base,IHttpHandler {
    B_User buser = new B_User();
    B_User_API buapi = new B_User_API();
    public void ProcessRequest (HttpContext context) {
        HttpContext.Current.Response.AddHeader("Cache-Control", "no-cache");
        HttpContext.Current.Response.AddHeader("Access-Control-Allow-Methods", "GET, POST");
        // The following line solves the error message
        HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", "*");
        // If any http headers are shown in preflight error in browser console add them below
        HttpContext.Current.Response.AddHeader("Access-Control-Allow-Headers", "Content-Type, Accept, Pragma, Cache-Control, Authorization ");
        HttpContext.Current.Response.AddHeader("Access-Control-Max-Age", "1728000");
        retMod.retcode = M_APIResult.Failed;
        try
        {
            switch (Action)
            {
                case "list":
                    {
                        int nid = DataConvert.CLng(Req("nid"));
                        PageSetting setting = new PageSetting();
                        setting.cpage = DataConvert.CLng(Req("cpage"), 1);
                        setting.psize = DataConvert.CLng(Req("psize")) == 0 ? 20 : DataConvert.CLng(Req("psize"));
                        setting.t1 = "ZL_CommonModel";
                        setting.t2 = "ZL_C_Article";
                        setting.pk = "A.ID";
                        setting.on = "A.ItemID=B.ID";
                        setting.fields = "A.Title,A.NodeID,A.GeneralID,A.Inputer,A.TopImg,B.synopsis,B.content";
                        setting.where = "(NodeID=" + nid + " or FirstNodeiD=" + nid + " And Status=99)";
                        DBCenter.SelPage(setting);
                        retMod.retcode = M_APIResult.Success;
                        retMod.result = JsonConvert.SerializeObject(setting.dt);
                        retMod.page = new M_API_Page(setting);
                    }
                    break;
                default:
                    {
                        retMod.retmsg = "[" + Action + "]接口不存在";
                    }
                    break;
            }
        }
        catch (Exception ex) { retMod.retmsg = ex.Message; }
        RepToClient(retMod);
    }

    public bool IsReusable { get { return false; } }

}