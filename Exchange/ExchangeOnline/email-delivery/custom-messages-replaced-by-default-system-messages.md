---
title: Custom messages in NDRs are replaced by default system messages
description: Fixes an issue in which custom messages in NDRs are replaced by default system messages in Office 365.
author: Norman-sun
ms.author: v-swei
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Online
- CSSTroubleshoot
ms.reviewer: borget
appliesto:
- Exchange Online
search.appverid: MET150
---
# Custom messages in NDRs are replaced by default system messages in Office 365

_Original KB number:_ &nbsp; 3044155

## Problem

You set a transport rule in Office 365 to return a non-delivery report (NDR) that displays a custom message. However, the custom message in the NDR is overwritten by the standard NDR message. This issue occurs in either of the following situations:

- The sender and recipient belong to different Office 365 organizations.
- The sender has an Office 365 mailbox, and the recipient belongs to an external Exchange Server organization.

## Cause

The `DSNConversionMode` parameter isn't set to **PreserveDSNBody**.

## Solution

Use the Set-TransportConfig cmdlet to set the `DSNConversionMode` parameter to the value of **PreserveDSNBody**. This transport configuration setting must be changed at the organization that receives the NDR.

To do this, follow these steps:

1. Connect to Exchange Online by using the Remote Desktop Services module for Windows PowerShell. For more info about how to do this, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Run the following command:

    ```powershell
    Set-TransportConfig -DSNConversionMode PreserveDSNBody
    ```

## More information

The `DSNConversionMode` parameter determines the format to use for delivery status notifications (DSNs). The parameter can be set to one of the following values:

- **UseExchangeDSNs**

    Exchange converts the DSNs to the Exchange Server 2013 DSN format. This format is the same as the Exchange Server 2010 DSN format. However, any customized text or attachments that were associated with the original DSN are overwritten if the DSN is delivered from another Office 365 organization or from an external organization.

- **PreserveDNSBody**

    Exchange converts the DSNs to the Exchange Server 2013 DSN format, and the text in the body of the DSN message is retained.

- **DoNotConvert**

    Exchange does not modify the DSN message. Instead, Exchange delivers the message as a standard message.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
