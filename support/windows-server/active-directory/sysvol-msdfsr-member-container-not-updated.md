---
title: DC rename doesn't rename all AD DFSR `SYSVOL` objects
description: Fixes an issue where the `SYSVOL` msDFSR-Member container used by DFS Replication isn't updated.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, nedpyle
ms.custom: sap:dcpromo-and-the-installation-of-domain-controllers, csstroubleshoot
---
# Domain Controller rename doesn't rename all AD DFSR SYSVOL objects

This article provides resolutions to fix the issue where the domain controller rename doesn't rename all AD DFSR `SYSVOL` objects.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 2001271

## Symptoms

The SYSVOL msDFSR-Member container used by DFS Replication (DFSR) isn't updated when a domain controller is renamed. For example, when renaming a DC named "OldName" to a DC named "NewName", the following object doesn't get renamed:

 CN=OLDNAME,CN=Topology,CN=Domain System Volume,CN=DFSR-Globalsettings,CN=System,DC=contoso,DC=com  

File replication will continue to work correctly and normally, and sysvol folder won't be affected for group policy processing or scripts.

However, the CN won't be updated or removed during later demotions or via Metadata Cleanup. This will leave orphaned DFSR topology objects in the Active Directory domain indefinitely. In addition, if a new domain controller - with the previously renamed DC's old name - were to be promoted in the domain, it would take over the old object and temporarily stop replication on the renamed domain controller until an administrator manually recreated a new object for the renamed domain controller using ADSIEDIT.MSC.

## Cause

A code defect in the domain controller rename process.

## Resolution

**Workaround 1:**  

Before running DCPROMO.EXE, rename computers to the final intended name using the System control panel applet or NETDOM.EXE.

 **Workaround 2:**  

When renaming an existing DC, first demote it gracefully with DCPROMO.EXE, rename it, then promote it back to being a DC.

 **Workaround 3:**  

Use ADSIEDIT.MSC to correct the AD objects manually, using the following steps:  

1. Sign in as a Domain Administrator on a DC in the affected domain.
2. Start ADSIEDIT.MSC.
3. Connect to the default naming context.
4. Navigate to the DFSR Topology container. For example, in a domain called `contoso.com`, it will be:

    CN=Topology,CN=Domain System Volume,CN=DFSR-Globalsettings,CN=System,DC=contoso,DC=com

5. Rename the msDFSR-Member CN object that has the old computer name and give it the new computer name.

    Was: CN=OLDNAME,CN=Topology,CN=Domain System Volume,CN=DFSR-Globalsettings,CN=System,DC=contoso,DC=com

    Change to: CN=NEWNAME,CN=Topology,CN=Domain System Volume,CN=DFSR-Globalsettings,CN=System,DC=contoso,DC=com

## More information

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
