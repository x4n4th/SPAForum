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


        /// <summary>
        /// Returns Forums listed on the server.
        /// </summary>
        /// <returns></returns>
        [WebGet(UriTemplate = "/getForums",
            ResponseFormat = WebMessageFormat.Json)]
        [OperationContract]
        forum[] getForums();

        /// <summary>
        /// Verifies the user
        /// </summary>
        /// <param name="userName">the user name</param>
        /// <param name="password">password</param>
        /// <returns>true if user is valid else false</returns>
        [WebGet(UriTemplate = "/verify?user={userName}&password={password}",
            ResponseFormat = WebMessageFormat.Json)]
        [OperationContract]
        bool verifyUser(string userName, string password);

        /// <summary>
        /// Creates a member with a user name and password
        /// </summary>
        /// <param name="userName">user name</param>
        /// <param name="password">password</param>
        /// <returns>returns if the user was successfully created</returns>
        [WebGet(UriTemplate = "/createMember?user={userName}&email={email}&password={password}",
            ResponseFormat = WebMessageFormat.Json)]
        [OperationContract]
        bool createMember(string userName, string email, string password);
    }
}
