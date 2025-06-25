---
title: Access Denied when you delete federation trust
description: Describes an issue that occurs when you try to remove the federation trust in an Exchange organization, and provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: brenle, jmartin, v-six
ms.custom: 
  - sap:Plan and Deploy\Need help to deploy Oauth, HMA, ADFS
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Service Pack 3
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
ms.date: 01/24/2024
---
# Error (1007 AccessDenied) when you try to delete the federation trust in an Exchange organization

_Original KB number:_ &nbsp; 3215278

## Symptoms

This problem occurs if your Exchange organization's federation certificate has expired. When this problem occurs, you receive an error message that resembles the following:

> The URI "**contoso.com**" for domain "**contoso.com**" on application identifier "**xxxxxxxxxxxxxxxx**" couldn't be released.  
> Detailed information: "An unexpected result was received from Windows Live. Detailed information: "1007 AccessDenied: Access Denied.".".

## Workaround

To work around this issue, use the `-force` parameter to delete the current federation trust. To do this, follow these steps:

1. Identify your federated domains.

    If you have multiple federated domain names, you'll have to determine which is your primary AccountNamespace.

    Run the following cmdlet in the Exchange Management Shell to identify the federated domains and AccountNamespace:

    ```powershell
    Get-FederatedOrganizationIdentifier
    ```

    For example, if the AccountNamespace is set to `FYDIBOHF25SPDLT.Contoso.com`, `Contoso.com` is your primary AccountNamespace. This will be the last domain to be removed.

2. Remove the federated domains if more than one domain is federated.

    Run the following cmdlet in the Exchange Management Shell to remove each federated domain:

    ```powershell
    Remove-FederatedDomain -DomainName <your federated domain > -force
    ```

    For example: `RemoveFederatedDomain -DomainName Contoso.com -force`

3. Remove the federated domain that's associated with your AccountNameSpace.

    Run the following cmdlet in the Exchange Management Shell to remove the federated domain that's associated with your AccountNameSpace:

    ```powershell
    Remove-FederatedDomain -DomainName <your federated domain> -force
    ```

    For example: `Remove-FederatedDomain -DomainName Contoso.com -force`
  
4. Remove the federation trust.

    Run the following cmdlet in the Exchange Management Shell to remove the federation trust:

    ```powershell
    Remove-FederationTrust "Microsoft Federation Gateway"
    ```

For more information about how to create a federation trust, see [Configure a federation trust](/exchange/configure-a-federation-trust-exchange-2013-help).
