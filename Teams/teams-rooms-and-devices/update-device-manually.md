---
title: Update a Teams Rooms device manually
description: Describes how to update your Microsoft Teams Rooms device to the latest version manually.
ms.reviewer: travissnoozy, mattslomka
ms.topic: troubleshooting
ms.date: 08/18/2026
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: Admin
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:Teams Devices
---
# Update a Teams Rooms device manually

## Summary

The Microsoft Teams Rooms app is distributed through the Microsoft Store, and it updates automatically through Windows Update. This is the recommended method to get updates. However, there are some situations where a Teams Rooms device can't receive updates from the Microsoft Store.

If you can't get updates from the Microsoft Store, you can use a PowerShell script that's available for offline app updates to manually update your Teams Rooms devices to a newer version of the Teams Rooms app.

> [!NOTE]
> You can use the PowerShell script to only update a Teams Rooms device that has the Teams Rooms app already installed. The script can't be used to perform a new installation or downgrade the app to an older version.

## Step 1: Download the offline app update script

Select <https://go.microsoft.com/fwlink/?linkid=2151817> to download the latest version of the PowerShell script. The script will download to the default **Downloads** folder on your computer.

The downloaded file might be blocked by Windows. If you want to run the script without any user interaction, unblock the script by using the following steps:

1. Right-click on the downloaded script in File Explorer.
2. Select **Properties** > **Unblock**, and then select **OK**.

To unblock the script by using PowerShell, see [Unblock-File](/powershell/module/microsoft.powershell.utility/unblock-file).

After the offline app update script is downloaded, transfer the file to the Teams Rooms device. You can transfer a file to the device by using a USB drive or by accessing the file from a network file share while in Admin Mode on the device. Be sure to note where you save the file on the device.

## Step 2: Run the script to update the Teams Rooms app

Run the offline app update script from an [elevated command prompt while the Skype user is still signed in](/microsoftteams/rooms/rooms-operations#switching-to-admin-mode-and-back-when-the-microsoft-teams-rooms-app-is-frozen).

Use the following steps to run the script:

1. Switch to Admin mode.
2. Select the **Start** icon, type **Command Prompt**, and then select **Run as administrator**.
3. Run the following command where `<path to script>` includes the full path to the script and the name of the script file:

   ```console
   PowerShell -ExecutionPolicy Unrestricted "<path to script>"
   ```

For example, if the script file is located in `C:\Users\Admin\Downloads`, and the script file name is `MTR-Update-4.5.6.7.ps1`, run the following command:

```console
PowerShell -ExecutionPolicy Unrestricted "C:\Users\Admin\Downloads\MTR-Update-4.5.6.7.ps1"
```

Wait for the script to complete.

## Step 3: Verify the app has been updated successfully

Check the output from the script. It will indicate whether or not the script completed successfully.

If the script completes successfully, the Teams Rooms device will run the updated version of the Teams Rooms app the next time it restarts.

If the script encounters a problem, it will indicate what the problem is on the command line and record its output to a log file. Follow the instructions that the script provides. If you need to contact Microsoft Support, make sure to include the log file with the support request that you file. The log file is located at `C:\Users\Skype\AppData\Local\Packages\Microsoft.SkypeRoomSystem_8wekyb3d8bbwe\LocalState\Tracing\MTR-Update`.
