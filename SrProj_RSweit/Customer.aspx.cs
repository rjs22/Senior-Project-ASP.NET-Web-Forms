using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SrProj_RSweit
{
    public partial class Customer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //User shouldn't be on this page if they are not logged in
            if(Session["ID"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }

            // Sets error if there is one
            if (Request.QueryString["Parameter"] != null)
            {
                string err = Request.QueryString["Parameter"];
                this.ShowError(err);
            }
            // loading current user's cart and user infomration
            if (!Page.IsPostBack)
            {
                CartLoad();
                UsrLoad();
            }
        }

        // Submit button for users to update their information
        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsPostBack)    ///
            {                       /// Block used to check for validation reguardless if they have
                Page.Validate();    /// Javascript enabled or not
                if (Page.IsValid)   ///
                {
                    using (DBContextDataContext db = new DBContextDataContext())
                    {
                        var qry = (from c in db.users where c.UserID.Equals(Session["ID"]) select c).FirstOrDefault();

                        qry.UserFirstName = txtFname.Text;
                        qry.UserLastName = txtLname.Text;
                        qry.UserAddress1 = txtAddressLnOne.Text;
                        qry.UserAddress2 = txtAddressLnTwo.Text;
                        qry.UserCity = txtCity.Text;
                        qry.UserState = txtState.Text;
                        qry.UserZip = txtZip.Text;
                        qry.UserPhone = txtPhone.Text;

                        db.SubmitChanges();
                    }
                }
            }


        }

        // Simple clear button to set all textboxes to blank but not null
        protected void BtnClear_Click(object sender, EventArgs e)
        {
            if (!IsPostBack)
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

        // function for the delete button to work in user carts
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

        // function to the update button located in each row of the user cart.
        protected void gvCart_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            using (DBContextDataContext db = new DBContextDataContext())
            {
                HiddenField hfID = (HiddenField)gvCart.Rows[e.RowIndex].FindControl("hfID");
                var update = (from x in db.UserCarts where x.CartID == Convert.ToInt32(hfID.Value) select x).ToList();

                foreach (var qty in update)
                {
                    qty.CartQuantity = Convert.ToInt32(((TextBox)gvCart.Rows[e.RowIndex].FindControl("txtQuantity")).Text);
                    db.SubmitChanges();
                }
                CartLoad();
            }
        }

        // method to load user cart by their ID, also sets the subtotal of their order in this instance
        private void CartLoad()
        {
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

            // sets the subtotal of all items in current users cart
            using (DBContextDataContext db = new DBContextDataContext())
            {
                var load = (from x in db.UserCarts
                            where x.CartOrderID == null && x.CartUserID.Equals(Session["ID"])
                            group x by 1 into g
                            select new
                            {
                                total = g.Sum(x => x.CartPrice * x.CartQuantity)
                            }).FirstOrDefault();
                if (load == null)
                {
                    btnCheckOut.Visible = false;
                    lblSub.Text = "SubTotal: $0.00";
                }
                else
                {
                    lblSub.Text = "SubTotal: $" + Convert.ToString(load.total) + ".00";
                }
            }
        }

        // Method used to load the user infomation in the database to the customer page
        // so they know what is current
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

        // check out button function
        protected void btnCheckOut_Click(object sender, EventArgs e)
        {
            // used to check the database to see if they have an open order, if it is then they are not
            // not allowed to generate another order until the first one has shipped
            using (DBContextDataContext db = new DBContextDataContext())
            {
                var orderCheck = (from x in db.orders where x.OrderShipped == false select x).Any();

                if (orderCheck == true)
                {
                    string err = "Please allow us to process your first order before making another one";
                    Response.Redirect("Customer.aspx?Parameter=" + err);
                    Response.Redirect("~/Customer.aspx");
                }
            }

            // functions to set the shipping rates, orders can range from 1 - 28 items for now.
            // if the order exceeds 28, the user is given an error and is rejected from continuing.
            if (FindQty() < 4)
            {
                Session["shipping"] = 7.17;
                Response.Redirect("~/Checkout.aspx");
            }
            else if (FindQty() < 12 && FindQty() > 3)
            {
                Session["shipping"] = 13.60;
                Response.Redirect("~/Checkout.aspx");
            }
            else if (FindQty() > 13 && FindQty() < 28)
            {
                Session["shipping"] = 18.85;
                Response.Redirect("~/Checkout.aspx");
            }
            else if (FindQty() > 28)
            {
                string err = "Orders cannot exceed 28 items at this time";
                Response.Redirect("Customer.aspx?Parameter=" + err);
                Response.Redirect("~/Customer.aspx");
            }
        }

        // method that returns total quantity in current user cart
        private int FindQty()
        {
            using (DBContextDataContext db = new DBContextDataContext())
            {
                var totalQty = (from x in db.UserCarts
                                where x.CartOrderID == null && x.CartUserID.Equals(Session["ID"])
                                group x by 1 into g
                                select new
                                {
                                    qty = g.Sum(x => x.CartQuantity)
                                }).FirstOrDefault();

                return totalQty.qty;
            }

        }

        // method to set error message if there is an error that occurs
        void ShowError(string ErrorMessage)
        {
            this.lblErrorMessage.Text = ErrorMessage + "<p>";
        }
    }
}