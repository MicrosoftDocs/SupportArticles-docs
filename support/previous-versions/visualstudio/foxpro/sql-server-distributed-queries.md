---
title: SQL Server distributed queries
description: This article demonstrates how to perform a SQL Server distributed query to retrieve data from FoxPro .dbc and .dbf files using either the VFP ODBC Driver or the VFP OLE DB Provider.
ms.date: 09/08/2020
ms.prod-support-area-path: 
ms.topic: how-to
ms.prod: visual-studio-family
---
# Do SQL Server distributed queries with FoxPro .dbf files

This article introduces how to perform a SQL Server distributed query to retrieve data from FoxPro .dbc and .dbf files using either the VFP ODBC Driver or the VFP OLE DB Provider.

_Original product version:_ &nbsp; Visual FoxPro  
_Original KB number:_ &nbsp; 207595

## Summary

This article demonstrates how to perform a SQL Server distributed query to retrieve data from FoxPro `.dbc` and `.dbf` files using either the VFP ODBC Driver or the VFP OLE DB Provider.

## More information

Microsoft SQL Server 2000 provides the ability to perform queries against OLE DB providers. This query is done by using the `OpenQuery` or `OpenRowset` Transact-SQL functions or by using a query with four-part names including a linked-server name.

For example:

```sql
sp_addlinkedserver 'mylinkedserver', 'product_name', 'myoledbprovider', 'data_source','location', 'provider_string', 'catalog'

SELECT * FROM OPENQUERY(mylinkedserver, 'select * from table1')
```

You should use the Microsoft OLE DB provider for ODBC (MSDASQL) and the Visual FoxPro ODBC driver to set up a linked server to perform distributed queries against FoxPro `.dbc` and `.dbf` files. Using Jet OLEDB Provider with FoxPro is not supported. The VFP ODBC driver is not thread safe. Because SQL Server is multi-threaded, the VFP ODBC Driver may cause problems under some circumstances. If it is possible, we recommend using the VFP OLE DB Provider to connect to the SQL Server data.

The following T-SQL code example demonstrates how to set up and use distributed queries with FoxPro with OpenQuery and OpenRowset functions. It also demonstrates how to update a remote FoxPro table from SQL Server 2000. You can test this code in SQL Query Analyzer after you install the Visual FoxPro ODBC driver on a SQL Server 2000 machine. You will need to change the data source names and path to the FoxPro files as appropriate:

