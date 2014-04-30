using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SPAForum
{
    [Serializable]
    public class ForumFormatted
    {
        forum forumEntity;
        string postDate;
        post latestPost;

        public ForumFormatted(forum forumEntity, string postDate, post latestPost) {
            this.forumEntity = forumEntity;
            this.postDate = postDate;
            this.latestPost = latestPost;
        }
    }
}