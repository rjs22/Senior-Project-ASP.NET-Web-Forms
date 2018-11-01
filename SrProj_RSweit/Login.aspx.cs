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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        
        // Button for login action
        protected void LoginButton_Click(object sender, EventArgs e)
        {
            if (Page.IsPostBack)    ///
            {                       /// Ensures validation happens regardless if the user has javascript
                Page.Validate();    /// enabled or not
                if (Page.IsValid)   ///
                {
                    // linq to sql that logs the user in
                    using (DBContextDataContext db = new DBContextDataContext())
                    {
                        // set textbox values to string variables
                        string email = Email.Text;
                        string pass = Password.Text;

                        // Capturing user salt from database
                        var retrivedSalt = (from s in db.users where (email == s.UserEmail) select s.UserSalt).FirstOrDefault();
                        // Combining password and salt fields to recreate user passoword for verification
                        string unhashedPW = Master.PasswordHash(pass, retrivedSalt.ToString());

                        // if using the email and password provided brings back any records, set the
                        // id, name, and is admin boolean to session variables
                        if (db.users.Any(u => u.UserEmail == email && u.UserPassword == unhashedPW) == true)
                        {
                            Session["ID"] = (from x in db.users where email == x.UserEmail select x.UserID).FirstOrDefault();
                            Session["Name"] = (from x in db.users where email == x.UserEmail select x.UserFirstName).FirstOrDefault();
                            Session["Admin"] = (from x in db.users where email == x.UserEmail select x.UserIsAdmin).FirstOrDefault();
                            this.DataBind();
                            Response.Redirect("~/Customer.aspx");
                        }
                        else
                            Response.Redirect("~/Login.aspx");
                    }
                    
                }
            }
            

        }
    }
}