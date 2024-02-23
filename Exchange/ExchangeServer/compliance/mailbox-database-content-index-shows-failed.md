---
title: Update 2874216 breaks the content index in Exchange Server 2013
description: Security update MS13-061 causes issues in Exchange Server 2013. You can make changes in the registry to work around these issues.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: batre, nasira, v-six
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Update 2874216 breaks the content index in Exchange Server 2013

_Original KB number:_ &nbsp;2879739

## Symptoms

After you install update 2874216, you experience the following issues in Microsoft Exchange Server 2013:

> [!NOTE]
> Update 2874216 is described in [security update MS13-061](https://support.microsoft.com/help/2876063).
>
> You don't experience these symptoms after you install the Exchange 2007 or Exchange 2010 versions of the MS13-061 security update.

- The content index (CI) for mailbox databases shows "Failed" on the affected server.
- The Microsoft Exchange Search Host Controller service is missing.
- You see a new service that's named "Host Controller service for Exchange."

## Workaround

To work around this problem, update the following registry entries.

- **`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Search Foundation for Exchange`**

    Set the value of the DataDirectory registry entry to the Data directory path for the Exchange Server installation.

    For example, if the Exchange Server installation directory is *C:\Program Files\Microsoft\Exchange Server\V15*, you would set the value of the DataDirectory registry entry to the following path:

    *C:\Program Files\Microsoft\Exchange Server\V15\Bin\Search\Ceres\HostController\Data*

    :::image type="content" source="media/mailbox-database-content-index-shows-failed/datadirectory-registry-entry.png" alt-text="Screenshot of setting the Exchange Data Directory registry entry.":::

- **`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HostControllerService`**

    1. Set the value of the DisplayName registry entry to "Microsoft Exchange Search Host Controller."
    1. Add a new multi-string value that's named DependOnService, and then set its value to http.
    1. Restart the Microsoft Exchange Search Host Controller service.

    > [!NOTE]
    > The change to the service display name will take effect after you restart the server.
