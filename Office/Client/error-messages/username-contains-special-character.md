---
title: Error when you create a user name that contains a special character
description: Describes an issue in which you receive an Invalid user name error message when you try to create a user name that contains special characters in Microsoft Office 365.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office 365
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Office 365 User and Domain Management
---

# "Invalid user name" when you try to create a user name that contains a special character in Office 365

## Problem

When you try to create a user name that contains a special character in Microsoft Office 365, you receive one of the following error messages: 

Within the Office 365 portal

```adoc
Invalid user name
Only letters and numbers are allowed. No spaces.
```

Within Microsoft Azure Active Directory Module for Windows PowerShell

```adoc
New-MsolUser : Invalid value for parameter. Parameter Name: UserPrincipalName.
At line:1 char:13
```

Within Exchange Online Windows PowerShell

```adoc
A Windows Live error occurred while provisioning for "user+invalid_characters@contoso.com". The e-mail name contains invalid characters.
```

## Cause

This behavior occurs because certain special characters aren't permitted in user names that you create in the Office 365. These special characters include but aren't limited to the following:

- Tilde (~)   
- Exclamation point (!)   
- At sign (@)   
- Number sign (#)   
- Dollar sign ($)   
- Percent (%)   
- Circumflex (^)   
- Ampersand (&)    
- Asterisk (*)   
- Parentheses (( ))   
- Hyphen (-)   
- Plus sign (+)   
- Equal sign (=)   
- Brackets ([ ])   
- Braces ({ })   
- Backslash (\)   
- Slash mark (/)   
- Pipe (|)   
- Semicolon (;)   
- Colon (:)   
- Quotation marks (")    
- Angle brackets (< >)   
- Question mark (?)   
- Comma (,)   

However, the following exceptions apply:

- A period (.) or a hyphen (-) is permitted anywhere in the user name, except at the beginning or end of the name.   
- An underscore (_) is permitted anywhere in the user name. This includes at the beginning or end of the name.   

## Solution

When you create a new user in Office 365, make sure that you don't use any of the special characters that are listed in the "Cause" section.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
