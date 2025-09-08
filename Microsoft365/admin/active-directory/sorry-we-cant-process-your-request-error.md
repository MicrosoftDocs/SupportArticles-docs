---
title: Can't set security verification with Microsoft Entra multifactor authentication
description: Describes an issue that triggers an error message when you try to set up extra security verification settings for a user for Microsoft Entra multifactor authentication.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Cloud Services (Web roles/Worker roles)
  - Azure Active Directory
  - Microsoft Intune
  - Azure Backup
  - Microsoft 365
ms.date: 10/20/2023
---

# "Sorry! We can't process your request" error when you try to set up security verification settings for Microsoft Entra multifactor authentication

## Problem

When you try to set up extra security verification settings for Microsoft Entra multifactor authentication, you receive the following message:

> Sorry! We can't process your request. Your session is invalid or expired.
>
> There was an error processing your request because your session is invalid or expired. Please try again.

This issue occurs if you wait too long to complete the setup process for the user. 

## Solution

To prevent this issue, make sure that you complete the setup process within 10 minutes.

## More Information 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Entra Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
