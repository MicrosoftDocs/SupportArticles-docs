---
title: K-12 assessments unexpectedly report apps running in background
description: This article provides a workaround for the problem where K-12 assessments test unexpectedly reports that Apps are running in the background in Windows 10.
ms.date: 01/21/2021
ms.custom: sap:Administration
ms.reviewer: 
ms.topic: troubleshooting
---
# K-12 assessment unexpectedly reports apps running in the background in Windows 10

[!INCLUDE [](../../../includes/browsers-important.md)]

This article helps you work around the problem where K-12 assessments test unexpectedly reports that Apps are running in the background in Windows 10.

_Applies to:_ &nbsp; Windows 10  
_Original KB number:_ &nbsp; 4338725

## Symptom

K-12 assessments that are provided by AIR Secure Browser or Take a Test detect that unallowed apps are running in the background, although you didn't start the apps. As a result, you can't start an assessment, or you are kicked out of an ongoing assessment, and you must manually end the apps' task in Task Manager.

Example apps: Microsoft Photos App, Microsoft Edge (starting in version 1803).

## Cause

Windows gives Universal Windows Platform (UWP) store apps, such as Microsoft Photos app, the ability to register to prelaunch. Pre-launching helps the performance of Microsoft Edge and minimizes the amount of time that is needed to start Microsoft Edge.

This issue occurs because AIR assessments have a list of apps that aren't allowed to run during or before the assessment, and apps like those cited previously are blocked. Therefore, when the apps are preloaded, the assessment will think there is a breach in security because the apps are running in the background, and kick out the user.

## Workaround

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

To work around this issue, disable the application prelaunch by using a PowerShell command, and Microsoft Edge prelaunch by using a registry key.

To do this, use the following PowerShell cmdlets:

1. Temporarily disable the Window Defender Application Guide service, because the `Disable-MMAgent` command fails if this service is running or not used.

   ```powershell
   Stop-Service -Name hvsics -ErrorAction SilentlyContinue
   ```

1. Disable application prelaunch.

   ```powershell
   Disable-MMAgent -ApplicationPreLaunch.
   ```

1. Restart the Windows Defender Application Guard service. If this is not used, the command silently fails.

   ```powershell
   Start-Service -Name hvsics -ErrorAction SilentlyContinue
   ```

1. Disable Microsoft Edge prelaunch by setting a registry key.

   ```powershell
   $registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\PreLaunch\Microsoft.MicrosoftEdge_8wekyb3d8bbwe!MicrosoftEdge" $Name = "Enabled" $value = "0" New-Item -Path $registryPath -Force | Out-Null New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWORD -Force | Out-Null
   ```

1. Create a scheduled task that re-enables application prelaunch on a specified date.

   ```powershell
   $A = New-ScheduledTaskAction -Execute "powershell" -Argument "-Command `"Stop-Service -Name hvsics -ErrorAction SilentlyContinue; Enable-MMAgent -ApplicationPreLaunch;Start-Service -Name hvsics -ErrorAction SilentlyContinue;New-ItemProperty -Path `"HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\PreLaunch\Microsoft.MicrosoftEdge_8wekyb3d8bbwe!MicrosoftEdge`" -Name `"Enabled`" -Value `"1`" -PropertyType DWORD -Force | Out-Null`"" $revertDate = <Specify a date> $T = New-ScheduledTaskTrigger -Once -At $revertDate $P = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest $timespan = New-TimeSpan -Minutes 1 $S = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DontStopOnIdleEnd -StartWhenAvailable -RestartCount 3 -RestartInterval $timespan $D = New-ScheduledTask -Action $A -Principal $P -Trigger $T -Settings $S Register-ScheduledTask DisableAppPrelaunch -InputObject $D
   ```

   > [!NOTE]
   > Set `$revertDate` to a date when to re-enable application prelaunch. For example, **$revertDate = [datetime]"6/28/2020 5:35 PM"**.
