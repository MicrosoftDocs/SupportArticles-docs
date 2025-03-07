---
title: Usability limit for Volume Shadow Copy Service
description: Provides a workaround for usability limit of Volume Shadow Copy Service (VSS).
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, folkertb
ms.custom:
- sap:backup,recovery,disk,and storage\partition and volume management
- pcy:WinComm Storage High Avail
---
# Usability limit for Volume Shadow Copy Service (VSS)

This article provides a workaround for usability limit of Volume Shadow Copy Service (VSS).

_Original KB number:_ &nbsp; 2967756

## Symptoms

You may receive an error message or notice a failure if you try to perform one of the following operations on Windows client or Windows Server operating systems:  

- You enable the Volume Shadow Copy Service (VSS) on a volume that is larger than 64 terabytes (TB).
- You create writable snapshots or snapshots that are larger than 64 TB.
- You enable VSS for a shared folder on a volume that is larger than 64 TB.
- You run a backup operation on a volume that is larger than 64 TB that has a shadow copy enabled.
- You run chkdsk.exe on a volume that is larger than 64 TB.  

The error message may include:  
>
>- STOP: 0x0000007E
>
>- Failed to create a shadow copy of volume < **Drive_letter** >.
>
>- Error 0x80042306: The shadow copy provider had an error. Check the System and Application event logs for more information.
>
>- Event ID: 12289. Error: 0x80070057. The parameter is incorrect.

## Cause

This issue occurs because Microsoft does not support VSS on volumes larger than 64 TB. Also, writable snapshots or snapshots larger than 64 TB are not supported.

## Workaround

To work around this issue, do not perform any of the operations that are described in the "Symptoms" section on a volume that is larger than 64 TB.

## More information

For more information about VSS, go to the following Microsoft websites:  
[Volume Shadow Copy Service](https://msdn.microsoft.com/library/ee923636%28v=ws.10%29.aspx)  

[How Volume Shadow Copy Service works](https://technet.microsoft.com/library/cc785914%28v=ws.10%29.aspx)  

[Scalability factors for shadow copies](https://technet.microsoft.com/library/cc755419%28v=ws.10%29.aspx)  

[Best practices for shadow copies of shared folders](https://technet.microsoft.com/library/cc753975.aspx)
