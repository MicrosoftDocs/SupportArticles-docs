---
title: The time limit for logging on was reached error in Outlook
description: Describes an issue in which Outlook 2016 displays a (The time limit for logging on was reached while waiting for system resources) error message. Provides several workarounds.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Product Stability, startup or Shutdown and perform\Add-in error
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae, shabbirh, sfellman, gbratton, almah
appliesto: 
  - Outlook 2016
  - Outlook for Microsoft 365
  - Outlook 2019
search.appverid: MET150
ms.date: 01/30/2024
---
# Error when starting Outlook 2016: The time limit for logging on was reached while waiting for system resources

_Original KB number:_ &nbsp;3181206

## Symptoms

When you start Microsoft Outlook 2016, you receive the following error message:

> The time limit for logging on was reached while waiting for system resources. Try again. MAPI 1.0 [000004C2]

When you click **OK** in the error message window, Outlook 2016 crashes.

This problem has been observed in some cases when the Salesforce for Outlook add-in is installed.

> [!NOTE]
> The presence of the Salesforce add-in doesn't necessarily mean that you will experience these symptoms. There may be other causes of these symptoms. The purpose of this article is to help you identify possible causes of this problem when you're running Outlook.

## Cause

This problem occurs in the following programs:

- Office 2016 version 16.0.6925.1018 or a later version for Click-to-Run based installations
- Outlook version 16.0.4351.1000 for MSI-based installations

To determine whether your Office 2016 installation is Click-to-Run or MSI-based, see the ["More information"](#more-information) section.

## Workaround 1: Update the Salesforce for Outlook add-in

Install the latest update for the Salesforce for Outlook add-in. At the time that this article was first published, the latest version was 3.1.1. For more assistance, contact [Salesforce](https://www.salesforce.com/).

## Workaround 2: Reinstall the Salesforce for Outlook add-in

Uninstall the Salesforce for Outlook add-in, update Outlook, and then install the latest version of the Salesforce for Outlook add-in. To do this, follow these steps:

1. Uninstall the Salesforce for Outlook add-in. To do this, follow the steps provided in [this article](https://help.salesforce.com/articleView?id=outlookcrm_uninstall.htm&type=5) on the Salesforce website.

1. Install the latest update for Outlook 2016. To do this, follow the steps for your installation type.

### Click-to-Run installations

1. Open Outlook 2016.
1. On the **File** menu, select **Office Account**.
1. Click **Update Options**, and then click **Update Now**.

    > [!NOTE]
    > If you have previously disabled updates, click **Enable updates** after you click **Update Options**, and then click **Update Now**.

### MSI-based installations

To determine the latest update for Outlook, see [Outlook Updates](https://support.office.com/article/outlook-updates-472c2322-23a4-4014-8f02-bbc09ad62213).

1. Install the Salesforce for Outlook add-in. To do this, follow the steps provided in [this article](https://help.salesforce.com/articleView?id=outlookcrm_uninstall.htm&type=5) on the Salesforce website.

    At the time that this article was first published, the latest version was 3.1.1. For more assistance, contact [Salesforce](https://www.salesforce.com/).

## Workaround 3: Disable or uninstall the Salesforce for Outlook add-in

Disable the Salesforce for Outlook add-in, and then test for the problem. To do this, follow these steps.

1. Press the Windows logo key+R.
1. Type the following command in the **Open** box, and then press Enter:

    ```console
    Outlook /safe  
    ```

1. Click **File**, and then click **Options**.
1. Click **Add-ins**, and then click the **Go** button next to **Manage COM Add-ins**.
1. Clear the check mark next to Salesforce for Outlook add-in, and then click **OK**.
1. Exit and restart Outlook.

If the problem persists, uninstall the Salesforce for Outlook add-in.

To uninstall the Salesforce for Outlook add-in, follow the steps provided in [this article](https://help.salesforce.com/articleView?id=outlookcrm_uninstall.htm&type=5)  on the Salesforce website.

For more assistance, contact [Salesforce](https://www.salesforce.com/).

## More information

To determine whether your Office 2016 installation is Click-to-Run or MSI-based, follow these steps:

1. Start Outlook 2016.
1. On the File menu, click Office Account.
1. For Office 2016 Click-to-Run installations, an Update Options item is displayed. For MSI-based installations, the Update Options item isn't displayed.

|Click-to-Run Office 2016 installation|MSI-based Office 2016 installation|
|---|---|
|:::image type="content" source="./media/time-limit-logging-reached-error-outlook-2016/click-to-run-version.png" alt-text="Screenshot of the Office Account page of Click-to-Run Office 2016 installations." border="false":::|:::image type="content" source="./media/time-limit-logging-reached-error-outlook-2016/msi-version.png" alt-text="Screenshot of the Office Account page of MSI-based Office 2016 installations." border="false":::|

## Status

Microsoft is researching this problem and will post more information in this article when the information becomes available.  

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]
