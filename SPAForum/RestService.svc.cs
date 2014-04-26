using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Security.Cryptography;
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

                topic chosenTopic = entities.topics.Find(topicId);
               
                chosenTopic.views += 1;

                entities.SaveChanges();

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
        public forum[] getForums(int catId) {
            using (ist331Entities entities = new ist331Entities()) {
                var forums = from s in entities.forums.Where(x => x.catagorieId == catId) select s;
                return forums.ToArray();
            }
        }

        public catagory[] getCatagories() {
            using (ist331Entities entities = new ist331Entities()) {
                var catagories = from s in entities.catagories select s;
                return catagories.ToArray();
            }
        }

        /// <summary>
        /// Checks to see if the user is valid
        /// </summary>
        /// <param name="user">users name or login</param>
        /// <param name="password">password</param>
        /// <returns>session string if user is valid</returns>
        public string verifyUser(string user, string password) {
            using (ist331Entities entities = new ist331Entities()) {
                string hashedPassword = SHA1HashStringForUTF8String(password);
                var member = from s in entities.members
                                 .Where(x => x.name == user)
                                 .Where(x => x.password_hash == hashedPassword) 
                             select s;


                if (member.Count() == 1) {
                    Random rnd = new Random();

                    int sessionNumber = rnd.Next(0, 1000);
                    string sessionStr = SHA1HashStringForUTF8String(sessionNumber.ToString());

                    session dbSession = new session();

                    foreach(member mem in member){
                        dbSession.member_id = mem.id;
                    }

                    var sessions = from s in entities.sessions
                                 .Where(x => x.member_id == dbSession.member_id)
                                 select s;

                    foreach (session sesh in sessions) {
                        entities.sessions.Remove(sesh);
                    }

                    dbSession.date = DateTime.Now;
                    dbSession.session1 = sessionStr;

                    entities.sessions.Add(dbSession);
                    entities.SaveChanges();

                    return sessionStr;
                }
            }
            return "Not Valid";
        }

        /// <summary>
        /// Creates a new member
        /// </summary>
        /// <param name="name">the members name</param>
        /// <param name="password">the members password</param>
        /// <returns>returns if the member was created</returns>
        public bool createMember(string name, string password) {
            using (ist331Entities entities = new ist331Entities()) {
                try {
                    member mem = new member();
                    mem.joined = DateTime.Now;
                    mem.member_group_id = 1;
                    mem.name = name;
                    mem.password_hash = SHA1HashStringForUTF8String(password);

                    entities.members.Add(mem);
                    entities.SaveChanges();
                }
                catch {
                    return false;
                }
            }
            return true;
        }


        /// <summary>
        /// Compute hash for string encoded as UTF8
        /// </summary>
        /// <param name="s">String to be hashed</param>
        /// <returns>40-character hex string</returns>
        public string SHA1HashStringForUTF8String(string s)
        {
            byte[] bytes = Encoding.UTF8.GetBytes(s);
 
            var sha1 = SHA1.Create();
            byte[] hashBytes = sha1.ComputeHash(bytes);
 
            return HexStringFromBytes(hashBytes);
        }
 
        /// <summary>
        /// Convert an array of bytes to a string of hex digits
        /// </summary>
        /// <param name="bytes">array of bytes</param>
        /// <returns>String of hex digits</returns>
        public string HexStringFromBytes(byte[] bytes)
        {
            var sb = new StringBuilder();
            foreach (byte b in bytes)
            {
                var hex = b.ToString("x2");
                sb.Append(hex);
            }
            return sb.ToString();
        }
    }
}
