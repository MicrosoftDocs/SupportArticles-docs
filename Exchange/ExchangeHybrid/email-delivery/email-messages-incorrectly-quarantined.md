---
title: Email messages are incorrectly quarantined
description: Fixes an issue in which email messages are incorrectly quarantined or SPF checks fail in Exchange hybrid deployments that use centralized mail control. This problem occurs if header promotion is configured incorrectly.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: alehud, v-six
appliesto: 
  - Exchange Online
  - Exchange Online Protection
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Email messages are incorrectly quarantined in Exchange hybrid deployments that use centralized mail control

_Original KB number:_ &nbsp; 3079142

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the [Microsoft 365 Hybrid Configuration wizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Problem

You have a hybrid deployment of on-premises Exchange Server and Exchange Online in Microsoft 365. In this deployment, you use centralized mail control. This forces messages to route to the on-premises mail server before they are delivered to Exchange Online mailboxes. In this scenario, you experience one or more of the following symptoms:

- Spam notifications to users are quarantined.
- Email messages on the Allow list are quarantined.
- Email messages that are released from quarantine are requarantined.
- Sender Policy Framework (SPF) checks fail on the second pass.

## Cause

This problem occurs if the Exchange Online organization or the on-premises organization isn't set up to promote email headers as cross-premises (that is, from Exchange Online to the on-premises server to Microsoft 365).

## Solution

1. Verify that centralized mail control is enabled and is set up to promote headers in Microsoft 365. To do this, follow these steps:

   1. Connect to Exchange Online by using a remote Windows PowerShell session. For more information, see [Connect to Exchange Online using remote PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
   2. View the configuration information of the hybrid outbound connector in the Exchange Online organization. To do this, run the following command:

        ```powershell
        Get-OutboundConnector "Contoso Outbound Connector" | Format-List
        ```  

        Verify that the value of the `RouteAllMessagesViaOnPremises` property is set to **$true**.
   3. View the configuration information of the hybrid inbound connector in the Exchange Online organization. To do this, run the following command:

        ```powershell
        Get-InboundConnector "Contoso Inbound Connector" | Format-List
        ```

        Verify that the value of the `CloudServicesMailEnabled` property is set to **$true**.
   4. Locate the following line in the headers:

      `X-MS-Exchange-Organization-Cross-Premises-Headers-Promoted: <Microsoft 365 Server Name>`

      For example, *server.contoso.com*.

      > [!NOTE]
      > If the `RouteAllMessagesViaOnPremises` property and the `CloudServicesMailEnabled` property are set to **$false**, and the `X-MS-Exchange-Organization-Cross-Premises-Headers-Promoted: <Microsoft 365 Server Name>` header isn't found, this resolution does not apply to your organization's configuration.

2. Send an inbound test message to an Exchange Online mailbox by routing the message through the on-premises server first. Locate the following X-header lines in the message headers. This helps indicate that the message was scanned two times in transport.

   - `X-Forefront-Antispam-Report-Untrusted`: This is the first pass. It occurs when the message is first received in Microsoft 365. The connecting IP address (CIP) on that line will be an Internet IP address.
   - `X-Forefront-Antispam-Report`: This is the second pass. It occurs when the message is returned by the on-premises server and is received for the second time in Microsoft 365. The connecting IP address will be your organization's on-premises server IP address.

   > [!NOTE]
   > If there's only one X-Forefront header, this resolution does not apply to your organization's configuration.

3. To promote the headers from the on-premises environment back to Microsoft 365, follow these steps:
   1. Verify that the headers are currently not being promoted. To do this, check whether the following line is missing in the headers:

      `X-MS-Exchange-Organization-Cross-Premises-Headers-Promoted: <On-premises Server Name>`

      For example, the on-premises server name is *contoso_on_premises.contoso.com*.
   2. Locate `X-OriginatorOrg` from the headers. It will be in the format of *contoso.onmicrosoft.com*.
   3. Open the Exchange Management Shell in Exchange 2013 or Exchange 2010, and then run the following commands:

        - ```powershell
          New-RemoteDomain -Name 'Hybrid Domain - contoso.onmicrosoft.com' -DomainName 'contoso.onmicrosoft.com'
          ```  

        - ```powershell
          Set-RemoteDomain 'Hybrid Domain - contoso.onmicrosoft.com' -TrustedMailOutboundEnabled $true -TrustedMailInboundEnabled $true
          ```

   4. Verify that the issue is fixed. Send a new message, and then verify that the following line is present in the headers:

      `X-MS-Exchange-Organization-Cross-Premises-Headers-Promoted: <On-premises Server Name>`

      For example, the on-premises server name is *contoso_on_premises.contoso.com*.

## More information

For more information, see the following Microsoft resources:

- [Exchange Server hybrid deployments](/exchange/exchange-hybrid)
- [Hybrid Deployments](/previous-versions/office/exchange-server-2010/gg577584(v=exchg.141))
