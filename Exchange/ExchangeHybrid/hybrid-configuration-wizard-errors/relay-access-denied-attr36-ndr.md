---
title: 550 5.7.64 Relay Access Denied ATTR36
description: Fixes an issue in which an on-premises environment cannot send messages on behalf of any domain when you run the Hybrid Configuration Wizard.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: scottlan, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# You receive a warning about possible NDR of email messages when running Hybrid Configuration Wizard

_Original KB number:_ &nbsp; 4019940

## Symptoms

Consider the following scenario:

- You are running Microsoft Exchange Hybrid Configuration Wizard.
- Mail flow connectors are being created.
- You receive a warning message.

In this scenario, If you ignore the warning, the Hybrid Configuration Wizard lets you continue by using the value that's obtained from on-premises. However, your on-premises environment cannot send messages on behalf of any domain that's not validated as an accepted domain in your Microsoft 365 tenant.

Also, you receive the following non-delivery report (NDR):

> 550 5.7.64 Relay Access Denied ATTR36. For more details please refer to: `https://support.microsoft.com/kb/3169958`

## Cause

The warning message that is mentioned in the Symptoms section is generated if one of the following conditions is true:

- The certificate that you are using on-premises has a subject name (the certificate value for host name) that does not match any accepted domain in your Microsoft 365 tenant.

    For example, the certificate subject is \<S>CN=*contoso.com*. However, the *contoso.com* domain isn't validated in your Microsoft 365 tenant.

- The certificate that you are using on-premises has a subject name that contains a host name that doesn't belong to an immediately accepted domain name that's validated in your Microsoft 365 tenant.

    For example, the certificate subject is \<S>CN=*hostname.contoso.com*. However, the *contoso.com* domain isn't validated in your Microsoft 365 tenant. As another example, the certificate subject name is \<S>CN=hostname.subdomain.contoso.com. However, onlycontoso.com is registered as an accepted domain for your tenant.

## Resolution

To enable your on-premises environment to send messages, use one of the following methods:

- (Preferred) Add the domain that's used on the certificate to the Microsoft 365 tenant. If you own the domain, sign in to Microsoft 365 by using administrator permissions, locate **Settings** > **Domains**, and then follow the instructions. If the certificate subject name is *hostname.subdomain.contoso.com*, you have to add only *subdomain.contoso.com*.
- Have the certificate reissued by using a different name that matches an accepted domain in the Microsoft 365 tenant. You can still any specify subject alternative names that you want. Wildcard certificates are enabled, but not required.

    > [!NOTE]
    > If you do this, you have to install the newly issued certificate on the Exchange Server that's used for hybrid mail flow. You may also have to make sure that the fully qualified domain name (FQDN) is set correctly on the Exchange Server connector.

After you complete either option, rerun the Hybrid Configuration Wizard so that the Exchange Online connector can be set correctly.

## More information

Make sure that the client certificate that's provided when you establish Transport Layer Security (TLS) matches the value of the `TlsSenderCertificateName` parameter on the (inbound) connector. Then, authenticate the certificate as a validated accepted domain. You can use this method to verify that messages that are submitted during an SMTP conversation belong to your Microsoft 365 tenant. In this manner, you can verify that the messages exist only on the tenant.

For more information, see [Identifying email from your email server](/previous-versions/exchange-server/exchange-150/dn910993(v=exchg.150)).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
