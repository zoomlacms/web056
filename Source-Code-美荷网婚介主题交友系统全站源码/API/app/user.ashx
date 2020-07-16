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
using System.Linq;
using System.Data.SqlClient;
using ZoomLa.BLL.Helper;
using ZoomLa.Components;
using ZoomLa.Common;
using System.Collections.Generic;
using System.Data.Common;

public class user : API_Base, IHttpHandler
{
    B_User buser = new B_User();
    B_User_API buapi = new B_User_API();
    public void ProcessRequest(HttpContext context)
    {
        HttpContext.Current.Response.AddHeader("Cache-Control", "no-cache");
        HttpContext.Current.Response.AddHeader("Access-Control-Allow-Methods", "GET, POST");
        // The following line solves the error message
        HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", "*");
        // If any http headers are shown in preflight error in browser console add them below
        HttpContext.Current.Response.AddHeader("Access-Control-Allow-Headers", "Content-Type, Accept, Pragma, Cache-Control, Authorization ");
        HttpContext.Current.Response.AddHeader("Access-Control-Max-Age", "1728000");
        retMod.retcode = M_APIResult.Failed;
        PageSetting setting = new PageSetting();
        int uid;
        try
        {
            switch (Action)
            {
                case "register":
                    {
                        string uname = HttpUtility.UrlDecode(Req("uname"));
                        string upwd = HttpUtility.UrlDecode(Req("upwd"));
                        M_UserInfo mu = buser.NewUser(uname, upwd);
                        M_Uinfo basemu = new M_Uinfo();
                        mu.HoneyName = "";
                        mu.TrueName = "";
                        mu.UserFace = "";

                        basemu.Mobile = "";
                        basemu.UserSex = true;
                        basemu.BirthDay = "";
                        basemu.Province = "";//省市县
                        basemu.City = "";
                        basemu.County = "";
                        mu.UserID = buser.Add(mu);
                        basemu.UserId = mu.UserID;
                        buser.AddBase(basemu);
                        mu = buser.SelReturnModel(mu.UserID);
                        M_AJAXUser user = new M_AJAXUser(mu);
                        user.openid = buapi.CreateOpenID(mu);
                        retMod.result = JsonConvert.SerializeObject(user);
                        retMod.retcode = M_APIResult.Success;
                    }
                    break;
                case "login":
                    {
                        M_UserInfo mu = buser.AuthenticateUser(Req("uname"), Req("upwd"));
                        if (mu.IsNull)
                        {
                            retMod.retmsg = "用户不存在";
                        }
                        else
                        {

                            M_AJAXUser user = new M_AJAXUser(mu);
                            user.openid = buapi.CreateOpenID(mu);
                            retMod.result = JsonConvert.SerializeObject(user);
                            retMod.retcode = M_APIResult.Success;
                        }
                    }
                    break;
                case "list":
                    {
                        uid = DataConvert.CLng(Req("uid"), 0);
                        setting.cpage = DataConvert.CLng(Req("cpage"), 1);
                        setting.psize = DataConvert.CLng(Req("psize"), 20);
                        setting.t1 = "ZL_User";
                        setting.pk = "A.UserID";
                        setting.fields = "UserID,UserName,HoneyName,JoinTime,salt AS UserFace";
                        setting.where = "1=1 and UserID <>" + uid + "ORDER BY NEWID()";
                        DBCenter.SelPage(setting);
                        retMod.retcode = M_APIResult.Success;
                        retMod.result = JsonConvert.SerializeObject(setting.dt);
                        retMod.page = new M_API_Page(setting);
                    }
                    break;
                case "get":
		{
                    uid = DataConvert.CLng(Req("uid"));
                    setting = new PageSetting();
                    setting.cpage = DataConvert.CLng(Req("cpage"), 1);
                    setting.psize = DataConvert.CLng(Req("size"), 1);
                    setting.t1 = "ZL_User";
                    setting.t2 = "ZL_UserBase";
                    setting.fields = "A.UserID,A.UserName,B.*";
                    setting.pk = "A.UserID";
                    setting.on = "A.UserID=B.UserID";
                    setting.where = "1=1 And A.UserID=" + uid;
                    DBCenter.SelPage(setting);
                    retMod.retcode = M_APIResult.Success;
                    retMod.result = JsonConvert.SerializeObject(setting.dt);
                    retMod.page = new M_API_Page(setting);
                    break;
		    }
                case "msglist":
		{
                    uid = DataConvert.CLng(Req("uid"));
                    setting.cpage = DataConvert.CLng(Req("cpage"), 1);
                    setting.psize = DataConvert.CLng(Req("psize"), 100);
                    setting.t1 = "ZL_Message";
                    setting.t2 = "ZL_User";
                    setting.pk = "A.MsgID";
                    setting.on = "A.Sender=B.UserID";
                    setting.fields = "A.*,B.*";
                    setting.where = "1=1 And Incept like '%," + uid + ",%'";
                    DBCenter.SelPage(setting);
                    retMod.retcode = M_APIResult.Success;
                    retMod.result = JsonConvert.SerializeObject(setting.dt);
                    retMod.page = new M_API_Page(setting);
                    break;
		    }
                case "upuserbase":
		{
                    uid = DataConvert.CLng(Req("uid"));
                    string sets = "xl=@xl";
                    sets += ",mothmony=@mothmony";
                    sets += ",sxzx=@sxzx    ";
                    sets += ",tx=@tx";
                    sets += ",xx=@xx";
                    sets += ",tz=@tz";
                    sets += ",mz=@mz";
                    sets += ",xmzp=@xmzp";
                    sets += ",zjxy=@zjxy";
                    sets += ",shzx=@shzx";
                    sets += ",spxy=@spxy";
                    sets += ",sphj=@sphj";
                    sets += ",xhsjh=@xhsjh";
                    sets += ",spxyxh=@spxyxh";
                    sets += ",padykfs=@padykfs";
                    sets += ",xwdfkz=@xwdfkz";
                    sets += ",qddhlxs=@qddhlxs";
                    sets += ",cyzk=@cyzk";
                    sets += ",jwfg=@jwfg";
                    string where = "1=1 And UserID=" + uid;
                    List<SqlParameter> sp = new List<SqlParameter>();
                    sp.Add(new SqlParameter("xl", Req("xl")));
                    sp.Add(new SqlParameter("mothmony", Req("mothmony")));
                    sp.Add(new SqlParameter("sxzx", Req("sxzx")));
                    sp.Add(new SqlParameter("tx", Req("tx")));
                    sp.Add(new SqlParameter("xx", Req("xx")));
                    sp.Add(new SqlParameter("tz", Req("tz")));
                    sp.Add(new SqlParameter("mz", Req("mz")));
                    sp.Add(new SqlParameter("xmzp", Req("xmzp")));
                    sp.Add(new SqlParameter("zjxy", Req("zjxy")));
                    sp.Add(new SqlParameter("shzx", Req("shzx")));
                    sp.Add(new SqlParameter("spxy", Req("spxy")));
                    sp.Add(new SqlParameter("sphj", Req("sphj")));
                    sp.Add(new SqlParameter("xhsjh", Req("xhsjh")));
                    sp.Add(new SqlParameter("spxyxh", Req("spxyxh")));
                    sp.Add(new SqlParameter("padykfs ", Req("padykfs ")));
                    sp.Add(new SqlParameter("xwdfkz", Req("xwdfkz")));
                    sp.Add(new SqlParameter("qddhlxs ", Req("qddhlxs ")));
                    sp.Add(new SqlParameter("cyzk", Req("cyzk")));
                    sp.Add(new SqlParameter("jwfg", Req("jwfg")));
                    DBCenter.UpdateSQL("ZL_UserBase", sets, where, sp);
                    M_UserInfo mu = buser.GetUserByUserID(uid);
                    M_AJAXUser user = new M_AJAXUser(mu);
                    user.openid = buapi.CreateOpenID(mu);
                    retMod.result = JsonConvert.SerializeObject(user);
                    retMod.retcode = M_APIResult.Success;
                    break;
		    }
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