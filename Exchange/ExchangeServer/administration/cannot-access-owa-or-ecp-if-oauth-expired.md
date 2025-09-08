---
title: Can't access OWA/EAC with expired OAuth certificate
description: Fixes an issue in which you can't sign in to Outlook on the web (formerly known as Outlook Web App) or EAC if the Exchange Server OAuth certificate is expired. Provide steps to create and deploy a new certificate.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Clients and Mobile\Can't Connect to Mailbox with OWA
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: jashinba, mhaque, v-six
appliesto: 
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
  - Exchange Server 2010
search.appverid: MET150
ms.date: 01/24/2024
---
# Can't sign in to Outlook on the web or EAC if Exchange Server OAuth certificate is expired

_Original KB number:_ &nbsp; 2617816

## Symptoms

When you try to sign in to Outlook on the web or the EAC in Exchange Server, the web browser freezes or reports that the redirect limit was reached. Additionally, Event 1003 is logged in the event viewer. For example, the following entry is logged:

> Event ID: 1003  
Source: MSExchange Front End HTTPS Proxy  
[Owa] An internal server error occurred. The unhandled exception was: System.NullReferenceException: Object reference not set to an instance of an object.  
   at Microsoft.Exchange.HttpProxy.FbaModule.ParseCadataCookies(HttpApplication httpApplication)

> [!NOTE]
> The EAC was introduced in Exchange Server 2013, and replaces the Exchange Management Console (EMC) and the Exchange Control Panel (ECP), which were the two management interfaces in Exchange Server 2010.

## Cause

This issue occurs if the Exchange Server Open Authentication (OAuth) certificate is expired, not present, or not configured correctly.

## Resolution

To check the status of your existing OAuth certificate, run the following command in the Exchange Management Shell:

```powershell
(Get-AuthConfig).CurrentCertificateThumbprint | Get-ExchangeCertificate | Format-List
```

If the command returns an error, or the certificate has expired, use the following steps to create and deploy a new OAuth certificate to the Exchange server:

1. Create a new OAuth certificate by running the following command:

    ```powershell
    New-ExchangeCertificate -KeySize 2048 -PrivateKeyExportable $true -SubjectName "cn=Microsoft Exchange Server Auth Certificate" -FriendlyName "Microsoft Exchange Server Auth Certificate" -DomainName @()
    ```

2. Set the new certificate for server authentication. To do this, run the following commands:

    ```powershell
    Set-AuthConfig -NewCertificateThumbprint <ThumbprintFromStep1> -NewCertificateEffectiveDate (Get-Date)
    Set-AuthConfig -PublishCertificate
    Set-AuthConfig -ClearPreviousCertificate
    ```

3. Restart the Microsoft Exchange Service Host Service.
4. Either run the `IISReset` command to restart IIS or run the following commands (in elevated mode) to recycle the Outlook on the web and EAC application pools:

    ```powershell
    Restart-WebAppPool MSExchangeOWAAppPool
    Restart-WebAppPool MSExchangeECPAppPool
    ```

    > [!NOTE]
    > In some environments, it may take an hour for the OAuth certificate to be published. If you have a hybrid setup, you have to run the Hybrid Configuration Wizard again to update the changes to Microsoft Entra ID.

## More information

To check the expiration date of your certificate, follow these steps:

1. Open the Microsoft Management Console. To do this, open the **Run** box (Windows logo key+R), enter *MMC*, and then press Enter.

    > [!NOTE]
    > If you are prompted for an administrator password or for confirmation, type the password or select **Yes**.

1. Select **File** > **Add/Remove Snap-in** > **Select Certificates** > **Add** > **Computer Account**, and then select **Finish** to close the window.

1. Find the **Microsoft Exchange Server Auth Certificate** entry in the **Personal** > **Certificate** folder, and verify the expiration date.
