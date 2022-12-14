USE [CnmPro]
GO
/****** Object:  StoredProcedure [dbo].[UserProfessionTypes_Insert_UDT]    Script Date: 8/7/2022 10:20:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Hyun Kim>
-- Create date: <7/25/22>
-- Description: <[UserProfessionTypes_Insert_UDT]>
-- Code Reviewer:

-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer:
-- Note:
-- =============================================


CREATE proc [dbo].[UserProfessionTypes_Insert_UDT]
				@UserProfileId int
				,@ListProfessionTypeId dbo.IntTable readonly

AS

/*-----TEST CODE----

	Declare @UserProfileId int = 20  
			,@ProfessionTypeId int = 1, 2;


	execute dbo.UserProfessionTypes_Insert_UDT
							@UserProfileId 
							,@ProfessionTypeId 

			Select * 
			from dbo.UserProfessionTypes
			order by ProfessionTypeId
			
			select * 
			from dbo.ProfessionTypes

			select *
			from dbo.UserProfileId
		


*/-----TEST CODE----

BEGIN

INSERT INTO [dbo].[UserProfessionTypes]
			   ([UserProfileId]
			   ,[ProfessionTypeId])

     Select
           @UserProfileId 
           ,lpt.data
		  from @ListProfessionTypeId as lpt

END
GO
