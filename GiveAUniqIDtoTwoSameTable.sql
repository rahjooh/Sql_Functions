declare @id	varchar(20)

declare id_cursor Cursor for 
SELECT distinct [id_t1]
   
FROM [db_source1].[dbo].[tb1]
where [id_t1] not in (SELECT [ID]  FROM [db_dest].[dbo].[table_dest])

open id_cursor

Fetch next from id_cursor
into @id

while @@FETCH_STATUS = 0
Begin 
	print ''
	INSERT INTO [db_dest].[dbo].[table_dest]
           (UniqID
           ,[CustID]
           ,[System])
     VALUES
           ((Select max(UniqID) from  [db_dest].[dbo].[table_dest] where UniqID < 70000000) + 1
           ,@id
           ,'tb1')
	fetch next from id_cursor
	into @id
END
close id_cursor
deallocate id_cursor



declare @id1	varchar(20)

declare id_cursor1 Cursor for 
SELECT distinct [id_t2]
  FROM [db_source2].[dbo].[tb2]
  where [id_t2] not in (SELECT [ID]  FROM [db_dest].[dbo].[table_dest])

open id_cursor1

Fetch next from id_cursor1
into @id1

while @@FETCH_STATUS = 0
Begin 
	print ''
	INSERT INTO [db_dest].[dbo].[table_dest]
           (UniqID
           ,[CustID]
           ,[System])
     VALUES
           ((Select max(UniqID) from [db_dest].[dbo].[table_dest] ) + 1
           ,@id1
           ,'tb2')
	fetch next from id_cursor1
	into @id1
END
close id_cursor1
deallocate id_cursor1