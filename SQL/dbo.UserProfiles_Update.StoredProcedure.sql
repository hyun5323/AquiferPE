USE [CnmPro]
GO
/****** Object:  StoredProcedure [dbo].[UserProfiles_Update]    Script Date: 8/7/2022 10:20:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: <Hyun Kim>
-- Create date: <7/3/22>
-- Description: <UserProfiles_Update>
-- Code Reviewer:

-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer:
-- Note:
-- =============================================

CREATE proc [dbo].[UserProfiles_Update]
	@Id int 
	,@UserId int
	,@FirstName nvarchar(100)
    ,@LastName nvarchar(100)
    ,@Mi nvarchar(2)
    ,@LocationId int 
    ,@AvatarUrl nvarchar(255)
    --,@ProfessionTypeId int 
    ,@DOB datetime2(7)
    ,@Email nvarchar(100)
    ,@Phone nvarchar(20)
    ,@LicenseNumber nvarchar(50)
    ,@YearsOfExperience nvarchar(10)
    ,@DesiredHourlyRate nvarchar(10)
    ,@IsActive bit


AS

/* ---- TEST CODE ----

Declare @Id int = 22		

	Declare @UserId int = 4
			,@FirstName nvarchar(100) = 'TestUserFirstNameUpdate'
			,@LastName nvarchar(100) = 'TestUserLastNameUpdate'
			,@Mi nvarchar(2) = 'T'
			,@LocationId int = 3
			,@AvatarUrl nvarchar(255) = 'TestImageUrl.com'
			,@ProfessionTypeId int = 1
			,@DOB datetime2(7) = '1955-05-05'
			,@Email nvarchar(100) = 'testuseremail@gmail.com'
			,@Phone nvarchar(20) = '1234567890'
			,@LicenseNumber nvarchar(50) = 'TestLicenseNumber123'
			,@YearsOfExperience nvarchar(10) = '10'
			,@DesiredHourlyRate nvarchar(10) = '100'
			,@IsActive bit = 1

	Execute [dbo].[UserProfiles_Update]		 
			@Id
			,@UserId 
			,@FirstName 
			,@LastName 
			,@Mi
			,@LocationId 
			,@AvatarUrl 
			,@ProfessionTypeId 
			,@DOB 
			,@Email
			,@Phone
			,@LicenseNumber 
			,@YearsOfExperience 
			,@DesiredHourlyRate 
			,@IsActive 


			Select @Id

			Select *
			From [dbo].[UserProfiles]

			Where Id = @Id

*/ ---- TEST CODE ----

BEGIN

UPDATE [dbo].[UserProfiles]

   SET [UserId] = @UserId
      ,[FirstName] = @FirstName
      ,[LastName] = @LastName
      ,[Mi] = @Mi
      ,[LocationId] = @LocationId 
      ,[AvatarUrl] = @AvatarUrl
      --,[ProfessionTypeId] = @ProfessionTypeId
      ,[DOB] = @DOB
      ,[Email] = @Email
      ,[Phone] = @Phone
      ,[LicenseNumber] = @LicenseNumber 
      ,[YearsOfExperience] = @YearsOfExperience
      ,[DesiredHourlyRate] = @DesiredHourlyRate
      ,[IsActive] = @IsActive
 
 WHERE Id = @Id

END
GO
