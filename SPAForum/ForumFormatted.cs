﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SPAForum
{
    [Serializable]
    public class ForumFormatted
    {
        int id;
        string /*postDate,*/ description, name;
        //post latestPost;

        public ForumFormatted(int id, string description, string name) {
            this.id = id;
            this.description = description;
            this.name = name;
        }
    }
}