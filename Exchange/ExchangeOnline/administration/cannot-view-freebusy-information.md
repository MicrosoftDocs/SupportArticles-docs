---
title: Can't view free/busy information
description: Describes a scenario in which users who have a mailbox in the on-premises environment can't view free/busy information for mailboxes in Exchange Online in a hybrid environment. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: akruss, jmartin, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# On-premises users can't view free/busy information of Exchange Online users

_Original KB number:_ &nbsp; 3137325

## Symptoms

Users who have a mailbox in the on-premises environment can't view free/busy information for mailboxes in Exchange Online in the following scenario:

- You have a hybrid deployment of Exchange Online and either on-premises Exchange Server 2016 or Exchange Server 2013.
- You set up an intraorganization connector between the Exchange Online organization and the on-premises Exchange organization.
- You set up an organization relationship between the Exchange Online organization and the on-premises Exchange organization.

## Cause

This issue occurs if the on-premises Exchange server can't obtain an authentication token by using OAuth. Exchange doesn't try to use the organization relationship if an intraorganization connector exists.

## Resolution

To resolve this issue, follow these steps.

### Step 1 - Verify the OAuth certificate

1. Open the Exchange Management Shell.
2. To identify the certificate for which the authentication configuration is looking, run the following command:

    ```powershell
    Get-AuthConfig |fl
    ```

3. If no value is returned in the output for CurrentCertificateThumbprint, run the following command to create a new certificate:

    ```powershell
    New-ExchangeCertificate -KeySize 2048 -SubjectName "cn= Microsoft Exchange ACS Certificate" -FriendlyName "Microsoft Exchange Server ACS Certificate" -PrivateKeyExportable $true -Services SMTP -DomainName <YourPrimarySmtpDomain>
    ```

4. Run the following commands to assign the new certificate for OAuth authentication:

    ```powershell
    Set-AuthConfig -NewCertificateThumbprint <ThumbprintFromStep3> -NewCertificateEffectiveDate (Get-Date)
    ```

    ```powershell
    Set-AuthConfig -PublishCertificate
    ```

### Step 2 - Specify the user account for the partner application

1. Open the Exchange Management Shell.
2. To identify the linked user account for the partner application, run the following command:

    ```powershell
    Get-PartnerApplication |fl
    ```

3. If no account is returned in the output, run the following command to add the appropriate user account:

    ```powershell
    Set-PartnerApplication "Exchange Online" -LinkedAccount "contoso.com/Users/Exchange Online-ApplicationAccount"
    ```

## More information

For more information about the cmdlets used in this article, see the following Microsoft TechNet resources:

- [Get-AuthConfig](/powershell/module/exchange/get-authconfig?view=exchange-ps&preserve-view=true)
- [Set-AuthConfig](/powershell/module/exchange/set-authconfig?view=exchange-ps&preserve-view=true)
- [Get-PartnerApplication](/powershell/module/exchange/get-partnerapplication?view=exchange-ps&preserve-view=true)
- [Set-PartnerApplication](/powershell/module/exchange/set-partnerapplication?view=exchange-ps&preserve-view=true)
