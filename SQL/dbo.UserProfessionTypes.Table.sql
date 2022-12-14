USE [CnmPro]
GO
/****** Object:  Table [dbo].[UserProfessionTypes]    Script Date: 8/7/2022 10:20:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserProfessionTypes](
	[UserProfileId] [int] NOT NULL,
	[ProfessionTypeId] [int] NOT NULL,
 CONSTRAINT [PK_UserProfessionTypes_1] PRIMARY KEY CLUSTERED 
(
	[UserProfileId] ASC,
	[ProfessionTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UserProfessionTypes]  WITH CHECK ADD  CONSTRAINT [FK_UserProfessionTypes_ProfessionTypes] FOREIGN KEY([ProfessionTypeId])
REFERENCES [dbo].[ProfessionTypes] ([Id])
GO
ALTER TABLE [dbo].[UserProfessionTypes] CHECK CONSTRAINT [FK_UserProfessionTypes_ProfessionTypes]
GO
ALTER TABLE [dbo].[UserProfessionTypes]  WITH CHECK ADD  CONSTRAINT [FK_UserProfessionTypes_UserProfiles] FOREIGN KEY([UserProfileId])
REFERENCES [dbo].[UserProfiles] ([Id])
GO
ALTER TABLE [dbo].[UserProfessionTypes] CHECK CONSTRAINT [FK_UserProfessionTypes_UserProfiles]
GO
