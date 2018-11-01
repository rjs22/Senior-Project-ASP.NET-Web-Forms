// This page uses Methods and functions from www.west-wind.com for credit card processing
// Some comments were left from the transfer to identify those specific parts
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using AuthorizeNet.Api.Controllers;
using AuthorizeNet.Api.Contracts.V1;
using AuthorizeNet.Api.Controllers.Bases;

namespace SrProj_RSweit
{
    public partial class Checkout : System.Web.UI.Page
    {
        /// Required internal variable that lets us know if
        /// we are returning from PayPal. This flag can be used
        /// to bypass other processing that might be happening
        /// for Credit Cards or whatever.
        /// 
        /// This gets set by HandlePayPalReturn. Not used in this
        /// demo. Refer to article to see how it's used in a more
        /// complex environment.

        private bool PayPalReturnRequest = false;

        /// Our ever so complicated ORDER DATA. Hey this is supposed to be 
        /// a quick demo and skeleton, so I kept it as simple as possible.
        /// The article shows a more complex environment!

        protected decimal OrderAmount = 0.00M;

        protected void Page_Load(object sender, EventArgs e)
        {
            //User shouldn't be on this page if they are not logged in
            if (Session["ID"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }

            // load user's cart if the page isn't a postback
            if (!Page.IsPostBack)
            {
                CartLoad();
            }

            // *** Check for PayPal responses - 
            // *** if we have no CC selection and PayPal QueryString we need to handle it
            if (Request.QueryString["PayPal"] != null)
                this.HandlePayPalReturn();

            this.rdbCCType.Items[1].Text = "Credit Card (" + App.Configuration.CCProcessor.ToString() + ")";
        }

        // method that captures current users cart and desplays it on the page
        private void CartLoad()
        {
            // linq to sql for cart display
            using (DBContextDataContext db = new DBContextDataContext())
            {
                var load = (from x in db.UserCarts
                            join y in db.products
                            on x.CartProductID
                            equals y.ProductID
                            where x.CartOrderID == null && x.CartUserID.Equals(Session["ID"])
                            select new
                            {
                                x.CartID,
                                y.ProductThumb,
                                y.ProductCartDesc,
                                x.CartPrice,
                                x.CartQuantity
                            }).ToList();
                gvCart.DataSource = load;
                gvCart.DataBind();
            }

            // linq to sql to calculate what the user owes based on current cart
            // sets all labels to display the correct amounts
            using (DBContextDataContext db = new DBContextDataContext())
            {
                var load = (from x in db.UserCarts
                            where x.CartOrderID == null && x.CartUserID.Equals(Session["ID"])
                            group x by 1 into g
                            select new
                            {
                                total = g.Sum(x => x.CartPrice * x.CartQuantity)
                            }).FirstOrDefault();
                string sub = Convert.ToString(load.total);
                string ship = Convert.ToDecimal(Session["Shipping"]).ToString("F2");
                string tax = Convert.ToString(Math.Round(load.total * .0625, 2));
                string total = (load.total + Convert.ToDouble(Session["Shipping"]) + Math.Round(load.total * .0625, 2)).ToString("F2");

                lblSub.Text = "SubTotal: $" + sub + ".00";
                lblShip.Text = "Shipping: $" + ship;
                lblTax.Text = "Tax: $" + tax;
                lblTotal.Text = "Total: $" + total;
                lblCheckOutTotal.Text = "Order Total: $" + total;
            }
        }

        // gridview function for users to remove items in cart
        protected void gvCart_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            using (DBContextDataContext db = new DBContextDataContext())
            {
                HiddenField hfID = (HiddenField)gvCart.Rows[e.RowIndex].FindControl("hfID");
                var delete = (from x in db.UserCarts where x.CartID == Convert.ToInt32(hfID.Value) select x).FirstOrDefault();

                db.UserCarts.DeleteOnSubmit(delete);
                db.SubmitChanges();
            }
            CartLoad();
        }

