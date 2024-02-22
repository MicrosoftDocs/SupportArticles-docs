---
title: Mailbox quota information isn't displayed on the Status bar in Outlook
description: Resolves an issue in which mailbox quota information isn't displayed on the status bar in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CI 119623
  - CI 171268
  - CSSTroubleshoot
ms.reviewer: batre, meerak, v-trisshores
search.appverid: 
  - MET150
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
ms.date: 10/30/2023
---

# Mailbox quota information isn't displayed on the Status bar in Outlook

## Symptoms

Your mailbox is located on a server that's running Microsoft Exchange Server. You right-click the Microsoft Outlook status bar, and then you select **Quota Information** in the **Customize Status Bar** menu. However, the **Quota Information** status in the menu remains **Off** and the status bar doesn't display any mailbox quota information, as shown in the following screenshot.

:::image type="content" source="./media/mailbox-quota-information-not-displayed/customize-status-bar.png" alt-text="Screenshot of the Quota Information menu item in the Customize Status Bar menu." border="true":::

## Cause

The mailbox quota settings in Exchange Server aren't configured correctly.

## Resolution

To resolve this issue, use either of the following methods.

> [!NOTE]
> To use the following methods, you must have administrator permissions.

### Method 1: Use the Exchange admin center

Use the following table to determine the relevant quotas in Exchange Server based on the [Cached Exchange mode](/outlook/troubleshoot/installation/cached-exchange-mode#comparison-of-cached-exchange-mode-and-online-mode) setting in the Outlook profile.

| Cached Exchange mode | Relevant quotas |
|---|:---|
| Enabled | <ul><li>Issue warning at</li><li>Prohibit send at</li><li>Prohibit send and receive at</li></ul> |
| Disabled | <ul><li>Prohibit send and receive at</li></ul> |

In order for the status bar to display mailbox quota information, the relevant quotas that are listed in the table must resolve to numeric values. Follow these steps:

1. Check and update the mailbox quotas:

    1. In the Exchange admin center (EAC), select **recipients** \> **mailboxes**, double-click the user mailbox, and then select the **mailbox usage** tab.

    2. On the **mailbox usage** tab, select **More options**.

    3. Check whether the relevant quotas resolve to numeric values:

       - If the **Customize the quota settings for this mailbox** option is selected, make sure that the relevant quota values are numeric and not set to `unlimited`, and then go to step 3.

       - If the **Use the default quota settings from the mailbox database** option is selected, go to the next step.

2. Check and update the default mailbox quotas that are set on the mailbox database:

    1. Select **servers** \> **databases**, double-click the database that contains the user mailbox, and then select the **limits** tab.

    2. On the **limits** tab, make sure that the relevant quota values are numeric and not set to `unlimited`.

3. Remount the mailbox database:

    1. Select **servers** \> **databases**.

    2. Select the More actions (…) menu, and then select **Dismount**.

    3. Select the More actions menu, and then select **Mount**.

### Method 2: Use the Exchange Management Shell

Use the following table to determine the relevant quota parameters in Exchange Server based on the [Cached Exchange mode](/outlook/troubleshoot/installation/cached-exchange-mode#comparison-of-cached-exchange-mode-and-online-mode) setting in the Outlook profile.

| Cached Exchange mode | Relevant quota parameters |
|---|:---|
| Enabled | <ul><li>IssueWarningQuota</li><li>ProhibitSendQuota</li><li>ProhibitSendReceiveQuota</li></ul> |
| Disabled | <ul><li>ProhibitSendReceiveQuota</li></ul> |

In order for the status bar to display mailbox quota information, the relevant quota parameters that are listed in the table must resolve to numeric values. Follow these steps:

1. Check and update the mailbox quotas:

   1. Run the following command to get the quota parameter values:

      ```PowerShell
      Get-Mailbox -Identity <mailbox ID> | FL *Quota*
      ```

   1. Check whether the relevant quotas resolve to numeric values:

      - If the **UseDatabaseQuotaDefaults** property value is `False`, make sure that the relevant quota values are numeric and not set to `unlimited`, and then go to step 3.

      - If the **UseDatabaseQuotaDefaults** property value is `True`, go to the next step.

2. Check and update the default mailbox quotas that are set on the mailbox database:

   1. Run the following command to get the quota parameter values:

      ```PowerShell
      Get-MailboxDatabase -Identity (Get-Mailbox <mailbox ID> | Select -Expand Database).Name | FL *Quota*
      ```

   1. Make sure that the relevant quota values are numeric and not set to `unlimited`.

3. Use one of the following options to remount the mailbox database:

   - Run the following commands:

     ```PowerShell
     Dismount-Database -Identity (Get-Mailbox <mailbox ID> | Select -Expand Database).Name
     Mount-Database -Identity (Get-Mailbox <mailbox ID> | Select -Expand Database).Name
     ```

     Note: The Status bar can take from 3 to 24 hours to update.

   - Switch the active mailbox database to another server (DAG required). Run the following command:

     ```PowerShell
     Move-ActiveMailboxDatabase <mailbox database name> -ActivateOnServer <other server name>
     ```

## More information

- The following screenshot shows mailbox quota information in the Outlook status bar. When you hover your mouse cursor over the quota information, more quota information appears in a tooltip.

  :::image type="content" source="./media/mailbox-quota-information-not-displayed/quota-information-display-on-status-bar.png" alt-text="Screenshot of the Status bar with quota information." border="true":::

- For more information about how to set mailbox quotas, see [Configure storage quotas for a mailbox in Exchange Server](/exchange/recipients/user-mailboxes/storage-quotas).

- For more information about how to set mailbox database quotas, see [Manage mailbox databases in Exchange Server](/exchange/architecture/mailbox-servers/manage-databases).
