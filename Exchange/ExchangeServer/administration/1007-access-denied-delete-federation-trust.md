---
title: Access Denied when you delete federation trust
description: Describes an issue that occurs when you try to remove the federation trust in an Exchange environment, and provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: brenle, jmartin, v-six, v-kccross
ms.custom: 
  - sap:Plan and Deploy\Need help to deploy Oauth, HMA, ADFS
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 11519
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
ms.date: 04/26/2026
---

# Error 1007 AccessDenied when you try to delete the federation trust in an Exchange organization

_Original KB number:_ &nbsp; 3215278

## Summary

When you try to delete a federation trust in your Exchange organization, you might receive an AccessDenied error. This issue occurs when your organization's federation certificate has expired, which prevents the federation trust from being removed by using the standard process. To resolve this issue, use the -force parameter with the Remove-FederatedDomain cmdlet in the Exchange Management Shell (EMS).

## Symptoms

This problem occurs if your organization's federation certificate has expired. When this problem occurs, you receive an error message that resembles the following:

> The URI "**contoso.com**" for domain "**contoso.com**" on application identifier "**xxxxxxxxxxxxxxxx**" couldn't be released.  
> Detailed information: "An unexpected result was received from Windows Live. Detailed information: "1007 AccessDenied: Access Denied.".".

## Workaround

To work around this issue, use the `-force` parameter to delete the current federation trust. You'll perform this workaround in the Exchange Management Shell (EMS). For more information about the EMS, see [Connect to Exchange servers using remote PowerShell](/powershell/exchange/connect-to-exchange-servers-using-remote-powershell).

To delete the trust, follow these steps:

1. Identify your federated domains.

    If you have multiple federated domain names, you'll have to determine which is your primary `AccountNamespace`.

    Run the [Get-FederatedOrganizationIdentifier](/powershell/module/exchangepowershell/Get-FederatedOrganizationIdentifier) cmdlet in the Exchange Management Shell (EMS) to identify the federated domains and `AccountNamespace`:

    ```powershell
    Get-FederatedOrganizationIdentifier
    ```

    For example, if the `AccountNamespace` is set to `FYDIBOHF25SPDLT.Contoso.com`, `Contoso.com` is your primary `AccountNamespace`. This will be the last domain to be removed.

1. Remove the federated domains if more than one domain is federated.

    Run the [Remove-FederatedDomain](/powershell/module/exchangepowershell/remove-federateddomain) cmdlet in the EMS to remove each federated domain:

    ```powershell
    Remove-FederatedDomain -DomainName <your federated domain > -force
    ```

    For example: `RemoveFederatedDomain -DomainName Contoso.com -force`

1. Remove the federated domain that's associated with your AccountNameSpace.

    Run the [Remove-FederatedDomain](/powershell/module/exchangepowershell/remove-federateddomain) cmdlet in the EMS to remove the federated domain that's associated with your `AccountNameSpace`:

    ```powershell
    Remove-FederatedDomain -DomainName <your federated domain> -force
    ```

    For example: `Remove-FederatedDomain -DomainName Contoso.com -force`
  
1. Remove the federation trust.

    Run the [Remove-FederationTrust](/powershell/module/exchangepowershell/remove-federationtrust) cmdlet in the EMS to remove the federation trust:

    ```powershell
    Remove-FederationTrust "Microsoft Federation Gateway"
    ```

For more information about how to create a federation trust, see [Configure a federation trust](/exchange/configure-a-federation-trust-exchange-2013-help).
