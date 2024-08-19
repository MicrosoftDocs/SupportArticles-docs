---
title: MRSProxyConfiguration settings aren't honored when they're configured
description: Describes a situation in which the settings in the MRSProxyConfiguration section of the MSExchangeMailboxReplication.exe.config file aren't honored in Exchange Server 2013.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration\Issues with Move Mailbox within same organization
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: bradhugh, v-six
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# MRSProxyConfiguration settings aren't honored when they're configured

_Original KB number:_ &nbsp;3002970

## Symptoms

Settings in the **MRSProxyConfiguration** section of the MSExchangeMailboxReplication.exe.config file aren't honored in Microsoft Exchange Server 2013. Instead, default settings for **MaxMRSConnections** and **DataImportTimeout** are used.

## Cause

Before Cumulative Update 7 (CU7), the MRS Proxy configuration section that's inserted by Exchange Server is incorrect. These incorrect values prevent the settings from being read by the Mailbox Replication Service, so the default settings are used instead. As a result, any pre-CU7 version of Exchange Server 2013 will meet this issue.

## Resolution

An upgrade to or clean install of CU7 will provide the correct template for the settings, and modifications will be honored. Otherwise, you can make these modifications manually by using the following procedure:

> [!NOTE]
> All of these configuration changes are case-sensitive, so please note the casing of each item.

1. Open the MsExchangeMailboxReplication.exe.config file in notepad or another text editor.
1. Near the beginning of the file, locate the section element underneath the configSections element named **MrsProxyConfiguration**.
1. Change the name of this section from **MrsProxyConfiguration** to **MRSProxyConfiguration**.
1. Change the type of this section from the value **Microsoft.Exchange.MailboxReplicationService.MRSProxyConfiguration, Microsoft.Exchange.MailboxReplication.ProxyService, Version=15.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35** to the value **Microsoft.Exchange.MailboxReplicationService.MRSProxyConfiguration, Microsoft.Exchange.MailboxReplicationService.ProxyService, Version=15.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35**.
1. Near the end of the file, locate the element called **MrsProxyConfiguration**.
1. Change the name of the element from **MrsProxyConfiguration** to **MRSProxyConfiguration**.

After you make these changes, any values configured in the **MRSProxyConfiguration** section will be read and honored by the Mailbox Replication Service.

> [!NOTE]
> These changes will take effect after the next restart of the Mailbox Replication Service.
