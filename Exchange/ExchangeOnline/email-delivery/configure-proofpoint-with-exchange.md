---
title: Configure Proofpoint Email Protection with Exchange Online
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.date: 01/24/2024
audience: Admin
ms.topic: troubleshooting
ms.collection: 
  - exchange-online
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Exchange Online
ms.custom: 
  - sap:Mail Flow
  - Exchange Online
  - CI 123370
  - CSSTroubleshoot
ms.reviewer: stanalek, v-six
description: Describes how to configure Proofpoint Email Protection and other Sendmail-based applications with Exchange Online.
---
# Configure Proofpoint Email Protection to work with Exchange Online

Exchange Online supports [integration with third-party Sendmail-based filtering solutions](/exchange/mail-flow-best-practices/manage-mail-flow-using-third-party-cloud) such as Proofpoint Email Protection (both the cloud service and on-premises deployments).

A popular configuration is shown in the following figure. It involves connecting Proofpoint and Exchange Online so that Proofpoint provides the first level of email filtering and then sends email messages to Exchange Online.

:::image type="content" source="media/configure-proofpoint-with-exchange/configure-proofpoint-with-exchange.png" alt-text="A popular configuration for email filtering using Proofpoint and Exchange Online.":::

In this configuration, if Proofpoint encounters a deferral from Exchange Online, its default settings prevent it for a long time from retrying the email messages. This situation causes long mail delays of an hour or more.

To prevent these delays, Microsoft and Proofpoint Support and Operations teams have identified changes that must be made to the Proofpoint settings for both cloud and on-premises deployments. Affected tenant admins have confirmed that these changes resolved their mail delay issue without introducing other issues.

## Changes to Proofpoint settings

Make the following changes to the Proofpoint default settings.

### Specify a limit for the number of messages per connection

By default, Proofpoint does not limit the number of messages that it sends per connection. However, Exchange Online maintains each connection for only 20 minutes. If the number of messages that are sent by Proofpoint is more than the number that can be transferred to Exchange Online within this time frame, mail delays occur and **ConnectionReset** error entries appear   in the Proofpoint log. These errors cause Proofpoint to identify Exchange Online as a bad host by logging an entry in the HostStatus file. This entry prevents Proofpoint from retrying the message immediately.

To avoid this situation, do the following:

1. Set the value of **Maximum Number of Messages per SMTP Connection** to a number that's based on the average message size and average network throughput to Exchange Online. Proofpoint recommends an initial value of 199. Start at this value and reduce it if **ConnectionReset** errors are still logged.
2. Increase the number of queue runners that are configured in Proofpoint that's appropriate to maintain the same message throughput before and after you change the number of messages per connection.
3. Clear any Exchange Online host names or IP addresses in the HostStatus file. You can use the Proofpoint UI to do this.

### Disable the HostStat feature

Exchange Online uses only two or three unique public hosts or IP addresses for each tenant (that correspond to different datacenters). These hosts or IPs are then load-balanced to hundreds of computers. If Proofpoint experiences a few **ConnectionReset** errors or other deferrals from one host, it identifies that host as bad, and doesn't retry any queued messages to that host for a long time. This situation blocks other messages in the queue to that host. In a configuration in which all incoming mail is sent to Proofpoint and then to Exchange Online, blocking mail to one of the two or three public hosts or IPs can cause a large delay in the mail delivery.

You can check the following locations to determine whether Proofpoint has identified a host as bad:

- **Sendmail log:**
  
   In the Sendmail log, the following entry is logged to indicate that messages to that host are being deferred:
   
   **:xxxx to=\<info@domain.info\>, delay=00:00:00, xdelay=00:00:00, mailer=smtp, tls_verify=NONE, pri=121904, relay=[192.168.0.0], dsn=4.0.0, stat=Deferred** 

- **SMTP log:**

  - In the SMTP log, the **stat=Deferred** entry is logged instead of the **stat=Deferred: 400-series SMTP response code** entry that is usually returned by the downstream MTA or SMTP server.
  - The corresponding log lines from the SMTP log indicate that a specific message was retried only a long time after the configured message retry interval.

To make sure that every message is retried at every retry attempt, disable the HostStat feature in Proofpoint. The feature is enabled by default.

> [!NOTE]
> If you use the Proofpoint Email Protection Cloud Service, you must contact the Proofpoint Support to have this feature disabled.

### Reduce the message retry interval

Set the message retry interval to 1, 5, or 10 minutes, as appropriate for the configuration.

If your Proofpoint configuration sends all incoming mail only to Exchange Online, set the interval to 1 minute. This increases the frequency of retries without penalties or message throttling.

If your Proofpoint configuration sends email to multiple destinations, choose an interval value that works for all destinations.
