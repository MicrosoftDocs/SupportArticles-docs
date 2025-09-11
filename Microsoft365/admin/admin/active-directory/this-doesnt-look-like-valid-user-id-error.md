---
title: This doesn't look like a valid user ID error when a user signs in
description: Resolves an issue that occurs if the user's UPN in the on-premises Active Directory environment and the user's UPN in Microsoft Entra ID don't match.
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
  - Azure Active Directory
  - Microsoft 365
ms.date: 03/31/2022
---

# "This doesn't look like a valid user ID" error when a user tries to sign in to Microsoft 365

## Problem

When a user tries to sign in to Microsoft 365, the user receives the following error message:

> Sorry, that didn't work
>
> This doesn't look like a valid user ID. Make sure you typed the user ID assigned to you by your organization. It usually looks like someone@example.com or someone@example.onmicrosoft.com.

## Cause 

This issue occurs if the user principal name (UPN) of the user in the on-premises Active Directory environment and the user's UPN in Microsoft Entra ID don't match. For example, the issue occurs if the on-premises UPN is john@contoso.com and the Microsoft Entra UPN is john@contoso.onmicrosoft.com. 

This situation can occur if the user's UPN changed but directory synchronization didn't yet occur to sync the change.

## Solution

To resolve this issue, make sure that the on-premises UPN suffix is a verified domain, and then either wait until the next time that directory synchronization runs or force directory synchronization. 

For more information about how to force directory synchronization, go to the following Microsoft website: [Force directory synchronization](/azure/active-directory/hybrid/whatis-hybrid-identity#bkmk_synchronizedirectories)

## More Information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
