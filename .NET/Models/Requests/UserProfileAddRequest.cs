using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Requests.UserProfiles
{
    public class UserProfileAddRequest
    {

        //[Required]
        //[Range(1, int.MaxValue)]
        //public int UserId { get; set; }

        [Required]
        [StringLength(100)]
        public string FirstName { get; set; }
        [Required]
        [StringLength(100)]
        public string LastName { get; set; }
        [Required]
        [StringLength(2)]
        public string Mi { get; set; }
        [Required]
        [Range(1, int.MaxValue)]
        public int LocationId { get; set; }
        [Required]
        [StringLength(255)]
        public string AvatarUrl { get; set; }
        [Required]
        public List<string> ProfessionTypeId { get; set; }
        [Required]
        public DateTime DOB { get; set; }
        [Required]
        [StringLength(100)]
        public string Email { get; set; }
        [Required]
        [StringLength(20)]
        public string Phone { get; set; }
        [Required]
        [StringLength(50)]
        public string LicenseNumber { get; set; }
        [Required]
        [StringLength(10)]
        public string YearsOfExperience { get; set; }
        [Required]
        [StringLength(10)]
        public string DesiredHourlyRate { get; set; }
        [Required]
        public bool IsActive { get; set; }
 
    }
}
