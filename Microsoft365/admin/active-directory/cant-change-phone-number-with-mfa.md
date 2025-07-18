---
title: Can't change office phone number when setting up Azure Multi-Factor Authentication
description: Describes a scenario that prevents users from changing their office phone number when they set up Azure Multi-Factor Authentication. A solution is provided.
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
ms.date: 03/31/2022
---

# Users can't change their office phone number when they set up Azure Multi-Factor Authentication

## Problem

When a user tries to set up Azure Multi-Factor Authentication, the user can't select or change the **Office Phone** option. The user can't edit the phone number because the text box is unavailable (appears dimmed). Additionally, the user can't set the office phone as the preferred contact method. 

## Cause 

This problem occurs for on-premises users who are synchronized from the on-premises Active Directory environment to Microsoft Entra ID. 

## Solution 

Change the user's office phone number in the on-premises Active Directory. 

## More Information

For more information about Azure Multi-Factor Authentication, see [Azure Multi-Factor Authentication](/previous-versions/azure/azure-services/dn249471(v=azure.100)).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Entra Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
