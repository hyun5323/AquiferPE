USE [CnmPro]
GO
/****** Object:  StoredProcedure [dbo].[UserProfiles_Select_ById]    Script Date: 8/7/2022 10:20:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: <Hyun Kim>
-- Create date: <7/3/22>
-- Description: <UserProfiles_Select_ById>
-- Code Reviewer:

-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer:
-- Note:
-- =============================================

CREATE proc [dbo].[UserProfiles_Select_ById]
		@Id int

/* ---- TEST CODE ----

	Declare @Id int = 4;
	Execute dbo.UserProfiles_Select_ById
			@Id

*/ ---- TEST CODE ----

AS 

BEGIN

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
	  ,l.[Id] as LocationTypeId
	  ,lt.[Name] as LocationTypeName
	  ,l.[LineOne]
	  ,l.[LineTwo]
	  ,l.[City]
	  ,l.[Zip]
	  ,s.[Id] as StateId
	  ,s.[Code] as StateCode
	  ,s.[Name] as StateName
	  ,l.[Latitude]
	  ,l.[Longitude]
	  --,TotalCount = COUNT(1) OVER()

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

	Where up.Id = @Id 

END


GO
