---
title: Error using Remote Connectivity Analyzer to troubleshoot Exchange ActiveSync
description: Describes an issue in which you receive an error message when you try to use the Remote Connectivity Analyzer tool to troubleshoot Exchange ActiveSync in Microsoft 365. Provides a resolution.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.custom: 
  - sap:Clients and Mobile\Can't Connect to Mailbox with Active Sync Device
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 01/24/2024
ms.reviewer: v-six
---

# "Active Sync URL was in an Invalid format" when using Remote Connectivity Analyzer tool

> [!NOTE]
> This scenario applies only to Microsoft 365 customers who have a hybrid deployment of Exchange Online and on-premises Exchange Server.

## PROBLEM

When you try to use the Microsoft Remote Connectivity Analyzer tool to troubleshoot Microsoft Exchange ActiveSync (EAS) in your organization, you receive the following error message:

**ActiveSync URL was in an Invalid format. It should be https://host/Microsoft-Server-ActiveSync. The URL was *Your URL*.**

> [!NOTE]
> When you run the test, an HTTP request is sent to the MobileSync Autodiscover provider on the Client Access server. This request is made to obtain an external URL for ActiveSync devices to use when ActiveSync devices connect to the Exchange server.

## CAUSE

This issue occurs if the external URL isn't in the following format:

https://*hostname*/Microsoft-Server-ActiveSyncNote

> [!NOTE]
> In this URL, the *hostname* placeholder represents the fully qualified domain name (FQDN) of the external Domain Name System (DNS) that ActiveSync devices use to connect to EAS.

## SOLUTION

To fix this issue, check the setting of the ExternalURL property for the Microsoft-Server-ActiveSync virtual directory on the on-premises Exchange server. To do this, follow these steps:

1. Open Exchange Management Console (EMC) on the on-premises Exchange server.
2. Expand **Server Configuration**, select **Client Access**, select the appropriate Client Access server, and then click the **Exchange Active Sync** tab.
3. Select the Microsoft-Server-ActiveSync virtual directory, and then click **Properties**.
4. Make sure that the **ExternalURL** property uses the following format:

   https://*hostname*//Microsoft-Server-ActiveSync

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
