---
title: You can't start the User Profile Synchronization service in SharePoint Server 2013
description: Describes an issue in which the User Profile Synchronization service can't be started in SharePoint Server 2013 if the synchronization database is involved in a database mirroring session or an availability group.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - SharePoint Server 2013
ms.date: 12/17/2023
---

# You can't start the User Profile Synchronization service

## Symptoms  

You can't start the User Profile Synchronization service in Microsoft SharePoint Server 2013. The service shows a status of either **Starting** or **Stopped**. Additionally, the following error entry is logged in the ULS log:

```output
OWSTIMER.EXE (0x2B80) 0x3370 SharePoint Portal Server User Profiles g144 Unexpected Failed to set the new Service Broker on database <SyncDB> on server <ServerName>. Exception: The operation cannot be performed on database <SyncDB> because it is involved in a database mirroring session or an availability group. Some operations are not allowed on a database that is participating in a database mirroring session or in an availability group.  ALTER DATABASE statement failed.  ALTER DATABASE statement failed.    
OWSTIMER.EXE (0x2B80) 0x3370 SharePoint Portal Server User Profiles 9sip High UserProfileApplication.SynchronizeMIIS: Failed to configure MIIS post database, will attempt during next rerun. Exception: System.Data.SqlClient.SqlException (0x80131904): The operation cannot be performed on database <SyncDB> because it is involved in a database mirroring session or an availability group. Some operations are not allowed on a database that is participating in a database mirroring session or in an availability group.  ALTER DATABASE statement failed.  ALTER DATABASE statement failed.       
at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)       
at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)       
at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)       
at System.Data.SqlClient.SqlCommand.RunExecuteNonQueryTds(String methodName, Boolean async, Int32 timeout, Boolean asyncWrite)       
at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, String methodName, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry)       
at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()       
at Microsoft.Office.Server.Data.SqlSession.ExecuteNonQuery(SqlCommand command)       
at Microsoft.Office.Server.Administration.SynchronizationDatabase.EnableServiceBroker()  
at Microsoft.Office.Server.Administration.UserProfileApplication.SetupSynchronizationService(ProfileSynchronizationServiceInstance profileSyncInstance)    
ClientConnectionId:<Id>  Error Number:1468,State:1,Class:16.    
OWSTIMER.EXE (0x2B80) 0x3370 SharePoint Portal Server User Profiles 9i1u Medium UserProfileApplication.SynchronizeMIIS: End setup for 'User Profile Service Application'.        
```

## Cause  

The issue occurs if the synchronization database is involved in a database mirroring session or an availability group.

## Resolution  

To resolve the issue, follow these steps:

1. Remove the \<SyncDB\> synchronization database from the database mirroring session or the availability group.
2. Stop the User Profile Synchronization service.
3. Restart the User Profile Synchronization service.
4. Restore the \<SyncDB\> synchronization database to the availability group.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
