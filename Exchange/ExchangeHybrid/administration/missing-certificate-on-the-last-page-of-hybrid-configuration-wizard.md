---
title: Missing certificate from Hybrid Configuration Wizard
description: Describes an issue in which the last page of the Hybrid Configuration Wizard is missing a certificate. Occurs when you try to set up a hybrid deployment of on-premises Exchange Server and Exchange Online in Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: chwillia, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Missing certificate on the last page of the Hybrid Configuration Wizard

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Microsoft 365 Hybrid Configuration wizard that's available at [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

_Original KB number:_ &nbsp; 2879262

## Symptoms

You run the Hybrid Configuration Wizard to set up a hybrid deployment of on-premises Microsoft Exchange Server and Exchange Online in Microsoft 365. However, when you get to the last page of the wizard, you discover that a certificate is missing.

## Cause

This issue occurs if the root certification authority (CA) wasn't imported successfully. Therefore, it isn't verified as a public, third-party root CA, and the Exchange certificate wasn't configured correctly for an Exchange 2010 hybrid deployment.

## Resolution

To resolve this issue, check the value of the `RootCAType` property. To do so, use the Exchange Management Shell on the hybrid server to run the following command:

```powershell
Get-ExchangeCertificate | FL
```

The `RootCAType` property identifies the kind of CA that issued the certificate. It should return a value of **ThirdParty**.

If it instead returns a value of either **Registry** or **None**, reimport the certificate on the hybrid server, and then configure the certificate for an Exchange hybrid deployment. For more information, see [Configure Exchange Certificates for an Exchange 2007 Hybrid Deployment](/previous-versions/exchange-server/exchange-141/gg981497(v=exchg.141)).

## More information

The `RootCAType` property can have any of the following values:

- **Registry**: An internal, private PKI root CA that has been manually installed in the certificate store.
- **ThirdParty**: A public, third-party root CA. If the property's value is **Registry**, the certificate isn't listed when you run the Hybrid Configuration Wizard.

In the case of a private CA, the Hybrid Configuration Wizard can't be completed successfully. Self-signed certificates can't be used for Exchange services in a hybrid deployment. You have to install and assign Exchange services to a valid digital certificate that is purchased from a trusted CA.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
