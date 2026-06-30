---
title: Can't export to PST with EAC when the target user belongs to a child domain
description: Provides a workaround for an error that occurs if you export a .pst file of a user in a child domain through the Exchange Admin Center.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:OWA  And Exchange Admin Center\Need help in configuring EAC
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 12259
ms.reviewer: v-six
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 06/29/2026
---

# Can't use EAC to export to a PST file when the target user belongs to a child domain in Microsoft Exchange Server

_Original KB number:_ &nbsp;3173182

## Summary

Microsoft Exchange Server can’t export mailbox data to a .pst file from the Exchange Admin Center (EAC) when the target user is in a child domain. This issue occurs because the EAC session searches only the local domain and can’t locate user objects in other domains. Use the Exchange Management Shell (EMS) and specify a domain controller in the target domain to complete the export.

## Symptoms

When you use the Exchange Admin Center (EAC) to export to a .pst file, and the target user account is in a separate child domain, you might receive the following error message:

> The Operation couldn't be performed because object 'username' couldn't be found on domain.corp

This issue also occurs in the command shell when you run the `New-MailboxExportRequest` cmdlet unless you use the `-DomainController` switch to explicitly provide the name of a domain controller in the child domain in which the user exists.

## Cause

This issue occurs if the Active Directory session that's responsible for searching the directory is scoped to the local domain. Because the user doesn't belong to the local domain, the user object isn't found.

## Workaround

To work around this issue, use the Exchange Management Shell (EMS) with the `-DomainController` switch, as in the following example:

```powershell
New-MailboxExportRequest -Mailbox "User One" -FilePath \\server\share\export.pst -DomainController DC1.child.domain.corp
```
