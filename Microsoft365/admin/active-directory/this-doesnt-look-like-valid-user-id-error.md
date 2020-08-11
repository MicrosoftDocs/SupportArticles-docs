---
title: This doesn't look like a valid user ID error when a user signs in
description: Resolves an issue that occurs if the user's UPN in the on-premises Active Directory environment and the user's UPN in Microsoft Azure Active Directory don't match.
author: lucciz
ms.author: v-zolu
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: office 365
localization_priority: Normal
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Azure Active Directory
- Office 365 Identity Management
---

# "This doesn't look like a valid user ID" error when a user tries to sign in to Office 365

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Problem

When a user tries to sign in to Office 365, the user receives the following error message:

    Sorry, that didn't work 

    This doesn't look like a valid user ID. Make sure you typed the user ID assigned to you by your organization. It usually looks like someone@example.com or someone@example.onmicrosoft.com.

## Cause 

This issue occurs if the user principal name (UPN) of the user in the on-premises Active Directory environment and the user's UPN in Microsoft Azure Active Directory (Azure AD) don't match. For example, the issue occurs if the on-premises UPN is john@contoso.com and the Azure AD UPN is john@contoso.onmicrosoft.com. 

This situation can occur if the user's UPN changed but directory synchronization didn't yet occur to sync the change.

## Solution

To resolve this issue, make sure that the on-premises UPN suffix is a verified domain, and then either wait until the next time that directory synchronization runs or force directory synchronization. 

For more information about how to force directory synchronization, go to the following Microsoft website: [Force directory synchronization](https://technet.microsoft.com/library/jj151771.aspx#bkmk_synchronizedirectories)

## More Information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).