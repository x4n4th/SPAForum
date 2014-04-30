using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SPAForum
{
    [Serializable]
    public class TopicFormatted
    {
        int tid, replies, views;
        string formattedDate, title, description, starter_name;

        public TopicFormatted(int tid, int replies, int views, string title, string description, string starter_name, string formattedDate) {
            this.tid = tid;
            this.replies = replies;
            this.views = views;
            this.title = title;
            this.description = description;
            this.starter_name = starter_name;
            this.formattedDate = formattedDate;
        }
    }
}