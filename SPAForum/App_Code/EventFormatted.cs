using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SPAForum
{
    public class EventFormatted
    {
        public EventFormatted(comEvent e){
            this.id = e.id;
            this.name = e.name;
            this.dateCreated = ((DateTime)e.dateCreated).ToString("g");
            this.dateStart = ((DateTime)e.dateStart).ToString("g");
            this.wayPoints = e.wayPoints;
            this.startPoint = e.startPoint;
            this.endPoint = e.endPoint;
            this.description = e.description;
            this.memberId = e.memberId;
            this.forumId = e.forumId;
        }
        public int id { get; set; }
        public string name { get; set; }
        public string dateCreated { get; set; }
        public string dateStart { get; set; }
        public string wayPoints { get; set; }
        public string startPoint { get; set; }
        public string endPoint { get; set; }
        public string description { get; set; }
        public Nullable<int> memberId { get; set; }
        public Nullable<int> forumId { get; set; }
    }
}