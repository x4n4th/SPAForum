﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class ist331Entities : DbContext
    {
        public ist331Entities()
            : base("name=Entities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<catagory> catagories { get; set; }
        public virtual DbSet<forum> forums { get; set; }
        public virtual DbSet<member> members { get; set; }
        public virtual DbSet<post> posts { get; set; }
        public virtual DbSet<topic> topics { get; set; }
    }
}
