---
title: ATP notifications displayed in foreign languages
description: Discusses an issue in which ATP notifications are randomly displayed in foreign languages in Office 365.
author: Norman-sun
ms.author: v-swei
manager: dcscontentpm
audience: ITPro
ms.topic: article
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Online
- CSSTroubleshoot
ms.reviewer: kunalsh
appliesto:
- Exchange Online
search.appverid: MET150
---
# ATP notifications are displayed in foreign languages in Office 365

_Original KB number:_ &nbsp; 4136754

## Symptoms

Advanced Threat Protection (ATP) notification email messages are randomly displayed in foreign languages in Microsoft Office 365.

## Cause

This behavior is by design.

ATP notification email messages use the preferred language that's set for the sender's system. For example, if the sender's preferred language is Swedish, the ATP notification to recipients (or administrators) will be sent in Swedish.
