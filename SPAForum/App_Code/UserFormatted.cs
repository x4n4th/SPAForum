using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SPAForum
{
    [Serializable]
    public class UserFormatted
    {
        public string session;
        public string gravitar;

        public UserFormatted(string session, string gravitar)
        {
            this.session = session;
            this.gravitar = gravitar;
        }
    }
}