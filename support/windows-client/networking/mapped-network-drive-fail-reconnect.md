---
title: Mapped network drive may fail to reconnect in Windows 10, version 1809
description: An article provides a workaround to resolve mapped network drives not working in Windows 10, version 1809.
ms.date: 05/07/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-xuhuan, v-jesits
ms.custom:
- sap:network connectivity and file sharing\access to file shares (smb)
- pcy:WinComm Networking
---
# Mapped network drive may fail to reconnect in Windows 10, version 1809

This article provides a workaround for the issue that mapped network drive may fail to reconnect in Windows 10, version 1809.

_Applies to:_ &nbsp; Windows 10, version 1809  
_Original KB number:_ &nbsp; 4471218

## Symptoms

You experience the following issues in Windows 10, version 1809:

- In Windows Explorer, a red X appears on the mapped network drives.
- Mapped network drives are displayed as **Unavailable** when you run the `net use` command at a command prompt.
- In the notification area, a notification displays the following message:
    > Could not reconnect all network drives.

## Workaround

Microsoft is working on a resolution and estimates a solution will be available by the end of November 2018. Monitor the mapped drive topic in the Windows 10 1809 Update History KB [4464619](https://support.microsoft.com/help/4464619/windows-10-update-history). Currently, you can work around this issue by running scripts to automatically reconnect mapped network drive when you log on the device. To do this, create two script files, and then use one of the workarounds, as appropriate.

### Create a script file named MapDrives.cmd

The file should be run at a regular but not at an elevated command prompt because it should be run at the same privilege as Windows Explorer:

```powershell
PowerShell -Command "Set-ExecutionPolicy -Scope CurrentUser Unrestricted" >> "%TEMP%\StartupLog.txt" 2>&1
PowerShell -File "%SystemDrive%\Scripts\MapDrives.ps1" >> "%TEMP%\StartupLog.txt" 2>&1
```

### Create a script file named MapDrives.ps1

The file should be run at a regular but not at an elevated command prompt because it should be run at the same privilege as Windows Explorer:

```powershell
$i=3
while($True){
    $error.clear()
    $MappedDrives = Get-SmbMapping |where -property Status -Value Unavailable -EQ | select LocalPath,RemotePath
    foreach( $MappedDrive in $MappedDrives)
    {
        try {
            New-SmbMapping -LocalPath $MappedDrive.LocalPath -RemotePath $MappedDrive.RemotePath -Persistent $True -ErrorAction Stop
        } catch {
            Write-Host "There was an error mapping $($MappedDrive.RemotePath) to $($MappedDrive.LocalPath)"
        }
    }
    $i = $i - 1
    if($error.Count -eq 0 -Or $i -eq 0) {break}

    Start-Sleep -Seconds 30
}
```

### Workarounds

All workarounds should be executed in standard user security context. Executing scripts in an elevated security context will prevent mapped drives from being available in the standard user context.

#### Workaround 1: Create a startup item

> [!NOTE]
> This workaround works only for the device that has network access at logon. If the device has not established a network connection by the time of logon, the startup script won't automatically reconnect network drives.

1. Copy the script file **MapDrives.cmd** to the following location:  
    **%ProgramData%\\Microsoft\\Windows\\Start Menu\\Programs\\StartUp**
2. Copy the script file **MapDrives.ps1** to the following location: **%SystemDrive%\\Scripts\\**.
3. A log file **StartupLog.txt** is created in the **%TEMP%\\** folder.
4. Sign out, and then sign in to the device to open the mapped drives.

#### Workaround 2: Create a scheduled task

> [!NOTE]
> A PowerShell window flashes up when the scheduled task runs.

1. Copy the script file **MapDrives.ps1** to the following location: **%SystemDrive%\\Scripts\\**.
2. In **Task Scheduler**, select **Action** > **Create Task**.
3. On the **General** tab in the **Create Task** dialog, type a name (such as **Map Network Drives**) and description for the task.
4. Select **Change User or Group**, select a local user or group (such as **LocalComputer\\Users**) and then select **OK**.
5. On the **Triggers** tab, select **New**, and then select **At log on** for the **Begin the task** field.
6. On the **Actions** tab, select **New**, and then select **Start a program** for the **Action** field.
7. Type **Powershell.exe** for the **Program/script** field.
8. In the **Add arguments (optional)** field, type the following:  
   **-windowstyle hidden -command .\\MapDrives.ps1 >> %TEMP%\\StartupLog.txt 2>&1**
9. In the **Start in (optional)** field, type the location of the script file: **%SystemDrive%\\Scripts\\**.
10. On the **Conditions** tab, select the **Start only if the following network connection is available** option, select **Any connection**, and then select **OK**.
11. Sign out, and then sign in to the device to run the scheduled task.

#### Workaround 3: Create a scheduled task for VPN connection Event ID 20225

> [!NOTE]
> Event ID 20225 indicates that a virtual private network (VPN) connection is successfully established.

1. Copy the script file **MapDrives.ps1** to the following location: **%SystemDrive%\\Scripts\\**.
2. In **Task Scheduler**, select **Action** > **Create Task**.
3. On the **General** tab in the **Create Task** dialog, type a name (such as **Map Network Drives**) and description for the task.
4. Select **Change User or Group**, select a local user or group (such as **LocalComputer\\Users**) and then select **OK**.
5. On the **Triggers** tab, select **New**, and then select **On an event** for the **Begin the task** field.
6. Select **Application** from the **Log** dropdown list, type **RasClient** in the **Source** field, and type **20225** in the **Event ID** field. Then, select **OK**.
7. On the **Actions** tab, select **New**, and then select **Start a program** for the **Action** field.
8. Type **Powershell.exe** for the **Program/script** field.
9. In the **Add arguments (optional)** field, type the following:  
   **-windowsstyle hidden -command .\\MapDrives.ps1 >> %TEMP%\\StartupLog.txt 2>&1**
10. In the **Start in (optional)** field, type the location of the script file: **%SystemDrive%\\Scripts\\**.
11. On the **Conditions** tab, select the **Start only if the following network connection is available** option, select **Any connection**, and then select **OK**.
12. Sign out, and then sign in to the device to run the scheduled task.
