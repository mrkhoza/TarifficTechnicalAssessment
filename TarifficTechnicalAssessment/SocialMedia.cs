using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.IO;
using System.Net;
using System.Text.RegularExpressions;
using System.Collections.Specialized;
using System.Runtime.InteropServices;

namespace TarifficTechnicalAssessment
{
    public class SocialMedia
    {
        static string userAgent = "Mozilla/2.0 (Windows NT 6.1; WOW64;) Gecko/20100101 Firefox/11.0";

        CookieCollection myLoginCookies;
        CookieCollection cok;
    
        public SocialMedia()
        {
            myLoginCookies = cok;
        }

        public SocialMedia(CookieCollection myLoginCookies)
        {
            // TODO: Complete member initialization
            this.myLoginCookies = myLoginCookies;
        }

        public bool StatusUpdate(string txt)
        {
            string url = "https://m.facebook.com/home.php";
            CookieCollection cok = new CookieCollection();
            cok.Add(myLoginCookies);

            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            request.CookieContainer = new CookieContainer();
            request.CookieContainer.Add(cok);
            request.UserAgent = userAgent;
            request.KeepAlive = false;
            request.Timeout = 45000;

            HttpWebResponse response = (HttpWebResponse)request.GetResponse();

            cok.Add(response.Cookies);

            StreamReader sr = new StreamReader(response.GetResponseStream());

            string mainHTML = sr.ReadToEnd();
            string html = mainHTML.Replace("&quot;", "\"");
            html = html.Replace(@"\/", "/");
            html = html.Replace(@"\u0025", "%");
            html = html.Replace("&amp;", "&");
            html = html.Replace("&quot;", "\"");
            File.WriteAllText("1.html", html);
            if (html.Contains("/composer/mbasic/"))
            {
                Regex regAct = new Regex("action=\"(/composer/mbasic/[^\"]+?)\"");
                Match matAct = regAct.Match(html);
                string action = "https://m.facebook.com" + (matAct.Groups[1].Value);
                html = html.Substring(html.IndexOf("/composer/mbasic/") - 50);
                html = html.Remove(html.IndexOf("form>"));
                File.WriteAllText("2.html", html);
                Regex reg = new Regex(@"name=""([^""]+)"" value=""([^""]*)""");
                MatchCollection mc = reg.Matches(html);
                List<string> values = new List<string>();
                string postData = "";

                for (int k = 0; k < mc.Count; k++)
                {
                    postData += mc[k].Groups[1].Value + "=" + Uri.EscapeDataString(mc[k].Groups[2].Value) + "&";
                }

                postData += "xc_message=" + Uri.EscapeDataString(txt);

                File.WriteAllText("1p.html", postData);
                HttpWebRequest getRequest = (HttpWebRequest)WebRequest.Create(action);
                getRequest.CookieContainer = new CookieContainer();
                getRequest.CookieContainer.Add(cok); //recover cookies First request
                getRequest.Method = WebRequestMethods.Http.Post;
                getRequest.UserAgent = userAgent;
                getRequest.AllowWriteStreamBuffering = true;
                getRequest.ProtocolVersion = HttpVersion.Version11;
                getRequest.AllowAutoRedirect = true;
                getRequest.ContentType = "application/x-www-form-urlencoded";
                getRequest.Referer = action;
                getRequest.Headers.Add("DNT", "1");

                byte[] byteArray = Encoding.ASCII.GetBytes(postData);
                getRequest.ContentLength = byteArray.Length;
                Stream newStream = getRequest.GetRequestStream(); //open connection
                newStream.Write(byteArray, 0, byteArray.Length); // Send the data.
                newStream.Close();

                HttpWebResponse getResponse = (HttpWebResponse)getRequest.GetResponse();
                cok.Add(getResponse.Cookies);

                sr = new StreamReader(getResponse.GetResponseStream());
                html = sr.ReadToEnd();
                File.WriteAllText("3.html", html);

                return true;
            }
            return false;
        }

        public static CookieCollection getCookies(string url, string cookieData)
        {
            Uri uri = new Uri(url);
            CookieContainer cookies = new CookieContainer();
            if (cookieData.Length > 0)
            {
                cookies.SetCookies(uri, cookieData.ToString().Replace(';', ','));
            }
            return cookies.GetCookies(uri);
        }

        public static SocialMedia Login(string username, string password)
        {
            CookieCollection myLoginCookies = new CookieCollection();
            myLoginCookies.Add(GetUriCookieContainer("https://facebook.com"));
            myLoginCookies.Add(GetUriCookieContainer("https://m.facebook.com"));
            myLoginCookies.Add(GetUriCookieContainer("https://www.facebook.com"));

            string txt = "";
            foreach (Cookie c in myLoginCookies)
                txt += c.Name + ": " + c.Value + Environment.NewLine;

            //MessageBox.Show(txt, "Cookies");
            if (myLoginCookies.Count > 6)
            {
                return new SocialMedia(myLoginCookies);
            }
            else
            {
                //MessageBox.Show("Failed To Login, Check Your Browser");
            }
            return null;
        }

        [DllImport("wininet.dll", SetLastError = true)]
        public static extern bool InternetGetCookieEx(
            string url,
            string cookieName,
            StringBuilder cookieData,
            ref int size,
            Int32 dwFlags,
            IntPtr lpReserved);

        private const Int32 InternetCookieHttponly = 0x2000;

        public static CookieCollection GetUriCookieContainer(string url)
        {
            Uri uri = new Uri(url);
            CookieContainer cookies = null;
            // Determine the size of the cookie
            int datasize = 8192 * 16;
            StringBuilder cookieData = new StringBuilder(datasize);
            if (!InternetGetCookieEx(uri.ToString(), null, cookieData, ref datasize, InternetCookieHttponly, IntPtr.Zero))
            {
                if (datasize < 0)
                    return null;
                // Allocate stringbuilder large enough to hold the cookie
                cookieData = new StringBuilder(datasize);
                if (!InternetGetCookieEx(
                    uri.ToString(),
                    null, cookieData,
                    ref datasize,
                    InternetCookieHttponly,
                    IntPtr.Zero))
                    return null;
            }
            if (cookieData.Length > 0)
            {
                cookies = new CookieContainer();
                cookies.SetCookies(uri, cookieData.ToString().Replace(';', ','));
            }
            return cookies.GetCookies(uri);
        }


    }
}