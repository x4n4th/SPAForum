using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SPAForum
{
    [Serializable]
    public class TopicFormatted
    {
        topic topicEntity;
        string formattedDate;

        public TopicFormatted(topic topicEntity, string formattedDate) {
            this.topicEntity = topicEntity;
            this.formattedDate = formattedDate;
        }
    }
}