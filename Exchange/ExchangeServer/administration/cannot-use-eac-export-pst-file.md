---
title: Can't export to PST with EAC when the target user belongs to a child domain
description: Describes an error when you export a .pst file through the Exchange Admin Center. This is a child domain issue. A workaround is provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:OWA  And Exchange Admin Center\Need help in configuring EAC
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2013 Enterprise
search.appverid: MET150
ms.date: 01/24/2024
---
# Can't use EAC to export to a PST file when the target user belongs to a child domain in Exchange Server 2013

_Original KB number:_ &nbsp;3173182

## Symptoms

When you use the Exchange Admin Center (EAC) to export to a .pst file, and the target user account is in a separate child domain, you may receive the following error message:

> The Operation couldn't be performed because object 'username' couldn't be found on domain.corp

This issue also occurs in the command shell when you run the `New-MailboxExportRequest` cmdlet unless the `-DomainController` switch is used and explicitly provides the name of a domain controller in the child domain in which the user exists.

## Cause

This issue occurs if the Active Directory session that's responsible for searching the directory is scoped to the local domain. Because the user doesn't belong to the local domain, the user object isn't found.

## Workaround

To work around this issue, use the Exchange Management Shell with the `-DomainController` switch, as in the following example:

```powershell
New-MailboxExportRequest -Mailbox "User One" -FilePath \\server\share\export.pst -DomainController DC1.child.domain.corp
```
