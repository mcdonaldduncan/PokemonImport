USE [PROG260FA22]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertPokemon]    Script Date: 12/12/2022 11:03:47 AM ******/
DROP PROCEDURE [dbo].[sp_InsertPokemon]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertPokemon]    Script Date: 12/12/2022 11:03:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_InsertPokemon]
	-- Add the parameters for the stored procedure here
	@Pokedex_Number int,
	@Name nvarchar(50),
	@Type1 nvarchar(50),
	@Type2 nvarchar(50),
	@HP int,
	@Attack int,
	@Defense int,
	@SPATK int,
	@SPDEF int,
	@Speed int,
	@Generation int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @T1_ID int
	DECLARE @T2_ID int
	DECLARE @Stat_ID int
	

    IF NOT EXISTS (SELECT Name FROM Type
					WHERE Name = @Type1)
					BEGIN
					INSERT INTO Type (Name)
					VALUES (@Type1)
					END

	SELECT @T1_ID = ID FROM Type
	WHERE Name = @Type1

	IF NULLIF(@Type2, '') IS NOT NULL AND @Type2 IS NOT NULL 
	BEGIN
		IF NOT EXISTS (SELECT Name FROM Type
						WHERE Name = @Type2)
						BEGIN
						INSERT INTO Type (Name)
						VALUES (@Type2)
						END

		SELECT @T2_ID = ID FROM Type
		WHERE Name = @Type2
	END

	INSERT INTO PokemonStatistic (Type1_ID, Type2_ID, HP, Attack, Defense, Sp_Atk, Sp_Def, Speed)
	VALUES (@T1_ID, @T2_ID, @HP, @Attack, @Defense, @SPATK, @SPDEF, @Speed)
	
	SELECT @Stat_ID = MAX(ID) FROM PokemonStatistic

	INSERT INTO Pokemon (Pokedex_Number, Name, Stats_ID, Generation_ID)
	VALUES (@Pokedex_Number, @Name, @Stat_ID, @Generation)
	

END
GO
