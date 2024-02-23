---
title: Error when you use Chrome to manage settings in the EAC in Exchange Server 2013
description: Resolves an issue in which you receive a (The Web page isn't loading properly) error message when you use Chrome to manage settings in the EAC. This issue occurs in an Exchange Server 2013 environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: zhengy, v-six
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# You can't use Chrome to manage settings in the EAC in an Exchange Server 2013 environment

_Original KB number:_ &nbsp;2769335

## Symptoms

Consider the following scenario:

- You install Xunlei Thunder on a computer in a Microsoft Exchange Server 2013 environment.
- You use Google Chrome to go to the Microsoft website and access the Exchange Administration Center (EAC): `https://exchangeserver/ecp`.

- You select an option in the EAC.

In this scenario, you receive the following error message:

> The Web page isn't loading properly. Please reload the page by refreshing your Web browser.

## Cause

This issue occurs because of a conflict between the EAC and the Thunder extension in Chrome.

## Resolution

To resolve this issue, open the extension settings menu in Chrome, and then disable the Thunder extension.

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]
