---
title: Mail access issues in a hybrid Exchange deployment with cloud-based archive
description: Describes an issue in which users who have a cloud-based archive in a hybrid Exchange deployment can't access their mail in Outlook or Outlook on the web. Also, on-premises users receive an NDR when they try to send mail to users who have a cloud-based archive.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Archiving
  - CSSTroubleshoot
  - 'Associated content asset: 4555316'
ms.reviewer: timothyh, bilong
appliesto: 
  - Exchange Online,Exchange Online Archiving
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 05/05/2025
---
# Mail access issues in a hybrid Exchange deployment with cloud-based archive

_Original KB number:_&nbsp;2901386

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Microsoft 365 Hybrid Configuration wizard that's available at [Microsoft 365 Hybrid Configuration wizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Problem

You experience the following symptoms in a hybrid deployment of on-premises Microsoft Exchange Server and Exchange Online in Microsoft 365:

- When on-premises users try to send mail to a user who has a cloud-based archive, they receive a nondelivery report (NDR) that contains the following error message:

    > 554 5.2.0 STOREDRV.Deliver.Exception:UserWithoutFederatedProxyAddressException;
    >
    > Failed to process message due to a permanent exception with message User doesn't have any SMTP proxy address from a domain that is federated.
    >
    > UserWithoutFederatedProxyAddressException: User doesn't have any SMTP proxy address from a domain that is federated. ##

- A user who has a cloud-based archive can't access mail in Outlook or Outlook on the web (formerly known as Outlook Web App [OWA]). The user receives the following error message in Outlook on the web:

    > Url: <`https://mail.contoso.com:443/owa/auth.owaOWA`> version: 14.3.146.0
    >
    > ExceptionException type: System.NullReferenceException Exception message: Object reference not set to an instance of an object.

## Cause

This issue occurs if the email address policy has a default domain that isn't a federated domain. This causes the default SMTP address on the federated arbitration mailbox to use a domain that can't obtain a delegation token.

## Solution

1. Verify that you're experiencing this issue:
   1. Open the Exchange Management Shell on the on-premises Exchange 2013 server or Exchange 2010 server.
   1. Run the following cmdlet:

        ```powershell
        Get-Mailbox -arbitration |fl PrimarySMTPAddress
        ```

   1. In the output, note the SMTP domain that's specified for the FederatedEmail mailbox.

        The following is an example of the output:

        :::image type="content" source="media/mail-access-issues/listed-domain-output.png" alt-text="Screenshot shows an example of the output, which notes the S M T P domain that's specified for the FederatedEmail mailbox." border="false":::

   1. Run the following cmdlet:

        ```powershell
        get-FederatedOrganizationIdentifier |fl Domains
        ```

   1. Check whether the domain that you noted in step 1C is listed. If the domain isn't listed, you've verified that you are experiencing this issue. Go to step 2.

1. To resolve this issue, do one of the following:

   - Federate the SMTP domain that's associated with the arbitration mailbox  

        To do this, use the Exchange admin center or the Exchange Management Console to add the domain name to the existing federation trust.

        For more information about how to do this, go to [Manage a federation trust](/exchange/manage-a-federation-trust-exchange-2013-help).

   - Change the SMTP address of the arbitration mailbox and the transport settings container in Active Directory

        Change the email address of the federated arbitration mailbox to use a federated domain. Also change the email address of the transport settings container so that it matches the email address of the federated arbitration mailbox.

        > [!WARNING]
        > This procedure requires Active Directory Service Interfaces Editor (ADSI Edit). Using ADSI Edit incorrectly can cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that problems that result from the incorrect use of ADSI Edit can be resolved. Use ADSI Edit at your own risk.

        To do this, follow these steps:

        1. Open ADSI Edit, and connect to the domain naming context container.
        2. Under **Default naming context**, in the **User** container, open the properties of the federated arbitration mailbox.
        3. Change the value of the proxyAddress  attribute so that the primary SMTP address (the address in which SMTP is in uppercase letters) uses a federated domain.
        4. Connect to the **Configuration** container, and then locate the transport settings container in the following path:

           **Configuration** \ **Services** \ **Microsoft Exchange** \ **\<organization name>**  
        5. Open the properties of the transport settings container, and then change the value of the MSExchOrgFederatedMailbox attribute to the SMTP address that you specified in step 3.
