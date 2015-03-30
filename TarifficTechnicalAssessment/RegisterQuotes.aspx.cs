using System;
using System.Threading;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using BO;
using DAL;
using TarifficTechnicalAssessment;

namespace TarifficTechnicalAssessment
{
    public partial class RegisterQuotes : System.Web.UI.Page
    {
        Quotes quote = new Quotes();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                grvCountsPerMood.DataBind();
                grdSearch.DataBind();
                btnCancel_Click(e, null);
                Session.Add("UserID", User.Identity.Name.ToString());
                quote.UserInputA = "Testring 1, 2";

                Thread stFirstThrd = new Thread(new ThreadStart(MultiThreadsDemonstration));
                Thread stSecThrd = new Thread(new ThreadStart(MultiThreadsDemonstration));
                Thread stThirdThrd = new Thread(new ThreadStart(MultiThreadsDemonstration));

                stFirstThrd.Start();
                stSecThrd.Start();
                stThirdThrd.Start();
                
                          
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            quote.Author = txtAuthor.Text;
            quote.Quote = txtQuote.Text;
            quote.MoodOrEmotion = txtMoodOrEmotion.Text;
            quote.QuoteSource = txtQuoteSource.Text;
            quote.UserID = "LuckyK";

            QuoteBL quo = new QuoteBL();
            if (quo.AddNewQuote(quote) == true)
            {
                txtAuthor.Text = "";
                txtQuote.Text = "";
                txtMoodOrEmotion.Text = "";
                txtQuoteSource.Text = "";
                lblMessage.Visible = true;
                lblMessage.Text = "Your quote saved successful.";
            }
            lblProcessedQuote.Visible = false;
            lblValue.Text = "";

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
        }

        public void MultiThreadsDemonstration()
        {
            txtDemonstration.Text =  quote.ToString();
        }

        protected void txtQuote_TextChanged(object sender, EventArgs e)
        {
            if (txtQuote.Text != "")
            {
                quote.UserInputA = txtQuote.Text;
                lblProcessedQuote.Visible = true;
                lblValue.Visible = true;
                lblValue.Text = quote.ToString();
            }
            else {
                lblProcessedQuote.Visible = false;
                lblValue.Text = "";
            }
        }

        protected void btnPost_Click(object sender, EventArgs e)
        {
            SocialMedia sm = new SocialMedia();
            sm.StatusUpdate("Wow, I like it hey");

        }
    }
 }