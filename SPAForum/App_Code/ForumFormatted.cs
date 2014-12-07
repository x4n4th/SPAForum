using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SPAForum
{
    [Serializable]
    public class ForumFormatted
    {
        int id;
        string description, name, author_name, topic_name, post_date, gravatar;

        public ForumFormatted(int id, string description, string name, string author_name, string topic_name, string post_date, string gravatar) {
            this.id = id;
            this.gravatar = gravatar;
            this.description = description;
            this.name = name;
            this.author_name = author_name;
            this.topic_name = topic_name;
            this.post_date = post_date;
        }
    }
}