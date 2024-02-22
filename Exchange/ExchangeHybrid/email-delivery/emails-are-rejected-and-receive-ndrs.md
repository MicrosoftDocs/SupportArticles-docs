---
title: Emails are rejected and NDRs are received
description: Discusses a scenario in which email messages that are sent from cloud-based mailboxes in a hybrid deployment of on-premises Exchange Server and Exchange Online in Microsoft 365 are rejected, and nondelivery reports are received. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: jhayes, rorylen, v-six
appliesto: 
  - Exchange Online
  - Exchange Online Protection
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Emails sent from Microsoft 365 in a hybrid deployment are rejected and nondelivery reports are received

_Original KB number:_ &nbsp; 2750145

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Microsoft 365 Hybrid Configuration wizard that's available at [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Symptoms

You run the Hybrid Configuration wizard in Exchange Server 2010 to set up a shared namespace and centralized mail control configuration between your on-premises Exchange Server environment and Exchange Online in Microsoft 365. However, eventually, you notice that email messages that are sent from cloud-based mailboxes are rejected, and senders receive nondelivery reports (NDRs). Over time, the frequency of the NDRs increase.

## Cause

This issue can occur if the IP addresses that are associated with Exchange Online Protection changed. These IP addresses aren't automatically updated in the on-premises environment. Therefore, the IP addresses that are set in the on-premises Exchange Online Protection receive connector may become invalid. When this issue occurs, mail that's routed from Microsoft 365 users through Exchange Online Protection to the on-premises environment may be rejected.

## Resolution

To fix this issue, use the following steps:

- Rerun the Hybrid Configuration wizard. Rerunning the wizard configures the on-premises Exchange Online Protection receive connector to use the correct IP addresses.

  > [!NOTE]
  > This step applies only to the Hybrid Configuration wizard in Exchange Server 2010. When you run the Hybrid Configuration wizard in Exchange Server 2013, no receive connectors are created or are necessary.

- Manually update the IP addresses that are listed under **Receive mail from remote servers that have these IP addresses** for the on-premises Exchange Online Protection receive connector.

## More information

In a shared namespace and centralized mail control scenario, an Exchange Online Protection receive connector must be created on the hybrid Exchange 2010 hub transport server to make sure that the on-premises environment receives mail from Microsoft 365 users. The Hybrid Configuration wizard creates the receive connector on the appropriate Exchange 2010 server. Then, the wizard configures the connector with the IP addresses to enable incoming Exchange Online Protection traffic from Microsoft 365 users to be routed to the on-premises environment.

The following screenshot shows an example of an Exchange Online Protection receive connector that the Hybrid Configuration wizard creates.

:::image type="content" source="media/emails-are-rejected-and-receive-ndrs/example-of-eop-receive-connector.png" alt-text="Screenshot of an Exchange Online Protection receive connector.":::

For more information about the Hybrid Configuration wizard in Exchange 2010, see [Hybrid Deployments with the Hybrid Configuration wizard](/previous-versions/office/exchange-server-2010/hh529920(v=exchg.141)).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
