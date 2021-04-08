---
title: IMCEAEX non-delivery report when you send email messages to an internal user
description: Describes an issue in which you receive an NDR when you send email messages to an internal user in Office 365. Provides a resolution.
author: Norman-sun
audience: ITPro
ms.service: exchange-online
ms.topic: troubleshooting
ms.author: v-swei
manager: dcscontentpm
localization_priority: Normal
ms.custom: 
- Exchange Online
- CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Exchange Online
---
# IMCEAEX non-delivery report when you send email messages to an internal user in Office 365

## Symptoms

When you send email messages to an internal user in Microsoft Office 365, you receive an IMCEAEX non-delivery report (NDR) because of a bad LegacyExchangeDN reference. The IMCEAEX NDR indicates that the user no longer exists in the environment.

## Cause

This issue occurs because the value for the LegacyExchangeDN attribute changed. The auto-complete cache in Microsoft Outlook and in Microsoft Outlook Web App (OWA) uses the value of the LegacyExchangeDN attribute to route email messages internally. If the value changes, the delivery of email messages may fail with a 5.1.1 NDR. For example, the recipient address in the NDR resembles the following:

> IMCEAEX-_O=MMS_OU=EXCHANGE+20ADMINISTRATIVE+20GROUP+20+28FYDIBOHF23SPDLT+29_CN=RECIPIENTS_CN=User6ed4e168-addd-4b03-95f5-b9c9a421957358d\\@mgd.domain.com

## Resolution

To resolve this issue, use the following method.

### Create an X500 proxy address for the old LegacyExchangeDN attribute for the user

To create an X500 proxy address for the old `LegacyExchangeDN` attribute for the user, make the following changes based on the recipient address in the NDR:

- Replace any underscore character (_) with a slash character (/).
- Replace "+20" with a blank space.
- Replace "+28" with an opening parenthesis character.
- Replace "+29" with a closing parenthesis character.
- Delete the "IMCEAEX-" string.
- Delete the "@mgd.domain.com" string.
- Add "X500:" at the beginning.

After you make these changes, the proxy address for the example in the "Symptoms" section resembles the following:

X500:/O=MMS/OU=EXCHANGE ADMINISTRATIVE GROUP (FYDIBOHF23SPDLT)/CN=RECIPIENTS/CN=User-addd-4b03-95f5-b9c9a421957358d

> [!NOTE]
> The most common items will be replaced. However, there may be other symbols in the `LegacyExchangeDN` attribute that will also be changed from the way that they appear in the NDR. Generally, any character pattern of "+##" must be replaced with the corresponding ASCII symbol.

If you are unfamiliar with the ASCII code in question, see [ASCII Character Codes Chart 1](https://msdn.microsoft.com/library/60ecse8t%28v=vs.80%29.aspx).
