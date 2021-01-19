---
title: Error 1079 when services fail to start
description: This article provides help to fix the error 1079 that occurs when some services fail to start on a computer that is running Windows 7.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Permissions, access control, and auditing
ms.technology: windows-server-security
---
# Services fail to start and you receive an error 1079 on a computer that is running Windows 7

This article provides help to fix the error 1079 that occurs when some services fail to start on a computer that is running Windows 7.

_Original product version:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2478117

## Symptoms

One of more of the following services may fail to start on a computer that is running Windows 7:

- Windows Time (W32Time)
- Windows Event Log (eventlog)
- Windows Firewall (MpsSvc)

Additionally, when trying to start the service manually, you may receive the following error message:

> Error 1079: The account specified for this service is different from the account specified for other services running in the same process

## Cause

The issue may occur if the service is started by the **Local System** account instead of by the **Local Service** account (**NT AUTHORITY\LocalService**). The **Local System** account may have insufficient permissions to start the service.

## Resolution

Set the service and any dependent services to run under the **NT AUTHORITY\LocalService** account.

For example, for the Windows Firewall service, follow the steps:

1. Click Start, type *Services.msc* in the **Search programs and files** box, and then press **ENTER**,
2. Locate and double-click the **Windows Firewall** service.
3. Click the **Log On** tab,
4. In **This account** text box, type *NT AUTHORITY\LocalService*.
5. Set both **Password** fields blank.
6. Click **Apply** and then **OK**,
7. Repeat these steps for the **Base Filtering Engine** service.
8. Restart both services.
