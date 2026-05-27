---
title: Unhealthy state of Exchange servers when monitoring mailboxes are deleted
description: Learn how to resolve Exchange Server unhealthy state errors caused by monitoring mailbox deletions and prevent future issues.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Performance Issues
  - Exchange Server
  - CI 115307
  - CI 9823
  - CI 11507
  - CSSTroubleshoot
ms.reviewer: chris.mcgurk, v-six, v-kccross
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: 
  - MET150
ms.date: 05/27/2026
---

# Unhealthy state of Exchange servers when monitoring mailboxes are deleted

## Summary

Use this article to troubleshoot Exchange Server health sets that appear unhealthy after monitoring mailboxes are repeatedly deleted. This issue can occur when server names share a common prefix (for example, EXCH and EXCH-02), which can cause the MonitoringMailboxCleaner process to remove valid monitoring mailboxes. This article explains why the issue occurs, how to verify it in logs, and how to prevent recurrence by using safer server naming or protecting monitoring mailbox objects in Active Directory.

## Symptoms

In Microsoft Exchange Server 2019, 2016, you deploy multiple servers that are named, for example, EXCH, EXCH-02, and so on. In this situation, you notice that the monitoring mailboxes and associated Active Directory accounts for EXCH-02 are deleted every hour, even after you re-create them. Additionally, `Get-ServerHealth` shows several health sets in an **Unhealthy** state because of the missing monitoring mailboxes.

## Cause

This issue occurs because the **MonitoringMailboxCleaner** process incorrectly deletes the monitoring mailboxes. This process runs every hour on every computer that runs Exchange Server. The process removes monitoring mailboxes that the server doesn't use. To build the list of mailboxes to check, the process examines the `DisplayName` value of the accounts by using a pattern match for the **HealthMailbox-SERVERNAME-** string. Then, the process evaluates each item on the list to determine whether that item should be deleted.

In this scenario, when the process runs on server EXCH, the list includes all mailboxes that have a **DisplayName** that matches the **HealthMailbox-EXCH-** string. This match includes the mailboxes for both EXCH and EXCH-02. The process sees the EXCH-02 mailboxes as invalid, and then deletes them.

You can observe this behavior in the Active Monitoring trace logs that are located in `<ExchangeInstallDir>\Logging\Monitoring\Monitoring\MSExchangeHMWorker\ActiveMonitoringTraceLogs`.

## Resolution

To fix this issue, use a different naming convention that doesn't include hyphens for the servers that run Exchange Server.

If you already set up the servers with this naming convention, prevent the problem by selecting the **Protect object from accidental deletion** option in **Active Directory Users and Computers** as shown in the following steps:

1. Open **Active Directory Users and Computers**.
1. Select **View**, and verify that **Advanced Features** is selected.
1. Expand the domain, expand **Microsoft Exchange System Objects**, and then select **Monitoring Mailboxes**.
1. Double-click the first **HealthMailbox\<GUID>** object.
1. Select the **Object** tab.
1. Select the **Protect object from accidental deletion** option, and then select **OK**.
1. Repeat these steps for each **HealthMailbox\<GUID>** object in the **Monitoring Mailboxes** container.
