---
title: Error message when you use the DiskPart break command
description: Describes an issue where an error occurs when you use the DiskPart break command to break a mirrored set.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: chadbee, kaushika
ms.custom: sap:partition-and-volume-management, csstroubleshoot
---
# Error message when you use the DiskPart break command to break a mirrored set

This article describes an issue where an error occurs when you use the DiskPart break command to break a mirrored set.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 331494

## Symptoms

When you use the DiskPart text-mode command interpreter (Diskpart.exe) and you select a mirrored volume and then use the break command to break the mirrored volume in two volumes, you may receive one of the following error messages:

> The arguments you specified for this command are not valid.

-or-

> The disk management services could not complete the operation.

## Cause

This behavior may occur if one of the two disks that contain the mirrors is missing and you're using incorrect syntax for the break command.

## Resolution

To resolve this behavior, use the disk parameter to refer to the missing disk, and use the nokeep parameter.

Without the nokeep parameter, the break command tries to convert both mirrors to simple volumes, retaining the data. If one of the disks is missing, this isn't possible. By using the nokeep parameter, you retain only one half of the mirror as a simple volume, and the other half is deleted and converted to free space. Neither volume receives the focus.

For example, select the mirrored volume, issue the "detail volume" command, then break the mirror as follows:

```console
diskpart> List Volume

Volume ###  Ltr  Label       Fs    Type       Size    Status    Info
 ---------- --- ----------- ----- ---------- ------- --------- --------
 Volume 0   D   data_vol    NTFS  Mirror     737 KB   Failed Rd
 Volume 1   C   system      NTFS  Simple     3000 MB           Boot

diskpart> select volume 0

Volume 0 is the selected volume.

Diskpart> detail volume

Disk ###     Status  Size   Free   Dyn Gpt
 ---------- ------- ------- ---    --- ---
 Disk 1     Online  1023 MB 737 KB *
 Disk M0    Missing 1022 MB 0 B    *
```

In this example, the correct command to break the mirrored volume is:  
`Diskpart> break disk=m0 nokeep`

After you issue this command, the mirror on Disk 1 is converted to a simple volume, and the reference to the missing mirror is deleted from the Logical Disk Management (LDM) database.

## Status

This behavior is by design.  

## More information

For additional information about using DiskPart to manage disks, click the following article number to view the article in the Microsoft Knowledge Base:

[300415](/previous-versions/windows/it-pro/windows-vista/cc766465(v=ws.10)?redirectedfrom=MSDN) A Description of the DiskPart Command-Line Utility
