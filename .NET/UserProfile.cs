using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class UserProfile : UserProfileBase
    {
        public DateTime DOB { get; set; }     
        public string Email { get; set; }   
        public string Phone { get; set; }   
        public string LicenseNumber { get; set; }    
        public string YearsOfExperience { get; set; }   
        public string DesiredHourlyRate { get; set; }    
        public bool IsActive { get; set; } 
        public DateTime DateCreated { get; set; }  
        public DateTime DateModified { get; set; }
        public Location Location { get; set; }
        public LookUp State { get; set; }
        //public LookUp ProfessionType { get; set; }
        public List<UserProfessionTypes> Profession { get; set; }
    }
}
