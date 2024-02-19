---
title: Error 1079 when services fail to start
description: Fixes error 1079 that occurs when some services fail to start on a computer that's running Windows 7.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:permissions-access-control-and-auditing, csstroubleshoot
---
# Service fails to start and you receive an error 1079 on a computer that's running Windows 7

This article helps fix error 1079 that occurs when some services fail to start on a computer that's running Windows 7.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2478117

## Symptoms

One or more of the following services may fail to start on a computer that's running Windows 7:

- Windows Time (W32Time)
- Windows Event Log (eventlog)
- Windows Firewall (MpsSvc)

Additionally, when trying to start the service manually, you may receive the following error message:

> Error 1079: The account specified for this service is different from the account specified for other services running in the same process

## Cause

The service is started by the **Local System** account instead of the **Local Service** account (**NT AUTHORITY\LocalService**). The **Local System** account may have insufficient permissions to start the service.

## Resolution

Set the service and any dependent services to run under the **NT AUTHORITY\LocalService** account.

For example, for the Windows Firewall service, follow the steps:

1. Select **Start**, type *`Services.msc`* in the **Search programs and files** box, and then press Enter.
2. Locate and double-click the **Windows Firewall** service.
3. Select the **`Log On`** tab.
4. In **This account** text box, type *`NT AUTHORITY\LocalService`*.
5. Set both **Password** fields blank.
6. Select **Apply**, and then select **OK**.
7. Repeat these steps for the **Base Filtering Engine** service.
8. Restart both services.
