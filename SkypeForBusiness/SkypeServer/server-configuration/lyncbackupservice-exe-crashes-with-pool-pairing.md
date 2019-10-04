---
title: "Title goes here"
ms.author: v-todmc
author: todmccoy
manager: dcscontentpm
ms.date: 2/5/2019
ms.audience: Admin|ITPro|Developer
ms.topic: article
ms.service: sharepoint-online
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- SharePoint Online 
ms.custom: CI ID
ms.reviewer: aliases for tech reviewers and CI requestor
description: "How to resolve the error "Virus Found" in SharePoint Server 2013 when the antivirus scanner is unavailable ."
---

# LyncBackupService.exe stops responding after pool pairing enabled on a Skype for Business 2019 

## Symptoms
You receive Event ID 4007 and LyncBackupservice.exe stops responding after enabling pool pairing for two or more pools on a Skype for Business 2019 CU1 server. The following details appear in the log:

```
     Log Name:      Lync Server
Source:        LS Backup Service
Date:          xx/xx/xxxx xx:xx:xx
Event ID:      4007
Task Category: (4000)
Level:         Error
Keywords:      Classic
User:          N/A
Computer:      FE1.contoso.com
Description:
An unhandled exception was encountered.

Exception Details. System.NullReferenceException: Object reference not set to an instance of an object.
   at Microsoft.Rtc.BackupService.BackupModuleHandler..ctor(IBackupModule backupModule, Topology topology)
   at Microsoft.Rtc.BackupService.BackupModuleController.RefreshBackupModuleHandlers()
```

## Cause
When enabling the pool pairing service for the first time, the Skype for Business server installs LyncBackupService.exe using RTM binaries whether or not the Skype for Business Server 2019 Cumulative Update has  already been installed.

The Skype for Business Server 2019 Cumulative Updates include an update to the LyncBackupService. The crash occurs because of a mismatch between versions of Lyncbackupservice and the Skype for Business Server 2019 Core Components.

## Resolution
To fix this issue, run the Skype for Business Server Cumulative Update installer again in order to patch the LyncBackupService to a version compatible with the Skype for Business Server 2019 Core Components.

## More information
[Front End pool disaster recovery in Skype for Business Server](https://docs.microsoft.com/en-us/skypeforbusiness/plan-your-deployment/high-availability-and-disaster-recovery/disaster-recovery)