```sql
/* OPENROWSET and OPENQUERY examples with VFP via ODBC OLE DB provider */ 

/* These OPENROWSET examples depend on the sample files VFP98\data\Testdata.dbc
Modify your code accordingly for differences in location or DBC name */ 

--====================================================
-- Using DBC file , read and update
--====================================================
-- OPENROWSET DSN-less example

select * from openrowset('MSDASQL',
'Driver=Microsoft Visual FoxPro Driver;
SourceDB=e:\VFP98\data\Testdata.dbc;
SourceType=DBC',
'select * from customer where country != "USA" order by country')
go

select * from openrowset('MSDASQL',
'Driver=Microsoft Visual FoxPro Driver;
SourceDB=e:\VFP98\data\Testdata.dbc;
SourceType=DBC',
'select * from customer where region="WA"')
go

Update openrowset('MSDASQL',
'Driver=Microsoft Visual FoxPro Driver;
SourceDB=e:\VFP98\data\Testdata.dbc;
SourceType=DBC',
'select * from customer where region="WA"')
set region = "Seattle" 
go

-- check to verify which rows were updated
select * from openrowset('MSDASQL',
'Driver=Microsoft Visual FoxPro Driver;
SourceDB=e:\VFP98\data\Testdata.dbc;
SourceType=DBC',
'select * from customer where region="Seattle"') 
go

-- OPENROWSET DSN example
/* Note the DSN Example might fail if SQL Server is configured to use a local account.*/ 
select * from openrowset('MSDASQL',
'DSN=Visual FoxPro Database;
SourceDB=e:\VFP98\data\Testdata.dbc;
SourceType=DBC',
'select * from customer where country != "USA" order by country'
go

/* sp_addlinkedserver examples */ 
-- sp_addlinkedserver example with DSN

/* You will need to make a DSN and point it to the Testdata database. 
Modify your code accordingly for differences in location or DBC name */ 

/* Note this Example may fail if SQL Server is configured to use a local account.*/ 
sp_addlinkedserver 'VFP Testdata Database With DSN', 
 '', 
 'MSDASQL',
 'VFP System DSN'
go

sp_addlinkedsrvlogin 'VFP Testdata Database With DSN', FALSE, NULL, NULL, NULL
go 

SELECT *
FROM OPENQUERY([VFP Testdata Database With DSN], 'select * from customer where region = "Seattle"') 
go

-- Update using OpenQuery
Update OPENQUERY([VFP Testdata Database With DSN], 'select * from customer where region="WA"') 
set region = &quot;Seattle&quot; 
go

/* SP_addlinkedserver example with DSN-less connection */ 

/* This example also depends on the sample files Testdata.dbc
Modify your code accordingly for differences in location or DBC name */ 

sp_addlinkedserver 'VFP Testdata Database With No DSN', 
 '', 
 'MSDASQL',
 NULL,
 NULL,
'Driver={Microsoft Visual FoxPro Driver};UID=;PWD=;SourceDB=e:\VFP98\data\Testdata.dbc;SourceType=DBC;Exclusive=No;BackgroundFetch=Yes;Collate=Machine;'
go

sp_addlinkedsrvlogin 'VFP Testdata Database With No DSN', FALSE, NULL, NULL, NULL
go

SELECT *
FROM OPENQUERY([VFP Testdata Database With No DSN], 'select * from customer where country != "USA" order by country')
go

--====================================================
-- Using VFP 6.0 driver, read and update data from VFP sample dbf files
--====================================================

-- OPENROWSET DSN-less example

select * from openrowset('MSDASQL',
'Driver=Microsoft Visual FoxPro Driver;
SourceDB=e:\VFP98\data;
SourceType=DBF',
'select * from customer where country != "USA" order by country')
go

-- perform UPDATE

Update openrowset('MSDASQL',
'Driver=Microsoft Visual FoxPro Driver;
SourceDB=e:\VFP98\data;
SourceType=DBF',
'select * from customer where region="Seattle"')
set region = "WA"
go

-- verify update

select * from openrowset('MSDASQL',
'Driver=Microsoft Visual FoxPro Driver;
SourceDB=e:\VFP98\data;
SourceType=DBF',
'select * from customer where region = "WA"')
go&amp;lt;BR/&amp;gt;

-- OPENROWSET DSN example
-- DSN points to the folder where .dbf files are.
/* Note this Example may fail if SQL Server is configured to use a local account.*/ 
select * from openrowset('MSDASQL',
'DSN=Visual FoxPro Tables;
SourceDB=e:\VFP98\data;
SourceType=DBF',
'select * from customer where country != "USA" order by country') 
go"?
-- SQL Server's QUOTED_IDENTIFIER has to be set to OFF.

SET QUOTED_IDENTIFIER OFF

-- OPENROWSET DSN-less example

select * from openrowset('MSDASQL',

'Driver=Microsoft Visual FoxPro Driver;

SourceDB=e:\VFP90\samples\data\Testdata.dbc;

SourceType=DBC',

'select * from customer where country = "USA" order by city')

go

select * from openrowset('MSDASQL',

'Driver=Microsoft Visual FoxPro Driver;

SourceDB=e:\VFP90\samples\data\Testdata.dbc;

SourceType=DBC',

'select * from customer where region="WA"')

go

Update openrowset('MSDASQL',

'Driver=Microsoft Visual FoxPro Driver;

SourceDB=e:\VFP90\samples\data\Testdata.dbc;

SourceType=DBC',

'select * from customer where city = "Seattle"')

set region = "WW" 

go

-- check to verify which rows were updated

select * from openrowset('MSDASQL',

'Driver=Microsoft Visual FoxPro Driver;

SourceDB=e:\VFP90\samples\data\Testdata.dbc;

SourceType=DBC',

'select * from customer where region="WW"') 

go

-- OPENROWSET DSN example

/* Note the DSN Example might fail if SQL Server is configured to use a local account.*/ 

select * from openrowset('MSDASQL',

'DSN=Visual FoxPro Database;

SourceDB=e:\VFP90\samples\data\Testdata.dbc;

SourceType=DBC',

'select * from customer where country = "USA" order by city')

go

/* sp_addlinkedserver examples */ 

-- sp_addlinkedserver example with DSN

/* You will need to make a DSN and point it to the Testdata database. 

Modify your code accordingly for differences in location or DBC name */ 

/* Note this Example may fail if SQL Server is configured to use a local account.*/ 

sp_addlinkedserver 'VFP Testdata Database With DSN', 

'', 

'MSDASQL',

'VFP System DSN'

go

sp_addlinkedsrvlogin 'VFP Testdata Database With DSN', FALSE, NULL, NULL, NULL

go 

SELECT *

FROM OPENQUERY([VFP Testdata Database With DSN], 'select * from customer where city = "Seattle" ') 

go

-- We will set the region back to "WA" if it currently is "WW".

-- Update using OpenQuery

Update OPENQUERY([VFP Testdata Database With DSN], 'select * from customer where city = "Seattle" ') 

set region = "WA" 

go

-- Make sure that the region got updated.

SELECT *

FROM OPENQUERY([VFP Testdata Database With DSN], 'select * from customer where city = "Seattle" ') 

go

/* SP_addlinkedserver example with DSN-less connection */ 

/* This example also depends on the sample files Testdata.dbc

Modify your code accordingly for differences in location or DBC name */ 

sp_addlinkedserver 'VFP Testdata Database With No DSN', 

'', 

'MSDASQL',

NULL,

NULL,

'Driver={Microsoft Visual FoxPro Driver};UID=;PWD=;SourceDB=e:\VFP90\samples\data\Testdata.dbc;SourceType=DBC;Exclusive=No;BackgroundFetch=Yes;Collate=Machine;'

go

sp_addlinkedsrvlogin 'VFP Testdata Database With No DSN', FALSE, NULL, NULL, NULL

go

SELECT *

FROM OPENQUERY([VFP Testdata Database With No DSN], 'select * from customer where country = "USA" order by city') 

go

--====================================================

-- Using VFP 6.0 driver, read and update data from VFP sample dbf files

--====================================================

-- OPENROWSET DSN-less example

select * from openrowset('MSDASQL',

'Driver=Microsoft Visual FoxPro Driver;

SourceDB=e:\VFP90\samples\data;

SourceType=DBF',

'select * from customer where country != "USA" order by country')

go

-- perform UPDATE

Update openrowset('MSDASQL',

'Driver=Microsoft Visual FoxPro Driver;

SourceDB=e:\VFP90\samples\data;

SourceType=DBF',

'select * from customer where city = "Seattle"')

set region = "WW" 

go

-- verify update

select * from openrowset('MSDASQL',

'Driver=Microsoft Visual FoxPro Driver;

SourceDB=e:\VFP90\samples\data;

SourceType=DBF',

'select * from customer where region = "WW"')

go

-- OPENROWSET DSN example

-- DSN points to the folder where .dbf files are.

/* Note this Example may fail if SQL Server is configured to use a local account.*/ 

select * from openrowset('MSDASQL',

'DSN=Visual FoxPro Tables; 

SourceDB=e:\VFP90\samples\data;

SourceType=DBF',

'select * from customer where country != "USA" order by country') 

go
```

