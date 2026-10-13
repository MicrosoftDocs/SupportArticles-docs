---
title: Create a support request for Teams device issues
description: Discusses how to create a support request and collect required information for Microsoft Support to resolve issues that affect Teams devices.
ms.reviewer: miaitelh, mattslomka
ms.topic: troubleshooting
ms.date: 08/18/2026
manager: dcscontentpm
audience: Admin
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:Teams Devices
  - CI 6186
---
# Create a support request for Teams device issues

You can contact Microsoft Support for assistance if you experience issues that affect the Teams Rooms Pro Management portal or the following Teams devices:

- Teams Rooms on Android
- Teams Rooms on Windows
- Teams panels
- Teams phones

This article discusses how to create a support request for these issues.

## Prerequisites

Before you create a request, make sure that:

- Your device is running the latest version of [Teams Rooms](/microsoftteams/rooms/rooms-release-note), [Teams panels](/microsoftteams/devices/devices-release-notes?tabs=panels), or [Teams phones](/microsoftteams/devices/devices-release-notes?tabs=phones) as appropriate.
- Your device is running a supported version of the [Windows](/microsoftteams/rooms/rooms-lifecycle-support) or [Android](/microsoftteams/devices/android-version-support) operating system.
- Your device is certified for Teams and check the **End of certification** tab to ensure the device is supported:
    - [Teams Rooms on Windows](/microsoftteams/rooms/certified-hardware?tabs=Windows)
    - [Teams Rooms on Android](/microsoftteams/devices/certified-hardware-android)
    - [Teams panels](/microsoftteams/devices/teams-panels-certified-hardware)
    - [Teams phones](/microsoftteams/devices/teams-phones-certified-hardware?tabs=certified-phones).
    
  If your device isn't certified, contact the manufacturer for support. If the certification for the device has ended, consider replacing the device.

## Create a support request

To create a support request, follow these steps:

1. Sign in to the [Teams Rooms Pro Management Portal](/microsoftteams/rooms/enrolling-mtrp-managed-service) or [Microsoft 365 Admin Center](https://admin.microsoft.com/) using an account that minimally has the [Service Support Administrator](/entra/identity/role-based-access-control/permissions-reference#service-support-administrator) role.
1. Select the **Need Help** icon in the lower-right corner of the page.
1. In the text box under **How can we help**, enter your question, and then select **Search**.
1. Review the suggested topics. If the results aren't helpful, select **Contact support**.
1. Select a contact method.
1. In the **Title** field, type *[Teams devices]* followed by the device type (within square brackets) as a prefix. For example, *[Teams devices][MTRW]*.
1. In the **Description** field, provide as much of the following information as possible:

   - Description of the issue.
   - Whether the issue affects a Teams Rooms device on Windows or Android, or the Teams Rooms Pro Management portal.
   - Information required for all issues:
      - Steps to reproduce the issue. If it's a Teams Rooms issue, include a video, if possible.
      - The time, date, and time zone of the most recent occurrence of the issue.
      - If the issue recurs, the recurrence rate.
      - Error messages that are generated when the issue occurs. If possible, include the message text or screenshots of any message windows that are related to the issue.
      - If available, the Teams Rooms Pro Management incident number.
   - Additional information for Teams Rooms issues:
      - Steps already tried from the referenced troubleshooting guide.
      - Logs that have been collected. You can collect logs in the Teams Rooms Pro Management portal or locally by using PowerShell.
      - Active signals in Teams Rooms Pro Management portal.
      - Whether the issue affects all devices, some devices, or only a single device.
      - The following system information that can be found on the Settings tab in the Teams Rooms Pro Management portal:
          - Operating System version
          - Device firmware version
          - Teams app version
          - Device model and manufacturer
          - Attached peripherals
          - Number of displays (if applicable)
          - Resource account information:
             - Account UPN
             - Room name
   - Additional information for calling or meeting issues:
      - Meeting link for the affected meeting.
      - PSTN number, if the issue involves a PSTN call.
      - Caller and callee UPN, if the issue involves a One-to-One call.
1. Under **Attachments**, select **Add a file or screenshot or video**, and then upload the collected logs, screenshots, and videos. For more information about how to collect logs, see [Collect device logs for Teams devices](/microsoftteams/troubleshoot/teams-rooms-and-devices/collect-device-logs).
1. Select **Contact me**.

After you submit the request, a Microsoft support engineer will follow up by using your preferred contact method.
