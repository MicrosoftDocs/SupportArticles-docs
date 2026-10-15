---
title: Reset a Teams Rooms on Windows device
description: Describes how to use the recovery tool for Microsoft Teams Rooms to bring an out-of-date system into a supported state.
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
# Reset a Teams Rooms on Windows device by using the recovery tool

## Summary

This article discusses how to use the recovery tool for Microsoft Teams Rooms to bring a nonfunctional system into a supported state. This tool should be used when either the Microsoft Teams Rooms console shows a "system config out of date" error, or before performing a Windows push button reset (PBR). Using the built-in Windows reset functionality without first running the recovery tool will result in the Teams Rooms application being removed after a reset.

> [!IMPORTANT]
> It may be faster to reset a Teams Rooms on Windows device using an OEM (original equipment manufacturer) recovery image. Contact your Teams Rooms OEM for guidance to reset a device by using their recovery image.

## Download the recovery tool

Download the latest [Microsoft Teams Rooms package](https://go.microsoft.com/fwlink/?linkid=851168) and extract it to a USB memory stick or network share accessible to Microsoft Teams Rooms.

> [!TIP]
> Extracting the files from the MSI can be accomplished by many means. Any mechanism that extracts all the files and preserves their directory structure is acceptable. One such way is to use the command `msiexec /a PathToMsi /qb TARGETDIR=PathToTarget` where `PathToMsi` represents the full path to the Microsoft Teams Rooms installation package, and `PathToTarget` represents the full path to the folder you would like the files extracted to.

## Run the recovery tool

1. [Switch to admin mode](/microsoftteams/rooms/rooms-operations#switching-to-admin-mode) on the Microsoft Teams Rooms device and launch an elevated command prompt.
1. Access your extracted Teams Rooms package and verify that you're able to access the `RecoveryTool.ps1` file.
1. Run the following command:

   ```console
   powershell.exe -ExecutionPolicy Unrestricted -File "<path to RecoveryTool.ps1>"
   ```

1. When prompted by the script, select option 2: **Reset**.
1. If BitLocker is enabled, follow the instructions provided at the end of the script output to disable it.

## Perform a Windows factory reset

1. In Windows, select the **Start Button** then select **Settings**, and select **System**.
2. Select the **Recovery** option.
3. Select **Reset PC**.
4. Select **Remove everything**, then **Next** and **Reset**
5. The system restarts multiple times. When the reset is complete, the system will be at the Windows out-of-box experience (OOBE).

> [!WARNING]
> The Microsoft Teams Rooms device can become unusable if the **Keep my files - Removes Apps and settings, but keeps your personal files** option is selected during the Windows Reset process. Don't select this option.
