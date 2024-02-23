---
title: Federation trust and sharing errors
description: Resolves an issue in which federated sharing features for an Exchange 2010 organization stop functioning correctly after February 25, 2014.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2010 Standard
  - Exchange Server 2010 Enterprise
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Federation trust and sharing errors for federated Exchange 2010 organizations

_Original KB number:_ &nbsp; 2937358

## Problem

Federated sharing features for an Exchange 2010 organization stop working correctly after February 25, 2014. You or your federated sharing partners may see errors that affect federation trust and sharing features.

## Cause

Microsoft has discontinued federation trust support for the consumer instance of the Microsoft Federation Gateway. Currently, only federation trusts in the business instance of the Microsoft Entra authentication system are supported.

By default, the following Exchange organizations use the consumer instance of the Microsoft Federation Gateway and are immediately affected by this change in support:

- Release to manufacturing (RTM) versions of Exchange 2010 that have set up federation trusts for sharing free/busy calendar information together with other federated organizations
- Exchange organizations that are hosted by Microsoft Live@edu

By default, the following Exchange organizations use the business instance of the Microsoft Entra authentication system and aren't affected by this change:

- Exchange 2013 (or later version) organizations that use the Enable Federation Trust wizard
- Exchange 2010 Service Pack 1 (SP1) (or later version) organizations that use the New Federation Trust wizard
- Exchange organizations that are hosted by Microsoft 365, such as Exchange Online
- Federation trusts that are configured to support hybrid deployments between Exchange 2010 organizations and Exchange Online

If you're using Azure, and you have to verify which Microsoft Entra authentication system instance your Exchange organization is using for an existing federation trust, run the following command in the Exchange Management Shell:

```powershell
Get-FederationInformation -DomainName <your hosted Exchange domain namespace>
```

The consumer instance returns a value of \<uri:WindowsLiveID> for the *TokenIssuerURIs* parameter.

## Resolution

To resolve this issue, Exchange 2010 organizations and any affected federated Exchange 2010 partner organizations must remove their existing federation trusts and create new federation trusts by using the Microsoft Entra authentication system. To do so, follow these steps:

1. Identify your federated domains

    To identify the federated domains and **AccountNamespace**, run the following cmdlet in the Exchange Management Shell:

    ```powershell
    Get-FederatedOrganizationIdentifier
    ```

2. Remove the federated domains

    Run the following cmdlet in the Exchange Management Shell to remove each federated domain:

    ```powershell
    Remove-FederatedDomain -DomainName <your federated domain> -force
    ```

3. Remove AccountNamespace

    Run the following cmdlet in the Exchange Management Shell to remove **AccountNamespace**:

    ```powershell
    Remove-FederatedDomain -DomainName <your AccountNamespace> -force
    ```

4. Remove the federation trust

    Run the following cmdlet in the Exchange Management Shell to remove the federation trust:

    ```powershell
    Get-FederationTrust | Remove-FederationTrust
    ```

    For more information, see [Replace an expired federation certificate](/previous-versions/exchange-server/exchange-160/mt779252(v=exchg.160)#replace-an-expired-federation-certificate) and [Remove-FederationTrust](/powershell/module/exchange/remove-federationtrust).

5. Create a new federation trust

    For more information, see [Create a Federation Trust](/previous-versions/office/exchange-server-2010/dd335198(v=exchg.141)).
