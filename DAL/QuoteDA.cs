using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using BO;

namespace DAL
{
    public class QuoteDA
    {
        public bool AddNewQuote(Quotes quote)
        {
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@AuthorName", quote.QuoteSource),
                new SqlParameter("@Quote",quote.Quote),
                new SqlParameter("@MoodOrEmotion",quote.MoodOrEmotion),
                new SqlParameter("@QuoteSource",quote.QuoteSource),
                new SqlParameter("@AddedBy",quote.UserID),
            };

            return SqlDBHelper.ExecuteNonQuery("usp_AddNewQuote", CommandType.StoredProcedure, parameters);
 
        }

        public bool UpdateQuote(Quotes quote)
        {
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@AuthorName", quote.QuoteSource),
                new SqlParameter("@Quote",quote.Quote),
                new SqlParameter("@MoodOrEmotion",quote.MoodOrEmotion),
                new SqlParameter("@QuoteSource",quote.QuoteSource),
                new SqlParameter("@AddedBy",quote.UserID),
            };

            return SqlDBHelper.ExecuteNonQuery("usp_UpdateQuote", CommandType.StoredProcedure, parameters);

        }

        public bool DeleteQuote(int quoteID)
        {
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@QuoteID", quoteID)
            };

            return SqlDBHelper.ExecuteNonQuery("usp_DeleteQuote", CommandType.StoredProcedure, parameters);
        }
    }
}
