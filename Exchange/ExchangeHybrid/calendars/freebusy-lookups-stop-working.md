---
title: Free/busy lookups stop working
description: Discusses an issue that prevents users from looking up free/busy information of other users. Occurs in a cross-premises environment or in a hybrid deployment of Exchange Server and Exchange Online in Microsoft 365. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendaring
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: timothyh, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Free/busy lookups stop working in a cross-premises environment or an Exchange Server hybrid deployment

> [!NOTE]
> The Hybrid Configuration wizard included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Microsoft 365 Hybrid Configuration wizard available at [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Symptoms

**Free/Busy** lookups stop working for users in a cross-premises environment, or in a hybrid deployment of on-premises Exchange Server and Exchange Online. Additionally, these issues may extend to other features that rely on the **Microsoft Federation Gateway**.

If you run the `Test-FederationTrust` cmdlet, you receive an error message that indicates that the Delegation token has validation issues. For example, you receive an error message that resembles the following:

```output
Id : TokenValidation  
Type: Error  
Message : Failed to validate delegation token.
```

Additionally, you might receive one of the following error messages in the **Exchange Web Services (EWS)** Responses:

> An error occurred when processing the security tokens in the message

> Autodiscover failed for email address User@contoso.com with error System.Web.Services.Protocols.SoapHeaderException: An error occurred when verifying security for the message

## Cause

This issue occurs if the certificate, and other metadata information, in the **Microsoft Federation Gateway** (or in the on-premises environment) becomes outdated or invalid.

## Resolution

To resolve this issue, refresh the metadata by running the `Get-FederationTrust | Set-FederationTrust -RefreshMetadata` command.

> [!NOTE]
> This command updates the information used for the Federation trust. You won't have to re-create organization relationships or sharing policies. The commands must be run in the target environment of the **Free/Busy** request.

1. Open the Exchange Management Shell on the on-premises Exchange server.
1. Run the following cmdlet:

    ```powershell
    Get-FederationTrust | Set-FederationTrust -RefreshMetadata
    ```

## More information

This issue could affect any environment that uses the **Microsoft Federation Gateway**. These environments include on-premises organizations that have set up free/busy, or sharing policies, between their organization and either other on-premises organizations, or **Exchange Online** in **Microsoft 365**.

To run the procedure in the Resolution section as an automated task and prevent future issues, open a command prompt on the Exchange server, then run the following command. Doing this updates the Federation trust daily.

```console
Schtasks /create /sc Daily /tn FedRefresh /tr "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -version 2.0 -command Add-PSSnapin Microsoft.Exchange.Management.PowerShell.SnapIn; $fedTrust = Get-FederationTrust;Set-FederationTrust -Identity $fedTrust.Name -RefreshMetadata" /ru System
```

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
