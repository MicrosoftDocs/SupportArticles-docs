---
title: Mobile device management installation fails
description: Describes a problem in which you receive the Call to HttpSendRequestSync failed for port 443 with status code 401 error when trying to enable a mobile device on a management point.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Site Server and Roles\Management Point Operations
---
# Mobile device management installation errors on System Center 2012 Configuration Manager SP1 management point

This article provides a solution for the error that occurs when you try to enable a mobile device on a management point in Microsoft System Center 2012 Configuration Manager Service Pack 1 (SP1).

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager Service Pack 1  
_Original KB number:_ &nbsp; 2814125

## Symptoms

When you attempt to enable a mobile device on a management point enabled for mobile devices in System Center 2012 Configuration Manager SP1, you may see this error in the mpcontrol.log:

> Call to HttpSendRequestSync failed for port 443 with status code 401, text: Unauthorized

## Cause

This issue can occur if the .NET Framework 4 is installed on the server before IIS is enabled.

## Resolution

To resolve this issue, follow the steps below:

1. Open a command prompt with administrative privileges.
2. Run the following command:

   ```console
   %windir%\Microsoft.NET\Framework64\v4.0.30319\aspnet_regiis.exe -i -enable
   ```

## More information

For more information, see [ASP.NET IIS Registration Tool (Aspnet_regiis.exe)](/previous-versions/k6h9cz8h(v=vs.100)).

The .NET Framework 4 can be installed side-by-side with previous versions of the .NET Framework on a single computer. If IIS was previously enabled on the computer, the setup process for the .NET Framework automatically registers ASP.NET 4 with IIS. However, if you install the .NET Framework 4 before you enable IIS, you must run the ASP.NET IIS Registration tool in order to register the .NET Framework with IIS and create application pools that use the .NET Framework 4.

For more information, see [Prerequisites for Site System Roles](/previous-versions/system-center/system-center-2012-R2/gg682077(v=technet.10)?redirectedfrom=MSDN#prerequisites-for-site-system-roles).
