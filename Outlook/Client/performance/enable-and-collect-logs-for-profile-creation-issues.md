---
title: Enable and collect logs for profile creation issues
description: Describes the different diagnostic information collecting options available in Outlook for issues with creating profiles.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Outlook
search.appverid: MET150
ms.date: 10/30/2023
---
# Enable and collect Outlook logs to troubleshoot profile creation issues

_Original KB number:_ &nbsp; 4495260

## Summary

This article describes the different diagnostic information collecting options available in Outlook if you have issues creating a new profile in Outlook.

## Configure and retrieve Outlook logs

Outlook logs are helpful in investigations into free busy issues, connectivity problems, and unexpected authentication prompts.

### Outlook 2016, Outlook 2013, and Outlook 2010

1. In Outlook, go to the **File** tab, then **Options**, and then **Advanced**.
2. Under **Other**, select or clear the check box **Enable troubleshooting logging** (this will require an Outlook restart).

   :::image type="content" source="media/enable-and-collect-logs-for-profile-creation-issues/enable-troubleshooting-logging.png" alt-text="Screenshot of the Advanced tab of Outlook Options.":::

3. Select **OK** and restart Outlook.

If you are troubleshooting a profile with the creation of a new profile, you can enable logging through the registry:

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

1. Select **Start**, type *regedit* in the **Start** search box, and then select regedit.exe in the Programs list.
2. In Registry Editor, locate the following subkey for Outlook:

    `HKEY_CURRENT_USER\Software\Microsoft\Office\<1x.0>\Outlook\Options\Mail`

    > [!NOTE]
    > In this subkey, <1x.0> represents the program version number (15.0 = Outlook 2013, 14.0 = Outlook 2010, 12.0 = Outlook 2007, 11.0 = Outlook 2003).

3. In the right side pane, right-click **EnableLogging**, and then select **Modify**.
4. In the **Edit DWORD Value** dialog box, type *1* under Value data, and then select **OK**.
5. Exit Registry Editor.

> [!NOTE]
> It is important to close Outlook after you have reproduced the behavior. Outlook stores diagnostic information in memory until the application is shut down.

The log files will be in the user's temp directory that can be found by typing *%temp%* in the **Run** box or File Explorer:

:::image type="content" source="media/enable-and-collect-logs-for-profile-creation-issues/search-logging-folder.png" alt-text="Screenshot of Run dialog box after you type %temp%.":::

In File Explorer, select on the Outlook Logging folder and sort by Date Modified:

:::image type="content" source="media/enable-and-collect-logs-for-profile-creation-issues/sort-by-date-modified.png" alt-text="Screenshot of File Explorer window when you select on the Outlook Logging folder.":::

In most cases, you will only have to collect the Outlook*.etl for analysis by Microsoft. To do this:

1. Exit Outlook so the data you captured is written to the file.
2. Copy the most recent Outlook*.etl file to your Desktop or other temporary folder. This file can be compressed into a .zip file if it's too large to easily share.
3. Restart Outlook and send it to Microsoft, or upload to the secure location if that was specified.

## Check Outlook connection status

The Outlook connection status may be used to investigate connectivity issues.

1. Locate the Outlook icon in the task bar. Hold down the Ctrl key and right-select the icon. Then, select **Connection Status**.

   :::image type="content" source="media/enable-and-collect-logs-for-profile-creation-issues/connection-status.png" alt-text="Screenshot of the Connection Status option on the right-click menu of the Outlook icon in the task bar.":::

2. Expand ALL columns, and then take screenshots of all the information.

    > [!NOTE]
    > You will have to scroll to the right side of the screen to capture all columns.

   :::image type="content" source="media/enable-and-collect-logs-for-profile-creation-issues/capture-all-columns.png" alt-text="Screenshot of the Outlook Connection Status window.":::

3. Provide the screen shots to the support agent as requested.

## Check Autodiscover status

The Autodiscover status may also be used to investigate connectivity issues.

1. Locate the Outlook icon in the task bar. Hold down the Ctrl key and right-select the icon. Select **Test Email AutoConfiguration**.

   :::image type="content" source="media/enable-and-collect-logs-for-profile-creation-issues/test-email-autoconfiguration.png" alt-text="Screenshot of the Test Email AutoConfiguration option on the right-click menu of the Outlook icon in the task bar.":::

2. Enter the email address of the user's mailbox, if that field isn't already auto-completed.

3. Clear the check boxes for **Use Guessmart** and **Secure Guessmart Authentication**, and then select **Test**. After the test is complete, the results will appear in three tabs: **Results**, **Log**, and **XML**.

4. Take screenshots of each tab. You may have to take multiple screenshots of each tab by scrolling down to access all the data.

   :::image type="content" source="media/enable-and-collect-logs-for-profile-creation-issues/take-screenshots-of-each-tab.png" alt-text="Screenshot of Test Email AutoConfiguration window.":::

5. Provide the screenshots to the support agent as requested.