You can also use the Visual FoxPro OLE DB Provider to create a distributed query. It is the preferred technology to use. While this code shows how to update and delete data, adding, updating (editing), and deleting data in a distributed query using the OLE DB Provider is not supported.

The following T-SQL code example demonstrates how to set up and use distributed query with FoxPro with OpenQuery and `OpenRowset` functions. You can test this code in SQL Query Analyzer after you install the Visual FoxPro OLE DB Provider on an SQL Server 2000 machine. You will need to change the data source names and path to the FoxPro files as appropriate:

```sql
 '/* These OPENROWSET examples depend on the sample files VFP98\data\Testdata.dbc

'Modify your code accordingly for differences in location or DBC name */

--*====================================================

--* Using the DBC file, reading and updating data.

--*====================================================

--* A couple of OPENROWSET queries.

select * from openrowset('VFPOLEDB',

'e:\vfp7junk\Testdata.dbc';'Exclusive=No';'Data Source=DBC',

'select * from customer where country != "USA" order by country')

go

Select * from openrowset('VFPOLEDB',

'e:\vfp7junk\Testdata.dbc';'Exclusive=No';'Data Source=DBC',

'select * from customer where region="WA"')

go

--* Need to use an error trapping routine with the UPDATE and DELETE functions:

select * from

openrowset('VFPOLEDB',

'E:\VFP7Junk\Testdata.DBC';'Exclusive=No';'Data Source=DBC',

'Update Customer Set city = "SEATTLE" where region = "WA" ') 

go

declare @upderror int

select @upderror = @@error

print ''

if @upderror != 7357 and @upderror != 0

print 'Update failed with error '+convert(varchar(5),@upderror)

else

print 'Ignore the error above, the Update succeeded'

go

-- check to verify which rows were updated

select * from openrowset('VFPOLEDB',

'E:\VFP7junk\Testdata.DBC';'Exclusive=No';'Data Source=DBC',

'select * from customer where region = "WA"')

go

--* Change the City field back to "Seattle".

select * from

openrowset('VFPOLEDB',

'E:\VFP7Junk\Testdata.DBC';'Exclusive=No';'Data Source=DBC',

'Update Customer Set city = "Seattle" where region = "WA" ') 

go

declare @upderror int

select @upderror = @@error

print ''

if @upderror != 7357 and @upderror != 0

print 'Update failed with error '+convert(varchar(5),@upderror)

else

print 'Ignore the error above, the Update succeeded'

go

--* The DELETE fucntion also causes an error, but the DELETE works.

select * from

openrowset('VFPOLEDB',

'E:\VFP7Junk\Testdata.DBC';'Exclusive=No';'Data Source=DBC',

'Delete from Customer where country = "Spain" ') 

go

declare @delerror int

select @delerror = @@error

print ''

if @delerror != 7357 and @delerror != 0

print 'Delete failed with error '+convert(varchar(5),@delerror)

else

print 'Ignore the error above, the Delete succeeded'

go

--* Check to see that the records are deleted.

Select * from openrowset('VFPOLEDB',

'e:\vfp7junk\Testdata.dbc';'Exclusive=No';'Data Source=DBC',

'select * from customer where country = "Spain"')

go

--* Here are some examples using the VFP OLE DB Provider to create Linked Servers.

--* Using sp_addlinkedserver to create the Linked Server.

sp_addlinkedserver @server='VFP_Linked_Server',

@srvproduct='Microsoft Visual FoxPro OLE DB Provider', 

@provider='VFPOLEDB',

@datasrc = 'E:\vfp7junk'

go

SELECT *

FROM OPENQUERY([VFP_Linked_Server], 'select * from customer where city = "Seattle"')

go

-- The Update command will update the table with the OPENQUERY function when using the 

-- linked server, but the same error 7357 error will occur.

select * from

OPENQUERY([VFP_Linked_Server],

'Update Customer Set city = "SEATTLE" where region = "WA" ') 

go

declare @upderror int

select @upderror = @@error

print ''

if @upderror != 7357 and @upderror != 0

print 'Update failed with error '+convert(varchar(5),@upderror)

else

print 'Ignore the error above, the Update succeeded'

go

-- Check and see if the City field is all uppercase with "SEATTLE".

SELECT *

FROM OPENQUERY([VFP_Linked_Server], 'select * from customer where region = "WA"')

go

--* Let's check for how many records have the word "London" in the City field.

SELECT *

FROM OPENQUERY([VFP_Linked_Server], 'select * from customer where city = "London"')

go

-- We can also use the Delete command to remove records with the OPENQUERY function when using the 

-- linked server, but the same error 7357 error will occur.

select * from

OPENQUERY([VFP_Linked_Server],

'Delete from Customer where city = "London"') 

go

declare @delerror int

select @delerror = @@error

print ''

if @delerror != 7357 and @delerror != 0

print 'Delete failed with error '+convert(varchar(5),@delerror)

else

print 'Ignore the error above, the Delete succeeded'

go

/* SP_addlinkedserver example with DSN-less connection */

/* This example also depends on the sample files Testdata.dbc

Modify your code accordingly for differences in location or DBC name */

sp_addlinkedserver 'VFP Testdata Database With No DSN',

'',

'MSDASQL',

NULL,

NULL,

'Driver={Microsoft Visual FoxPro Driver};UID=;PWD=;SourceDB=e:\VFP8junk\Testdata.dbc;SourceType=DBC;Exclusive=No;BackgroundFetch=Yes;Collate=Machine;'

go

SELECT *

FROM OPENQUERY([VFP Testdata Database With No DSN], 'select * from customer where country = "USA" order by country')

go
```

## References

For more details on setting up and using Distributed Queries, take a look at `sp_addlinkedserver`, OpenQuery, OpenRowset, and related topics in SQL 7.0 Books Online.

To learn more about FoxPro, and `.dbf` and `.dbc` files, refer to the FoxPro product documentation.
