---
title: Exchange Server doesn't display all OUs
description: Describes an Exchange Server issue that blocks the display of organizational units when a new mailbox and associated user account are created. A resolution is provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:OWA And Exchange Admin Center\Need help in configuring EAC
  - Exchange Server
  - CI 119623
  - CI 9823
  - CI 12201
  - CSSTroubleshoot
ms.reviewer: tmoore, gregmans, v-six, v-kccross
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
ms.date: 07/07/2026
---
# Exchange Server doesn't display all OUs when it creates a new mailbox

_Original KB number:_ &nbsp; 3038717

## Summary

This article describes an issue in which Exchange Server doesn't display all organizational units (OUs) when you create a new mailbox and associated user account. The issue occurs because the Exchange Control Panel (ECP) limits OU searches to 500 results by default. To resolve the issue, increase the `GetListDefaultResultSize` value in the ECP web.config file so that it exceeds the total number of OUs in the organization, and then restart the `MSExchangeECPAppPool` application pool.

## Symptoms

When you create a new mailbox together with a new user account in Exchange Server, the complete list of organizational units (OUs) isn't displayed as expected.

## Cause

Exchange Control Panel (ECP) can display no more than 500 OUs. When there are more than 500 OUs, a new window is generated, and this window is either blank or contains a message (There are more items to show in this view).

## Resolution

To resolve this issue, follow these steps:

1. Determine the number of OUs on the Exchange Server mailbox server. To do this, run the following command in a shell:

    ```powershell
    (Get-OrganizationalUnit -ResultSize unlimited).count
    ```

2. On the Exchange Server mailbox server, go to the following folder:

    `drive:\Program Files\Microsoft\Exchange Server\V15\ClientAccess\ecp`

3. Add the following lines in the web.config file just above `</appsettings>`:

    ```xml
    <!-- allows the OU picker when placing a new mailbox in its designated organizational unit to retrieve all OUs - default value is 500 -->
    <add key="GetListDefaultResultSize" value="500" />
    ```

    > [!NOTE]
    > The value of `GetListDefaultResultSize` key should exceed the number of OUs that you found in step 1. Additionally, you will have to add this value every time that you install a cumulative update.

4. In IIS Manager, restart the **MSExchangeECPAppPool** application pool.

  > [!CAUTION]
  > Any customized Exchange or Internet Information Server (IIS) settings that you made in Exchange XML application configuration files on the Exchange server (for example, web.config files or the EdgeTransport.exe.config file) **will be overwritten** when you install an Exchange Cumulative Update. For more information, see [Upgrade Exchange to the latest Cumulative Update](/exchange/plan-and-deploy/install-cumulative-updates).
