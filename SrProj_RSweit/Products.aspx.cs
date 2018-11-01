using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SrProj_RSweit
{
    public partial class Products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // if its not a postback then load products
            if (!Page.IsPostBack)
            {
                listview1.DataSource = GetProductRecord();  // set datasource for listview
                listview1.DataBind();                       // bind data to list view
            }
        }

        // method to get list of all products using linq to sql
        public List<product> GetProductRecord()
        {
            DBContextDataContext db = new DBContextDataContext();
            var listProductRecord = (from x in db.products select x).ToList<product>();
            return listProductRecord;
        }
        
        // this captures the id of the item chosen and sent to productdisplay
        protected void listview1_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            Response.Redirect("ProductDisplay.aspx?Parameter=" + id);
        }
    }
}