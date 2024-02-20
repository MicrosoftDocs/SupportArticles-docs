---
title: Hyper-V replication is suspended at system shutdown
description: Helps resolve the issue in which Hyper-V replication is suspended when the primary server or the replica server is shut down.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, nookawa
ms.custom: sap:hyper-v-replica, csstroubleshoot
---
# Hyper-V replication is suspended at system shutdown

This article helps to resolve the issue in which Hyper-V replication is suspended when the primary server or the replica server is shut down.

_Applies to:_ &nbsp; Windows Server 2012, Windows Server 2012 R2

Hyper-V replication is suspended when the primary server or the replica server is shut down. Additionally, the Hyper-V Virtual Machine Management service (VMMS) records a series of event logs with event IDs 32086 and 32022.

- Event ID 32086

    ```output
    Log Name:  Microsoft-Windows-Hyper-V-VMMS/Admin
    Source:      Hyper-V-VMMS
    Event ID: 32086
    Level:  Error
    Description:  
    Hyper-V suspended replication for virtual machine <VM Name> due to a non-recoverable failure. Resume replication after correcting the failure. (Virtual machine ID <VM GUID>) 
    ```

- Event ID 32022

    ```output
    Log Name:  Microsoft-Windows-Hyper-V-VMMS/Admin
    Source:      Hyper-V-VMMS
    Event ID: 32022
    Level:  Error
    Description: 
    Hyper-V could not replicate changes for virtual machine <VM Name>: The operation has been canceled (0x80004004). (Virtual Machine ID <VM GUID>)
    ```

    > [!NOTE]
    > The description may also include the message "Operation was interrupted (0x80004004)".

