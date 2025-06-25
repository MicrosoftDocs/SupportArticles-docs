---
title: Email shows addresses instead of names in From
description: Describes an issue in which email messages that are sent from the on-premises environment to Microsoft 365 show email addresses instead of display names in the From field after you migrate mailboxes to Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Emails that are sent from on-premises to Microsoft 365 show email addresses not display names in From

_Original KB number:_ &nbsp; 2663556

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Microsoft 365 Hybrid Configuration wizard that's available at [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Symptoms

After you migrate mailboxes from your on-premises environment to Microsoft 365 in a hybrid deployment, the **From** field of email messages that are sent from the on-premises environment to Microsoft 365 doesn't show display names. Instead, the **From** field shows email addresses.

## Cause

This issue occurs if the hybrid deployment is set up incorrectly.

To verify that you're experiencing this issue, examine the email header of an email message that was sent from the on-premises user account. Typically, `X-MS-Exchange-Organization-AuthAs` should be listed as **Internal**. If `X-MS-Exchange-Organization-AuthAs` is listed as **anonymous** or if it's missing, this indicates an incorrect configuration or an incorrect mail route.

## Resolution

To fix this issue, follow these steps:

1. Check the mail route.

    The simplest route is Exchange 2010 mailbox server to Exchange 2010 hub server (hybrid server) to the Exchange Online Protection (EOP) inbound connector to Exchange Online. Make sure that there are no unnecessary network devices such as anti-spam gateway devices between the Exchange 2010 hub server (hybrid server) and EOP. Those devices could remove the necessary header.

2. Check the remote domain of the on-premises Exchange server. To do this, follow these steps:

   1. In Exchange Management Shell, run the following PowerShell command:

        ```powershell
        Get-RemoteDomain < NameOfService>.< DomainName>.com | FL
        ```

        For example:

        ```powershell
        Get-RemoteDomain exchangedelegation.contoso.com | FL
        ```  

   2. In the output, make sure that the `TrustedMailOutboundEnabled`, `TargetDeliveryDomain`, and `IsInternal` attributes are set to **True**.

   3. If the attributes in step 2b aren't set to **True**, use the `Set-RemoteDomain` command to change the value to **True**.

3. Check the remote domain in Microsoft 365. To do this, follow these steps:
   1. Connect to Exchange Online by using remote PowerShell. For more info about how to do this, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
   2. Run the following PowerShell command:

        ```powershell
        Get-RemoteDomain <FQDNOfOnPremisesEndConnector> | FL
        ```  

   3. In the output, make sure that the `TrustedMailnboundEnabled` attribute is set to **True**.
   4. If the attribute in step 3C isn't set to **True**, use the `Set-RemoteDomain` command to change the value to **True**.

4. Make sure that Transport Layer Security (TLS) is implemented and enabled in both environments and that the fully qualified domain name (FQDN) is set correctly. Check the on-premises send connector and the EOP inbound connector by using the Exchange Server Deployment Assistant at [Exchange Deployment Assistant](/exchange/exchange-deployment-assistant?view=exchserver-2019&preserve-view=true).

5. Check the Exchange certificate of the send connector on the on-premises Exchange servers that are responsible for delivering mail to EOP. The Exchange certificate should have Simple Mail Transfer Protocol (SMTP) enabled and should match the FQDN of the send connector.

If the issue persists after you follow these steps, contact Microsoft 365 Support.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](https://social.technet.microsoft.com/forums/exchange/home?category=exchange2010%2cexchangeserver).
