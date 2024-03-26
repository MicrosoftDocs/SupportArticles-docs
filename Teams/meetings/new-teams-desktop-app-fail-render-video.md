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
ms.reviewer: revaldiv,corbinm,scapero
appliesto: 
  - New Microsoft Teams
search.appverid: 
  - MET150
ms.date: 02/08/2024
---
# New Teams desktop app fails to render video

## Symptoms

You're using the new Microsoft Teams desktop app on a computer that also has the Nahimic audio driver installed. During a Teams meeting, the app does not render video in any of the following scenarios:

- Video content is presented during the meeting.
- You join a meeting without having video enabled, and then you enable video while you're in the meeting.
- Before you join a meeting, you check the video preview screen in the meeting join window to verify that the video works correctly.

## Cause

This issue occurs because of a conflict that exists between the new Teams app and the Nahimic audio driver.

## Workaround

To work around the issue, follow these steps:

1. Exit the Teams desktop app.
1. Search in File Explorer for a file named *BlackApps.dat* in the %PROGRAMDATA% folder. This file is the exclusion list used by the Nahimic app.
1. Open the BlackApps.dat file by using a text editor, such as Notepad.

   **Note:** If you can't open the file, follow these steps to change permissions on the file:

   1. Right-click the file, and then select **Properties**.
   1. Select the **Security** tab, and then select the **Edit** button.
   1. On the **Permissions** screen, in the **Group or user names** box, select the appropriate group to which you belong.
   1. In the list in the **Permissions** box, select **Allow** for the **Full control** permission.
   1. Select **Apply**, and then select **OK** to close the **Permissions** screen.
   1. Close the **Properties** dialog box.
1. In the BlackApps.dat file, add the following executable files:

   - `ms-teams.exe`
   - `msedgewebview2.exe`
1. Save the file, and then exit the text editor.
1. Restart the Teams desktop app.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-information-disclaimer.md)]
