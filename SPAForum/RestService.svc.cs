using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
 
namespace SPAForum
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "RestService" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select RestService.svc or RestService.svc.cs at the Solution Explorer and start debugging.
    public class RestService : IRestService
    {
        /// <summary>
        /// Gets posts given a certain topic
        /// </summary>
        /// <param name="topicId">int topic number</param>
        /// <returns>array of posts</returns>
        public post[] getPosts(int topicId){
            using(ist331Entities entities = new ist331Entities()){
                var posts = from s in entities.posts.Where(x=>x.topic_id == topicId) select s;
                return posts.ToArray();
            }
        }

        /// <summary>
        /// Gets Topics given a forumid
        /// </summary>
        /// <param name="forumId">forum id</param>
        /// <returns>an array of topics</returns>
        public topic[] getTopics(int forumId) {
            using (ist331Entities entities = new ist331Entities()) {
                var topics = from s in entities.topics.Where(x => x.forum_id == forumId) select s;
                return topics.ToArray();
            }
        }

        /// <summary>
        /// Gets a list of forums
        /// </summary>
        /// <returns>returns a list containing all forums</returns>
        public forum[] getForums() {
            using (ist331Entities entities = new ist331Entities()) {
                var forums = from s in entities.forums select s;
                return forums.ToArray();
            }
        }
    }
}
