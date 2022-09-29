---
title: Get support for Microsoft Teams Rooms Pro Management
description: Describes how to create a support request and collect required information and logs when contacting Microsoft Support to resolve issues in the Teams Rooms Pro Management portal.
ms.reviewer: aageorge
ms.topic: troubleshooting
ms.date: 9/29/2022
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: Admin
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: CI167668
---
# Get support for Microsoft Teams Rooms Pro Management

When you experience issues in the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/), you can contact Microsoft support for further assistance. This article describes how to create a support request and collect required information and logs.

## Collect necessary information

To reduce the time required to gather information when you open a support request with Microsoft or a Microsoft OEM partner, we recommend that you collect and aggregate the following information:

> [!NOTE]
> This may not be a complete list of information that will be requested but includes the most common items.

- Specify whether it's a Teams Rooms device (Teams Rooms on Windows or Teams Rooms on Android), or Teams Rooms Pro Management portal issue.
- Information required for all issues:
  - Steps to reproduce the issue. If it's a Teams Rooms issue, include a video if possible.
  - The time, date, and time zone of the last time the issue occurred.
  - If the issue recurs, the reoccurrence rate.
  - Errors or messages when the issue occurs. If possible, include text or screenshots of any errors or messages related to the issue.
  - If available, the Teams Rooms Pro Management support case number.
- Additional information for Teams Rooms issues:
  - Steps already tried in the referenced troubleshooting guide.
  - Logs that have been collected. You can collect logs in the Teams Rooms Pro Management portal, or [locally by using PowerShell](/MicrosoftTeams/rooms/rooms-operations#collecting-logs-on-microsoft-teams-rooms).
  - Active signals in Teams Rooms Pro Management portal.
  - Whether the issue affects all devices, some devices, or only a single device.
  - The following system information, which can be found under **Settings** tab in the Teams Rooms Pro Management portal:
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
  - PSTN number, if it's a PSTN call.
  - Caller and callee UPN, if it's a One-to-One call.

## Collect logs

To collect logs in the [Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/):

1. Go to the room pane of the room you want to collect logs for, select **Collect logs**.

    :::image type="content" source="./media/get-support-teams-rooms-pro-management/room-pane.png" alt-text="Screenshot of the room pane that shows the collect logs button.":::

1. In the **Collect logs** dialog box, select **Run**.

    :::image type="content" source="./media/get-support-teams-rooms-pro-management/collect-logs-prompt.png" alt-text="Screenshot of the Collect logs dialog box that shows the prompt to start log collection.":::

1. Select **Ok**. It can take five to ten minutes to upload the logs, depending on the room's local internet bandwidth.

    :::image type="content" source="./media/get-support-teams-rooms-pro-management/collect-logs-confirmation.png" alt-text="Screenshot of the Collect logs dialog box that shows the request was sent successfully to the device.":::

1. When the upload is complete, you can find the file in the **Activity** tab. Select **Refresh** to check the status if needed.

    :::image type="content" source="./media/get-support-teams-rooms-pro-management/collected-log-files.png" alt-text="Screenshot that shows the collected log files.":::

1. Select the download icon to download the logs.

To collect logs on the Teams Rooms device:

1. Sign in to the device with the **Admin** account.
1. Run the following command in an elevated command prompt:

   ```console
   powershell -ExecutionPolicy unrestricted c:\rigel\x64\scripts\provisioning\ScriptLaunch.ps1 CollectSrsV2Logs.ps1
   ```

1. The logs are saved as a zip file under _c:\rigel_.

## Create a support request

> [!NOTE]
> You can also get support directly from the OEM for OEM peripheral or device issues. Usually, the following signals are related to OEM peripheral or device issues:
>
> - Camera
> - Display
> - Microphone
> - Speaker

To create a support request, follow these steps:

1. Go to the [Microsoft 365 admin center](https://go.microsoft.com/fwlink/p/?linkid=2166757). At the bottom right side of the page, select **Help & support**. Alternatively, go to the [Microsoft Teams admin center](https://go.microsoft.com/fwlink/?linkid=867439). At the bottom right side of the page, select **Need help**.
1. Type *Teams Rooms Portal* in the **Tell us your problem** text box, then press **Enter**.
1. Review suggested topics. If the results aren't helpful, select **Contact support**.
1. In the **Contact support** pane, complete the following information:

   - **Title**: Enter "_MTR Pro –_" followed by the signal that's reported in the Teams Rooms Pro Management portal, such as Meeting app. Or, enter "_MTR Pro – other_" if no signal is reported.
   - **Description**: Enter the information listed in the [Collect necessary information](#collect-necessary-information) section.
   - Confirm your contact number, email address and preferred contact method.
   - **Attachments**: Select **Add a file**, then upload the collected logs, screenshots and videos.
   - Complete the regional settings.
1. Select **Contact me**.
