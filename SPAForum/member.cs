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
    
    public partial class member
    {
        public int id { get; set; }
        public string name { get; set; }
        public int member_group_id { get; set; }
        public string email { get; set; }
        public System.DateTime joined { get; set; }
        public string password_hash { get; set; }
        public int banned { get; set; }
    }
}
