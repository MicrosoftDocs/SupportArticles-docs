---
title: Error when you create a user name that contains a special character
description: Resolve the Invalid user name error message when you try to create a user name that contains special characters in Microsoft 365.
author: helenclu
manager: dcscontentpm
date: 3/16/2020
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CI 115151
  - CSSTroubleshoot
  - no-azure-ad-ps-ref 
ms.reviewer: timball
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 04/18/2025
---

# "Invalid user name" when you try to create a user name that contains a special character in Microsoft 365

## Problem

When you create a user name that contains a special character in Microsoft 365, you receive one of the following error messages:

Within the Microsoft 365 portal

```output
Invalid user name
Only letters and numbers are allowed. No spaces.
```

Within Exchange Online Windows PowerShell

```output
A Windows Live error occurred while provisioning for "user+invalid_characters@contoso.com". The e-mail name contains invalid characters.
```

## Cause

This behavior occurs because certain special characters aren't permitted in user names that you create in Microsoft 365. These special characters include but aren't limited to the following characters:

| Property | UserPrincipalName requirements |
| --- | --- |
| Characters allowed |<ul> <li>A – Z</li> <li>a - z</li><li>0 – 9</li> <li> `'` `.` `-` `_` `!` `#` `^` `~`</li></ul> |
| Characters not allowed |<ul> <li>Any `@` character that's not separating the username from the domain.</li> <li>Can't contain a period character (`.`) immediately preceding the `@` symbol.</li> <li>Can't contain an ampersand (&) character in the user name.</li></ul> </ul> |
| Length constraints |<ul> <li>The total length must not exceed 113 characters.</li><li>There can be up to 64 characters before the `@` symbol.</li><li>There can be up to 48 characters after the `@` symbol.</li></ul> |

However, the following exceptions apply:

- An underscore (_) is permitted anywhere in the user name, including at the beginning or end of the name.
- When you create a group, the number sign (#) can be used as part of the group's name. However, the email address you create for a distribution group or shared mailbox can't use the # sign.  

## Solution

When you create a new user in Microsoft 365, make sure that you don't use any of the special characters that are listed in the [Cause](#cause) section.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
