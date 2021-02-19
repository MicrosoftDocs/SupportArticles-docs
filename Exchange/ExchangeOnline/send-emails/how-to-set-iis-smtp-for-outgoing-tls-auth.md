---
title: Set IIS SMTP for outgoing TLS authentication
description: Describes how to configure IIS SMTP so that it works correctly with outgoing Transport Layer Security (TLS) authentication.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Online
- CSSTroubleshoot
ms.reviewer: romccart
appliesto:
- Exchange Online
search.appverid: MET150
---
# How to configure IIS SMTP for outgoing TLS authentication

_Original KB number:_ &nbsp; 4014125

> [!NOTE]
> The IIS SMTP Virtual Server Component that is mentioned in this article is part of IIS 6.0, the support for which has ended with the support of [Windows Server 2003](https://support.microsoft.com/lifecycle/search/810). To relay email to Office 365, use one of the supported versions of Exchange Server.

## Introduction

The way in which Microsoft mandates connector configuration for Exchange Online may require that certificates be applied to those connector settings. For more information, see [Configure a certificate-based connector to relay email messages through Office 365](/exchange/troubleshoot/connectors/office-365-notice).

Because of this requirement, customers who use IIS SMTP Virtual Server to send data such as relay content, reports, and fax messages may have problems finding a channel through which to select the necessary certificate.

## More information

To make sure that you select the correct certificate, follow these steps:

1. Confirm that only the certificate to be used by the SMTP server is in the `Local_Machine\Personal certificates` repository. Additional certificates can be added later.

2. Confirm that the fully qualified domain name (FQDN) that's configured under the SMTP Virtual Server properties matches the certificate's subject name.
3. Configure the FQDN of the SMTP Virtual Server. Confirm that the certificate is found by the SMTP service. To do this, follow these steps:

   1. Locate **SMTP Virtual Server Properties**.
   2. On the **Delivery** tab, select **Advanced**, and then type the FQDN in the **Fully-qualified domain name** box.
   3. Restart the SMTP service.
4. Confirm that the certificate is found by the SMTP service. To do this, follow these steps:

   1. Locate **SMTP Virtual Server Properties**.
   2. On the **Access** tab, the **Secure communications** section should display the following:

      A TLS certificate is found with expiration date:*day/month/year*.
   3. Compare the shown date with the actual certificate expiration date.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
