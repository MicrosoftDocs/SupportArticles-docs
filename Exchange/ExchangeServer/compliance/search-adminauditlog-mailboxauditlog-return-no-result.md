---
title: Search-AdminAuditLog or Search-MailboxAuditLog with parameter returns empty results in Exchange Server
description: Fixes an issue that returns an empty result set when you run Search-AdminAuditLog or Search-MailboxAuditLog with parameters. This issue occurs if your account uses a non-English regional setting in an Exchange Server 2013 environment.
author: Norman-sun
ms.author: v-swei
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Server
- CSSTroubleshoot
ms.reviewer: excontent, dkhrebin, genli, christys
appliesto:
- Exchange Server 2013 Enterprise
- Exchange Server 2013 Standard Edition
- Exchange Server 2016 Standard Edition
- Exchange Server 2016 Enterprise Edition
search.appverid: MET150 
---
# Empty results are returned when you run Search-AdminAuditLog or Search-MailboxAuditLog with a parameter in Exchange Server

_Original KB number:_ &nbsp;3054391

## Symptoms

When you run the [Search-AdminAuditLog](/powershell/module/exchange/search-adminauditlog) or [Search-MailboxAuditLog](/powershell/module/exchange/search-mailboxauditlog) cmdlets in Exchange Management Shell together with a **Cmdlets** or **Parameters** parameter to filter the results, an empty or incomplete result set is returned. Even if you run the `Search-AdminAuditLog` cmdlet without parameters, the full results might not be returned as expected.

This issue occurs in Microsoft Exchange Server 2019, Exchange Server 2016 and Exchange Server 2013.

## Workaround

You might be able to work around this issue depending on the language settings on the server where the searched mailbox is located (active copy of database containing the mailbox you are running search for). On the server, open the [**Welcome screen and new user account settings**](./media/search-adminauditlog-mailboxauditlog-return-no-result/welcome-screen-user-accounts-settings.png) dialog box in the **Region** settings and check the **Format** setting for **Welcome screen**. If **Format** is not set to **English (United States)**, follow these steps to set the language and regional settings for the system and network service accounts:

1. Set English (United States) as the primary language.
    1. In Control Panel, open **Language**.
    1. Add the language of **English (United States)**.
    1. Click **Options** for the added language.
    1. Click **Download and install language pack** if it appears.
    1. Click **Make this the primary language**.
1. Copy the regional settings.
    1. In Control Panel, open **Region**.
    1. Select **English (United States)** as Format in the "Format:" drop down list.
    1. Click the **Administrative** tab.
    1. On the **Administrative** tab, click **Copy settings**.
    1. In the **Welcome screen and new user accounts settings** dialog box, click to select **Welcome screen and system accounts**, and then click **OK**.

        > [!NOTE]
        >
        > - The system accounts include the network service account.
        > - You can revert the **Format** for **Current user** to the original value as long as **Format** for **Welcome screen** is set to **English (United States)**.

        :::image type="content" source="./media/search-adminauditlog-mailboxauditlog-return-no-result/welcome-screen-user-accounts-settings.png" alt-text="Select the Welcome screen and system accounts option":::

> [!NOTE]
> The MSExchangeDelivery service may not start with Exchange Server. If the service doesn't start, follow these steps:
>
> 1. Change the logon account of the service to **Local System**.
> 1. Revert the logon account to **Network Service**.
> 1. Start the service.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.