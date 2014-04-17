using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace SPAForum
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IRestService" in both code and config file together.
    [ServiceContract]
    public interface IRestService
    {
        /// <summary>
        ///  Given a topic id it returns array of posts
        /// </summary>
        /// <param name="topicId"></param>
        /// <returns></returns>
        [WebGet(UriTemplate = "/getPosts?topic={topicId}",
            ResponseFormat = WebMessageFormat.Json)]
        [OperationContract]
        post[] getPosts(int topicId);

        /// <summary>
        /// Given a forum id returns a array of topics
        /// </summary>
        /// <param name="forumId"></param>
        /// <returns></returns>
        [WebGet(UriTemplate = "/getTopics?topic={forumId}",
            ResponseFormat = WebMessageFormat.Json)]
        [OperationContract]
        topic[] getTopics(int forumId);
    }
}
