---
title: Kernel event ID 2 when calling MSFT_NetLbfoTeamNic
description: Describes an issue that triggers kernel event ID 2 when the MSFT_NetLbfoTeamNic class is called in Windows Server 2012 R2. A workaround is provided.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, steved
ms.custom: sap:windows-nic-teaming-load-balance-failover, csstroubleshoot
ms.technology: networking
---
# Kernel event ID 2 is logged when the MSFT_NetLbfoTeamNic class is called in Windows Server 2012 R2

This article provides a workaround for an issue that triggers kernel event ID 2 when the MSFT_NetLbfoTeamNic class is called in Windows Server 2012 R2.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3087042

## Symptoms

When Windows Server 2012 R2 is used with the NIC Teaming feature, and a third-party WMI provider is used to call the MSFT_NetLbfoTeamNic  WMI class, the following event is logged:

> Source: Kernel-EventTracing/Admin  
Event ID: 2  
Session "" failed to start with the following error: 0xC0000022

This article addresses only this specific error that occurs when NIC Teaming is being used. This error is not the fault of the third-party WMI provider. Additionally, this event may be logged for reasons that are not related to the NIC Teaming WMI provider.

## Cause

This problem is not caused by the third-party WMI provider. This problem is being tracked for consideration in a future version of Windows Server.

The Windows Server 2012 R2 MSFT_NetLbfoTeamNic WMI class uses the iNetCfg interface. The iNetCfg interface is associated with the NetCfgTrace kernel logging provider, which is automatically enabled by Windows. Trace data is automatically saved to the C:\\Windows\\inf\\netcfgx.0.etl file. All WMI providers run under the context of the WMIPRVSE process, which in turn runs under the NETWORK SERVICE account. However, if a WMI provider calls the MSFT_NetLbfoTeamNic class, the NETWORK SERVICE account does not have authority to write trace data to this file.

## Workaround

If the scenario that's described in the "Symptoms" section triggers the kernel event ID 2 error, the error is harmless and can be safely ignored.

If you want to prevent this error from being logged, open an administrative command prompt, and then run the following commands:

```console
Takeown /f c:\windows\inf  
icacls c:\windows\inf /grant "NT AUTHORITY\NETWORK SERVICE":"(OI)(CI)(F)"  
icacls c:\windows\inf\netcfgx.0.etl /grant "NT AUTHORITY\NETWORK SERVICE":F  
icacls c:\windows\inf\netcfgx.1.etl /grant "NT AUTHORITY\NETWORK SERVICE":F
```

These commands grant the necessary file permissions to prevent the error logging in this scenario.

You may also want to reset the owner of C:\Windows\inf back to the NT SERVICE\TrustedInstaller account (the default setting). To do this, follow these steps:

1. In Windows Explorer, navigate to C:\Windows, right-click the **C:\Windows\INF** directory, and then select **Properties**. On the **Security** tab, click **Advanced**.
2. Next to **Owner**, click **Change**.
3. Click **Location**, and then select the local computer (you may have to scroll up if you've joined a domain).
4. In the Object name, enter *NT SERVICE\TrustedInstaller*, select **Check Names**, and then click **OK**.
Finally, run the icacls command to make sure that the NETWORK SERVICE account is set for inheritance, as in the following example:

    ```console
    C:\>icacls c:\windows\inf

    C:\Windows\inf NT AUTHORITY\NETWORK SERVICE:(OI)(CI)(F)

    [...]
    ```
