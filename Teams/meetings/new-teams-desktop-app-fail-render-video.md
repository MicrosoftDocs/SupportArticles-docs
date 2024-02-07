---
title: New Teams desktop app fails to render video
description: Provides a workaround for an issue in which video rendering fails in the new Teams app on a computer that has the Nahimic audio driver installed.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
- CI 186626
- CSSTroubleshoot
ms.reviewer: revaldiv,scapero
appliesto: 
  - New Microsoft Teams
search.appverid: 
  - MET150
ms.date: 02/07/2024
---
# New Teams desktop app fails to render video

## Symptoms

You're using the new Teams desktop app on a computer that also has the Nahimic audio driver installed. During Teams meetings, the meeting video fails to render video in one of the following scenarios:

- When you join a meeting after checking the preview of the video in **Camera**.
- When video content is presented during the meeting.

## Cause

This issue is caused by conflicts between the new Teams client and the Nahimic audio driver.

## Workaround

To work around the issue, follow these steps:

1. Exit the Teams desktop app.
1. Locate the file named *BlackApps.dat*, which is the exclusion list used by Nahimic. The default location for this file is `C:\ProgramData\A-Volute\A-Volute.Nahimic\Modules\Scheduled\Configurator\BlackApps.dat`.

   **Note:** The file location may vary depending on the version of Windows on the device.
1. Open the BlackApps.dat file by using a text editor, such as Notepad.

   **Note:** If you can't access the file, follow these steps to change permissions on the file:

   1. Right-click the file, and then select **Properties**.
   1. Select the **Security** tab, and then select the **Edit** button.
   1. In the **Permissions** dialog box, select the group or user that you want to change permissions.
   1. In the permissions list for this group or user, select **Allow** for the **Full control** permission.
   1. Select **Apply**, and then select **OK** to close the **Permissions** dialog box.
   1. Close the **Properties** dialog box.
1. Add the following executable files to the BlackApps.dat file:

   - `ms-teams.exe`
   - `msedgewebview2.exe`
1. Save the file and exit Notepad.
1. Restart the Teams desktop app.

## Status

[!INCLUDE [Status disclaimer](../../includes/status.md)]
