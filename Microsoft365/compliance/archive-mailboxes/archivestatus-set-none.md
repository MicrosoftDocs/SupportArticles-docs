---
title: ArchiveStatus is set to None for an active archive mailbox
description: In some scenarios, the ArchiveStatus property may be set to None even though you enabled an active archive for a user's mailbox in Office 365.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: Office 365
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: MS aliases for tech reviewers and CI requestor, without "@microsoft.com".
appliesto: 
- Exchange Online
- Exchange Online Archiving
search.appverid: MET150
---

# ArchiveStatus is set to "None" for an active archive mailbox in Office 365

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

_Original KB number:_&nbsp;4486848

## Symptoms

Office 365 Online archives allow for additional storage of users' email messages. However, in some scenarios, the **ArchiveStatus** property may be set to "None" even though you enabled an active archive for a user's mailbox in Office 365.

For example, when you run the following cmdlet in Exchange Online PowerShell to check the archive status, the status shows as "None" instead of "Active":

`Get-mailbox id|fl ArchiveStatus`

The output of the cmdlet resembles the following:

`ArchiveStatus: None`

> [!NOTE]
> Although **ArchiveStatus** hows "None," the user can access the online archive, and valid **ArchiveGuid** and **ArchiveDatabase** properties are set.

## Cause

One of the following scenarios may cause the **ArchiveStatus** to be displayed as "None."

- A user is re-licensed for an archive mailbox.
- Move a primary and archive mailbox from on-premises to Office 365.

## Resolution

You should not use the **ArchiveStatus** property value to check the status of the archive unless this is a cross-premises scenario where the primary mailbox is on-premises and the archive mailbox exists in Office 365 (that is, cross-premises archive). In all other scenarios, you should use both of the following properties to confirm the status of the archive:

- **ArchiveDatabase**  
- **ArchiveGuid**

For example, run the following cmdlet:

`Get-mailboxUserName|fl archivedatabase,archiveguid`

The output resembles the following:

`ArchiveDatabase :DatabaseIdParameterArchiveGuid :GUID`