        // Method to upload user information, loads if checkbox is checked for billing and shipping
        // addresses are the same
        private void UsrLoad()
        {
            using (DBContextDataContext db = new DBContextDataContext())
            {
                var qry = (from x in db.users where x.UserID.Equals(Session["ID"]) select x).FirstOrDefault();

                txtFname.Text = qry.UserFirstName;
                txtLname.Text = qry.UserLastName;
                txtAddressLnOne.Text = qry.UserAddress1;
                txtAddressLnTwo.Text = qry.UserAddress2;
                txtCity.Text = qry.UserCity;
                txtState.Text = qry.UserState;
                txtZip.Text = qry.UserZip;
                txtPhone.Text = qry.UserPhone;
            }
        }


        protected void btnCheckOut_Click(object sender, EventArgs e)
        {
            // *** simplistic 'order validation'
            try
            {
                // linq to sql to fetch current user order total
                using (DBContextDataContext db = new DBContextDataContext())
                {
                    var load = (from x in db.UserCarts
                                where x.CartOrderID == null && x.CartUserID.Equals(Session["ID"])
                                group x by 1 into g
                                select new
                                {
                                    total = g.Sum(x => x.CartPrice * x.CartQuantity)
                                }).FirstOrDefault();

                    string total = (load.total + Convert.ToDouble(Session["Shipping"]) + Math.Round(load.total * .0625, 2)).ToString("F2");
                    this.OrderAmount = decimal.Parse(total);
                }

            }
            catch
            {
                this.ShowError("Invalid Order Amount. Get a grip.");
                return;
            }


            // *** Dumb ass data simulation - this should only be set once the order is Validated!
            this.Session["OrderAmount"] = this.OrderAmount;


            // *** Handle PayPal Processing seperately from ProcessCard() since it requires
            // *** passing off to another page on the PayPal Site.
            // *** This request will return to this page Cancel or Success querystring
            if (this.rdbCCType.SelectedValue == "PP" && !this.PayPalReturnRequest)
                this.HandlePayPalRedirection(); // this will end this request!
            else
            {
                // *** CC Processing
                if (!this.ProcessCreditCard())
                    return;    // failure - display error

                // *** Write the order amount (and enything else you might need into session)
                // *** Normally you'd probably write a PK for the final invoice so you 
                // *** can reload it on the Confirmation.aspx page
                Session["PayPal_OrderAmount"] = this.OrderAmount;


            }

            // checking for validation on the page regardless if javascript is enabled or not

            // linq to sql to fetch user id and total of order to insert information into the new order
            using (DBContextDataContext db = new DBContextDataContext())
            {
                var qry = (from x in db.users where x.UserID.Equals(Session["ID"]) select x).FirstOrDefault();
                var load = (from x in db.UserCarts
                            where x.CartOrderID == null && x.CartUserID.Equals(Session["ID"])
                            group x by 1 into g
                            select new
                            {
                                total = g.Sum(x => x.CartPrice * x.CartQuantity)
                            }).FirstOrDefault();

                order odr = new order
                {
                    OrderUserID = Convert.ToInt32(Session["ID"]),
                    OrderAmount = Convert.ToDouble(this.OrderAmount),
                    OrderShipName = qry.UserFirstName + " " + qry.UserLastName,
                    OrderShipAddress = qry.UserAddress1,
                    OrderShipAddress2 = qry.UserAddress2,
                    OrderCity = qry.UserCity,
                    OrderState = qry.UserState,
                    OrderZip = qry.UserZip,
                    OrderPhone = qry.UserPhone,
                    OrderShipping = Convert.ToDouble(Session["Shipping"]),
                    OrderTax = Math.Round(load.total * .0625, 2),
                    OrderEmail = qry.UserEmail
                };

                db.orders.InsertOnSubmit(odr);

                db.SubmitChanges();

                // sets the cart's orderID to the id of the order so the cart will appear empty when the user
                // makes a new order
                var cart = (from x in db.UserCarts where x.CartOrderID == null && x.CartUserID.Equals(Session["ID"]) select x).ToList();

                // loops through each item in the cart and sets the order id of each cart record that is 
                // attached to the current user
                foreach (var x in cart)
                {
                    x.CartOrderID = (from y in db.orders where y.OrderUserID.Equals(Session["ID"]) && y.OrderShipped == false select y.OrderID).FirstOrDefault();
                }

                db.SubmitChanges();
            }



            // *** Show the confirmation page - don't transfer so they can refresh without error
            Response.Redirect("Confirmation.aspx");
        }

