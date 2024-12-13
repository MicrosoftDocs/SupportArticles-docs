---
title: The Meeting app status of a Teams Rooms device is Unhealthy
description: Resolve the issue that causes the Meeting app signal of a Microsoft Teams Rooms device to appear as Unhealthy.
ms.reviewer: rafilipe
ms.topic: troubleshooting
ms.date: 12/08/2023
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
  - CI167273
  - CI185119
---
# The Meeting app status is Unhealthy

In the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/), the **Meeting app** signal of a Microsoft Teams Rooms device is shown as **Unhealthy**, and the incident severity value is shown as **Critical**.

Users might also experience the following issues on the device.

## The device doesn't sign in automatically

This issue can occur for different reasons:

- The local Windows user account that's named **Skype** doesn't exist. In this situation, the Teams Rooms app can't start or work correctly.
- The **Skype** account isn't set as the default user of the device. In this situation, Windows doesn't sign in automatically, and the Teams Rooms app doesn't start.
- Automatic logon is disabled.
- A password is set for the **Skype** account.

To troubleshoot this issue, follow these steps:

1. Sign in to the device by using the **Admin** account.
2. Run the following PowerShell command to check whether the **Skype** account exists:
  
   ```powershell
   Get-LocalUser "Skype"
   ```

   If this account doesn't exist, reimage the device as described in the OEM documentation. Otherwise, go to step 3.
3. Open Registry Editor, locate the `HKEY_LOCAL_MACHINE\Software\Microsoft\windowsNT\CurrentVersion\Winlogon` subkey.
4. Verify the following values of the registry key:

   - **DefaultUserName**: If this value isn't set to **Skype**, set it to **Skype**.
   - **AutoAdminLogon**: If this value is set to **0**, automatic logon is disabled. In this case, set this value to **1**.

   You can also set these values by running the following commands at an elevated PowerShell prompt:

   ```powershell
   Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name "DefaultUserName" -Value "Skype"
   Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name "AutoAdminLogon" -Value 1
   ```

   If the issue persists, check for Group Policy or Mobile Device Management (MDM) settings that override these values or prevent the expected behavior. For more information, see [`gpresult`](/windows-server/administration/windows-commands/gpresult) (for Active Directory) or [Generate & gather Windows 10 MDM client logs and diagnostics](https://techcommunity.microsoft.com/t5/intune-customer-success/generate-amp-gather-windows-10-mdm-client-logs-and-diagnostics/ba-p/1082142) (for MDM).
5. Make sure that no password is set for the [Skype account](/microsoftteams/rooms/security#software-security). To make Teams Rooms work correctly, the *Skype* account shouldn't have a password. If a password is set, remove it by running the following command at an elevated PowerShell prompt:

   ```powershell
   Set-LocalUser Skype -Password (new-object System.Security.SecureString)
   ```

   If the issue persists, check for Group Policy or MDM settings that override this value or prevent the expected behavior. For more information, see [`gpresult`](/windows-server/administration/windows-commands/gpresult) (for Active Directory) or [Generate & gather Windows 10 MDM client logs and diagnostics](https://techcommunity.microsoft.com/t5/intune-customer-success/generate-amp-gather-windows-10-mdm-client-logs-and-diagnostics/ba-p/1082142) (for MDM).

## The device is signed in by using another account

When another user is signed in to the device (for example, the *Admin* user is signed in to do administrative tasks), the **Meeting app** signal is reported as **Unhealthy**.

To fix this issue, try these options:

- Sign out the user so that the *Skype* account can sign in.
- Restart the device.
- If the *Admin* user has to run scheduled maintenance tasks within a specific time, [use the Suppress ticket functionality](/microsoftteams/rooms/managed-meeting-rooms-portal#room-detail-status-and-changes) to silence any notification about the **Meeting app** signal.

## The device displays a black or gray screen

This issue occurs in the following situations:

- The *SkypeRoomSystem.exe* or *DesktopAPIService.exe* process isn't running or crashes.
- The device isn't running a supported edition of Windows. Microsoft Teams Rooms requires the Windows IoT Enterprise or Windows Enterprise SKUs under the Global Availability Channel servicing option. For more information, see [Windows release support](/microsoftteams/rooms/rooms-lifecycle-support#windows-release-support).

To fix the issue, try these options:

- Make sure that the device is running a supported edition of Windows. Otherwise, reimage the device as described in the OEM documentation.
- Restart the device. If the issue persists, reimage the device as described in the OEM documentation.

## The device displays an app error message, or returns to the logon screen when you try to start the Teams Rooms app

This issue can occur in the following situations:

- There are multiple versions of Teams Rooms app installed on the device.
- The Teams Rooms app needs remediation.
- The device isn't running a supported edition of Windows. Microsoft Teams Rooms requires the Windows IoT Enterprise or Windows Enterprise SKUs under the Global Availability Channel servicing option. For more information, see [Windows release support](/microsoftteams/rooms/rooms-lifecycle-support#windows-release-support).

To fix the issue, follow these steps:

1. Make sure that the device is running a supported edition of Windows. Otherwise, reimage the device as described in the OEM documentation.
2. Run the following command at an elevated PowerShell prompt:

   ```powershell
   (Get-AppxPackage "*SkypeRoomSystem*" -AllUsers).Count
   ```

   If the result is greater than **1**, run the following script to uninstall old versions and keep only the latest version. Otherwise, go to step 3.
  
   ```powershell
   $apps = Get-AppxPackage "*SkypeRoomSystem*" -AllUsers | Sort-Object -Property @{ Expression = {[Version] $_.Version} }

   $greatestVersion = ($apps | Select-Object Last -1).Version

   foreach ($app in $apps)
   {
      if ($app.Version -eq $greatestVersion) { continue }
            
      try
      {
        Remove-AppxPackage -Package $app.PackageFullName -AllUsers
      }
      catch
      {
        Write-Output ("Failed to remove AppVersion {0} with the exception: {1}" -f $app.version,$_)
      }
        
   }
   ```

   If the issue persists, go to step 3.
3. Run the following command at an elevated PowerShell prompt:

   ```powershell
   Get-AppxPackage "*SkypeRoomSystem*" -AllUsers | Select-Object Version, Status
   ```

   If the status shows **NeedsRemediation**, take one of the following actions:

   - If the device is running the latest version of Teams Rooms app, reimage the device.
   - [Manually update the device](/microsoftteams/rooms/manual-update) to the latest version of the Teams Rooms app.
4. If the issue persists, reimage the device as described in the OEM documentation.

## More information

The Teams Rooms app logs a heartbeat event to the Skype Room System Windows event log every five minutes. The Teams Rooms Pro agent uses this information to check the status of the app and other signals. If this heartbeat event isn't logged for some time, this indicates that an issue is affecting the app, and the app isn't in a healthy state.
