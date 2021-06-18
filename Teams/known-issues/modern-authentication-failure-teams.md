---
title: Multi-factor authentication error in Microsoft Teams
ms.author: luche
author: helenclu
ms.date: 4/9/2020
audience: ITPro
ms.topic: article
manager: dcscontentpm
ms.service: msteams
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Microsoft Teams
ms.custom: 
- CI 113425
- CSSTroubleshoot 
ms.reviewer: scapero
description: Resolves a multi-factor authentication error in a Teams form. 
---

# Modern authentication failure in Microsoft Teams

## Symptom

You receive an error when using multi-factor (or modern) authentication in Microsoft Teams forms.

## Cause

Forms authorization is not enabled.

## Resolution

Use the web app for authentication. Make sure the following switch is set:

```powershell
Set-MsolDomainFederationSettings -DomainName yourdomainhere -PreferredAuthenticationProtocol WsFed -SupportsMfa $False -PromptLoginBehavior Disabled.
```

## More information

For more information, see [Active Directory Federation Services prompt=login parameter support](/windows-server/identity/ad-fs/operations/ad-fs-prompt-login).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).