---
title: Troubleshooting steps for Microsoft Teams Rooms if it does not start after updating to 4.4.41.0
ms.author: v-todmc
author: todmccoy
manager: dcscontentpm
ms.date: 5/20/2020
audience: ITPro
ms.topic: article
ms.prod: microsoft-teams
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Microsoft Teams Rooms
ms.custom: 
- CI 118782
- CSSTroubleshoot 
ms.reviewer: sohailta
description: Troubleshooting steps when Microsoft Teams Rooms doesn't start after updating to version 4.4.41.0. 
---

# Microsoft Teams Rooms application does not start after update to version 4.4.41.0

## Summary

This guide covers how to troubleshoot known issues that may cause your Microsoft Teams Rooms (MTR) system to become nonfunctional after you upgrade to version 4.4.41.0. This guide proceeds in order from most-likely to least-likely causes and resolutions.

## More information

If your MTR system is running smoothly, but the application does not start after you install an application update, follow these steps to troubleshoot and fix the issue.

### Step 1: Restart up to two times

If any errors occur that might prevent the MTR from starting as expected after the update is installed, you can try to fix them by restarting the system two times. Wait 10 minutes between restarts. This step clears most cases. 

To restart MTR, try any of the following methods:
- Use the power button in the Start menu (RDP or local)
- Run the “shutdown /r /t 0” command (remote or local)
- Run the PowerShell “Restart-Computer” command (remote or local)

> [!NOTE]
> - Do not press and hold the computer power button or unplug the system from AC power to turn the system off. This can interrupt important script processing or damage the file system. Turning off the computer in this situation is generally not recommended except when no other option is available.
> - A system that is left to run for two days or longer will complete these restarts automatically.

After the second restart, wait an additional 10 minutes. If the system does not become fully operational within 10 minutes after the second restart, go to the next step.

### Step 2: Check for ScriptLaunch errors

Critical scripts that typically run during startup may not run on some systems. To check for this situation, follow these steps:

