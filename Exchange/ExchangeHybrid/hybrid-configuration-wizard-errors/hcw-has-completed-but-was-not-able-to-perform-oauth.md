---
title: Warning occurs when running Hybrid Configuration
description: Describes an issue in which you receive a message when you run the Hybrid Configuration wizard.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
  - CI 162077
ms.reviewer: timothyh, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2013 Enterprise
search.appverid: MET150
ms.date: 01/24/2024
---
# "HCW has completed, but was not able to perform the OAuth" error when running Hybrid Configuration

_Original KB number:_ &nbsp; 3089172

## Symptoms

When you run the Hybrid Configuration wizard, you receive the following warning message:

> The HCW has completed, but was not able to perform the OAuth portion of your Hybrid configuration. If you need features that rely on OAuth [https://technet.microsoft.com/library/dn497703(v=exchg.150).aspx](/exchange/using-oauth-authentication-to-support-ediscovery-in-an-exchange-hybrid-deployment-exchange-2013-help), you can try running the HCW again or manually configure OAuth using these manual steps [https://technet.microsoft.com/library/dn594521(v=exchg.150).aspx](/exchange/configure-oauth-authentication-between-exchange-and-exchange-online-organizations-exchange-2013-help).

## Cause

An issue occurred that prevented OAuth authentication from being configured. The issue could be a transient or permanent exception.

## Resolution

Do one of the following, if you have to have the features that OAuth provides:

- Rerun the Hybrid Configuration wizard to see whether OAuth authentication configuration is completed successfully.
- Manually configure OAuth authentication. For more information about how to do this, see [Configure OAuth authentication between Exchange and Exchange Online organizations](/exchange/configure-oauth-authentication-between-exchange-and-exchange-online-organizations-exchange-2013-help).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).