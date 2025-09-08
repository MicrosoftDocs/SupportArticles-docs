---
title: Time service does not correct the time
description: Provides a resolution for the issue that Windows Time service does not correct the time if the service gets into Spike state.
ms.date: 03/28/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:active directory\windows time service configuration,accuracy,and synchronization
- pcy:WinComm Directory Services
---
# When SpecialPollInterval is used as a polling interval, the Windows Time service does not correct the time if the service gets into Spike state

This article provides a resolution for the issue that Windows Time service does not correct the time if the service gets into Spike state.

_Applies to:_ &nbsp; Windows Server (All supported versions), Windows client (All supported versions)  
_Original KB number:_ &nbsp; 2638243

## Symptoms

An NTP client computer that is running Windows Server editions or Windows Client editions may not correct the time if the following conditions are true:  

- The NTP client syncs its time with the manually specified NTP server.
- The NTP client uses SpecialPollInterval as a polling interval.
- The time offset between the NTP client and the NTP server is greater than the LargePhaseOffset as configured in the NTP client.  

In this situation, the NTP client cannot correct its time even after waiting for SpikeWatchPeriod to pass.

## Cause

This problem occurs because the NTP client gets into SPIKE state every time the client polls the time sample to the NTP server. The Time service manages its internal status, and if the client gets into SPIKE state, the client does not sync its time.

## Resolution

To work around this issue so that the NTP client is enabled to sync with the NTP server after a SPIKE state, configure Windows Time to use the MinPollInterval/MaxPollInterval as the polling interval.

To configure Windows Time to use the MinPollInterval/MaxPollInterval as the polling interval, follow these steps:  

1. Click **Start**, click **Run**, type cmd, and then press ENTER.

    > [!NOTE]
    > In Windows 8 or Windows Server 2012, press the Windows logo Key+R to open the **Run** box, type cmd in the **Run** box, and then press ENTER.  
2. At the command prompt, type the following command. After you type the command, press ENTER.

    ```console
        w32tm /config /update /manualpeerlist:NTP_server_IP_Address,0x8 /syncfromflags:MANUAL  
    ```  

    > [!NOTE]
    > When you use the 0x1 flag with the `/manualpeerlist` switch, you specify use of SpecialPollInterval . To work around this problem, do not use the 0x1 flag.  

## Workaround

If you want to use "SpecialPollinterval", you should change the following registry:

Key: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Config`  
Value: MinPollInterval  
Type: DWORD  

To avoid this issue, the registry key should apply conditional expression as follows:  
Conditional expression:  
SpecialPollInterval<(2^MinPollInterval)*(HoldPeriod+1)  
Domain member computer has default values:  

- MinPollInterval=10
- HoldPeriod=5  

> [!NOTE]
> If you set Windows Time Service's settings by Group Policy or Local Group Policy, this workaround does not work and you have to delete Policy settings.

## Status

Microsoft has confirmed that it is a problem in the Microsoft products that are listed in the "Applies to" section.

## More information

The polling interval that Windows Time uses is set by the following registry subkey:  
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Parameters`

If the value of the NtpServer entry in this subkey contains 0x1, Windows Time uses SpecialPollInterval as the polling interval. Otherwise, Windows Time uses MinPollInterval/MaxPollInterval. For additional Information about the Windows Time Service and registry values, visit the following Microsoft Web site:  
 [https://technet.microsoft.com/library/cc773263(WS.10).aspx](https://technet.microsoft.com/library/cc773263%28ws.10%29.aspx)
