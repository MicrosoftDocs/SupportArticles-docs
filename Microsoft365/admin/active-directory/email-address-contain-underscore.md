---
title: Microsoft 365 email address contains underscore character
description: Describes an issue in which after you run the Microsoft Entra Connect Tool  to synchronize your on-premises Active Directory environment to Microsoft Entra ID, an email address unexpectedly contains an underscore character _.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Exchange Online
  - Azure Active Directory
  - Microsoft 365
ms.date: 03/31/2022
---

# Microsoft 365 email address contains an underscore character after directory synchronization

## Symptoms

After the Microsoft Entra Connect Tool runs to sync your on-premises Active Directory environment to Microsoft Entra ID, a user's Microsoft 365 email address unexpectedly contains an underscore (_) character. 

## Cause

This occurs if the user account in your on-premises environment has a **proxyaddresses** attribute or **mail** attribute that contains one or more of the following special characters before the "@domain.com" part of the address:

|Character | Name |
|----------|------|
||space character |
|`|accent grave |
|(|opening parenthesis |
|)|closing parenthesis |
|   \|  |pipe |
|=|equal sign |
|?|question mark |
|/|forward slash |
|%|percent |
    
In this scenario, after directory synchronization is run, the special character is replaced by an underscore character. Therefore, the user's Microsoft 365 email address contains an underscore character instead of the special character. 

## Resolution

Remove the special characters from the **proxyaddresses** attribute of the user account in the on-premises environment.

## More information

The characters that are listed in the Cause section are treated as special characters in Microsoft 365. Use of any of these characters may cause issues such as service disruption.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
