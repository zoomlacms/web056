<%@ WebHandler Language="C#" Class="message" %>

using System;
using System.Web;
using ZoomLa.BLL;
using ZoomLa.BLL.API;
using ZoomLa.Model;
using Newtonsoft.Json;
using System.Data;
using ZoomLa.SQLDAL;
using ZoomLa.SQLDAL.SQL;
using ZoomLa.BLL.User;
using System.Collections.Generic;
using System.Data.SqlClient;
public class message :API_Base,IHttpHandler {
    B_User_API buapi = new B_User_API();
    B_Message msgBll = new B_Message();
    public void ProcessRequest (HttpContext context) {
        HttpContext.Current.Response.AddHeader("Cache-Control", "no-cache");
        HttpContext.Current.Response.AddHeader("Access-Control-Allow-Methods", "GET, POST");
        // The following line solves the error message
        HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", "*");
        // If any http headers are shown in preflight error in browser console add them below
        HttpContext.Current.Response.AddHeader("Access-Control-Allow-Headers", "Content-Type, Accept, Pragma, Cache-Control, Authorization ");
        HttpContext.Current.Response.AddHeader("Access-Control-Max-Age", "1728000");
        retMod.retcode = M_APIResult.Failed;
        int cpage = DataConvert.CLng(Req("cpage"), 1);
        int psize = DataConvert.CLng(Req("psize"), 10);
        M_UserInfo mu = B_User_API.GetLogin(Req("openid"));
        if (mu.IsNull) { retMod.retmsg = "用户未登录"; RepToClient(retMod); return; }
        //-------------------------------
        try
        {
            switch (Action)
            {
                case "get":
                    {
                        //int id = DataConvert.CLng(Req("id"));
                        //M_Message msgMod = msgBll.SelReturnModel(id);
                        //retMod.retcode = M_APIResult.Success;
                        //retMod.result = JsonConvert.SerializeObject(msgMod);
                    }
                    break;
                case "list"://发给我的信息
                    {
                        string fast = Req("fast");
                        string where = "1=1 ";
                        List<SqlParameter> sp = new List<SqlParameter>();
                        switch (fast)
                        {
                            case "tome":
                                where += " AND Incept LIKE @uid";
                                sp.Add(new SqlParameter("uid", "%," + mu.UserID + ",%"));
                                break;
                            case "isend":
                                where += " AND Sender=" + mu.UserID;
                                break;
                        }
                        DataTable dt = new DataTable();
                        PageSetting setting = PageSetting.Single(cpage, psize, "ZL_Message", "MsgID", where, "ID DESC", sp);
                        retMod.result = JsonConvert.SerializeObject(dt);
                        retMod.page = new M_API_Page(setting);
                        retMod.retcode = M_APIResult.Success;
                    }
                    break;
                case "send":
                    {
                        string[] titleType = new string[] { "#招呼#", "#消息#", "#喜欢#" };
                        int uid = DataConvert.CLng(Req("uid"));
                        string content = HttpUtility.UrlDecode(Req("content")).ToString();
                        if (mu.IsNull) { retMod.retmsg = "用户未登录"; }
                        else if (uid < 1) { retMod.retmsg = "未指定接收人"; }
                        else if (uid == mu.UserID) { retMod.retmsg = "不能给自己发邮件"; }
                        else
                        {
                            M_Message msgMod = new M_Message();
                            msgMod.MsgType = 1;
                            msgMod.PostDate = DateTime.Now;
                            msgMod.Savedata = 0;
                            msgMod.status = 1;
                            msgMod.Sender = mu.UserID;
                            msgMod.UserName = mu.UserName;
                            msgMod.Title = titleType[DataConvert.CLng(Req("type"))];
                            msgMod.Incept = uid.ToString();
                            msgMod.Content = content;
                            msgMod.MsgID = msgBll.GetInsert(msgMod);
                            retMod.retcode = M_APIResult.Success;
                        }
                    }
                    break;
                default:
                    {
                        retMod.retmsg = "user.[" + Action + "]接口不存在";
                    }
                    break;
            }
        }
        catch (Exception ex) { retMod.retmsg = ex.Message; }
        RepToClient(retMod);
    }

    public bool IsReusable { get { return false; } }

}