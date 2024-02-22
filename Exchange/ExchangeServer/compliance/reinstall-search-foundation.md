---
title: Reinstall Search Foundation in Exchange Server
description: Describes the steps to reinstall Search Foundation in Exchange Server when troubleshooting issues that affect Exchange Search.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom:
  - CI 161581
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: dpaul, batre, meerak
appliesto:
  - Exchange Server 2019
  - Exchange Server 2016 
search.appverid: MET150
ms.date: 01/24/2024
---
# Reinstall Search Foundation in Exchange Server

If you're troubleshooting issues that affect Microsoft Exchange Search, a Microsoft Support agent might advise you to reinstall Search Foundation in Exchange Server.

To complete the installation correctly, follow these steps:

1. Stop the following services:

   1. Microsoft Exchange Search

   1. Microsoft Exchange Search Host Controller

1. Remove the four folders that are in the following path:

   *C:\Program Files\Microsoft\Exchange Server\V15\Bin\Search\Ceres\HostController\Data\Nodes\Fsis*

1. Select **Start** > **Windows PowerShell**. Then, right-click **Windows PowerShell**, and select **Run as administrator**.

1. Navigate to *C:\Program Files\Microsoft\Exchange Server\V15\Bin\Search\Ceres\Installer*.

1. Run the following cmdlet:

   `.\installconfig.ps1 -action I -datafolder "c:\Program Files\Microsoft\Exchange Server\V15\Bin\Search\Ceres\HostController\Data"`

1. If the ContentSubmitters group isn't present in your organization, remove the entry for the *WcfConfigurator.xml* file from all locations:

   1. Make sure that the Microsoft Exchange Search and Microsoft Exchange Search Host Controller services are stopped.

   1. Remove the **\<AuthorizedRole>ContentSubmitters\</AuthorizedRole>** entry in the *WcfConvigurator.xml* file from the following four configuration locations:

      - *C:\Program Files\Microsoft\Exchange Server\V15\Bin\Search\Ceres\HostController\Data\Nodes\Fsis\AdminNode1\Configuration\Local*

      - *C:\Program Files\Microsoft\Exchange Server\V15\Bin\Search\Ceres\HostController\Data\Nodes\Fsis\ContentEngineNode1\Configuration\Local*

      - *C:\Program Files\Microsoft\Exchange Server\V15\Bin\Search\Ceres\HostController\Data Nodes\Fsis\IndexNode1\Configuration\Local*

      - *C:\Program Files\Microsoft\Exchange Server\V15\Bin\Search\Ceres\HostController\Data Nodes\Fsis\InteractionEngineNode1\Configuration\Local*

If you're troubleshooting issues that affect item indexing in Microsoft Exchange Server 2016, you have to re-index the databases after you reinstall Search Foundation. To avoid performance issues, we recommend that you re-index only two databases at a time.
