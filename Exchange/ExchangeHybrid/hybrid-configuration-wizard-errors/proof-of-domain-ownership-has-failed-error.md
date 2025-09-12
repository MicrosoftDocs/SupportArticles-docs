---
title: Proof of domain ownership has failed error
description: Describes an issue in which you receive a Make sure that the TXT record for the specified domain is available in DNS error when you run the Hybrid Configuration wizard.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: scotro, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Proof of domain ownership has failed error when you run the Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3068837

## Symptoms

When you run the Hybrid Configuration wizard, you receive a **Proof of domain ownership has failed. Make sure that the TXT record for the specified domain is available in DNS** error message. The full text of the message resembles the following:

> ERROR:System.Management.Automation.RemoteException: Proof of domain ownership has failed. Make sure that the TXT record for the specified domain is available in DNS. The format of the TXT record should be ""example.com IN TXT hash-value"" where ""example.com"" is the domain you want to configure for Federation and ""hash-value"" is the proof value generated with ""Get-FederatedDomainProof -DomainName example.com"".

## Cause

This problem occurs if proof of ownership for the domain is required. If an existing federation trust isn't present, the Hybrid Configuration wizard creates a federation trust between the on-premises organization and the Microsoft Entra authentication system. When the federation trust is being created, proof of domain ownership is required.

## Resolution

Provide proof of ownership by creating a text (TXT) record in the Domain Name System (DNS) zone of each accepted domain that you want to federate. The TXT record contains the federated domain proof encryption string that's generated when you run the `Get-FederatedDomainProof` cmdlet for each domain.

Make sure that your external DNS server has the correct TXT records for **Proof** and that you can successfully query the server. To do this, follow these steps:

1. Open Exchange Management Shell on the on-premises Exchange server, and then run the following command:

    ```powershell
    Get-FederatedDomainProof -DomainName contoso.com
    ```

2. On a computer that uses an external DNS server, run the following command:

    ```console
    Nslookup.exe -querytype=txt <contoso.com>
    ```

3. Examine the values that are returned in the commands that you ran in steps 1 and 2.

    One of the values that's returned by the `Nslookup` command must match the **Proof of Domain Ownership** value that's returned by the `Get-FederatedDomainProof` command. If the values do not match, use the result that's returned by the `Get-FederatedDomainProof` command to update your external DNS server. For more information about how to do this, see [Create a TXT Record for Federation](/previous-versions/office/exchange-server-2010/ee423548(v=exchg.141)).

4. Rerun the Hybrid Configuration wizard.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