        // checkbox function that fills up shipping information if its the same as the user profile
        // if the user unchecks the box, it will set all fields to blank
        protected void cbAddress_CheckedChanged(object sender, EventArgs e)
        {
            if (cbAddress.Checked)
            {
                UsrLoad();
            }
            else if (!cbAddress.Checked)
            {
                txtFname.Text = "";
                txtLname.Text = "";
                txtAddressLnOne.Text = "";
                txtAddressLnTwo.Text = "";
                txtCity.Text = "";
                txtState.Text = "";
                txtZip.Text = "";
            }
        }
        private void HandlePayPalRedirection()
        {

            // *** Set a flag so we know we redirected
            Session["PayPal_Redirected"] = "True";

            // *** Save any values you might need when you return here
            Session["PayPal_OrderAmount"] = this.OrderAmount;  // already saved above

            //			Session["PayPal_HeardFrom"] = this.txtHeardFrom.Text;
            //			Session["PayPal_ToolUsed"] = this.txtToolUsed.Text;

            PayPalHelper PayPal = new PayPalHelper();
            PayPal.PayPalBaseUrl = App.Configuration.PayPalUrl;
            PayPal.AccountEmail = App.Configuration.AccountEmail;
            PayPal.Amount = this.OrderAmount;


            //PayPal.LogoUrl = "https://www.west-wind.com/images/wwtoollogo_text.gif";

            PayPal.ItemName = "West Wind Web Store Invoice #" + new Guid().GetHashCode().ToString("x");

            // *** Have paypal return back to this URL
            PayPal.SuccessUrl = Request.Url + "?PayPal=Success";
            PayPal.CancelUrl = Request.Url + "?PayPal=Cancel";

            Response.Redirect(PayPal.GetSubmitUrl());

            return;
        }
        private void HandlePayPalReturn()
        {
            string Result = Request.QueryString["PayPal"];
            string Redir = (string)Session["PayPal_Redirected"];

            // *** Only do this if we are redirected!
            if (Redir == "True")
            {
                Session.Remove("PayPal_Redirected");

                // *** Set flag so we know not to go TO PayPal again
                this.PayPalReturnRequest = true;

                // *** Retrieve saved Page content
                this.lblCheckOutTotal.Text = ("Total: " + (decimal)Session["PayPal_OrderAmount"]).ToString();
                this.rdbCCType.SelectedValue = "PP";

                //				this.txtNotes.Text = (string) Session["PayPal_Notes"];
                //				this.txtHeardFrom.Text = (string) Session["PayPal_HeardFrom"];
                //				this.txtToolUsed.Text = (string) Session["PayPal_ToolUsed"];

                if (Result == "Cancel")
                {
                    this.ShowError("PayPal Payment Processing Failed");
                }
                else
                {
                    // *** We returned successfully - simulate button click to save the order
                    this.btnCheckOut_Click(this, EventArgs.Empty);
                }
            }


        }

