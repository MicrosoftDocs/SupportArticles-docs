---
title: Can't verify a password in Excel
description: You cannot verify a password in Excel with the error saying that the password you supplied is not correct.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Microsoft Excel
---

# Error message: "The password you supplied is not correct"

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

When Microsoft Excel attempts to verify a password that you typed, you receive the following error message:

**The password you supplied is not correct. Verify that the CAPS LOCK key is off and be sure to use the correct capitalization.**

## Cause

You may receive this error message if the password that you typed has a different capitalization from the actual password. For example, suppose that you created your password by using all lowercase letters, like this:

beach

If CAPS LOCK is on when you type your password, Excel reads your password in uppercase, like this:

BEACH

Conversely, suppose that you created your password by using all uppercase letters, like this:

BEACH

If CAPS LOCK is on and you hold down SHIFT when you type your password, Excel reads your password in lowercase, like this:

beach

## Workaround

Check to see if the CAPS LOCK key is on. If it is, press it to turn it off, and then retype your password by using the correct capitalization.