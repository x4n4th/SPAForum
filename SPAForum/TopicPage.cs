using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SPAForum
{
    [Serializable]
    public class TopicPage
    {
        List<TopicFormatted> topicArray;
        int pageCount;
        int page;

        public TopicPage(List<TopicFormatted> topicArray, int pageCount, int page) {
            this.topicArray = topicArray;
            this.pageCount = pageCount;
            this.page = page;
        }
    }
}