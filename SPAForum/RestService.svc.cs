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
        public post[] getPosts(int topicId){
            using(ist331Entities entities = new ist331Entities()){
                var posts = from s in entities.posts.Where(x=>x.topic_id == topicId) select s;
                return posts.ToArray();
            }
        }
    }
}
