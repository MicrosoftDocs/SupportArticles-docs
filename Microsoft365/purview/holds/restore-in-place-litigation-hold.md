---
title: How to restore In-Place Hold and Litigation Hold settings in an Exchange hybrid deployment
description: Describes how to restore In-Place Hold and Litigation Hold settings in an Exchange hybrid deployment.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Litigation Hold
  - CSSTroubleshoot
ms.reviewer: jgagnon
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Lync Server 2013
search.appverid: MET150
ms.date: 05/05/2025
---
# How to restore In-Place Hold and Litigation Hold settings in an Exchange hybrid deployment

_Original KB number:_&nbsp;2934398

## Introduction

This article describes how to restore In-Place Hold and Litigation Hold settings in a Microsoft Exchange Server hybrid deployment.

## Procedure

### In an Exchange hybrid deployment with or without on-premises Microsoft Lync Server 2013

#### Restore In-Place Hold settings

To restore In-Place Hold settings, follow these steps:

1. On the Exchange server, open the Exchange Admin Center by using on-premises admin credentials.
1. If your organization is enabled for a hybrid deployment with Microsoft Exchange Online in Microsoft 365, click the **Enterprise**  tab in the navigation bar.

   :::image type="content" source="media/restore-in-place-litigation-hold/navigation-bar.png" alt-text="Screenshot of the navigation bar in the Exchange Admin Center.":::

1. Click **compliance management**, and then click **in-place eDiscovery & hold**.

   :::image type="content" source="media/restore-in-place-litigation-hold/e-discovery-hold.png" alt-text="Screenshot shows steps to click in-place eDiscovery & hold page in the Exchange Admin Center.":::

1. Select the In-Place Hold entry for which you want to restore In-Place Hold settings, and then double-click it, or click **Edit** (:::image type="icon" source="media/restore-in-place-litigation-hold/edit-icon.png" border="false":::), to open the properties page.

   :::image type="content" source="media/restore-in-place-litigation-hold/properties-page.png" alt-text="Screenshot of the properties page for an In-Place Hold entry." border="false":::

1. On the properties page, click **In-Place Hold**. The In-Place Hold settings for the user are displayed.

   :::image type="content" source="media/restore-in-place-litigation-hold/in-place-hold-settings.png" alt-text="Screenshot of the In-Place Hold settings for a user." border="false":::

1. Click to clear the **Place content matching the search query in selected mailboxes on hold** check box, and then click **Save**.
1. Reopen the same properties page, and then click **In-Place Hold**. Notice that the **Place content matching the search query in selected mailboxes on hold** check box is cleared.

   :::image type="content" source="media/restore-in-place-litigation-hold/settings-selected.png" alt-text="Screenshot of the Place content matching the search query in selected mailboxes on hold check box is cleared." border="false":::

1. Click to select the **Place content matching the search query in selected mailboxes on hold** check box. Additionally, if you were using a time-based In-Place Hold, select **Specify number of days to hold items relative to their received date**, enter the duration, and then click **Save**. Doing this restores any In-Place Hold settings that existed before the issue occurred.
1. Repeat steps 4 through 8 for any other In-Place Hold entries that you have.

#### Restore Litigation Hold settings

To restore Litigation Hold settings, follow these steps:

1. Open Exchange Management Shell, and then connect to your on-premises Exchange Server deployment.
1. To restore a user's Litigation Hold duration setting, run the following command:

    ```powershell
    Set-Mailbox <user> -LitigationHoldDuration <valueInDays>
    ```

   For example, to set NinaT's Litigation Hold duration to 90 days, run the following command:

    ```powershell
    Set-Mailbox NinaT -LitigationHoldDuration 90
    ```

1. Repeat step 2 for each user whose Litigation Hold duration setting you want to restore.

### In an Exchange Online deployment with on-premises Lync Server 2013 that is running the Microsoft Azure Active Directory Sync tool with hybrid enabled

To restore the Litigation Hold duration setting, follow these steps:

1. Connect to Exchange Online by using remote PowerShell. For more information, go to [Connect to Exchange Online Using Remote PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. To restore a user's Litigation Hold duration setting, run the following command:

    ```powershell
    Set-Mailbox <user> -LitigationHoldDuration <valueInDays>
    ```

    For example, to set NinaT's Litigation Hold duration to 90 days, run the following command:

    ```powershell
    Set-Mailbox NinaT -LitigationHoldDuration 90
    ```

3. Repeat step 2 for each user whose Litigation Hold duration setting you want to restore. After the next time that directory synchronization runs, the Lync 2013 server will detect the restored Litigation Hold duration settings.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
