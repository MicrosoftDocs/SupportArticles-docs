---
title: Error when you run Remote Connectivity Analyzer
description: Describes an issue in which you can't use the Remote Connectivity Analyzer tool to test connectivity to Office 365. Provides a resolution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office 365
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
ms.reviewer: nical, smcgrath, bradh, jason
appliesto:
- Office 365 Identity Management
---

# "To authenticate to Office 365, you must enter your Microsoft account" when you run the Remote Connectivity Analyzer tool to test connectivity to Office 365

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Problem

When you try to run the Microsoft Remote Connectivity Analyzer tool to test connectivity to Microsoft Office 365, you receive the following error message:

```adoc
To authenticate to Office 365, you must enter your Microsoft account. This is your User Principal Name and in many cases will be something like user@contoso.com.
```

## Cause

This issue occurs if one or more of the following conditions are true: 

- You're using an incorrect user name.   
- Your password has expired.    
- Your user account isn't activated.   


## Solution

To resolve this issue, use one of the methods in the following table, as appropriate for your situation.

|Cause|Resolution|
|---|--|
|You're using an incorrect user name.|Enter your Office 365 user ID. Your Office 365 user ID is your user principal name (UPN). For example, enter jane@contoso.com. If you don't know your Office 365 user ID, contact the admin for help. |
|Your password has expired.|Contact the admin at your company to reset your password. For more information, see [A user or an administrator forgot his or her password in Office 365, Azure, or Intune](https://support.microsoft.com/help/2606983).|
|Your user account isn't activated.|To get started with Office 365, you have to activate your user account. To do this, sign in to the Office 365 portal ([https://portal.office.com](https://portal.office.com/)) for the first time by using your temporary password, and then create a new password to use when you sign in.|

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
