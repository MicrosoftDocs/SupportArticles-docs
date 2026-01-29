---
title: Certificate assignment fails with error 0xe434352
description: This article resolves error 0xe434352 that occurs during certificate assignment if unsupported characters are used in the domain name of Receive Connectors.
#customer intent: As an Exchange Server administrator, I want to resolve certificate binding issues that are caused by invalid fully-qualified domain names (FQDNs) so that I can maintain system reliability.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrative Tasks
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: igserr, batre, arindamt, v-kccross
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 01/28/2026
---

# Error 0xe434352 and SMTP certificate assignment fails 

## Summary

When you assign certificates to Exchange services, you might encounter error 0xe0434352 during the certificate binding process. This error typically indicates that one or more Receive Connectors in your Microsoft Exchange Server environment use FQDNs that contain characters that aren't supported by DNS standards.

## Symptoms

You run the `Enable-ExchangeCertificate` cmdlet to assign a certificate to the SMTP service. The operation fails and returns the following error message:

> The Exchange Certificate operation has failed with an exception on server <*Server Name*>.
> 
> The error message is: Unknown error (0xe0434352)

## Cause

This issue occurs if the FQDN of one or more Receive Connectors contains unsupported characters, such as underscores. The connector creation process allows unsupported characters, such as underscores, in the domain name. However, these characters violate DNS standards and cause failures during certificate binding.

For more information about domain names, see the following articles:

- [DNS host names](../../support/windows-server/active-directory/naming-conventions-for-computer-domain-site-ou.md#dns-host-names)
- [Unsupported characters for Exchange 2013 object names](/exchange/unsupported-characters-for-exchange-2013-object-names-exchange-2013-help)

## Resolution

To resolve this issue, use the Exchange Management Shell to find connectors that have invalid FQDNs. Run the following PowerShell command:

```powershell
Get-ReceiveConnector | Select Identity, FQDN  
```

You can refine your search to look for specific unsupported characters. The following example searches for underscores in FQDNs:

```powershell
Get-ReceiveConnector | Where-Object { $_.FQDN -like "*_*" } | Select Identity, FQDN
```

After you identify the connector that contains unsupported characters, rename it by using supported characters:

```powershell
Set-ReceiveConnector -Identity "ServerName\ConnectorName" -FQDN ValidFQDN.domain.com
```

After you fix the domain name, retry the certificate assignment to verify that you no longer encounter the error:

```powershell
Enable-ExchangeCertificate -Thumbprint <Thumbprint> -Services SMTP
```

## References

For more information about domain name formation and supported characters, see:

- DoD Internet host table specification [RFC 952](https://www.rfc-editor.org/rfc/rfc952)
- Domain names - Implementation and specification [RFC 1035](https://www.rfc-editor.org/rfc/rfc1035)
- Requirements for Internet hosts - Application and Support [RFC 1123](https://www.rfc-editor.org/rfc/rfc1123)
