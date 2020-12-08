---
title: Event ID 513 when running VSS in Windows Server
description: 
ms.date: 12/04/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# Event ID 513 when running VSS in Windows Server

_Original product version:_ &nbsp; Windows Server version 1803, Windows Server version 1709, Windows Server version 1803, Windows Server 2016  
_Original KB number:_ &nbsp; 3209092

## Symptoms

In Windows Server, w hen an application calls the Volume Shadow Copy Service (VSS) to run a backup, event 513 may be generated: 

Log Name: Application
Source: Microsoft-Windows-CAPI2
Event ID: 513
Task Category: none
Level: Error

Description:
An error occurred in Cryptographic Services while processing the OnIdentity() call in System Writer Object.

Details:
AddLegacyDriverFiles: Unable to back up image of binary Microsoft Link-Layer Discovery Protocol.

System Error:
Access is denied. 

## Cause

This problem occurs because VSS System Writer does not have permission to read the NT AUTHORITY\SERVICE (service account). When System Writer runs as a cryptographic service and tries to read the Mslldp.sys information from a Microsoft Link-Layer Discovery Protocol driver, the "access denied" error is generated. 

## Workaround

This event log entry can be safely ignored. To prevent this entry from being logged, grant the required permission to the Microsoft Link-Layer Discovery Protocol driver (Mslldp.dll) to process System Writer. 
 To do this, follow these steps: 
1. Open an administrative Command Prompt window, and then run the following command to check the current permissions: **sc sdshow mslldp**  
2. Copy the output string from step 1, append it with **(A;;CCLCSWLOCRRC;;;SU)**, and then run the following command to add the access permission to Mslldp.dll: **sc sdset mslldp <string>**  
For example, run the following command: **sc sdset mslldp D:(D;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BG)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;SY)(A;;CCDCLCSWRPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWRPWPDTLOCRRC;;;SO)(A;;LCRPWP;;;S-1-5-80-3141615172-2057878085-1754447212-2405740020-3916490453)(A;;CCLCSWLOCRRC;;;SU)** 
