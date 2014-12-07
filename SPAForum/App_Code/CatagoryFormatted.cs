using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SPAForum
{
    [Serializable]
    public class CatagoryFormatted
    {
        int id;
        string name;

        public CatagoryFormatted(int id, string name) {
            this.id = id;
            this.name = name;
        }
    }
}