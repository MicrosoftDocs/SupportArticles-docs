---
title: LyncBackupService.exe stops responding after pool pairing enabled on a Skype for Business 2019 server
ms.author: v-six
author: simonxjx
manager: dcscontentpm
ms.date: 10/04/2019
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Skype for Business 2019
ms.custom: 
  - CI 108454
  - CSSTroubleshoot
ms.reviewer: joaol
description: How to resolve an issue where LyncBackupService.exe stops responding after enabling pool pairing on a Skype for Business 2019 server.
---

# LyncBackupService.exe stops responding after pool pairing Skype for Business Server 2019

## Symptoms
You receive Event ID 4007 and LyncBackupservice.exe stops responding after enabling pool pairing for two pools on a Skype for Business Server 2019. The following details appear in the log:

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
[Front End pool disaster recovery in Skype for Business Server](/skypeforbusiness/plan-your-deployment/high-availability-and-disaster-recovery/disaster-recovery)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
