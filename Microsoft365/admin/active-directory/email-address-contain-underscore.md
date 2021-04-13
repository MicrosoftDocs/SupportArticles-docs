---
title: Office 365 email address contains underscore character
description: Describes an issue in which after you run the Azure Active Directory Sync Tool  to synchronize your on-premises Active Directory environment to Azure Active Directory, an email address unexpectedly contains an underscore character "_".
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office 365
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-maqiu
appliesto:
- Exchange Online
- Azure Active Directory
- Office 365 Identity Management
---

# Office 365 email address contains an underscore character after directory synchronization

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

After the Microsoft Azure Active Directory Sync Tool runs to sync your on-premises Active Directory environment to Azure Active Directory, a user's Office 365 email address unexpectedly contains an underscore character "_". 

## Cause

This occurs if the user account in your on-premises environment has a **proxyaddresses** attribute or **mail** attribute that contains one or more of the following special characters before the "@domain.com" part of the address:

|Character | Name |
|----------|------|
||space character |
|`|apostrophe |
|(|opening parenthesis |
|)|closing parenthesis |
|'|single quotation mark |
|&|ampersand |
|   \|  |pipe |
|=|equal sign |
|?|question mark |
|/|forward slash |
|%|percent |
    
In this scenario, after directory synchronization is run, the special character is replaced by an underscore character. Therefore, the user's Office 365 email address contains an underscore character instead of the special character. 

## Resolution

Remove the special characters from the **proxyaddresses** attribute of the user account in the on-premises environment.

## More information

The characters that are listed in the Cause section are treated as special characters in Office 365. Use of any of these characters may cause issues such as service disruption.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).