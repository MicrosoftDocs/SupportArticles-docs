---
title: Can't access meetings or connectors with blocked EWS
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
description: Describes a resolution to an issue in which you can't access meetings or connectors when you have actively blocked EWS from services within Exchange Online.
---

# Users with Exchange Online mailboxes can't access meetings or connectors 

## Problem

You have actively blocked EWS from services within Exchange Online, but need to have Microsoft Teams compliant within EWS policies and cannot access meetings or connectors.

## Solution

To make Microsoft Teams compliant, add the following user agent strings for Microsoft Teams within the **EWSAllowList**, including asterisks: 

```
SkypeSpaces/* 
```
and 

```
MicrosoftNinja/*
```

The following command can also be used: 

```
Set-organizationconfig -EwsAllowList @{Add="MicrosoftNinja/*","SkypeSpaces/*"}
```

## More information

For more information, see the Microsoft article on [Set-OrganizationConfig](https://docs.microsoft.com/powershell/module/exchange/organization/Set-OrganizationConfig).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
