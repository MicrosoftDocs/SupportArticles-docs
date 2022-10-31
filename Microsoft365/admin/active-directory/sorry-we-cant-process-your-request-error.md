---
title: Can't set security verification with Azure MFA
description: Describes an issue that triggers an error message when you try to set up additional security verification settings for a user for Azure Multi-Factor Authentication.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Cloud Services (Web roles/Worker roles)
  - Azure Active Directory
  - Microsoft Intune
  - Azure Backup
  - Microsoft 365
ms.date: 3/31/2022
---

# "Sorry! We can't process your request" error when you try to set up security verification settings for Azure Multi-Factor Authentication

## Problem

When you try to set up additional security verification settings for Microsoft Azure Multi-Factor Authentication, you receive the following message:

> Sorry! We can't process your request. Your session is invalid or expired.
>
> There was an error processing your request because your session is invalid or expired. Please try again.

This issue occurs if you waited too long to complete the Azure Multi-Factor Authentication set up process for the user. 

## Solution

To prevent this issue, make sure that you complete the set up process within 10 minutes.

## More Information 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.