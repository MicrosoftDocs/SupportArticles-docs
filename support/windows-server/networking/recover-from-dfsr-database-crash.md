---
title: DFSR databases crash on primary member
description: Describes how to recover from a DFSR database crash on designated primary member.
ms.date: 08/24/2020
author: delhan
ms.author: Delead-Han
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: DFSR
ms.technology: Networking
---
# Recover from a DFSR database crash on designated primary member

This article provides a workaround for an issue where the Distributed File System Replication (DFSR) database fails on a DFSR Replication member.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 961879

## RAPID PUBLISHING

RAPID PUBLISHING ARTICLES PROVIDE INFORMATION DIRECTLY FROM WITHIN THE MICROSOFT SUPPORT ORGANIZATION. THE INFORMATION CONTAINED HEREIN IS CREATED IN RESPONSE TO EMERGING OR UNIQUE TOPICS, OR IS INTENDED SUPPLEMENT OTHER KNOWLEDGE BASE INFORMATION.

## Symptom

The DFSR database may fail on a DFSR Replication member.

The DFSR service stops replication with error Event ID 2104. Since clients still use this member as change target, you do not want to lose the changes and need a solution without restoring content from a backup. When you manually rebuild the DFSR database by deleting the database from \<Volume>:\System Volume Information\DFSR and restarting DFSR service, DFSR performs initial replication from any other still-enabled member as non-master and moves conflicting files to the ConflictAndDeleted folder or new files to PreExisting. This may cause unnecessary manual clean up and recovery.

The idea to avoid this condition is to reinitialize the affected replicated folder in an order that ensures that the affected member becomes the designated primary member of the corresponding replicated folders.

## Resolution

To work around this issue:

When a DFSR database crash affected member needs to become primary master of a replicated folder:


1. Check that all members are set to "disabled" for the folder, check for event 4008 on all of them when you need to change the setting.
2. Force Active Directory replication when members in different Active Directory sites and use DFSRDIAG POLLAD /MEM:<MEMBER> to update the DFSR service after each change in the configuration.
3. Enable the folder on the designated primary member first and wait for Event ID 4112 indicating that "This member is the designated primary member for this replicated folder."
4. Enable other member(s) for the replicated folder and wait for Event ID 4104 indicating that "The DFS Replication service successfully finished initial replication on the replicated folder..."

## More information

## DISCLAIMER

MICROSOFT AND/OR ITS SUPPLIERS MAKE NO REPRESENTATIONS OR WARRANTIES ABOUT THE SUITABILITY, RELIABILITY OR ACCURACY OF THE INFORMATION CONTAINED IN THE DOCUMENTS AND RELATED GRAPHICS PUBLISHED ON THIS WEBSITE (THE "MATERIALS") FOR ANY PURPOSE. THE MATERIALS MAY INCLUDE TECHNICAL INACCURACIES OR TYPOGRAPHICAL ERRORS AND MAY BE REVISED AT ANY TIME WITHOUT NOTICE.

TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, MICROSOFT AND/OR ITS SUPPLIERS DISCLAIM AND EXCLUDE ALL REPRESENTATIONS, WARRANTIES, AND CONDITIONS WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING BUT NOT LIMITED TO REPRESENTATIONS, WARRANTIES, OR CONDITIONS OF TITLE, NON INFRINGEMENT, SATISFACTORY CONDITION OR QUALITY, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, WITH RESPECT TO THE MATERIALS.