1.	[Sign in to the Administrator account on the device](/microsoftteams/rooms/rooms-operations#admin-mode-and-device-management).
2.	Select the **Start** menu.
3.	Type **Event Viewer**, and then press **Enter**.
4.	Expand **Application and Service Logs**, and then select **ScriptLaunch** log.
5.	In the details pane, select **Filter Current Log**.
6.	Select the **Error** check box, and then type 1002 into the text box labeled **\<All Event IDs>**.
7.	Select **OK**.

If there are entries in the filtered list that correspond to your system’s recent startups, you are likely affected by this problem.

If your system is affected (and app version 4.4.41.0 or later is installed), follow these steps:

1.	[Sign in to the Administrator account on the device](/microsoftteams/rooms/rooms-operations#admin-mode-and-device-management).
2.	Open the **Start** menu.
3.	Type **Command Prompt**, right-click the search result, and then select **Run as administrator**.
4.	At the command prompt, type the following command, and then press Enter:

```
powershell -executionpolicy unrestricted c:\rigel\x64\scripts\provisioning\scriptlaunch.ps1 Config\LocalProvisioning\CopyFiles.ps1
```

   > [!NOTE]
   > If errors are produced, you can safely disregard them. The final line of the output should read, "Success."

5. Restart the system. Up to two additional restarts may be required (see Step 1).

### Step 3: Check whether the app is installed under user NT AUTHORITY\SYSTEM

Some systems in the field have installed the Microsoft.SkypeRoomSystem app for the NT AUTHORITY\SYSTEM user. The NT AUTHORITY\SYSTEM user context cannot run APPX apps and should not have the Microsoft.SkypeRoomSystem app installed or staged to it. Such systems frequently do not start correctly. The remedy is to remove the app from the system.

To check for this situation:

1. [Sign in to the Admin account on the device](/microsoftteams/rooms/rooms-operations#admin-mode-and-device-management).
2. Open the **Start** menu.
3. Type Windows PowerShell, right-click the search result, and then select **Run as administrator**.
4. At the command prompt, type and run the following script:

    ```
    Get-AppxPackage -User “NT AUTHORITY\SYSTEM” Microsoft.SkypeRoomSystem
    ```

5. If the command generates no output, the system is not affected. In this case, go to Step 4.

6. If the command does generate output, the system is affected. In this case, follow these steps:
    1. [Sign in to the Admin user on the device](/microsoftteams/rooms/rooms-operations#admin-mode-and-device-management).
    2. Open the **Start** menu.
    3. Type **Notepad**, right-click the search result, and then select **Run as administrator**.
    4. Copy the following script into Notepad:

       ```
       Get-AppxPackage Microsoft.SkypeRoomSystem | Remove-AppxPackage
       Remove-Item C:\Rigel\AdminHookScripts\Logon.ps1
       Restart-Computer -Force
       ```
        
    5. Press **Ctrl+S**.
    6. In the File name field, enter: 
            ```
            C:\Rigel\AdminHookScripts\Logon.ps1.
            ```
    7. In the **Save as type** list, select **All Files (*.*)**.
    8. Select **Save**.
    > [!NOTE]
    > You must have elevated privileges to write to this directory.

After the script is successfully saved, restart the computer. Up to two additional restarts may be required (see Step 1).

### Step 4: Check the shell configuration

This step applies to Windows 10, version 1903 or later systems only. If your system is running an earlier OS build, go to Step 5.

Some systems may have been interrupted or otherwise failed to correctly set their shell launch configuration. Therefore, they cannot start the app when the Skype user signs in.

> [!NOTE]
> The [PSExec](/sysinternals/downloads/psexec) tool must be available on the device. If Psexec.exe is not in the device’s execution path, you will have to specify the full path to your copy of the Psexec.exe executable in your commands.

To check for this situation, follow these steps:

1.	[Sign in to the Administrator account on the device](/microsoftteams/rooms/rooms-operations#admin-mode-and-device-management).
2.	Open the **Start** menu.
3.	Type **Command Prompt**, right-click the search result, and then select **Run as administrator**.
4.	At the command prompt, type the following script, and then press Enter: 
    ```
    psexec -accepteula -i -s cmd
    ```
    > [!NOTE]
    > A new shell is created.
5.	In the new shell, type and run the following command: 
    ```
    powershell -Command “& {(Get-CimInstance -Namespace ‘root\cimv2\mdm\dmmap’ -ClassName ‘MDM_AssignedAccess’).ShellLauncher}”
    ```

6.	If the command prints an XML file that's about 24 lines long, the system is not affected. In this case, go to Step 5. 

7. If the command returns an error, nothing, or an empty XML file, the system is affected. If your system is affected, follow these steps:
    1. [Sign in to the Administrator account on the device](/microsoftteams/rooms/rooms-operations#admin-mode-and-device-management).
    2. Open the **Start** menu.
    3. Type **winver**, and select the search result.
    4. Verify that the window that opens indicates “Version 1903” or a later version. If you follow these steps on MTR devices that run earlier versions of Windows this procedure will not resolve the issue and might cause further problems.
    5. Open the **Start** menu.
    6. Type **Command Prompt**, right-click the search result, and then select **Run as administrator**.
    7. At the command prompt, type the following script, and then press Enter:
     ```
     psexec -accepteula -i -s cmd
     ```
    > [!NOTE]
    > A new shell is created.

    8. In the new shell, type and run the following script: 
    ```
    powershell -executionpolicy unrestricted c:\Rigel\x64\Scripts\Provisioning\ScriptLaunch.ps1 Config\SetupShell\CustomShell.ps1
    ```
    > [!NOTE]
    > This command returns “RebootRequired.”

    9. Restart the computer. Up to two additional restarts may be required (see Step 1).

### Step 5: Contact Customer Support

If your problem is not addressed by this troubleshooting guide, it is possible that we are not aware of it. Contact your customer service representative for help to identify and resolve the problem.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
