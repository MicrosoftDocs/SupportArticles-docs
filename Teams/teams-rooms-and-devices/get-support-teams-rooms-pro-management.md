---
title: Get support for Microsoft Teams Rooms Pro Management
description: Discusses how to create a support request and collect required information for Microsoft Support to resolve issues in the Teams Rooms Pro Management portal.
ms.reviewer: aageorge
ms.topic: troubleshooting
ms.date: 12/14/2023
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: Admin
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:MTR Pro
  - CI167668
  - CI185120
---
# Get support for Microsoft Teams Rooms Pro Management

When you experience issues in the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/), you can contact Microsoft Support for assistance. This article describes how to create a support request and collect the required information and logs.

## Collect required information

To reduce the time that's needed to gather information when you open a support request for Microsoft or a Microsoft OEM partner, we recommend that you collect the following information.

> [!NOTE]
> This might not be a complete list of the information that will be requested. However, it includes the most common items.

- Specify whether the issue affects a Teams Rooms device (Teams Rooms on Windows or Teams Rooms on Android), or the Teams Rooms Pro Management portal.
- Information required for all issues:
  - Steps to reproduce the issue. If it's a Teams Rooms issue, include a video, if possible.
  - The time, date, and time zone of the most recent occurrence of the issue.
  - If the issue recurs, the recurrence rate.
  - Error messages that are generated when the issue occurs. If possible, include the message text or screenshots of any message windows that are related to the issue.
  - If available, the Teams Rooms Pro Management support case number.
- Additional information for Teams Rooms issues:
  - Steps already tried from the referenced troubleshooting guide.
  - Logs that have been collected. You can collect logs in the Teams Rooms Pro Management portal or [locally by using PowerShell](/MicrosoftTeams/rooms/rooms-operations#collecting-logs-on-microsoft-teams-rooms).
  - Active signals in Teams Rooms Pro Management portal.
  - Whether the issue affects all devices, some devices, or only a single device.
  - The following system information that can be found on the **Settings** tab in the Teams Rooms Pro Management portal:
    - Windows version
    - The Teams Rooms app version
    - Device model and manufacturer
    - Attached peripherals
    - Number of displays
  - Room account information:
    - Account UPN
    - Room name
- Additional information for calling or meeting issues:
  - Meeting link for the affected meeting
  - PSTN number, if the issue involves a PSTN call.
  - Caller and callee UPN, if the issue involves a One-to-One call.

## Collect logs

### Collect logs in the Teams Rooms Pro Management portal

#### Windows-based Teams Rooms devices

1. Go to the room pane of the room that you want to collect logs for, and select the **Actions** tab.

   :::image type="content" source="./media/get-support-teams-rooms-pro-management/select-actions-tab.png" alt-text="Screenshot of the room pane that shows the Actions tab.":::
1. Select the **Log Collection** action, and select **Run**.

   :::image type="content" source="./media/get-support-teams-rooms-pro-management/select-log-collection-action.png" alt-text="Screenshot of the room pane that shows the Log collection action.":::
1. Select all relevant logs you want to collect, enter the reason for collecting the logs, and then select **Run**.

   :::image type="content" source="./media/get-support-teams-rooms-pro-management/select-logs-to-collect.png" alt-text="Screenshot of the window that shows the log selection box.":::

   **Note:** This operation may take several minutes. To monitor progress, select the **Activity** tab.
1. After the operation is completed, you can find the log file on the **Activity** tab.

   :::image type="content" source="./media/get-support-teams-rooms-pro-management/log-collection-completed.png" alt-text="Screenshot of the window that shows that the log collection action is completed.":::
1. Select the download icon to download the *LogCollection\*.zip* file.

#### Other Teams Rooms devices

1. Go to the room pane of the room that you want to collect logs for, and select **Collect logs**.

    :::image type="content" source="./media/get-support-teams-rooms-pro-management/room-pane.png" alt-text="Screenshot of the room pane that shows the Collect logs button.":::

1. In the **Collect logs** window, select **Run**.

    :::image type="content" source="./media/get-support-teams-rooms-pro-management/collect-logs-prompt.png" alt-text="Screenshot of the Collect logs window that shows the prompt to start log collection.":::

1. Select **Ok**. It can take five to ten minutes to upload the logs, depending on the room's local internet bandwidth.

    :::image type="content" source="./media/get-support-teams-rooms-pro-management/collect-logs-confirmation.png" alt-text="Screenshot of the Collect logs window that shows that the request was sent successfully to the device.":::

1. After the upload finishes, you can find the file on the **Activity** tab. If necessary, select **Refresh** to check the status.

    :::image type="content" source="./media/get-support-teams-rooms-pro-management/collected-log-files.png" alt-text="Screenshot that shows the collected log files.":::

1. Select the download icon to download the logs.

### Collect logs on the Teams Rooms device

1. Sign in to the device by using the **Admin** account.
1. Run the following command in an elevated Command Prompt window:

   ```console
   powershell -ExecutionPolicy unrestricted c:\rigel\x64\scripts\provisioning\ScriptLaunch.ps1 CollectSrsV2Logs.ps1
   ```

   **Note:** The logs are saved as a .zip file under _c:\rigel_.

## Create a support request

> [!NOTE]
> You can also get support directly from the OEM for OEM peripheral or device issues. Usually, the following signals are related to OEM peripheral or device issues:
>
> - Camera
> - Display
> - Microphone
> - Speaker

To create a support request, follow these steps:

1. Go to the [Microsoft 365 admin center](https://go.microsoft.com/fwlink/p/?linkid=2166757). At the bottom-right side of the page, select **Help & support**. Or, go to the [Microsoft Teams admin center](https://go.microsoft.com/fwlink/?linkid=867439). At the bottom-right side of the page, select **Need help**.
1. In the **Tell us your problem** text box, enter *Teams Rooms Portal*, and then press **Enter**.
1. Review the suggested topics. If the results aren't helpful, select **Contact support**.
1. In the **Contact support** pane, specify the following information:

   - **Title**: Enter "_MTR Pro –_" followed by the signal that's reported in the Teams Rooms Pro Management portal, such as Meeting app. Or, enter "_MTR Pro – other_" if no signal is reported.
   - **Description**: Enter the information that's listed in the [Collect required information](#collect-required-information) section.
   - Confirm your contact number, email address, and preferred contact method.
   - **Attachments**: Select **Add a file**, and then upload the collected logs, screenshots, and videos.
   - Complete the regional settings.
1. Select **Contact me**.
