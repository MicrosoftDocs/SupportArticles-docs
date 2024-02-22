---
title: HCW8008 error in the Hybrid Configuration wizard
description: Fixes an issue in which you receive an HCW8008 error when you run the Hybrid Configuration wizard.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: timothyh, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# HCW8008 Server doesn't have the Client Access server role installed when you run the HCW

_Original KB number:_ &nbsp; 3087157

## Problem

When you run the Hybrid Configuration wizard (HCW), you receive the following error message:

> HCW8008 The server \<ServerName> is listed as a Client Access server in the HybridConfiguration Active Directory object, but it doesn't have the Client Access server role installed.

## Cause

This problem may occur if you removed the Client Access server role from a server that you selected as one of the receiving Client Access servers in the Hybrid Configuration wizard.

## Solution

To resolve this problem, do one of the following:

- Install the Client Access server role on the server.
- Run the Hybrid Configuration wizard again. On the page on which you specify the receiving Client Access servers, select a server that has the Client Access server role installed.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
