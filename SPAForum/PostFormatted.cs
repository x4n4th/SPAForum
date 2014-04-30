using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SPAForum
{
    [Serializable]
    public class PostFormatted
    {
        int id;
        string author_name, formattedDate, postBody;

        public PostFormatted(int id, string author_name, string postBody, string formattedDate) {
            this.author_name = author_name;
            this.id = id;
            this.postBody = postBody;
            this.formattedDate = formattedDate;
        }
    }
}