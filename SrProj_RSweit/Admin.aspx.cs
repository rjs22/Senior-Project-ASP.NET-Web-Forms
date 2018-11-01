using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SrProj_RSweit
{
    public partial class Admin : System.Web.UI.Page
    {
        // Global variables for image uploads and submissions
        private string thmbFileName, imgFileName;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                // if user is not an admin, then they will get kicked back to the login page
                if (Session["Admin"] == null || Session["Admin"].Equals(false))
                {
                    Response.Redirect("Login.aspx");
                }
            }
            catch
            {
                this.ShowError("You Are Not an Admin!");
                return;
            }
        }

        // Button to bring up details of specified order, uses orderID
        protected void btnDetail_Click(object sender, EventArgs e)
        {
            this.ShowError("");
            try
            {
                using (DBContextDataContext db = new DBContextDataContext())
                {
                    var load = (from x in db.UserCarts
                                join y in db.options
                                on x.CartOptionID
                                equals y.OptionID
                                where x.CartOrderID == Convert.ToInt32(txtOrderDetail.Text)
                                select new
                                {
                                    x.CartOrderID,
                                    x.CartUserID,
                                    x.CartName,
                                    y.OptionName,
                                    x.CartQuantity
                                }).ToList();

                    gvOrderDetail.DataSource = load;
                    gvOrderDetail.DataBind();
                }
            }
            catch
            {
                this.ShowError("Invalid Order Number. Enter valid order number");
                return;
            }
        }

        // Button for Product upload. add button will submit all data to the database as well as upload
        // images to the appropriate folders
        protected void BtnAdd_Click(object sender, EventArgs e)
        {
            // sets file upload objects equal to controls in gridview
            FileUpload thmbUp = (ProductGridView.FooterRow.FindControl("NewThmbUp") as FileUpload);
            FileUpload imgUp = (ProductGridView.FooterRow.FindControl("NewImgUp") as FileUpload);
            
            // if the thumbnail uploaded has a file then it will save the file to the folder
            // and into the specific directory
            if (thmbUp.HasFile)
            {
                thmbFileName = Path.GetFileName(thmbUp.PostedFile.FileName);
                thmbUp.PostedFile.SaveAs(Server.MapPath("~/Media/ProdThmb/") + thmbFileName);
            }

            // if the image uploaded has a file then it will save the file to the folder
            // and into the specific directory
            if (imgUp.HasFile)
            {
                imgFileName = Path.GetFileName(imgUp.PostedFile.FileName);
                imgUp.PostedFile.SaveAs(Server.MapPath("~/Media/ProdImg/") + imgFileName);
            }
            
            // setting all gridview controls to variables so insertion into the product table is simpler
            int id = Convert.ToInt32((ProductGridView.FooterRow.FindControl("NewID") as TextBox).Text);
            string name = (ProductGridView.FooterRow.FindControl("NewName") as TextBox).Text;
            double price = Convert.ToDouble((ProductGridView.FooterRow.FindControl("NewPrice") as TextBox).Text);
            double weight = Convert.ToDouble((ProductGridView.FooterRow.FindControl("NewWeight") as TextBox).Text);
            string cartDesc = (ProductGridView.FooterRow.FindControl("NewCartDesc") as TextBox).Text;
            string shortDesc = (ProductGridView.FooterRow.FindControl("NewShortDesc") as TextBox).Text;
            string longDesc = (ProductGridView.FooterRow.FindControl("NewLongDesc") as TextBox).Text;
            string heat = (ProductGridView.FooterRow.FindControl("HeatDropdown") as DropDownList).SelectedValue;
            int category = Convert.ToInt32((ProductGridView.FooterRow.FindControl("CategoryDropdown") as DropDownList).SelectedValue);
            double inStock = Convert.ToDouble((ProductGridView.FooterRow.FindControl("NewInStock") as TextBox).Text);

            // linq to sql for product insertion
            using (DBContextDataContext db = new DBContextDataContext())
            {
                product prod = new product
                {
                    ProductID = id, ProductName = name, ProductPrice = price, ProductWeight = weight,
                    ProductCartDesc = cartDesc, ProductShortDesc = shortDesc, ProductLongDesc = longDesc,
                    ProductThumb = "/Media/ProdThmb/" + thmbFileName, ProductImage = "/Media/ProdImg/" + imgFileName,
                    ProductHeat = heat, ProductCategoryID = category, ProductStock = inStock, ProductLive = false
                };
                
                db.products.InsertOnSubmit(prod);
                db.SubmitChanges();
            }
            // must bind data to update gridview
            ProductGridView.DataBind();
        }

        // error handling
        void ShowError(string ErrorMessage)
        {
            this.lblErrorMessage.Text = "<p>" + ErrorMessage + "<p>";
        }

    }
}