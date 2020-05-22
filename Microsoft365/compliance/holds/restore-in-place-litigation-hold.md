---
title: How to restore In-Place Hold and Litigation Hold settings in an Exchange hybrid deployment
description: Describes how to restore In-Place Hold and Litigation Hold settings in an Exchange hybrid deployment.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: Office 365
localization_priority: Normal
ms.custom: 
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
---
# How to restore In-Place Hold and Litigation Hold settings in an Exchange hybrid deployment

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

_Original KB number:_&nbsp;2934398

## Introduction

This article describes how to restore In-Place Hold and Litigation Hold settings in a Microsoft Exchange Server hybrid deployment.

## Procedure

### In an Exchange hybrid deployment with or without on-premises Microsoft Lync Server 2013

#### Restore In-Place Hold settings

To restore In-Place Hold settings, follow these steps:

1. On the Exchange server, open the Exchange Admin Center by using on-premises admin credentials.
1. If your organization is enabled for a hybrid deployment with Microsoft Exchange Online in Office 365, click the **Enterprise**  tab in the navigation bar.

   ![Screenshot of the navigation bar in the Exchange Admin Center](./media/restore-in-place-litigation-hold/navigation.jpg)

1. Click **compliance management**, and then click **in-place eDiscovery & hold**.

   ![Screenshot of the in-place eDiscovery & hold page in the Exchange Admin Center](./media/restore-in-place-litigation-hold/ediscovery.jpg)

1. Select the In-Place Hold entry for which you want to restore In-Place Hold settings, and then double-click it, or click **Edit** (![Edit](./media/restore-in-place-litigation-hold/edit.jpg)), to open the properties page.

   ![Screenshot of the properties page for an In-Place Hold entry](./media/restore-in-place-litigation-hold/properties.jpg)

1. On the properties page, click **In-Place Hold**. The In-Place Hold settings for the user are displayed.

   ![Screenshot of the In-Place Hold settings for a user](./media/restore-in-place-litigation-hold/settings.jpg)

1. Click to clear the **Place content matching the search query in selected mailboxes on hold** check box, and then click **Save**.
1. Reopen the same properties page, and then click **In-Place Hold**. Notice that the **Place content matching the search query in selected mailboxes on hold** check box is cleared.

   ![Screen shot of the In-Place hold settings for a user](./media/restore-in-place-litigation-hold/settings-selected.jpg)

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

1. Connect to Exchange Online by using remote PowerShell. For more information, go to [Connect to Exchange Online Using Remote PowerShell](https://technet.microsoft.com/library/jj984289%28v=exchg.160%29.aspx).
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

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](https://social.technet.microsoft.com/forums/exchange/home?category=exchange2010%2cexchangeserver).
