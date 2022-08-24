using Sabio.Data;
using Sabio.Models.Domain;
using Sabio.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Services
{
    public class UserProfileMapperService : IUserProfileMapper
    {
        public UserProfileBase Map(IDataReader reader, ref int index)
        {
            UserProfileBase profile = new UserProfileBase();
            profile.Id = reader.GetSafeInt32(index++);
            profile.UserId = reader.GetSafeInt32(index++);
            profile.FirstName = reader.GetSafeString(index++);
            profile.LastName = reader.GetSafeString(index++);
            profile.Mi = reader.GetSafeString(index++);
            profile.AvatarUrl = reader.GetSafeString(index++);
            return profile;
        }
    }
}
