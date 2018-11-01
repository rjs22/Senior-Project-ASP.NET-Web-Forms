using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SrProj_RSweit
{
    public partial class ProductDisplay : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // checking if user is logged in
            if (Session["ID"] != null)
            {
                btnCart.Visible = true;
                lblQty.Visible = true;
                txtQuantity.Visible = true;
            }
            else
                btnCart.Visible = false;
                ddlSize.Visible = false;

            // id sent from product page
            int id = Convert.ToInt32(Request.QueryString["Parameter"].ToString());
            
            // linq to sql for setting up product display from products chosen
            using (DBContextDataContext db = new DBContextDataContext())
            {
                // linq to sql query to find the product type of products that are of categoryID 2 (shirts)
                // this is used to ensure that the drop down list only appears with items that need
                // to choose the appropriate size
                var prodType = (from x in db.products where x.ProductID == id && x.ProductCategoryID == 2 select x).Any();
                
                // linq to sql query to get all products in inventory
                var qry = (from x in db.products where x.ProductID == id select x).FirstOrDefault();

                // makes the drop down list unavailable for users who are not logged in
                if(prodType == true && Session["ID"] == null)
                {
                    ddlSize.Visible = false;
                }
                // makes the drop down list available for users that are logged in
                else if (prodType == true && Session["ID"] != null)
                {
                    ddlSize.Visible = true;
                    imgProduct.ImageUrl = qry.ProductImage;
                    hdProdName.InnerText = qry.ProductName;
                    lblDesc.Text = qry.ProductLongDesc;
                }
                // sets the images, name and descriptions for non-logged in users
                // for sauces
                else
                {
                    imgProduct.ImageUrl = qry.ProductImage;
                    hdProdName.InnerText = qry.ProductName;
                    lblDesc.Text = qry.ProductLongDesc;
                }

            }
            
            // Used to load product information for shirts for non-logged in users
            using (DBContextDataContext db = new DBContextDataContext())
            {
                var qry = (from x in db.products where x.ProductID == id select x).FirstOrDefault();

                imgProduct.ImageUrl = qry.ProductImage;
                hdProdName.InnerText = qry.ProductName;
                lblDesc.Text = qry.ProductLongDesc;
            }
        }

        // button for users to add item to their cart
        protected void BtnCart_Click(object sender, EventArgs e)
        {
            if (Page.IsPostBack)    ///
            {                       /// Used to check for validation regardless if the user has javascprit
                Page.Validate();    /// turned on or off
                if (Page.IsValid)   ///
                {
                    // the sent id of the product from "Products.aspx"
                    int id = Convert.ToInt32(Request.QueryString["Parameter"].ToString());
                    
                    // linq to sql to capture current user and the product they are adding
                    using (DBContextDataContext db = new DBContextDataContext())
                    {
                        double price; // setting price variable to be used in context
                        // capturing current user
                        var usr = (from x in db.users where x.UserID.Equals(Session["ID"]) select x).FirstOrDefault();
                        // capturing product
                        var prod = (from x in db.products where x.ProductID == id select x).FirstOrDefault();

                        // code to add to the price if the size is a XX-Large or larger
                        if (Convert.ToInt32(ddlSize.SelectedValue) > 5)
                        {
                            price = prod.ProductPrice + 2;
                        }
                        else
                            price = prod.ProductPrice;

                        // submitting a new item in the current user cart
                        UserCart od = new UserCart
                        {
                            CartProductID = prod.ProductID,
                            CartUserID = Convert.ToInt32(Session["ID"]),
                            CartOptionID = Convert.ToInt32(ddlSize.SelectedValue),
                            CartName = prod.ProductName,
                            CartPrice = price,
                            CartQuantity = Convert.ToInt32(txtQuantity.Text)
                        };

                        // linq to sql actions to insert and submit database actions
                        db.UserCarts.InsertOnSubmit(od);
                        db.SubmitChanges();

                    }
                }
            }
            // once a user adds an item to thier cart, they are sent back to their customer page
            // to view their cart
            Response.Redirect("~/Customer.aspx");
        }
    }
}