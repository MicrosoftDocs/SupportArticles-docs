---
title: Safari Intelligent Tracking Prevention errors in Teams
ms.author: v-todmc
author: todmccoy
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
description: Describes a resolution to an issue with Safari's Intelligent Tracking Prevention in Teams.
---

# Users with Exchange Online mailboxes can't access Meetings or Connectors 

## Summary

You have actively blocked EWS from services within Exchange Online, but need to have MS Teams compliant within EWS policies and cannot access Meetings or Connectors.

## More information

To make Microsoft Teams compliant, add the following User Agent Strings for Microsoft Teams within the **EWSAllowList**, including asterisks: 

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

For more information, see the Microsoft article on [Set-OrganizationConfig](https://docs.microsoft.com/powershell/module/exchange/organization/Set-OrganizationConfig?view=exchange-ps).

Still need help? Go to [Microsoft Community](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fanswers.microsoft.com%2F&data=02%7C01%7Cv-todmc%40microsoft.com%7C98910814456c474880f108d7cf62d97d%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637205895885805857&sdata=9%2FYStDGvrU5ZIYXB7guowmaPlKazab0U%2BTpiBIItDaQ%3D&reserved=0).