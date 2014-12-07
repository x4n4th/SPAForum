using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SPAForum
{
    [Serializable]
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
            this.memberId = (int)e.memberId;
            this.forumId = (int)e.forumId;
        }

        int id;
        string name;
        string dateCreated;
        string dateStart;
        string wayPoints;
        string startPoint;
        string endPoint;
        string description;
        int memberId;
        int forumId;
    }
}