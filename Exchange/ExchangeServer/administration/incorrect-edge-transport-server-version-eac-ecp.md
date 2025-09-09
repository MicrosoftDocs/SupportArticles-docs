---
title: Edge Transport server version isn't updated
description: Discusses an issue in which the Exchange Server version for an Edge Server isn't updated in the Exchange Control Panel after upgrade.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: v-six, jarrettr, aartigoyle, btalb, v-six
ms.custom: 
  - sap:Mail Flow\Need help configuring Transport High Availability
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2019
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2010 Standard
  - Exchange Server 2010 Enterprise
ms.date: 01/24/2024
---
# The Exchange Edge Transport server version is incorrect in EAC or ECP after an upgrade

_Original KB number:_ &nbsp; 4019802

## Symptoms

After you upgrade an Edge Transport server to a new version, you notice the following situations:

- In Exchange Admin Center (EAC) or Exchange Control Panel (ECP), the version information for the Edge Transport server isn't updated as expected, as shown in the following screenshot.

    :::image type="content" source="media/incorrect-edge-transport-server-version-eac-ecp/incorrect-version-eac.png" alt-text="Screenshot of wrong Edge Transport server version in E A C.":::

- On another server that is running Exchange Server and that isn't an Edge Transport server, you run the [Get-ExchangeServer](/powershell/module/exchange/get-exchangeserver) cmdlet in Exchange Management Shell by using the following command:

    ```powershell
    Get-ExchangeServer edge | FL Name, AdminDisplayVersion
    ```

    After you run the command, you notice that the **AdminDisplayVersion** output is incorrect.

## Cause

This issue occurs because the Edge Subscription XML file that contains the version information isn't updated when you upgrade the Edge Transport server.

## Resolution

To resolve this issue, resubscribe the Edge Transport server. To do this, follow these steps:

1. On the Edge Transport server, run the [New-EdgeSubscription](/powershell/module/exchange/new-edgesubscription) cmdlet in Exchange Management Shell to create and export the Edge Subscription file, as follows:

    ```powershell
    New-EdgeSubscription -FileName "c:\EdgeServerSubscription.xml"
    ```

1. On the Mailbox server, import the file that is generated in step 1, and then complete the resubscription process. To do this, run the following commands in Exchange Management Shell:

    ```powershell
    [byte[]]$Temp = Get-Content -Path "C:\EdgeServerSubscription.xml" -Encoding Byte -ReadCount 0
    New-EdgeSubscription -FileData $Temp -Site "Default-First-Site-Name"
    ```

> [!NOTE]
>
> - You have to resubscribe the Edge Transport server to the same Active Directory site that it was originally subscribed to.
> - You don't have to remove the original Edge Subscription. This is because the resubscription process overwrites the existing Edge Subscription.

## References

- [Edge Subscription](/Exchange/architecture/edge-transport-servers/edge-subscriptions)

- [Manage Edge Subscriptions](/exchange/manage-edge-subscriptions-exchange-2013-help)
