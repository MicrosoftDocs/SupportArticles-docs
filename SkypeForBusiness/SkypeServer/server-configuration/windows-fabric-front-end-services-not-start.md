---
title: Windows Fabric, Front-end services won't start on system with 4K native disk
description: After Skype for Business Server 2015 install on Windows Server 2016 or Server 2012 R2 with 4K native disk, Windows Fabric or Front-end service won't start.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: v-six
appliesto: 
  - Skype for Business Server 2015
ms.date: 03/31/2022
---

# Windows Fabric, Front-end services won't start after Skype for Business Server 2015 installed on Windows Server 2016 or Server 2012 R2 system with 4K native disk

## Symptoms

After you install Skype for BusinessServer 2015 on a Windows Server 2016 or Windows Server 2012 R2 system that use a 4K native disk, the "Windows Fabric" and "Front-end" services won't start. 

Additionally, the following events are logged:  

### Application event log   

```AsciiDoc 
Log Name:      Application
 Source:        Application Error
 Date:         
 Event ID:      1000
 Task Category: (100)
 Level:         Error
 Keywords:      Classic
 User:          N/A
 Computer:     
 Description:
 Faulting application name: FabricHost.exe, version: 3.0.8549.9492, time stamp: 0x550aaac2
 Faulting module name: FabricHost.exe, version: 3.0.8549.9492, time stamp: 0x550aaac2
 Exception code: 0xc0000602
 Fault offset: 0x000000000006ea09
 Faulting process id: 0x1840
 Faulting application start time: 0x01d34359621e2925
 Faulting application path: C:\Program Files\Windows Fabric\bin\FabricHost.exe
 Faulting module path: C:\Program Files\Windows Fabric\bin\FabricHost.exe
 Report Id: 3ee46cf7-28a2-4575-ae37-0c4ffbeecc5e
 Faulting package full name:
 Faulting package-relative application ID:       
```

### Lync Server log   

```AsciiDoc
Log Name:      Lync Server
 Source:        LS Server
 Date:         
 Event ID:      12330
 Task Category: (1000)
 Level:         Error
 Keywords:      Classic
 User:          N/A
 Computer:     
 Description:
 Failed starting a worker process.

Process: 'C:\Program Files\Skype for Business Server 2015\Server\Core\RtcHost.exe'  Exit Code: 0xC3E8302D(SIPPROXY_E_WORKER_PROCESS_SLOW_INITIALIZING).
 Cause: This could happen due to low resource conditions or insufficient privileges.
 Resolution:
 Try restarting the server. If the problem persists contact Product Support Services.       
```

### Microsoft-Windows-WindowsFabric/Admin log  

```AsciiDoc
Log Name:      Microsoft-Windows-WindowsFabric/Admin
 Source:        Microsoft-Windows-WindowsFabric
 Date:         
 Event ID:      53760
 Task Category: FabricSetup
 Level:         Error
 Keywords:      Default
 User:          SYSTEM
 Computer:     
 Description:
 EventTraceInstaller::Install failed with error E_FAIL       
```

### Microsoft-Windows-WindowsFabric/Admin log

```AsciiDoc
Log Name:      Microsoft-Windows-WindowsFabric/Admin
 Source:        Microsoft-Windows-WindowsFabric
 Date:         
 Event ID:      53761
 Task Category: FabricSetup
 Level:         Warning
 Keywords:      Default
 User:          SYSTEM
 Computer:     
 Description:
 Method EnableTracingOnDCS failed with HRESULT: -2147024809
```

### Microsoft-Windows-WindowsFabric/Admin log   

```AsciiDoc
Log Name:      Microsoft-Windows-WindowsFabric/Admin
 Source:        Microsoft-Windows-WindowsFabric
 Date:         
 Event ID:      23041
 Task Category: Hosting
 Level:         Warning
 Keywords:      Default
 User:          SYSTEM
 Computer:     
 Description:
 FabricSetup operation returned errorcode E_FAIL     
```

## Cause

This issue occurs because the current version of Windows Fabric is incompatible with 4K native disks.

To determine the physical and logical sector size of the disk, run the following command from an elevated command prompt:

```powershell
fsutil fsinfo ntfsinfo c:
```

If the **Bytes Per Sector** and **Bytes Per Physical Sector** fields are both set to **4096**, native 4K disks are being used. 

## More information

Skype for Business Server 2015 uses Windows Fabric 3.0, which is not supported on 4K native disks. You must install Skype for Business Server 2015 on non-4K native disks.
For more information about 4k sector disks, see the following articles:

- [Advanced format (4K) disk compatibility update](/windows/compatibility/advanced-format-disk-compatibility-update) 
- [Microsoft support policy for 4K sector hard drives in Windows](https://support.microsoft.com/help/2510009)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
