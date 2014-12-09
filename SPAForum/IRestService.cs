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
        PostFormatted[] getPosts(int topicId);

        /// <summary>
        /// Given a forum id returns a array of topics
        /// </summary>
        /// <param name="forumId"></param>
        /// <returns></returns>
        [WebGet(UriTemplate = "/getTopics?forum={forumId}&page={page}&pageSize={pageSize}",
            ResponseFormat = WebMessageFormat.Json)]
        [OperationContract]
        TopicPage getTopics(int forumId, int page, int pageSize);


        /// <summary>
        /// Returns Forums listed on the server.
        /// </summary>
        /// <returns></returns>
        [WebGet(UriTemplate = "/getForums?catId={catId}",
            ResponseFormat = WebMessageFormat.Json)]
        [OperationContract]
        ForumFormatted[] getForums(int catId);

        /// <summary>
        /// Posts a post to a certain topic
        /// </summary>
        /// <param name="sessionId"></param>
        /// <param name="name"></param>
        /// <param name="topicId"></param>
        /// <param name="postStr"></param>
        /// <returns></returns>
        [WebGet(UriTemplate = "/post?session={sessionId}&name={name}&topic={topicId}&post={postStr}",
            ResponseFormat = WebMessageFormat.Json)]
        [OperationContract]
        bool postToTopic(string sessionId, string name, int topicId, string postStr);
        
        /// <summary>
        /// Create a new topic and the first post for the topic
        /// </summary>
        /// <param name="sessionId"></param>
        /// <param name="name"></param>
        /// <param name="forumId"></param>
        /// <param name="title"></param>
        /// <param name="description"></param>
        /// <param name="post"></param>
        /// <returns>If the topic was created properly</returns>
        [WebGet(UriTemplate = "/postTopic?session={sessionId}&name={name}&topic={forumId}&title={title}&desc={description}&post={post}",
            ResponseFormat = WebMessageFormat.Json)]
        [OperationContract]
        bool postTopic(string sessionId, string name, int forumId, string title, string description, string post);

        /// <summary>
        /// Get all catagories
        /// </summary>
        /// <returns></returns>
        [WebGet(UriTemplate = "/getCatagories",
            ResponseFormat = WebMessageFormat.Json)]
        [OperationContract]
        CatagoryFormatted[] getCatagories();

        /// <summary>
        /// Verifies the user
        /// </summary>
        /// <param name="userName">the user name</param>
        /// <param name="password">password</param>
        /// <returns>true if user is valid else false</returns>
        [WebGet(UriTemplate = "/verify?user={userName}&password={password}",
            ResponseFormat = WebMessageFormat.Json)]
        [OperationContract]
        string verifyUser(string userName, string password);

        /// <summary>
        /// Creates a member with a user name and password
        /// </summary>
        /// <param name="userName">user name</param>
        /// <param name="password">password</param>
        /// <returns>returns if the user was successfully created</returns>
        [WebGet(UriTemplate = "/createMember?user={userName}&password={password}",
            ResponseFormat = WebMessageFormat.Json)]
        [OperationContract]
        bool createMember(string userName, string password);

        /// <summary>
        /// Loges the user out by removeing session key
        /// </summary>
        /// <param name="sessionId"></param>
        /// <param name="name"></param>
        /// <returns>if the logout was successfull</returns>
        [WebGet(UriTemplate = "/logout?session={sessionId}&name={name}",
            ResponseFormat = WebMessageFormat.Json)]
        [OperationContract]
        bool logout(string sessionId, string name);

        /// <summary>
        /// Resgisters a new username
        /// </summary>
        /// <param name="username"></param>
        /// <param name="email"></param>
        /// <param name="rawPassword"></param>
        /// <returns>if the username was create successfully.</returns>
        [WebGet(UriTemplate = "/register?name={username}&email={email}&password={rawPassword}",
            ResponseFormat = WebMessageFormat.Json)]
        [OperationContract]
        bool register(string username, string email, string rawPassword);


        /// <summary>
        /// The watch dog. Returns if the forums or topics need to reloaded
        /// </summary>
        /// <param name="forumId">The id of the forum</param>
        /// <param name="topicId">the id of the topic</param>
        /// <returns>If the posts need to be reloaded</returns>
        [WebGet(UriTemplate = "/watchdog?forum={fId}&topic={tid}",
            ResponseFormat = WebMessageFormat.Json)]
        [OperationContract]
        bool watchDog(int fId, int tid);

        /// <summary>
        /// Returns a list of promoted events
        /// </summary>
        /// <returns>A List of promoted events in json</returns>
        [WebGet(UriTemplate = "/promotedEvents",
            ResponseFormat = WebMessageFormat.Json)]
        [OperationContract]

        EventFormatted[] getPromotionEvents();

        /// <summary>
        /// Registers a user with an event.
        /// </summary>
        /// <param name="username"></param>
        /// <param name="email"></param>
        /// <param name="rawPassword"></param>
        /// <returns>if the username was create successfully.</returns>
        /// //registerEvent?session=" + session + "&user=" + user + "&event=" + event.id;
        [WebGet(UriTemplate = "/registerEvent?session={session}&user={user}&event={eventId}",
            ResponseFormat = WebMessageFormat.Json)]
        [OperationContract]
        bool registerEvent(string session, string user, int eventId);

        /// <summary>
        /// Registered for event?
        /// </summary>
        /// <param name="username"></param>
        /// <param name="email"></param>
        /// <param name="rawPassword"></param>
        /// <returns>if the username was create successfully.</returns>
        /// "/checkRegisterEvent?user={user}&event={eventId}",
        [WebGet(UriTemplate = "/checkRegisterEvent?user={user}&event={eventId}",
            ResponseFormat = WebMessageFormat.Json)]
        [OperationContract]
        bool checkRegisterEvent(string user, int eventId);

        /// <summary>
        /// Registered for event?
        /// </summary>
        /// <param name="username"></param>
        /// <param name="email"></param>
        /// <param name="rawPassword"></param>
        /// <returns>if the username was create successfully.</returns>
        /// "/checkRegisterEvent?user={user}&event={eventId}",
        [WebGet(UriTemplate = "/eventsRegisteredFor?user={user}",
            ResponseFormat = WebMessageFormat.Json)]
        [OperationContract]
        EventFormatted[] eventsRegisteredFor(string user);
    }
}
