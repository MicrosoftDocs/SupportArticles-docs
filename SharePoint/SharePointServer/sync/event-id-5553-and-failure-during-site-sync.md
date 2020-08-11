---
title: Failure trying to synch site  - Event ID 5553
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: sharepoint-powershell
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Microsoft SharePoint
---

# Event ID 5553 when during a site sync

## Symptoms  

You notice the following event in the Application Event log on SharePoint Server.  

```
Log Name:      Application  
Source:           Microsoft-SharePoint Products-SharePoint Portal Server  
Date:              <Todays Date>  
Event ID:       5553  
Task Category: User Profiles  
Level:              Error  
Keywords:        
User:            <User>  
Computer:    <SharePoint Server Name>  
Description:  
failure trying to synch site <Site GUID> for ContentDB <Content Database GUID> WebApp <Web Application GUID>. Exception message was Cannot insert duplicate key row in object 'dbo.UserMemberships' with unique index 'CX_UserMemberships_RecordId_MemberGroupId_SID'.  
The statement has been terminated.  
```

## Cause  

This event occurs when the SharePoint Timer Job "User Profile to SharePoint Full Synchronization" fails. The "User Profile to SharePoint Full Synchronization" job runs every hour by default. The most common reason for this job to fail is inconsistent user profile data between the user profile service, and the content database. This inconsistency can occur when content databases are deleted or incorrectly moved.  

## Resolution  

You can use stsadm command to list information about the databases that have not been synchronized with the user profile service.   

```  
stsadm -o sync -listolddatabases n  
stsadm -o sync -deleteolddatabases n  
```  

where 'n' is the number of days that have passed since the databases have been synchronized.  

The '-listolddatabases' command lists the content databases that have not been synchronized since 'n' days while the 'deleteolddatabases' command performs the same operation as the listolddatabases parameter, except it deletes old records corresponding to these databases. It does not delete the databases themselves. Once the synchronization references are deleted and a new profile synchronization occurs, new references will be stored in the database.  

You must run the stsadm shell as the farm account for the previous commands to work successfully.  

## More Information  

[Move Content Databases](https://technet.microsoft.com/library/cc287899.aspx)  

[Stsadm Sync Commands](https://technet.microsoft.com/library/cc263196%28v=office.12%29.aspx)

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
