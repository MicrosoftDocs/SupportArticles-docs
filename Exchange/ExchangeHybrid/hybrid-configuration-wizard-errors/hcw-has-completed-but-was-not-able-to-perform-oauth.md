---
title: Warning occurs when running Hybrid Configuration
description: Describes an issue in which you receive a message when you run the Hybrid Configuration wizard.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Hybrid
- CSSTroubleshoot
ms.reviewer: timothyh
appliesto:
- Exchange Online
- Exchange Server 2013 Standard Edition
- Exchange Server 2013 Enterprise
search.appverid: MET150
---
# HCW has completed, but was not able to perform the OAuth error when running Hybrid Configuration

_Original KB number:_ &nbsp; 3089172

## Symptoms

When you run the Hybrid Configuration wizard, you receive the following warning message:

> The HCW has completed, but was not able to perform the OAuth portion of your Hybrid configuration. If you need features that rely on OAuth [https://technet.microsoft.com/library/dn497703(v=exchg.150).aspx](https://technet.microsoft.com/library/dn497703%28v=exchg.150%29.aspx), you can try running the HCW again or manually configure OAuth using these manual steps [https://technet.microsoft.com/library/dn594521(v=exchg.150).aspx](https://technet.microsoft.com/library/dn594521%28v=exchg.150%29.aspx).

## Cause

An issue occurred that prevented OAuth authentication from being configured. The issue could be a transient or permanent exception.

## Resolution

Do one of the following, if you have to have the features that OAuth provides:

- Rerun the Hybrid Configuration wizard to see whether OAuth authentication configuration is completed successfully.
- Manually configure OAuth authentication. For more information about how to do this, see [Configure OAuth authentication between Exchange and Exchange Online organizations](/exchange/configure-oauth-authentication-between-exchange-and-exchange-online-organizations-exchange-2013-help).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
