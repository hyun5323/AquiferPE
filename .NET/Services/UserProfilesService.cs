using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Domain.User;
using Sabio.Models.Requests.UserProfiles;
using Sabio.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Services
{
    public class UserProfilesService : IUserProfilesService
    {
        public IDataProvider _data = null;

        public UserProfilesService(IDataProvider data)
        {
            _data = data;
        }

        public void DeleteById(int Id)
        {
            string procName = "[dbo].[UserProfiles_Delete_ById]";
            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {
                    col.AddWithValue("@Id", Id);
                });
        }

        public void Update(UserProfileUpdateRequest model, int userId)
        {
            string procName = "[dbo].[UserProfiles_Update]";
            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {
                    col.AddWithValue("@Id", model.Id);
                    col.AddWithValue("@UserId", userId);
                    AddCommonParams(model, col);
                },
            returnParameters: null);
        }

        public int Add(UserProfileAddRequest model, int userId)
        {
            int Id = 0;
            DataTable professionTypes = null;

            string procName = "[dbo].[UserProfiles_Insert]";
            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {
                    if (professionTypes == null)
                    {
                        professionTypes = MappingListOfIds(model.ProfessionTypeId);
                    }

                    AddCommonParams(model, col);
                    col.AddWithValue("@UserId", userId);
                    col.AddWithValue("@BatchProfessionTypes", professionTypes);

                    SqlParameter idOut = new SqlParameter("@Id", SqlDbType.Int);
                    idOut.Direction = ParameterDirection.Output;

                    col.Add(idOut);
                },
                returnParameters: delegate (SqlParameterCollection returnCollection)
                {
                    object oId = returnCollection["@Id"].Value;

                    int.TryParse(oId.ToString(), out Id);

                    Console.WriteLine("");

                });

            return Id;
        }

        //public List<ProfessionIdPair> AddProfessionTypes(UserProfileAddRequest model)
        //{
        //    List<ProfessionIdPair> userId = null;

        //    DataTable myParamValue = null;
        //    if(model.UserProfile != null)
        //    {
        //        myParamValue = MapAUserV2(model.UserProfile)
        //    }

        //    _dataProvider.ExecuteCmd("[dbo].[UserProfile_Insert]",
        //        inputParamMapper: delegate (SqlParameterCollection sqlParams)
        //        {
        //            sqlParamsAddWithValue("@BatchProfessionTypes", myParamValue);
        //        },

        //        singleRecordMapper: delegate (IDataReader reader, short set)
        //        {
        //            UserProfessionTypes type = new UserProfessionTypes();
        //            int startingIndex = 0;
        //            pair.UserprofileId = reader.GetInt32(startingIndex++);
        //            pair.ProfessionTypeId = reader.GetChar(startingIndex++);

        //            if (userId == null)
        //            {
        //                userId = new List<UserProfessionTypes>();
        //            }

        //            userId.Add(pair);
        //        });
        //}

        public UserProfile Get(int Id)
        {
            string procName = "[dbo].[UserProfiles_Select_ById]";
            int startingIndex = 0;

            UserProfile aUser = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection)
            {

                paramCollection.AddWithValue("@Id", Id);

            }, delegate (IDataReader reader, short set)
            {
                aUser = MapAUser(reader, ref startingIndex);
            }

            );

            return aUser;
        }


        public Paged<UserProfile> GetAll(int pageIndex, int pageSize)
        {
            string procName = "[dbo].[UserProfiles_SelectAll]";

            Paged<UserProfile> pagedList = null;
            List<UserProfile> list = null;
            int totalCount = 0;

            _data.ExecuteCmd(procName, (param) =>
            {
                param.AddWithValue("@PageIndex", pageIndex);
                param.AddWithValue("@PageSize", pageSize);
            }, (reader, recordSetIndex) =>
            {
                int startingIndex = 0;
                UserProfile userProfile = MapAUser(reader, ref startingIndex);
                if (totalCount == 0)
                {
                    totalCount = reader.GetSafeInt32(startingIndex++);
                }

                if (list == null)
                {
                    list = new List<UserProfile>();
                }

                list.Add(userProfile);
            });

            if (list != null)
            {
                pagedList = new Paged<UserProfile>(list, pageIndex, pageSize, totalCount);
            }

            return pagedList;
        }

        public Paged<UserProfile> Pagination(int pageIndex, int pageSize, int createdBy)
        {
            Paged<UserProfile> pagedList = null;
            List<UserProfile> list = null;
            int totalCount = 0;

            _data.ExecuteCmd("[dbo].[UserProfiles_Select_ByCreatedBy]", (param) =>
            {
                param.AddWithValue("@PageIndex", pageIndex);
                param.AddWithValue("@PageSize", pageSize);
                param.AddWithValue("@CreatedBy", createdBy);
            },
            (reader, recordSetIndex) =>
            {
                int startingIndex = 0;
                UserProfile userProfile = MapAUser(reader, ref startingIndex);

                if (totalCount == 0)
                {
                    totalCount = reader.GetSafeInt32(startingIndex++);
                }
                if (list == null)
                {
                    list = new List<UserProfile>();
                }

                list.Add(userProfile);
            });
            if (list != null)
            {
                pagedList = new Paged<UserProfile>(list, pageIndex, pageSize, totalCount);
            }
            return pagedList;
        }

        public List<User> GetUsers()
        {
            List<User> list = null;
            string procName = "[dbo].[Users_SelectAll]";

            _data.ExecuteCmd(procName, inputParamMapper: null
            , singleRecordMapper: delegate (IDataReader reader, short set)
            {

                int startingIndex = 0;
                User user = new User();
                user.Id = reader.GetSafeInt32(startingIndex++);
                user.Email = reader.GetSafeString(startingIndex++);

                if (list == null)
                {
                    list = new List<User>();
                }

                list.Add(user);
            });
            return list;
        }

        public List<State> GetStates()
        {
            List<State> list = null;
            string procName = "[dbo].[States_SelectAll]";

            _data.ExecuteCmd(procName, inputParamMapper: null
            , singleRecordMapper: delegate (IDataReader reader, short set)
            {

                int startingIndex = 0;
                State state = new State();
                state.Id = reader.GetSafeInt32(startingIndex++);
                state.Code = reader.GetSafeString(startingIndex++);
                state.Name = reader.GetSafeString(startingIndex++);

                if (list == null)
                {
                    list = new List<State>();
                }

                list.Add(state);
            });
            return list;
        }

        private static DataTable MappingListOfIds(List<string> ProfessionIdsToMap)
        {
            DataTable data = null;

            if (ProfessionIdsToMap != null)
            {
                data = new DataTable();
                data.Columns.Add("Name", typeof(String));

                foreach (string name in ProfessionIdsToMap)
                {
                    DataRow dr = data.NewRow();
                    int startingIndex = 0;
                    dr.SetField(startingIndex++, name);

                    data.Rows.Add(dr);
                }
            }
            return data;
        }

        private static UserProfile MapAUser(IDataReader reader, ref int startingIndex)
        {
            UserProfile aUser = new UserProfile();
            //aUser.State = new LookUp();
            //aUser.ProfessionType = new LookUp();
            //aUser.ProfessionTypeId = new List<int>();
            //aUser.Location = new Location();
            //aUser.Location.LocationType = new LookUp();
            //aUser.Location.State = new State();

            aUser.Id = reader.GetSafeInt32(startingIndex++);
            aUser.UserId = reader.GetSafeInt32(startingIndex++);
            aUser.FirstName = reader.GetSafeString(startingIndex++);
            aUser.LastName = reader.GetSafeString(startingIndex++);
            aUser.Mi = reader.GetSafeString(startingIndex++);
            aUser.AvatarUrl = reader.GetSafeString(startingIndex++);
            //aUser.ProfessionType = new LookUp();
            //aUser.ProfessionType.Id = reader.GetSafeInt32(startingIndex++);
            //aUser.ProfessionType.Name = reader.GetSafeString(startingIndex++);
            aUser.DOB = reader.GetSafeDateTime(startingIndex++);
            aUser.Email = reader.GetSafeString(startingIndex++);
            aUser.Phone = reader.GetSafeString(startingIndex++);
            aUser.LicenseNumber = reader.GetSafeString(startingIndex++);
            aUser.YearsOfExperience = reader.GetSafeString(startingIndex++);
            aUser.DesiredHourlyRate = reader.GetSafeString(startingIndex++);
            aUser.IsActive = reader.GetSafeBool(startingIndex++);
            aUser.DateCreated = reader.GetSafeDateTime(startingIndex++);
            aUser.DateModified = reader.GetSafeDateTime(startingIndex++);
            aUser.Location = new Location();
            aUser.Location.Id = reader.GetSafeInt32(startingIndex++);
            //aUser.Location.Name = reader.GetSafeString(startingIndex++);
            aUser.Location.LocationType = new LookUp();
            aUser.Location.LocationType.Id = reader.GetSafeInt32(startingIndex++);
            aUser.Location.LocationType.Name = reader.GetSafeString(startingIndex++);
            aUser.Location.LineOne = reader.GetSafeString(startingIndex++);
            aUser.Location.LineTwo = reader.GetSafeString(startingIndex++);
            aUser.Location.City = reader.GetSafeString(startingIndex++);
            aUser.Location.Zip = reader.GetSafeString(startingIndex++);
            aUser.Location.State = new State();
            aUser.Location.State.Id = reader.GetSafeInt32(startingIndex++);
            aUser.Location.State.Code = reader.GetSafeString(startingIndex++);
            aUser.Location.State.Name = reader.GetSafeString(startingIndex++);
            aUser.Location.Latitude = reader.GetSafeDouble(startingIndex++);
            aUser.Location.Longitude = reader.GetSafeDouble(startingIndex++);
            aUser.Profession = reader.DeserializeObject<List<UserProfessionTypes>>(startingIndex++);

            return aUser;
        }

        private static void AddCommonParams(UserProfileAddRequest model, SqlParameterCollection col)
        {
            //col.AddWithValue("@UserId", model.UserId);
            col.AddWithValue("@FirstName", model.FirstName);
            col.AddWithValue("@LastName", model.LastName);
            col.AddWithValue("@Mi", model.Mi);
            col.AddWithValue("@LocationId", model.LocationId);
            col.AddWithValue("@AvatarUrl", model.AvatarUrl);
            //col.AddWithValue("@ProfessionTypeId", model.ProfessionTypeId); //need to replace this with udt
            col.AddWithValue("@DOB", model.DOB);
            col.AddWithValue("@Email", model.Email);
            col.AddWithValue("@Phone", model.Phone);
            col.AddWithValue("@LicenseNumber", model.LicenseNumber);
            col.AddWithValue("@YearsOfExperience", model.YearsOfExperience);
            col.AddWithValue("@DesiredHourlyRate", model.DesiredHourlyRate);
            col.AddWithValue("@IsActive", model.IsActive);

        }

        //private static ProfessionTypeId MapSingleProfessionType(IDataReader reader, ref int startingIndex)
        //{
        //    ProfessionTypeId model = new ProfessionTypeId();
        //    model.UserProfileId = reader.GetSafeInt32(startingIndex++);
        //    model.ProfessionTypeId = reader.GetSafeInt32(startingIndex++);

        //    return model;
        //}
    }
}
