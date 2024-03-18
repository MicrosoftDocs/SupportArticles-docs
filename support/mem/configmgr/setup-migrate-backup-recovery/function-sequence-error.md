---
title: Function sequence error in Smsdbmon.log
description: Describes an issue in which a Function sequence error entry is repeatedly logged in Smsdbmon.log in Configuration Manager current branch version 1902.
ms.date: 12/05/2023
ms.custom: sap:Site Server and Roles\Site and Component Status Monitoring
ms.reviewer: kaushika
---
# Function sequence error repeatedly logged in Smsdbmon.log in Configuration Manager current branch version 1902

This article describes an issue in which the **Function sequence error** entry is repeatedly logged in Smsdbmon.log in Configuration Manager current branch version 1902.

_Original product version:_ &nbsp; Configuration Manager (current branch - version 1902)  
_Original KB number:_ &nbsp; 4508760

## Symptoms

After you install or update to Configuration Manager current branch version 1902, the following error entry is repeatedly logged in the Smsdbmon.log file:

> SMS_DATABASE_NOTIFICATION_MONITOR    *** exec dbo.spGetChangeNotifications  
> SMS_DATABASE_NOTIFICATION_MONITOR    *** [HY010][0][Microsoft][ODBC Driver Manager] Function sequence error  

## Resolution

To fix this issue, update to [Configuration Manager current branch version 1906](/mem/configmgr/core/plan-design/changes/whats-new-in-version-1906).

## More information

This error message can be safely ignored.
