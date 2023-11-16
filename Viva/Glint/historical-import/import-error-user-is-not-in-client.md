---
title: User is not in client error during historical imports
description: Fix the User is not in client error when you import historical data in Viva Glint.
manager: dcscontentpm
ms.reviewer: aweixelman
ms.date: 11/17/2023
audience: ITPro
ms.topic: troubleshooting
search.appverid: MET150
ms.custom: 
  - CSSTroubleshoot
  - CI184016
localization_priority: Normal
---

# "User is not in client" error during historical imports

## Symptoms

When you import historical data in Viva Glint, you receive the following error message:

> Errors (1):  
> Must correct to continue.
>
> User ('`user@contoso.com`') found in user file is NOT in client.

## Cause

This issue occurs because the user's email address in the Respondent User File and in the user's profile in Viva Glint don't match.

## Resolution

To fix the issue, verify that the user's email address differs between the two locations. Then, revise the email address in the user's profile to match the email address in the Respondent User File.

After you save the revised user profile, import the historical data again.
