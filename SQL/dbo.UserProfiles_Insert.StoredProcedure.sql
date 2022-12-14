USE [CnmPro]
GO
/****** Object:  StoredProcedure [dbo].[UserProfiles_Insert]    Script Date: 8/7/2022 10:20:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: <Hyun Kim>
-- Create date: <7/3/22>
-- Description: <UserProfiles_Insert>
-- Code Reviewer:

-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer:
-- Note:
-- =============================================

CREATE proc [dbo].[UserProfiles_Insert]
			@UserId int
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
			,@BatchProfessionTypes dbo.UserProfessionTypes READONLY
			,@Id int OUTPUT

/* ---- TEST CODE ----

	Declare @Id int = 11		

	Declare @UserId int = 50
			,@FirstName nvarchar(100) = 'TestUserFirstNameNew'
			,@LastName nvarchar(100) = 'TestUserLastNameNew'
			,@Mi nvarchar(2) = 'T'
			,@LocationId int = 3
			,@AvatarUrl nvarchar(255) = 'TestImageUrl.com'
			,@DOB datetime2(7) = '1955-05-05'
			,@Email nvarchar(100) = 'testuseremail@gmail.com'
			,@Phone nvarchar(20) = '1234567890'
			,@LicenseNumber nvarchar(50) = 'TestLicenseNumber123'
			,@YearsOfExperience nvarchar(10) = '10'
			,@DesiredHourlyRate nvarchar(10) = '100'
			,@IsActive bit = 1

	Declare @BatchProfessionTypes  dbo.UserProfessionTypes
	INSERT INTO @BatchProfessionTypes ([Name])
	Values('Accountant'),('Real Estate Agent')

	Execute [dbo].[UserProfiles_Insert]		 
			@UserId 
			,@FirstName 
			,@LastName 
			,@Mi
			,@LocationId 
			,@AvatarUrl 
			,@DOB 
			,@Email
			,@Phone
			,@LicenseNumber 
			,@YearsOfExperience 
			,@DesiredHourlyRate 
			,@IsActive
			,@BatchProfessionTypes
			,@Id OUTPUT

			Select @Id

			Select *
			From [dbo].[UserProfiles]

			Where Id = @Id


			select *
			from  dbo.UserProfessionTypes
*/ ---- TEST CODE ----

AS

BEGIN

INSERT INTO [dbo].[UserProfiles]
           ([UserId]
           ,[FirstName]
           ,[LastName]
           ,[Mi]
           ,[LocationId]
           ,[AvatarUrl]
           ,[DOB]
           ,[Email]
           ,[Phone]
           ,[LicenseNumber]
           ,[YearsOfExperience]
           ,[DesiredHourlyRate]
           ,[IsActive])

     VALUES
           (@UserId
           ,@FirstName
           ,@LastName
           ,@Mi
           ,@LocationId
           ,@AvatarUrl
           ,@DOB
           ,@Email
           ,@Phone
           ,@LicenseNumber
           ,@YearsOfExperience
           ,@DesiredHourlyRate
           ,@IsActive)

		   SET @Id = SCOPE_IDENTITY();

		   INSERT INTO dbo.ProfessionTypes ([Name])
			Select b.Name
			FROM @BatchProfessionTypes as b
			WHERE NOT Exists(SELECT 1 FROM dbo.ProfessionTypes as pt
							WHERE b.name = pt.Name)

			INSERT INTO dbo.UserProfessionTypes(UserProfileId,ProfessionTypeId)
						(SELECT @Id, pt.Id
						FROM dbo.ProfessionTypes as pt
						WHERE Exists(SELECT 1
									FROM @BatchProfessionTypes as bt
									WHERE pt.Name = bt.Name))

	

END


GO
