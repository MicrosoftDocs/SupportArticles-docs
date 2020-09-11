---
title: Add a Visual FoxPro database to SQL Server
description: This article describes how to programmatically add and query a Visual FoxPro data source as a linked server from Visual FoxPro.
ms.date: 09/08/2020
ms.prod-support-area-path: 
ms.topic: how-to
ms.prod: visual-studio
---
# How to add a Visual FoxPro database to SQL Server as a linked server

This article introduces how to programmatically add and query a Visual FoxPro data source as a linked server from Visual FoxPro.

_Original product version:_ &nbsp; Visual FoxPro  
_Original KB number:_ &nbsp; 199131

## Summary

SQL Server 7.0 and SQL Server 2000 allows the addition of external data sources as linked servers. This feature provides access to distribute, heterogeneous queries against OLE DB data sources. This article shows how to programmatically add and query a Visual FoxPro data source as a linked server from Visual FoxPro.

## More information

`sp_addlinkedserver` is a new stored procedure introduced in SQL Server 7.0 and SQL Server 2000. `sp_addlinkedserver` creates a linked server, which allows access to distribute, heterogeneous queries against OLE DB data sources.

The syntax for adding a linked server from Transact - SQL is:

```sql
 sp_addlinkedserver [@server =] 'server',
 [@srvproduct =] 'product_name',
 [@provider =] 'provider_name',
 [@datasrc =] 'data_source',
 [@location =] 'location',
 [@provstr =] 'provider_string',
 [@catalog =] 'catalog'[@server =] 'server' Is the name of the linked server to
 create with sp_addlinkedserver.

[@srvproduct =] 'product_name' Is the product name of the OLE DB data
 source to add as a linked server.

[@provider =] 'provider_name' Is the unique provider identifier of the
 OLE DB provider corresponding to the
 data source.

[@datasrc =] 'data_source' Is the name of the data source, as
 interpreted by the OLE DB provider.

[@location =] 'location' Is the location of or path to the
 database as interpreted by the OLE DB
 provider.

[@provstr =] 'provider_string' Is the OLE DB provider-specific.

[@catalog =] 'catalog' Is the catalog to be used when making a
 connection to the OLE DB provider.
```

The following code snippet adds the Visual FoxPro database `Testdata.DBC` from the SAMPLES\DATA directory to SQL Server as a linked server. This code snippet assumes that Visual FoxPro and SQL Server are being run on the same machine.

> [!NOTE]
> The user, **Username**, must have permissions to perform these operations on the database.

```sql
 Source_Path=IIF(VAL(SUBSTR(VERSION(),15,2))=6,HOME(2),HOME()+"SAMPLES\")
 Connect_String='DRIVER={SQL Server};' + ;
 'SERVER=MY_SERVER;DATABASE=PUBS;UID=UserName;PWD=StrongPassword'
 gnConnHandle=SQLSTRINGCONN(Connect_String)
 IF gnConnHandle > 0
 * Create a command string to pass to SQL Server via SQLExec
 SQLCommand="sp_addlinkedserver 'VFP','','MSDASQL',NULL,NULL,"+ ;
 "'DRIVER={Microsoft Visual FoxPro Driver};" + ;
 "SourceDB="+Source_Path+"DATA\TESTDATA.DBC;SourceType=DBC;NULL'"* CREATE the LINKED Server"
 Create_Linked_Server=SQLExec(gnConnHandle,SQLCommand)
 IF Create_Linked_Server > 0
 * The linked server was successfully created
 * Run the query
 =RunQuery()
 ELSE
 * The Linked Server either already exists or the command failed.
 * Test for existence of linked server with aerror()
 =AERROR(s_failed)
 IF "VFP' ALREADY EXISTS."$UPPER(s_failed[1,2])
 * The linked server exists, so run the query
 =RunQuery()
 ELSE
 * The linked server doesn't exist, so display a message
 =MESSAGEBOX(s_failed[1,2],32,'Failed')
 ENDIF
 ENDIF
 =SQLDISCONN(gnConnHandle)
 ENDIF

PROCEDURE RunQuery
 SQLCommand="SELECT * FROM OPENQUERY(VFP,'SELECT * FROM CUSTOMER')"
 QRYVal=SQLExec(gnConnHandle,SQLCommand,'SQLRESULTS')
 IF QRYVal > 0
 SELECT SQLResults
 BROW
 ELSE
 =AERROR(L_Server)
 =MESSAGEBOX(L_Server[1,2],32,'Query Failed')
 ENDIF
 RETURN
```

After running the code snippet, open SQL Server Enterprise Manager and expand the Linked Servers node. A linked server named VFP has been added.

## References

For more information about `sp_addlinkedserver`, search for `sp_addlinkedserver` in the Transact - SQL Reference Help file.
