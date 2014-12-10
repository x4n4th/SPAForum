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
        public PostFormatted[] getPosts(int topicId){
            using (IST421Entities entities = new IST421Entities())
            {
                var posts = from s in entities.posts.Where(x=>x.topic_id == topicId) select s;

                topic chosenTopic = entities.topics.Find(topicId);
               
                chosenTopic.views += 1;

                entities.SaveChanges();

                List<PostFormatted> postArray = new List<PostFormatted>();

                foreach(post p in posts){
                    postArray.Add(new PostFormatted(p.pid, p.author_name, p.post1, p.post_date.ToString("g")));
                }

                return postArray.ToArray();
            }
        }

        /// <summary>
        /// Gets Topics given a forumid
        /// </summary>
        /// <param name="forumId">forum id</param>
        /// <returns>an array of topics</returns>
        public TopicPage getTopics(int forumId, int page, int pageSize) {
            using (IST421Entities entities = new IST421Entities())
            {
                var topics = from s in entities.topics
                                 .Where(x => x.forum_id == forumId)
                                 .OrderByDescending(x => x.start_date)
                             select s;
                List<TopicFormatted> topicArray = new List<TopicFormatted>();

                foreach (topic t in topics) {
                    topicArray.Add(new TopicFormatted(t.tid, t.replies, t.views, t.title, t.description, t.starter_name, t.start_date.ToString("g")));
                }

                List<TopicFormatted> returnArray = new List<TopicFormatted>();

                int amountOfPages = (int)Math.Ceiling((decimal)(topicArray.Count() / (decimal)pageSize));

                for(int i = ((page - 1) * pageSize); i < (page * pageSize); i++){
                    if (topicArray.Count() > i) {
                        returnArray.Add(topicArray.ToArray()[i]);
                    }
                }

                TopicPage topicPage = new TopicPage(returnArray, amountOfPages, page);

                return topicPage;
            }
        }
        /// <summary>
        /// Gets a list of forums
        /// </summary>
        /// <param name="catId">A Catagory Id</param>
        /// <returns>returns a list containing forums for a catagory</returns>
        public ForumFormatted[] getForums(int catId) {
            using (IST421Entities entities = new IST421Entities())
            {
                try {
                    var forums = from s in entities.forums.Where(x => x.catagorieId == catId) select s;

                    List<ForumFormatted> forumArray = new List<ForumFormatted>();

                    foreach (forum f in forums) {

                        var topics = from s in entities.topics.Where(x => x.forum_id == f.id) select s;

                        post p = new post();

                        foreach (topic t in topics) {
                            post tempPost = entities.posts.Where(x => x.topic_id == t.tid).OrderByDescending(x => x.post_date).FirstOrDefault();
                            if (tempPost.post_date.CompareTo(p.post_date) == 1) {
                                p = tempPost;
                            }
                        }

                        forumArray.Add(new ForumFormatted(f.id, f.description, f.name, p.member.name, p.topic.title, p.post_date.ToString("g"), MD5HashStringForUTF8String(p.member.email)));
                    }

                    return forumArray.ToArray();
                }
                catch (Exception ex) {
                    Console.WriteLine(ex.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// Gets a list of all catagories
        /// </summary>
        /// <returns>catagory list</returns>
        public CatagoryFormatted[] getCatagories() {
            using (IST421Entities entities = new IST421Entities())
            {
                var catagories = from s in entities.catagories select s;

                List<CatagoryFormatted> catList = new List<CatagoryFormatted>();

                foreach (catagory cat in catagories) {
                    catList.Add(new CatagoryFormatted(cat.id, cat.name));
                }

                return catList.ToArray();
            }
        }

        /// <summary>
        /// The watch dog. Returns if the forums or topics need to reloaded
        /// </summary>
        /// <param name="forumId">The id of the forum</param>
        /// <param name="topicId">the id of the topic</param>
        /// <returns>If the posts need to be reloaded</returns>
        public bool watchDog(int forumId, int topicId){
            using (IST421Entities entities = new IST421Entities())
            {
                DateTime date = DateTime.Now.Subtract(TimeSpan.FromSeconds(3));

                if (topicId != -1) {
                    var posts = from s in entities.posts.Where(x => x.topic_id == topicId && x.post_date > date) select s;

                    if (posts.Count() > 0) {
                        return true;
                    }
                }


                if (forumId != -1) {
                    var topics = from s in entities.topics.Where(x => x.forum_id == forumId && x.start_date > date) select s;

                    if (topics.Count() > 0) {
                        return true;
                    }
                }

                return false;
            }
        }

        /// <summary>
        /// Removes users session id to log them out
        /// </summary>
        /// <param name="sessionId"></param>
        /// <param name="name"></param>
        /// <returns>returns if logout was successful</returns>
        public bool logout(string sessionId, string name) {
            using (IST421Entities entities = new IST421Entities())
            {
                var members = entities.members.Where(x => x.name == name);
                member suppliedMember = null;

                foreach (member mem in members) {
                    suppliedMember = mem;
                }
                
                if(suppliedMember != null){
                    var sessions = entities.sessions
                        .Where(x => x.session1 == sessionId)
                        .Where(x => x.member_id == suppliedMember.id);

                    session sesh = null;
                    foreach (session s in sessions) {
                        sesh = s;
                    }

                    if (sessions.Count() > 0 && sesh != null) {
                        entities.sessions.Remove(sesh);
                        entities.SaveChanges();
                        return true;
                    }
                }
                return false;
            }
        }

        /// <summary>
        /// Post to a topic
        /// </summary>
        /// <param name="sessionId">Users session</param>
        /// <param name="name">users name</param>
        /// <param name="topicId">the topic</param>
        /// <param name="postStr">The post</param>
        /// <returns>if the post was successful</returns>
        public bool postToTopic(string sessionId, string name, int topicId, string postStr){
            using (IST421Entities entities = new IST421Entities())
            {
                var members = entities.members.Where(x => x.name == name);
                member suppliedMember = null;

                foreach (member mem in members) {
                    suppliedMember = mem;
                }
                
                if(suppliedMember != null){
                    var sessions = entities.sessions
                        .Where(x => x.session1 == sessionId && x.member_id == suppliedMember.id);

                    if (sessions.Count() > 0) {

                        post newPost = new post();

                        newPost.author_name = name;
                        newPost.author_id = suppliedMember.id;
                        newPost.post_date = DateTime.Now;
                        newPost.post1 = postStr;
                        newPost.topic_id = topicId;

                        entities.posts.Add(newPost);

                        topic chosenTopic = entities.topics.Find(topicId);
                        chosenTopic.replies += 1;

                        entities.SaveChanges();

                        return true;
                    }
                }

                return false;
            }
        }

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
        public bool postTopic(string sessionId, string name, int forumId, string title, string description, string post) {
            using (IST421Entities entities = new IST421Entities())
            {
                var members = entities.members.Where(x => x.name == name);
                member suppliedMember = null;

                foreach (member mem in members) {
                    suppliedMember = mem;
                }

                if (suppliedMember != null) {
                    var sessions = entities.sessions
                        .Where(x => x.session1 == sessionId && x.member_id == suppliedMember.id);

                    if (sessions.Count() > 0) {

                        topic newTopic = new topic();

                        newTopic.replies = 0;
                        newTopic.start_date = DateTime.Now;
                        newTopic.forum_id = forumId;
                        newTopic.starter_id = suppliedMember.id;
                        newTopic.starter_name = name;
                        newTopic.title = title;
                        newTopic.views = 0;
                        newTopic.description = description;
                        newTopic.state = "open";

                        entities.topics.Add(newTopic);

                        entities.SaveChanges();


                        post newPost = new post();
                        newPost.author_name = name;
                        newPost.author_id = suppliedMember.id;
                        newPost.post_date = DateTime.Now;
                        newPost.post1 = post;
                        newPost.topic_id = newTopic.tid;

                        entities.posts.Add(newPost);

                        entities.SaveChanges();

                        return true;
                    }
                }

                return false;
            }
        }

        /// <summary>
        /// Checks to see if the user is valid
        /// </summary>
        /// <param name="user">users name or login</param>
        /// <param name="password">password</param>
        /// <returns>session string if user is valid</returns>
        public string verifyUser(string user, string password) {
            using (IST421Entities entities = new IST421Entities())
            {
                string hashedPassword = SHA1HashStringForUTF8String(password);
                var member = from s in entities.members
                                 .Where(x => x.password_hash == hashedPassword && x.name == user) 
                             select s;


                if (member.Count() >= 1) {
                    Random rnd = new Random();

                    int sessionNumber = rnd.Next(0, 999999999);
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
            using (IST421Entities entities = new IST421Entities())
            {
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
        /// Registers a new user 
        /// </summary>
        /// <param name="username"></param>
        /// <param name="email"></param>
        /// <param name="rawPassword"></param>
        /// <returns>returns if the user was registered</returns>
        public bool register(string username, string email, string rawPassword) {
            using (IST421Entities entities = new IST421Entities())
            {
                try {
                    member newMember = new member();

                    newMember.email = email;
                    newMember.banned = 0;
                    newMember.joined = DateTime.Now;
                    newMember.member_group_id = 0;
                    newMember.name = username;
                    newMember.password_hash = SHA1HashStringForUTF8String(rawPassword);

                    entities.members.Add(newMember);
                    entities.SaveChanges();
                    return true;
                }
                catch {
                    return false;
                }
            }
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

        /// <summary>
        /// Returns MD5 Hash of a string
        /// </summary>
        /// <param name="s">a string</param>
        /// <returns>MD5 hash as string</returns>
        public string MD5HashStringForUTF8String(string s) {
            byte[] bytes = Encoding.UTF8.GetBytes(s);

            var md5 = MD5.Create();
            byte[] hashBytes = md5.ComputeHash(bytes);

            return HexStringFromBytes(hashBytes);
        }

        public EventFormatted[] getPromotionEvents() {
            using (IST421Entities entities = new IST421Entities()) {
                var events = from s in entities.comEvents.Take(5)
                             select s;
                
                List<EventFormatted> listOfEvents = new List<EventFormatted>();

                foreach (comEvent e in events) {
                    listOfEvents.Add(new EventFormatted(e));
                }

                return listOfEvents.ToArray<EventFormatted>();
            }
        }

        public bool registerEvent(string session, string user, int eventId)
        {
            using (IST421Entities entities = new IST421Entities())
            {
                var members = entities.members.Where(x => x.name == user);
                member suppliedMember = null;

                foreach (member mem in members)
                {
                    suppliedMember = mem;
                }

                if (suppliedMember != null)
                {
                    var sessions = entities.sessions
                        .Where(x => x.session1 == session && x.member_id == suppliedMember.id);

                    if (sessions.Count() > 0)
                    {
                        memberEvent mEvent = new memberEvent();
                        mEvent.member = suppliedMember.id;
                        mEvent.@event = eventId;

                        entities.memberEvents.Add(mEvent);
                        entities.SaveChanges();
                        return true;
                    }
                }
                return false;
            }
        }

        public bool unregisterEvent(string session, string user, int eventId) {
            using (IST421Entities entities = new IST421Entities()) {
                var members = entities.members.Where(x => x.name == user);
                member suppliedMember = null;

                foreach (member mem in members) {
                    suppliedMember = mem;
                }

                if (suppliedMember != null) {
                    var sessions = entities.sessions
                        .Where(x => x.session1 == session && x.member_id == suppliedMember.id);

                    if (sessions.Count() > 0) {
                        entities.memberEvents.RemoveRange(entities.memberEvents.Where(x => x.member == suppliedMember.id && x.@event == eventId));
                        entities.SaveChanges();
                        return true;
                    }
                }
                return false;
            }
        }

        public bool checkRegisterEvent(string user, int eventId){
            using (IST421Entities entities = new IST421Entities()) {
                var members = entities.members.Where(x => x.name == user);
                member suppliedMember = null;

                foreach (member mem in members) {
                    suppliedMember = mem;
                }

                if (suppliedMember != null) {

                    var memberEvents = entities.memberEvents.Where(x => x.member == suppliedMember.id && x.@event == eventId);

                    if (memberEvents.Count() > 0) {
                        return true;
                    }
                }
                return false;
            }
        }


        public EventFormatted[] eventsRegisteredFor(string name)
        {
            using (IST421Entities entities = new IST421Entities()) {
                var members = entities.members.Where(x => x.name == name);
                member suppliedMember = null;

                foreach (member mem in members) {
                    suppliedMember = mem;
                }

                if (suppliedMember != null)
                {
                    //var events = from s in entities.memberEvents.Where(x => x.member == suppliedMember.id) select s;

                    var events = entities.comEvents.Join(entities.memberEvents
                        , e => e.id
                        , m => m.@event
                        , (e, m) => new { @events = e, MemberEvents = m })
                        .Where(x => x.MemberEvents.member == suppliedMember.id);


                    List<EventFormatted> listOfEvents = new List<EventFormatted>();

                    foreach (var e in events)
                    {
                        listOfEvents.Add(new EventFormatted(e.events));
                    }

                    return listOfEvents.ToArray<EventFormatted>();
                }
            }
            return null;
        }
    }
}
