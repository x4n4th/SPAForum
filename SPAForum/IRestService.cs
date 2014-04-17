﻿using System;
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
        [WebGet(UriTemplate = "/getPosts?topic={topicId}",
            ResponseFormat = WebMessageFormat.Json)]
        [OperationContract]
        post[] getPosts(int topicId);
    }
}
