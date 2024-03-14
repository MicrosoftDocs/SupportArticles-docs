---
title: Deleted app passwords for Multi-Factor Authentication continue to work
description: Discusses that app passwords that are used for Azure Multi-Factor Authentication and that have been deleted continue to work. Provides a resolution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Cloud Services (Web roles/Worker roles)
  - Azure Active Directory
  - Microsoft Intune
  - Azure Backup
  - Microsoft 365
ms.date: 03/31/2022
---

# Deleted app passwords for Multi-Factor Authentication still work in Microsoft 365, Azure, or Intune

## PROBLEM

After you delete an app password that's used for Azure Multi-Factor Authentication, the app password appears to continue to work.

## CAUSE

This problem occurs because the token that's acquired after a user successfully signs in by using an app password continues to work until the token expires. The token works only on devices on which the user successfully signed in.

## SOLUTION

Wait for the token to expire. This may take from 8 to 24 hours, depending on the service that the user is accessing. This practice follows the same guidelines for when passwords are changed or when users are deleted.

## MORE INFORMATION

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Entra Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
