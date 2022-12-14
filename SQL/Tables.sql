USE [PROG260FA22]
GO
ALTER TABLE [dbo].[PokemonStatistic] DROP CONSTRAINT [FK_Type2_ID]
GO
ALTER TABLE [dbo].[PokemonStatistic] DROP CONSTRAINT [FK_Type1_ID]
GO
ALTER TABLE [dbo].[Pokemon] DROP CONSTRAINT [FK_Stats_ID]
GO
ALTER TABLE [dbo].[Pokemon] DROP CONSTRAINT [FK_Generation_ID]
GO
/****** Object:  Table [dbo].[Type]    Script Date: 12/12/2022 11:01:11 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Type]') AND type in (N'U'))
DROP TABLE [dbo].[Type]
GO
/****** Object:  Table [dbo].[PokemonStatistic]    Script Date: 12/12/2022 11:01:11 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PokemonStatistic]') AND type in (N'U'))
DROP TABLE [dbo].[PokemonStatistic]
GO
/****** Object:  Table [dbo].[Pokemon]    Script Date: 12/12/2022 11:01:11 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pokemon]') AND type in (N'U'))
DROP TABLE [dbo].[Pokemon]
GO
/****** Object:  Table [dbo].[Generation]    Script Date: 12/12/2022 11:01:11 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Generation]') AND type in (N'U'))
DROP TABLE [dbo].[Generation]
GO
/****** Object:  Table [dbo].[Generation]    Script Date: 12/12/2022 11:01:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Generation](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Generation_Number] [int] NOT NULL,
	[Region_Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Generation] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pokemon]    Script Date: 12/12/2022 11:01:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pokemon](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Pokedex_Number] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Stats_ID] [int] NOT NULL,
	[Generation_ID] [int] NOT NULL,
 CONSTRAINT [PK_Pokemon] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PokemonStatistic]    Script Date: 12/12/2022 11:01:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PokemonStatistic](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type1_ID] [int] NOT NULL,
	[Type2_ID] [int] NULL,
	[HP] [int] NOT NULL,
	[Attack] [int] NOT NULL,
	[Defense] [int] NOT NULL,
	[Sp_Atk] [int] NOT NULL,
	[Sp_Def] [int] NOT NULL,
	[Speed] [int] NOT NULL,
 CONSTRAINT [PK_PokemonStatistic] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Type]    Script Date: 12/12/2022 11:01:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Type](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[HexColor] [nvarchar](50) NULL,
 CONSTRAINT [PK_Type] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Pokemon]  WITH CHECK ADD  CONSTRAINT [FK_Generation_ID] FOREIGN KEY([Generation_ID])
REFERENCES [dbo].[Generation] ([ID])
GO
ALTER TABLE [dbo].[Pokemon] CHECK CONSTRAINT [FK_Generation_ID]
GO
ALTER TABLE [dbo].[Pokemon]  WITH CHECK ADD  CONSTRAINT [FK_Stats_ID] FOREIGN KEY([Stats_ID])
REFERENCES [dbo].[PokemonStatistic] ([ID])
GO
ALTER TABLE [dbo].[Pokemon] CHECK CONSTRAINT [FK_Stats_ID]
GO
ALTER TABLE [dbo].[PokemonStatistic]  WITH CHECK ADD  CONSTRAINT [FK_Type1_ID] FOREIGN KEY([Type1_ID])
REFERENCES [dbo].[Type] ([ID])
GO
ALTER TABLE [dbo].[PokemonStatistic] CHECK CONSTRAINT [FK_Type1_ID]
GO
ALTER TABLE [dbo].[PokemonStatistic]  WITH CHECK ADD  CONSTRAINT [FK_Type2_ID] FOREIGN KEY([Type2_ID])
REFERENCES [dbo].[Type] ([ID])
GO
ALTER TABLE [dbo].[PokemonStatistic] CHECK CONSTRAINT [FK_Type2_ID]
GO
