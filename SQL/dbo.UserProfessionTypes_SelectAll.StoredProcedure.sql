USE [CnmPro]
GO
/****** Object:  StoredProcedure [dbo].[UserProfessionTypes_SelectAll]    Script Date: 8/7/2022 10:20:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: <Hyun Kim>
-- Create date: <7/25/22>
-- Description: <[UserProfessionTypes_SelectAll]>
-- Code Reviewer:

-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer:
-- Note:
-- =============================================

CREATE proc [dbo].[UserProfessionTypes_SelectAll]
						@PageIndex int
						,@PageSize int

AS


/* ----TEST CODE----

	Declare @PageIndex int = 0
			,@PageSize int = 10



execute dbo.UserProfessionTypes_SelectAll 
								@PageIndex 
								,@PageSize
				
					select * from dbo.ProfessionTypes

					select * from dbo.UserProfiles

*/ ----TEST CODE----

BEGIN

	Declare @offset int = @PageIndex * @PageSize

	Select upt.UserProfileId
		   ,pt.Name as ProfessionType
		   ,TotalCount = COUNT(1) OVER() 
			

  FROM [dbo].[UserProfessionTypes] as upt
		inner join dbo.ProfessionTypes as pt
		on upt.ProfessionTypeId = pt.Id

		ORDER BY upt.UserProfileId

	OFFSET @offSet Rows
	Fetch Next @PageSize Rows ONLY

END
GO
