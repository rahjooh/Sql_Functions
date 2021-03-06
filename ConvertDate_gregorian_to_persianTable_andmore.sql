USE [TAT_DWBI_TEMP]
GO
/****** Object:  UserDefinedFunction [dbo].[hadi_dateTable]    Script Date: 10/31/2018 7:36:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER function [dbo].[hadi_dateTable]
    (    @FirstDate nvarchar(8)
		,@LastDate nvarchar(8)
		)
returns @datetable TABLE([tarikh] nvarchar(50),[vaziat] nvarchar(50),[rooz] nvarchar(50),[mah] nvarchar(50))
as
Begin
--select @FirstDate = DATEADD(dd,0,DATEDIFF(dd,0,@FirstDate));
--select @LastDate = DATEADD(dd,0,DATEDIFF(dd,0,@LastDate));
with CTE_DatesTable
as
	(select cast(@FirstDate AS [date]) as [date],cast(@FirstDate AS [date]) as [date1],cast(@FirstDate AS [date]) as [date2],cast(@FirstDate AS [date]) as [date3],cast(@FirstDate AS [date]) as [date4]
	union all
	select dateadd(dd,1,[date]),dateadd(dd,1,[date1]),dateadd(dd,1,[date2]),dateadd(dd,1,[date3]),dateadd(dd,1,[date4])
	from CTE_DatesTable
	where DATEADD(dd,1,[date]) <= @LastDate )
insert into @datetable([tarikh],[vaziat],[rooz],[mah])
select  
substring(N''+dbo.[hadi_UDF_Gregorian_To_Persian]([date]) ,0,charindex('#',N''+dbo.[hadi_UDF_Gregorian_To_Persian]([date]))) as Tarikh ,
 substring(N''+dbo.[hadi_UDF_Gregorian_To_Persian]([date]) ,charindex('#',N''+dbo.[hadi_UDF_Gregorian_To_Persian]([date]))+1,charindex('*',N''+dbo.[hadi_UDF_Gregorian_To_Persian]([date]))-charindex('#',N''+dbo.[hadi_UDF_Gregorian_To_Persian]([date]))-1) as vaziat ,
 substring(N''+dbo.[hadi_UDF_Gregorian_To_Persian]([date]) ,charindex('*',N''+dbo.[hadi_UDF_Gregorian_To_Persian]([date]))+1,charindex('$',N''+dbo.[hadi_UDF_Gregorian_To_Persian]([date]))-charindex('*',N''+dbo.[hadi_UDF_Gregorian_To_Persian]([date]))-1) as roz ,
  substring(N''+dbo.[hadi_UDF_Gregorian_To_Persian]([date]) ,charindex('$',N''+dbo.[hadi_UDF_Gregorian_To_Persian]([date]))+1,len(N''+dbo.[hadi_UDF_Gregorian_To_Persian]([date]))) as mah 


from CTE_DatesTable
option (MAXRECURSION 0 );
return
end

