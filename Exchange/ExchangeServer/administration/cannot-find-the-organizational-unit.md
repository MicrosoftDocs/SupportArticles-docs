---
title: Can't manage a user in Exchange Admin Center
description: Provides workarounds to resolve a problem in which you receive an error (Can't find the organizational unit that you specified) when you manage a user in Exchange Admin Center (EAC).
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: marcn, v-six
ms.custom: 
  - sap:OWA  And Exchange Admin Center\Need help in configuring EAC
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server
ms.date: 01/24/2024
---
# Error when you manage a user in EAC: Can't find the organizational unit that you specified

_Original KB number:_ &nbsp; 3173169

## Symptoms

If a user belongs to an OU whose name includes a forward slash, you can't manage that user by using the EAC. If you try to open the user's properties, you receive the following error message:

> Can't find the organizational unit that you specified. Make sure that you have typed the OU's identity correctly.

## Cause

When the property page is rendered, one of the cmdlets that runs in the background is `Get-UserPrincipalNamesSuffix`. The OU property that is passed to this cmdlet is formed when `Get-Mailbox` is run and is retrieved from the OU property of the user.

This problem occurs because the OU property of the user contains an incorrectly escaped forward slash. For example, if *My OU/* is the name of the OU, `My OU\/` would be the properly escaped version. Passing `My OU\/` to `Get-UserPrincipalNamesSuffix` would let the cmdlet run correctly. However, `My OU/` is instead passed to `Get-UserPrincipalNamesSuffix`. In this situation, the cmdlet fails and returns the error message that is mentioned in the Symptoms section.

## Workarounds

To work around this problem, use one of the following methods:

- Use the Exchange Management Shell to manage the affected user accounts.
- Avoid the use of OUs that contain forward slashes in their names when you store users and groups that will be used by Microsoft Exchange Server.
