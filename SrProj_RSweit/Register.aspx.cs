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
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // regestration button
        protected void BtnRegister_Click(object sender, EventArgs e)
        {
            if (Page.IsPostBack)    ///
            {                       /// checks for validation regardless if the user has javascript
                Page.Validate();    /// enabled or not
                if (Page.IsValid)   ///
                {
                    // creating a new salt using a method placed in the master page
                    String salt = Master.CreateSalt(256);

                    // checking to see if the user exists
                    if (CheckForUser(txtEmail.Text) == true)
                    {
                        this.ShowError("A user with this email already exists, please use another email");
                    }
                    else if (CheckForUser(txtEmail.Text) == false)
                    {
                        // if email doesn't exist, use linq to sql to insert a new user into the database
                        user newUser = new user
                        {
                            UserEmail = txtEmail.Text,
                            UserPassword = Master.PasswordHash(txtPassword.Text, salt),
                            UserSalt = salt
                        };
                        // linq to sql to perform the insert into database
                        using (DBContextDataContext db = new DBContextDataContext())
                        {
                            db.users.InsertOnSubmit(newUser);

                            db.SubmitChanges();

                            // sets the session id for the new user so they can update their information
                            Session["ID"] = (from x in db.users where x.UserEmail == txtEmail.Text select x.UserID).FirstOrDefault();
                        }
                        // sending them to the customer page to update their informaition
                        Response.Redirect("~/Customer.aspx");
                    }
                    else
                    {
                        Response.Redirect("~/Register.aspx");   // sent back to registration if failed
                    }
                }
            }
            
        }

        // method to check if user exists in the database
        public bool CheckForUser(string email)
        {
            using (DBContextDataContext db = new DBContextDataContext())
            {
                var qry = (from x in db.users where x.UserEmail.Equals(email) select x);

                Session["Name"] = qry.Count();

                if (qry.Count() != 0)
                {
                    return true;
                }
                else
                    return false;
            }
                
        }

        // method to set error message if there is an error that occurs
        void ShowError(string ErrorMessage)
        {
            this.lblErrorMessage.Text = ErrorMessage + "<p>";
        }

    }
}