        // method that uses supported classes to process credit card
        public bool ProcessCreditCard()
        {
            bool Result = false;

            ccProcessing CC = null;
            ccProcessors CCType = App.Configuration.CCProcessor;

            try
            {
                // *** Figure out which type to use
                if (CCType == ccProcessors.AccessPoint)
                {
                    CC = new ccAccessPoint();
                }
                else if (CCType == ccProcessors.AuthorizeNet)
                {
                    CC = new ccAuthorizeNet();
                    CC.MerchantPassword = App.Configuration.CCMerchantPassword;
                }
                else if (CCType == ccProcessors.PayFlowPro)
                {
                    CC = new ccPayFlowPro();
                    CC.MerchantPassword = App.Configuration.CCMerchantPassword;
                }
                else if (CCType == ccProcessors.LinkPoint)
                {
                    CC = new ccLinkPoint();
                    CC.MerchantPassword = App.Configuration.CCMerchantId;
                    CC.CertificatePath = App.Configuration.CCCertificatePath;   // "d:\app\MyCert.pem"
                }


                //CC.UseTestTransaction = true;

                // *** Tell whether we do SALE or Pre-Auth
                CC.ProcessType = App.Configuration.CCProcessType;

                // *** Disable this for testing to get provider response
                CC.UseMod10Check = true;

                CC.Timeout = App.Configuration.CCConnectionTimeout;  // In Seconds
                CC.HttpLink = App.Configuration.CCHostUrl;           // The host Url format will vary with provider
                CC.MerchantId = App.Configuration.CCMerchantId;

                CC.LogFile = App.Configuration.CCLogFile;
                CC.ReferringUrl = App.Configuration.CCReferingOrderUrl;

                // *** Name can be provided as a single string or as firstname and lastname
                CC.Name = this.txtFname.Text + " " + this.txtLname.Text;
                //CC.Firstname = Cust.Firstname.TrimEnd();
                //CC.Lastname = Cust.Lastname.TrimEnd();
                // CC.Company = Cust.Company.TrimEnd();

                CC.Address = this.txtAddressLnOne.Text + " " + this.txtAddressLnTwo.Text;
                CC.State = this.txtState.Text;
                CC.City = this.txtCity.Text;
                CC.Zip = this.txtZip.Text;
                CC.Country = "US";   // 2 Character Country ID set statically to US since buisness is only
                                     // operating in the US currently

                // linq to sql to fetch current user information
                using (DBContextDataContext db = new DBContextDataContext())
                {
                    var qry = (from x in db.users where x.UserID.Equals(Session["ID"]) select x).FirstOrDefault();

                    CC.Phone = qry.UserPhone;
                    CC.Email = qry.UserEmail;
                }

                // linq to sql to capture current user total to add to the credit card processing
                using (DBContextDataContext db = new DBContextDataContext())
                {
                    var load = (from x in db.UserCarts
                                where x.CartOrderID == null && x.CartUserID.Equals(Session["ID"])
                                group x by 1 into g
                                select new
                                {
                                    total = g.Sum(x => x.CartPrice * x.CartQuantity)
                                }).FirstOrDefault();

                    string total = (load.total + Convert.ToDouble(Session["Shipping"]) + Math.Round(load.total * .0625, 2)).ToString("F2");
                    CC.OrderAmount = decimal.Parse(total);
                }

                //CC.TaxAmount = Inv.Tax;					// Optional

                CC.CreditCardNumber = this.txtCC.Text;
                CC.CreditCardExpiration = this.txtCCMonth.SelectedValue + "/" + this.txtCCYear.SelectedValue;

                CC.SecurityCode = this.txtSecurity.Text;

                // *** Make this Unique
                //CC.OrderId = Inv.Invno.TrimEnd() + "_" + DateTime.Now.ToString();
                CC.Comment = "Test Order # " + new Guid().GetHashCode().ToString("x");

                Result = CC.ValidateCard();

                if (!Result)
                {
                    this.lblErrorMessage.Text = CC.ValidatedMessage +
                        "<hr>" +
                        CC.ErrorMessage;
                }
                else
                {
                    // *** Should be APPROVED
                    this.lblErrorMessage.Text = CC.ValidatedMessage;
                }


                // *** Always write out the raw response
                if (wwUtils.Empty(CC.RawProcessorResult))
                {
                    this.lblErrorMessage.Text += "<hr>" + "Raw Results:<br>" +
                                                 CC.RawProcessorResult;
                }
            }
            catch (Exception ex)
            {

                this.lblErrorMessage.Text = "FAILED<hr>" +
                                            "Processing Error: " + ex.Message;

                return false;
            }

            return Result;
        }

        // error handling
        void ShowError(string ErrorMessage)
        {
            this.lblErrorMessage.Text = "<p>" + ErrorMessage + "<p>";
        }
    }
}