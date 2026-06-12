---
title: Can't manage a user in Exchange admin center
description: Provides workarounds to resolve a problem in which you receive a Can't find the organizational unit that you specified error when you manage a user in Exchange Admin Center (EAC).
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: marcn, v-six, v-kccross
ms.custom: 
  - sap:OWA And Exchange Admin Center\Need help in configuring EAC
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 11986
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
ms.date: 06/08/2026
---

# Can't find the organizational unit that you specified error when you manage a user in EAC

_Original KB number:_ &nbsp; 3173169

## Summary

When you manage a user in Exchange admin center (EAC), the operation fails and returns a "Can't find the organizational unit that you specified" error message. This problem prevents you from managing the user’s properties. The problem occurs if the user belongs to an organizational unit (OU) that contains a forward slash (/) in its name. The EAC doesn't correctly process these names.

To work around the problem, use Exchange Management Shell (EMS) to manage the user, or store Exchange-related objects in OUs that don't contain forward slashes.

## Symptoms

If a user belongs to an OU that has a name that includes a forward slash, you can't use the EAC to manage that user. If you open the user's properties, you receive the following error message:

> Can't find the organizational unit that you specified. Make sure that you have typed the OU's identity correctly.

## Cause

When the property page renders, the system runs the `Get-UserPrincipalNamesSuffix` PowerShell cmdlet in the background. The system forms the OU property that it passes to this cmdlet when `Get-Mailbox` runs, and it retrieves the value from the user’s OU property.

This problem occurs because the OU property of the user contains an incorrectly escaped forward slash. For example, if *My OU/* is the name of the OU, `My OU\/` is the properly escaped version. Pass `My OU\/` to `Get-UserPrincipalNamesSuffix` to let the cmdlet run correctly. However, if you pass `My OU/` to `Get-UserPrincipalNamesSuffix`, the cmdlet fails and returns the error message.

## Workarounds

To work around this problem, use one of the following methods:

- Use the Exchange Management Shell (EMS) to manage the affected user accounts.
- Avoid the use of OUs that contain forward slashes in their names when you store users and groups.
