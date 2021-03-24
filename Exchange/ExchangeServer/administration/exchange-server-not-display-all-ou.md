---
title: Exchange Server doesn't display all OUs
description: Describes an Exchange Server issue that blocks the display of organizational units when a new mailbox and associated user account are created. A resolution is provided.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting 
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Server
- CI 119623
- CSSTroubleshoot
ms.reviewer: tmoore, gregmans
search.appverid: 
- MET150
appliesto:
- Exchange Server 2016 Enterprise Edition
- Exchange Server 2016 Standard Edition
- Exchange Server 2013 Enterprise
- Exchange Server 2013 Standard Edition  
---
# Exchange Server doesn't display all OUs when it creates a new mailbox

_Original KB number:_ &nbsp; 3038717

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
