using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BO
{
    public class Quotes
    {
        int quoteID;
        string author;          //  should be (50)   chars only
        string quote;           //  should be (100)  chars only
        string moodOrEmotion;   //  should be (20)   chars only
        string quoteSource;     //  should be (50)   chars only
        string userID;           //  should be (50)   chars only
        string userInputA;
        string userInputB;
        string userInputC;

        public int QuoteID {
            get {
                return quoteID;
            }
            set {
                quoteID = value;
            }
        }

        public string Author {
            get {
                return author;
            }
            set {
                author = value;
            }
        }

        public string Quote
        {
            get
            {
                return quote;
            }
            set
            {
                quote = value;
            }
        }

        public string MoodOrEmotion
        {
            get
            {
                return moodOrEmotion;
            }
            set
            {
                moodOrEmotion = value;
            }
        }

        public string QuoteSource
        {
            get
            {
                return quoteSource;
            }
            set
            {
                quoteSource = value;
            }
        }

        public string UserID {
            get {
                return userID;
            }
            set {
                userID = value;
            }
        }

        public string UserInputA
        {
            get;set;
        }

        public string UserInputB
        {
            get;
            set;
        }
        public string UserInputC
        {
            get;
            set;
        }
        public override string ToString()
        {
            return ExtensionMethods.CapitalizeFirstAndLastCharOfString(UserInputA);
        }

    }

    public static class ExtensionMethods
    {
        public static string CapitalizeFirstAndLastCharOfString(this string word)
        {
            string Output = "";
            string[] inputWords = word.Split(" ".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
            foreach (string wd in inputWords)
            {
                char[] a = wd.ToCharArray();
                a[0] = char.ToUpper(a[0]);
                a[a.Length - 1] = char.ToUpper(a[a.Length - 1]);
                Output += new string(a) + " ";
            }
            return Output;
        }

    }
}
