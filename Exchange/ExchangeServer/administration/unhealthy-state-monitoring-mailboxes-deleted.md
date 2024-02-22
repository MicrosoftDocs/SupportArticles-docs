---
title: Unhealthy state of Exchange servers when monitoring mailboxes are deleted
description: Get-ServerHealth shows health sets in an Unhealthy state because the monitoring mailboxes are deleted. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CI 115307
  - CSSTroubleshoot
ms.reviewer: chris.mcgurk, v-six
appliesto: 
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
search.appverid: 
  - MET150
ms.date: 01/24/2024
---

# Unhealthy state of Exchange servers when monitoring mailboxes are deleted

## Symptoms

In Microsoft Exchange Server 2019, 2016, or 2013, you deploy multiple servers that are named, for example, EXCH, EXCH-02, and so on. In this situation, you notice that the monitoring mailboxes and associated Active Directory accounts for EXCH-02 are deleted every hour, even after you re-create them. Additionally, Get-ServerHealth shows many health sets in an **Unhealthy** state because of the missing monitoring mailboxes.

## Cause

This issue occurs because the monitoring mailboxes are incorrectly deleted by the **MonitoringMailboxCleaner** process. This process runs every hour on every server that is running Exchange Server. It removes monitoring mailboxes that are no longer needed by that server. To build the list of mailboxes that are to be checked, the process examines the DisplayName value of the accounts by using a pattern match for the **HealthMailbox-SERVERNAME-** string. Then, it evaluates each item on the list to determine whether that item should be deleted.

In this scenario, when the process runs on server EXCH, the list includes all mailboxes that have a **DisplayName** that matches the **HealthMailbox-EXCH-** string. This includes the mailboxes for both EXCH and EXCH-02. The process sees the EXCH-02 mailboxes as invalid, and then deletes them.

This behavior can be observed in the Active Monitoring trace logs that are located in `<ExchangeInstallDir>\Logging\Monitoring\Monitoring\MSExchangeHMWorker\ActiveMonitoringTraceLogs`.

## Resolution

To fix this issue, use a different naming convention that does't include hyphens for the servers that are running Exchange Server.

If the servers have already been set up in this manner, you can prevent the issue from occurring by selecting the Protect object from accidental deletion option in Active Directory Users and Computers. To do this, follow these steps:

1. Open **Active Directory Users and Computers**.
2. Select **View**, and verify that **Advanced Features** is selected.
3. Expand the domain, expand **Microsoft Exchange System Objects**, and then select **Monitoring Mailboxes**.
4. Double-click the first **HealthMailbox\<GUID>** object.
5. Select the **Object** tab.
6. Select the **Protect object from accidental deletion** option, and then select **OK**.
7. Repeat steps 1–6 for each **HealthMailbox\<GUID>** object in the **Monitoring Mailboxes** container.
