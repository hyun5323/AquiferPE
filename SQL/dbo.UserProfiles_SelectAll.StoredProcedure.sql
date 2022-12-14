USE [CnmPro]
GO
/****** Object:  StoredProcedure [dbo].[UserProfiles_SelectAll]    Script Date: 8/7/2022 10:20:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: <Hyun Kim>
-- Create date: <7/3/22>
-- Description: <UserProfiles_SelectAll>
-- Code Reviewer:

-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer:
-- Note:
-- =============================================

CREATE proc [dbo].[UserProfiles_SelectAll]
					@PageIndex int
					,@PageSize int

/* ---- TEST CODE ----
	
Declare @PageIndex int = 0
			,@PageSize int = 20

Execute [dbo].[UserProfiles_SelectAll]
				@PageIndex 
				,@PageSize 

		Select *
		from dbo.UserProfiles

		Select *
		from dbo.Locations

		Select *
		from dbo.ProfessionTypes

*/ ---- TEST CODE ----

AS

BEGIN

	Declare @offset int = @PageIndex * @PageSize

SELECT up.[Id]
      ,up.[UserId]
      ,up.[FirstName]
      ,up.[LastName]
      ,up.[Mi]
      --,up.[LocationId]
      ,up.[AvatarUrl]
   --   ,pt.[Id]
	  --,pt.[Name] as ProfessionType
      ,up.[DOB]
      ,up.[Email]
      ,up.[Phone]
      ,up.[LicenseNumber]
      ,up.[YearsOfExperience]
      ,up.[DesiredHourlyRate]
      ,up.[IsActive]
      ,up.[DateCreated]
      ,up.[DateModified]
	  ,l.[Id] 
	  ,lt.[Id] as LocationType
	  ,lt.[Name] as LocationTypeName
	  ,l.[LineOne]
	  ,l.[LineTwo]
	  ,l.[City]
	  ,l.[Zip]
	  ,s.[Id] as StateId
	  --,l.[CreatedBy]
	  --,l.[ModifiedBy]
	  ,s.[Code] as StateCode
	  ,s.[Name] as StateName
	  ,l.[Latitude]
	  ,l.[Longitude]
	  ,Professions = (SELECT pt.Id, pt.Name
					from dbo.ProfessionTypes as pt INNER JOIN dbo.UserProfessionTypes as upt
					ON pt.Id = upt.ProfessionTypeId
					WHERE upt.UserProfileId = up.UserId FOR JSON AUTO
					)
				
	  ,TotalCount = COUNT(1) OVER()

  FROM [dbo].[UserProfiles] as up inner join dbo.Locations as l
								on l.Id = up.LocationId
								--inner join dbo.ProfessionTypes as pt
								--on pt.Id = up.ProfessionTypeId
								inner join dbo.Users as u
								on u.Id = up.UserId
								inner join dbo.LocationTypes as lt
								on lt.Id = l.LocationTypeId
								inner join dbo.States as s
								on s.Id = l.StateId

	ORDER BY up.Id

	OFFSET @offSet Rows
	Fetch Next @PageSize Rows ONLY

END


GO
