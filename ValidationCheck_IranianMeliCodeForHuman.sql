USE [TAT_DWBI_TEMP]
GO
/****** Object:  UserDefinedFunction [dbo].[hadi_Fnc_CheckShenaseMelli]    Script Date: 10/31/2018 7:35:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[hadi_Fnc_CheckShenaseMelli]	(@ShenaseMelli VARCHAR(11))
RETURNS VARCHAR(100)
AS

BEGIN

DECLARE @ErrorMessage VARCHAR(100)
	,@C INT
	,@d INT
	,@s INT
	,@r INT
SET @ErrorMessage = ''

IF (
	LEN(@ShenaseMelli) <> 11
	OR @ShenaseMelli = '00000000000'
	OR @ShenaseMelli = '11111111111'
	OR @ShenaseMelli = '22222222222'
	OR @ShenaseMelli = '33333333333'
	OR @ShenaseMelli = '44444444444'
	OR @ShenaseMelli = '55555555555'
	OR @ShenaseMelli = '66666666666'
	OR @ShenaseMelli = '77777777777'
	OR @ShenaseMelli = '88888888888'
	OR @ShenaseMelli = '99999999999'
	)
BEGIN
	SET @ErrorMessage = 'unvalid'
END
ELSE
BEGIN

	SET @C = cast(SUBSTRING(@ShenaseMelli, 11, 1) as int)
	SET @d = cast(SUBSTRING(@ShenaseMelli, 10, 1) as int) +2 
	SET @s = 0


	SET @s = ((cast(SUBSTRING(@ShenaseMelli, 1, 1) as int) + @d) * 29) +
			 ((cast(SUBSTRING(@ShenaseMelli, 2, 1) as int) + @d) * 27) +
			 ((cast(SUBSTRING(@ShenaseMelli, 3, 1) as int) + @d) * 23) +
			 ((cast(SUBSTRING(@ShenaseMelli, 4, 1) as int) + @d) * 19) +
			 ((cast(SUBSTRING(@ShenaseMelli, 5, 1) as int) + @d) * 17) +
			 ((cast(SUBSTRING(@ShenaseMelli, 6, 1) as int) + @d) * 29) +
			 ((cast(SUBSTRING(@ShenaseMelli, 7, 1) as int) + @d) * 27) +
			 ((cast(SUBSTRING(@ShenaseMelli, 8, 1) as int) + @d) * 23) +
			 ((cast(SUBSTRING(@ShenaseMelli, 9, 1) as int) + @d) * 19) +
			 ((cast(SUBSTRING(@ShenaseMelli, 10, 1) as int) + @d) * 17) 
			


	SET @r = @s % 11
	IF @r = 10 SET @r = 0
	
	IF (@r = @c)
		SET @ErrorMessage = 'valid'
	ELSE
		SET @ErrorMessage = 'unvalid'

END

RETURN @ErrorMessage

END

