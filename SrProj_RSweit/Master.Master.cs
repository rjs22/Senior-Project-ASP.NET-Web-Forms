using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SrProj_RSweit
{
    public partial class Master : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // setting session to local variable to manage
            bool isAdmin = Convert.ToBoolean(Session["Admin"]);

            // if user is an admin, then they will have access to the admin page created
            if (isAdmin == true)
            {
                btnAdmin.Visible = true;
            }
            else
                btnAdmin.Visible = false;

            // checking to see if current user is logged in and has a session
            // if so, they are able to add products to cart and have access to the functions
            // that do so. if not, they will not have access to proper functions.
            if (Session["ID"] != null)
            {
                ulLogin.Attributes["style"] = "visibility:hidden";
                ulUser.Attributes["style"] = "visibility:visible";

                // linq to sql to find user's first name and set that as name in the nav bar
                 using (DBContextDataContext db = new DBContextDataContext())
                 {
                     var user = (from u in db.users where u.UserID.Equals(Session["ID"]) select u).FirstOrDefault();
                     if(user.UserFirstName == null || user.UserFirstName.Equals(""))
                     {
                         spanUser.InnerText = "Hello, Customer";
                     }
                     else
                         spanUser.InnerText = "Hello, " + user.UserFirstName;
                 }
            }
            else
            {
                ulLogin.Attributes["style"] = "visibility:visible";
                ulUser.Attributes["style"] = "visibility:hidden";
            }

            // insureing that current user can logout.
            lnkLogout.ServerClick += new EventHandler(this.Logout_Click);

            // Script used to prevent jquery error
            if (!IsPostBack)
            {
                string JQueryVer = "1.7.1";
                ScriptManager.ScriptResourceMapping.AddDefinition("jquery", new ScriptResourceDefinition
                {
                    Path = "~/Scripts/jquery-" + JQueryVer + ".min.js",
                    DebugPath = "~/Scripts/jquery-" + JQueryVer + ".js",
                    CdnPath = "http://ajax.aspnetcdn.com/ajax/jQuery/jquery-" + JQueryVer + ".min.js",
                    CdnDebugPath = "http://ajax.aspnetcdn.com/ajax/jQuery/jquery-" + JQueryVer + ".js",
                    CdnSupportsSecureConnection = true,
                    LoadSuccessExpression = "window.jQuery"
                });
                
                this.DataBind();
            }
        }

        // hashing algorithm combining user entered password and salt
        public static string PasswordHash(string pwd, string salt)
        {
            byte[] bytes = Encoding.UTF8.GetBytes(pwd + salt);
            SHA256Managed shaString = new SHA256Managed();
            byte[] hash = shaString.ComputeHash(bytes);
            StringBuilder hex = new StringBuilder(hash.Length * 2);
            foreach (byte b in hash)
                hex.AppendFormat("{0:x2}", b);

            return hex.ToString();
        }

        // method to generate a random salt for every user who registers
        public static string CreateSalt(int size)
        {
            //Generate a cryptographic random number.
            RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
            byte[] buff = new byte[size];
            rng.GetBytes(buff);

            // Return a Base64 string representation of the random number.
            return Convert.ToBase64String(buff);
        }

        // logout function, clears all sessions
        protected void Logout_Click(Object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("~/Default.aspx");
        }

        // Button to access admin page
        protected void btnAdmin_Click(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                Page.Validate();
                if (Page.IsValid)
                {
                    int usrID = Convert.ToInt32(Session["ID"]);
                    using (DBContextDataContext db = new DBContextDataContext())
                    {
                        var user = (from u in db.users where u.UserID == usrID select u).FirstOrDefault();
                        if (user.UserIsAdmin == true)
                        {
                            Response.Redirect("~/Admin.aspx");
                        }
                        else
                            btnAdmin.Visible = false;
                    }
                }
            }
        }
    }
}