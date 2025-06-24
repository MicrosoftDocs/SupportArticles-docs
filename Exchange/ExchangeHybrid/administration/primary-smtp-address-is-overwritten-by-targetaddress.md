---
title: Primary SMTP address is overwritten by targetAddress
description: The primary SMTP address of a mailbox is changed when the targetAddress is in the form SMTP usernam@domain.com.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: gmuntean, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Primary SMTP proxy address is replaced by targetAddress value in a hybrid environment

_Original KB number:_ &nbsp; 4459261

## Symptoms

Consider the following scenario:

- In a hybrid environment, the primary SMTP proxy address of a user's mailbox is set to **SMTP:FirstName.LastName\@domain.com**.
- The `targetAddress` attribute of the user is set to **SMTP:FirstName.LastName\@ExternalDomain.com**.
- The email address policy in the hybrid environment is set as follows:

  - **EnabledPrimarySMTPAddressTemplate**: @domain.com
  - **EnabledEmailAddressTemplates**: {`smtp:%m@domain.mail.onmicrosoft.com`, `SMTP:@domain.com`}

In this scenario, when you run the [Hybrid Configuration Wizard](/exchange/hybrid-configuration-wizard) (HCW), the following cmdlets are run:

```powershell
Set-EmailAddressPolicy -Identity "Default Policy" -ForceUpgrade "True" -EnabledEmailAddressTemplates ("SMTP: @domain.com", "smtp:%m@domain.mail.onmicrosoft.com", + "SMTP: @domain.com" + "smtp:%m@domain.mail.onmicrosoft.com")
```

```powershell
Update-EmailAddressPolicy -Identity "Default Policy" -UpdateSecondaryAddressesOnly "True" -DomainController "GlobalCatalog.domain.com"
```

In this scenario, the primary SMTP address will be replaced by the value of the `targetAddress` attribute. The `proxyAddresses` attribute will now have the former primary SMTP address as a secondary address, and the attribute value will be {`SMTP:FirstName.LastName@ExternalDomain.com`, `smtp:FirstName.LastName@domain.com`, `smtp:FirstName.LastName@domain.mail.onmicrosoft.com`}.

## Cause

This behavior is by design, as the `targetAddress` attribute value is considered when you update the email address policy.

The `UpdateSecondaryAddressesOnly` attribute only changes the secondary SMTP addresses. However, when the `targetAddress` attribute has a value, it will be added to the list of addresses of the `proxyAddresses` attribute. If the `targetAddress` is written in the form **SMTP**:EmailAddress, it will replace the primary address from the `proxyAddresses` attribute, while the former primary address (SMTP:) will now appear as a secondary address (smtp:).

## Workaround

To work around this issue, user lower case instead of upper case letters for the `targetAddress` attribute (use smtp instead of SMTP).
