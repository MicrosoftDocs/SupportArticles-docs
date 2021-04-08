---
title: Sign-in error if settings are incorrect
description: Describes an issue in which users can't sign in to Skype for Business Online when settings such as the computer time, date, user name, or password are incorrect. Provides a solution.
author: Norman-sun
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-swei
ms.reviewer: dahans
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business Online
---

# Skype for Business Online sign-in error if settings such as the computer time, date, user name, or password are incorrect

## Problem

When a user tries to sign in to Skype for Business Online (formerly Lync Online) from a particular computer, he or she receives one of the following error messages: 

- Lync 2013
    ```adoc
    Can't sign in to Lync
    
    Cannot sign in to Lync because your computer clock is not set correctly.  To check your computer clock settings, open Date and Time in the Control Panel.
    ```
- Lync 2010
    ```adoc
    Cannot sign in to Lync
    
    The user name, password, or domain appears to be incorrect.  Ensure that you entered them correctly.  If the problem continues, please contact your support team.
    ```
- Lync for Mac 2011
    ```adoc
    Either date and time settings are incorrect, or the digital certificate file is not valid or installed on your computer.  If date and time are correct, see your network administrator to verify that your digital certificate file is valid...
    ```
However, this same user can sign in from another computer that's running the Lync client. 

## Solution 

To resolve this issue, make sure that the computer's clock and time zone settings are set correctly. 

## More information

This issue may occur if the time is set incorrectly on the computer on which the user couldn't sign in. For example, this issue may occur if the time is skewed.

To determine whether a time skew is the cause of the issue, check whether the ClockSkew DWORD value is present in the following registry subkey:

**HKEY_USERS\.DEFAULT\Software\Microsoft\MSOIdentityCRL**

If the ClockSkew DWORD value is present, this is most likely the cause of the error message. A value of 300 represents a five-minute time difference, and this can cause the sign-in issue.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).