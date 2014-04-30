using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SPAForum
{
    [Serializable]
    public class PostFormatted
    {
        post postEntity;
        string formattedDate;

        public PostFormatted(post postEntity, string formattedDate) {
            this.postEntity = postEntity;
            this.formattedDate = formattedDate;
        }
    }
}