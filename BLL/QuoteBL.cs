using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;
using BO;
namespace BLL
{
    public class QuoteBL
    {

        //Quotes DAccess object
        QuoteDA quoteDb = null;

        public QuoteBL()
        {
            quoteDb = new QuoteDA();
        }
        // This fuction does not contain any business logic, it simply add the quoet
       public bool AddNewQuote(Quotes quote)
        {
           return quoteDb.AddNewQuote(quote);
        }

    }

   
}
