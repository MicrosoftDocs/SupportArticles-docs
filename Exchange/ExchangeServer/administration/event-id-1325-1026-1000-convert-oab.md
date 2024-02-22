---
title: Event ID 1325 and 1026 after you convert OAB
description: Resolves an issue in which you can't download the OAB in an Exchange Server 2010 environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: nourdinb, jmartin, genli, v-six
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
ms.date: 01/24/2024
---
# Event ID 1325, 1026, and 1000 after you convert OAB for Exchange Server 2010

_Original KB number:_ &nbsp; 2961921

## Summary

This issue occurs if you run the ConvertOABVdir.ps1 script on the Client Access Server that is running Windows Server 2012. Additionally, you can't download the OAB. Check out the [resolutions](#resolution) to resolve this issue.

## Cause

This issue occurs because the ConvertOABVdir.ps1 script configures the MSExchangeOabAppPool application pool to run .NET CLR Version 4.0 when the script is executed on a server that is running Windows Server 2012.

## Resolution

To resolve this issue, change the MSExchangeOabAppPool application pool to use .NET CLR Version 2.0. To do this, use one of the following methods.

### Method 1: Use IIS Manager

1. Open **Internet Information Services (IIS) Manager** on the Client Access Server, expand the server object, and then select **Application Pools**.
2. Right-click **MSExchangeOabAppPool**, and then select **Basic Settings**.
3. Select **.NET CLR Version v2.0.50727** from the **.NET CLR version** drop-down list and then click **OK**.
4. Right-click **MSExchangeOabAppPool** and select **Stop**.
5. Right-click **MSExchangeOabAppPool** and select **Start**.

### Method 2: Run script

Use a text editor to copy the original script without the trailing signature block (beginning at line 161) into a new script file, such as a *My-ConvertOABVdir.ps1* file.

Add the `$apppool.ManagedRuntimeVersion = "v2.0"` line after line #31 to create the .NET CLR Version 2.0 application pool in your .ps1 file. Then, execute your .ps1 file.

The following is a part of sample of this script:

```console
#29 # Create new app pool, then bind to it
#30 $a=$Iis.applicationPools.Add("MSExchangeOabAppPool")
#31 $apppool = $Iis.ApplicationPools["MSExchangeOabAppPool"]

#33 # add this line: make sure we create a .Net v2.0 app pool, regardless off underlying OS.
#34 $apppool.ManagedRuntimeVersion = "v2.0"

#36 # Now make sure it runs as LocalSystem, and prevent unnecessary app pool restarts
#37 $apppool.ProcessModel.IdentityType = [Microsoft.Web.Administration.ProcessModelIdentityType]"LocalSystem"
#38 $apppool.ProcessModel.idleTimeout = "0.00:00:00"
#39 $apppool.Recycling.PeriodicRestart.time = "0.00:00:00"
```

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in **Applies to**.
