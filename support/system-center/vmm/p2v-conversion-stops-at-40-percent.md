---
title: VMM P2V conversion stops at 40 percent
description: Fixes an issue in which a physical to virtual (P2V) conversion in Virtual Machine Manager stops at 40 percent with error 0x809933BB or 0x80070539.
ms.date: 09/11/2020
---
# VMM P2V fails at 40 percent with error 0x809933BB or 0x80070539

This article helps you fix an issue in which a physical to virtual (P2V) conversion in Virtual Machine Manager (VMM) stops at 40 percent with error 0x809933BB or 0x80070539.

_Original product version:_ &nbsp; System Center Virtual Machine Manager  
_Original KB number:_ &nbsp; 2019392

## Symptoms

When performing an online P2V conversion, the process stops at 40 percent every time and you see the following errors:

**Job result in VMM admin console**

> Error (13243)  
> The snapshot creation failed because the VSS writer {4dc3bdd4-ab48-4d07-adb0-3bee2926fd7f} on source machine xxx did not respond within the expected time interval.  
> (Internal error code: 0x809933BB)
>
> Recommended action:  
> Ensure that VSS writer is functioning properly and then try the operation again.
4dc3bdd4-ab48-4d07-adb0-3bee2926fd7f is the Shadow Copy Optimization Writer

**Event in Application event log on the source machine**

> Log Name:      Application  
> Source:        VSS  
> Date:          \<DateTime>  
> Event ID:      8193  
> Task Category: None  
> Level:         Error  
> Keywords:      Classic  
> User:          N/A  
> Computer:      ServerName.contoso.com  
> Description:  
> Volume Shadow Copy Service error: Unexpected error calling routine ConvertStringSidToSid.  hr = 0x80070539.
>  
> Operation:  
   OnIdentify event  
   Gathering Writer Data
>
> Context:  
   Execution Context: Shadow Copy Optimization Writer  
   Writer Class Id: {4dc3bdd4-ab48-4d07-adb0-3bee2926fd7f}  
   Writer Name: Shadow Copy Optimization Writer  
   Writer Instance ID: {d19e5030-d027-4b0d-b783-02d87be808f4}  

## Cause

This can occur if the Volume Shadow Service (VSS) **Shadow Copy Optimization Writer** is not functioning correctly. In the event log above, the issue involves resolving a security identifier (SID).

## Resolution

To resolve this issue, follow the steps below:

1. First check for unresolvable SIDs in the Administrators group on the VMM source machine. If any exist, delete them.
2. Open Registry Editor and locate `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList`.
3. Under the `ProfileList` subkey, delete any subkey that's named *SID.bak*.

    > [!NOTE]
    > SID is a placeholder for the security identifier of the user account that's experiencing the problem. The *SID.bak* subkey should contain a `ProfileImagePath` registry entry that points to the original profile folder of the user account that's experiencing the problem.

## Shadow Copy Optimization Writer

Beginning with Windows Vista and Windows Server 2008, this writer deletes certain files from volume shadow copies. This is done to minimize the impact of copy-on-write I/O during regular I/O on these files on the shadow-copied volume. The files that are deleted are typically temporary files or files that do not contain user or system state.

The writer name string for this writer is **Shadow Copy Optimization Writer**.

The writer ID for the shadow copy optimization writer is **4DC3BDD4-AB48-4D07-ADB0-3BEE2926FD7F**.

For more information, see [In-Box VSS Writers](/windows/win32/vss/in-box-vss-writers).
