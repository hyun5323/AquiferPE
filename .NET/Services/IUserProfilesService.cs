using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.UserProfiles;
using System.Collections.Generic;

namespace Sabio.Services.Interfaces
{
    public interface IUserProfilesService
    {
        int Add(UserProfileAddRequest model, int userId);
        void DeleteById(int Id);
        UserProfile Get(int Id);
        Paged<UserProfile> GetAll(int pageInex, int pageSize);
        Paged<UserProfile> Pagination(int PageIndex, int PageSize, int CreatedBy);
        void Update(UserProfileUpdateRequest model, int userId);
    }
}
