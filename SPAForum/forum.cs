//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace SPAForum
{
    using System;
    using System.Collections.Generic;
    
    public partial class forum
    {
        public forum()
        {
            this.topics1 = new HashSet<topic>();
        }
    
        public int id { get; set; }
        public Nullable<int> topics { get; set; }
        public Nullable<int> posts { get; set; }
        public string name { get; set; }
        public string description { get; set; }
        public Nullable<int> position { get; set; }
        public int catagorieId { get; set; }
    
        public virtual catagory catagory { get; set; }
        public virtual ICollection<topic> topics1 { get; set; }
    }
}