This issue occurs in Windows Server 2012 Standard, Windows Server 2012 Datacenter, and Windows Server 2012 R2 Standard. The issue has been fixed in [KB4088889](https://support.microsoft.com/help/4088889) in Windows Server 2016.

## Cause: Hyper-V VMMS stops issuing new processes

This issue occurs because Hyper-V VMMS stops issuing new processes. When the primary and the replica servers are shut down, the Hyper-V VMMS stops issuing new processes (tasks). If the different data of the Hyper-V replica server arrives or is transmitted at this time, the transmission or the reception process can't be issued, and the replication may be suspended.

## Workaround 1: Manually restart replication

You can select and hold (or right-click) the virtual machine from Hyper-V Manager and select **Replication** > **Resume Replication** to restart the replication manually.

## Workaround 2: Automatically restart replication by using script

You can also set a [replication automatic restart script](#replication-automatic-restart-script) in the task scheduler to automatically restart the replication when the system starts.

The script automatically restarts the replication that was paused at the time of system restart or shutdown and automatically resumes the replication if it's in a suspended state.

Follow these steps on both the primary server and the replica server:

1. Copy the replication automatic restart script and save it in any folder (for example, _C:\Scripts_) with the file name _restartReplication.ps1_.

2. Start PowerShell and run the following cmdlet:

    ```powershell
    PS > Set-ExecutionPolicy RemoteSigned
    ```

    > [!NOTE]
    >
    > - You don't need to run the cmdlet on a system that has already run it.
    > - PowerShell can't be started by default on a system that has never run PowerShell.

3. Press the Windows logo key + X to display the menu at the bottom left of the screen and select **Computer Management**.

4. Expand **Task Scheduler** in the left pane. Select and hold (or right-click) **Task Scheduler Library**, and then select **Create Task**. The task creation window will be displayed.

5. Set the following options on the **General** tab:

    - **Name**: Specify a task name (for example, _Hyper-V Replica AutoResume Task_)
    - **When running the task, use the following user account**: Specify a user account with administrator privileges (for example, _\<Domain Name>\administrator_)
    - **Run only when user is logged on**: Uncheck the option
    - **Run whether user is logged on or not**: Check the option
    - **Run with highest privileges**: Check the option

6. Select the **Triggers** tab and then select **New**.

7. Set the following options and then select **OK**:

    - **Begin the task**: Select **At startup**
    - **Advanced settings** > **Enabled**: Check the option

    > [!NOTE]
    > The other options are unchecked.

8. Select the **Actions** tab and then select **New**.

9. Set the following options and then select **OK**:

    - **Action**: Select **Start a program**
    - **Program/script**: Type _powershell.exe_
    - **Add arguments (optional)**: Specify the full path of the auto-restart script (For example, _C:\Scripts\restartReplication.ps1_)
    - **Start in (optional)**: Leave the value as blank

10. Leave the default settings on the **Conditions** and the **Settings** tabs, and then select **OK** to complete the settings.

When the authentication prompts, enter the administrator password.

## Test the operation status of the script

After completing the settings for the script, you can follow these steps to test the operation status of the script on the primary server.

1. Select the virtual machine for which the replication is configured from the Hyper-V Manager of the primary server. Select and hold (or right-click) it, and then select **Replication** > **Pause Replication** to intentionally suspend it.

2. Select the suspended virtual machine in Hyper-V Manager, and then select the **Replication** tab at the bottom of the screen. Make sure that the **Replication Status** is **Paused**.

3. Restart the primary server. If it can't be restarted, start the task scheduler on the primary server. Select and hold (or right-click) the task created above, and then select **Run**.

4. The script will be run when the system starts up, or a manual task is executed. To check if the replication is automatically restarted, select the suspended virtual machine from the Hyper-V manager on the primary server, and then select the **Replication** tab at the bottom of the screen. If the **Replication status** is **Replication enabled**, the replication has resumed normally.

You can also check the system event logs to confirm the operation status of the script.

- Event to start script

    ```output
    Log Name: System
    Source:   Hyper-V Replica script  
    Event ID: 0
    Level:   Information
    Description:  
    Starting script to restart replication.
    ```

- Event to resume replication

    ```output
    Log Name: System
    Source:   Hyper-V Replica script   
    Event ID: 4
    Level:    Information
    Description:  
    Replication for <VM Name> on <Primary Server Name> was in suspended and resumed successfully.
    ```

If an error such as a restart failure occurs, the error content is recorded in the system event log with an event source called "Hyper-V Replica script".

## Replication automatic restart script

Here's the replication automatic restart script:

```powershell
$EventSource = "Hyper-V Replica script"  ### Event source name recorded in system log. 
$StartUpTimeout = 60                     ### Startup timeout value for replication service in second.
If ([System.Diagnostics.EventLog]::SourceExists($EventSource) -eq $false)
{
    New-EventLog -LogName System -Source $EventSource 
}
Write-EventLog -LogName System -Source $EventSource -EntryType Information -EventID 0 -Message "Starting script to restart replication."
### Wait until VMMS starts up.
(Get-Service "vmms").WaitForStatus("Running")  ### No timeout. 
### Wait until replication service in VMMS gets active.
$Count = 0
While((Get-VMReplication).count -eq 0) 
{
    Start-Sleep -s 1
    $Count++   
    If ($Count -eq $StartUpTimeout) 
    {
        Write-EventLog -LogName System -Source $EventSource -EntryType Error -EventID 1 -Message "VMMS did not complete initialization after VMMS service started up. Exiting..."
        Exit(1)
    }
}
$Message = "Replication service in VMMS was started successfully. It took " + $Count + " seconds after VMMS started."
Write-EventLog -LogName System -Source $EventSource -EntryType Information -EventID 2 -Message $Message
###
### MAIN
###
$LocalVMs = Get-VMReplication   ### Get local VMs with replication enabled.
Foreach($LocalVM in $LocalVMs) 
{
    $PrimaryServer = $LocalVM.PrimaryServer
    $VMName = $LocalVM.Name
    ### Get-VMReplication will access remote primary server if this VM is RecoveryVM.
    $VM = Get-VMReplication -ComputerName $PrimaryServer | Where-Object { $_.Name -eq $VMName}
    If ($VM -eq $null -or $VM.count -eq 0) 
    {
        $Message = "Get-VMReplication has failed." + $Error[0].Exception + "(VM: " + $VMName + " Server: " + $PrimaryServer + ")" 
        Write-EventLog -LogName System -Source $EventSource -EntryType Error -EventID 3 -Message $Message
        Exit(1)
    }
    ### If the VM is normal, move to next VM.
    If ($VM.State -ne "Suspended" -and $VM.State -ne "Error") { continue }  
    ### Resuming replication here.
    $Err = Resume-VMReplication -VMName $VMName -ComputerName $PrimaryServer 2>&1 
    ### Wait status update for 1 sec.
    Start-Sleep -s 1
    
    ### Checking the replication status after resuming the replication
    $CurrentVM = Get-VMReplication -ComputerName $PrimaryServer | Where-Object { $_.Name -eq $VMName}
    
    ### If the replication state is still in suspended or error, it logs to event service.
    If ($CurrentVM.State -eq "Suspended" -or $VM.State -eq "Error")
    {  
        $Message = "Failed to resume replication for " + $VMName + " on " + $PrimaryServer + ". Please check replication status manually."  + $Err.Exception
        Write-EventLog -LogName System -Source $EventSource -EntryType Error -EventID 3 -Message $Message
    } 
    Else 
    {
        $Message = "Replication for " + $VMName + " on " + $PrimaryServer + " was in suspended and resumed successfully."
        Write-EventLog -LogName System -Source $EventSource -EntryType Information -EventID 4 -Message $Message
    }
}
```
