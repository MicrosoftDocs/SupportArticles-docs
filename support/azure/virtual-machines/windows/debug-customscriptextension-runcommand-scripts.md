---
title: Debug PowerShell scripts run by Custom Script Extension or Run Command
description: Troubleshoot PowerShell script failures when you run them remotely on a virtual machine by using the Custom Script Extension or Run Command feature.
ms.date: 03/15/2022
ms.reviewer: clandis, v-leedennis
editor: v-jsitser
ms.service: virtual-machines
ms.subservice: vm-troubleshooting-tools
ms.custom: devx-track-azurepowershell
#Customer intent: As an Azure Virtual Machine customer, I want to find out why a PowerShell script that's run by using Custom Script Extension or Run Command has failed so I can debug it.
---
# Debug PowerShell scripts run by Custom Script Extension or Run Command

This article discusses how to test and correct for a failure in a PowerShell script that uses the Custom Script Extension or Run Command feature.

## Prerequisites

- [Azure PowerShell](/powershell/azure/install-az-ps)
- The [PsExec](/sysinternals/downloads/psexec) tool

## Overview

Assume that you used the [Custom Script Extension](/azure/virtual-machines/extensions/custom-script-windows) or [Run Command](/azure/virtual-machines/windows/run-command) feature to run a PowerShell script. What do you do if the script fails? You have several available methods to determine the cause of the failure.

PowerShell has more than one output stream. Logs for Custom Script Extension and Run Command scripts send the **Success** stream to the `StdOut` substatus and the **Error** stream to the `StdErr` substatus. These substatuses belong to the extension that was used to run either the Custom Script Extension script or the Run Command script.

The `StdOut` and `StdErr` substatuses are in the certificate registration point (CRP) instance view for the virtual machine (VM). These substatuses are visible in several locations, per the following table.

| Interface | How to view the substatus |
| --------- | ------------------------- |
| [Azure portal](https://portal.azure.com) | <ol><li>Search for and select **Virtual machines**. </li><li>Select your VM from the list. </li><li>On the VM overview page, select **Extensions + applications** > **Extensions**. </li><li>Select the extension that was used to run the command. (It will be named either **CustomScriptExtension** or **RunCommand**.) </li><li>Select **View detailed status**. </li></ol> |
| Azure PowerShell | Enter the [Get-AzVM](/powershell/module/az.compute/get-azvm) cmdlet to get the properties of an Azure VM, as follows:<br> `Get-AzVM -ResourceGroupName <resource-group-name> -Name <vm-name> -Status`</br> |
| Azure CLI | Enter the [az vm get-instance-view](/cli/azure/vm#az-vm-get-instance-view) command to get instance information about an Azure VM, as follows:<br> `az vm get-instance-view --resource-group <resource-group-name> --name <vm-name> --query instanceView.extensions`</br> |

The error that usually causes the script to fail appears in the `StdErr` substatus. However, scripts can also fail without logging a fatal error entry in that substatus.

## Test the script manually and by using PsExec

Manually verify that the script runs successfully from an administrative PowerShell console on the VM.

If the script works manually, use PsExec to run the script by using the local system account. For both Custom Script Extension and Run Command, scripts are run by using that account. By entering `psexec -s`, you can test the script by using the local system account but without using either Custom Script Extension or Run Command. If the failure is reproduced by using `psexec -s`, then Custom Script Extension and Run Command aren't the cause of the issue.

### Test by using PsExec

You can use PsExec to run a PowerShell test script remotely. Open an administrative Command Prompt window, and then enter the following PsExec command. Replace the placeholder with the fully qualified name of the PowerShell script:

```cmd
psexec -accepteula -nobanner -s powershell.exe -NoLogo -NoProfile -File <C:\path\script-name.ps1>
```

Or, you can use PsExec interactively. In the following example, you enter the [whoami](/windows-server/administration/windows-commands/whoami) command to show that PowerShell is running under the Local System (`NT AUTHORITY\SYSTEM`) account:

```console
C:\>psexec -accepteula -nobanner -s powershell.exe -NoLogo -NoProfile

PS C:\Windows\system32> whoami
nt authority\system 
```

## Turn on logging of PowerShell script execution

If the `StdErr` substatus doesn't show the cause of the problem, you can turn on several types of logging to collectively show the script content and output. This logging shows what the script is trying to accomplish, and the result of running the script.

To turn on different types of logging, follow the steps in the next several sections.

> [!WARNING]
> Some of the instructions involve changing the Windows registry. Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft can't guarantee that these problems can be solved. [Back up your existing registry entries](../../windows-server/performance/windows-registry-advanced-users.md#back-up-the-registry) first, and then modify the registry at your own risk.

### Increase the maximum size of the event logs

A large number of events can be generated in both the Security log and the Microsoft-Windows-PowerShell/Operational event log. To prevent the loss of these logged events, increase the maximum size of the logs. But if either of these logs are at the maximum size of 100 MB or larger (a `maxSize` value of 104,857,600 or more), leave the maximum size setting as is.

To check the log's maximum size, use the [wevtutil](/windows-server/administration/windows-commands/wevtutil) command and the `get-log` option to retrieve information about event logs:

```powershell
wevtutil get-log "Security"
wevtutil get-log "Microsoft-Windows-PowerShell/Operational"
```

You'll see output that resembles the following text. In these cases, the maximum log size is much less than 100 MB.

```console
name: Security
enabled: true
type: Admin
owningPublisher:
isolation: Custom
channelAccess: O:BAG:SYD:(A;;CCLCSDRCWDWO;;;SY)(A;;CCLC;;;BA)(A;;CC;;;ER)(A;;CC;;;NS)
logging:
  logFileName: %SystemRoot%\System32\Winevt\Logs\Security.evtx
  retention: false
  autoBackup: false
  maxSize: 20971520
publishing:
  fileMax: 1
```

```console
name: Microsoft-Windows-PowerShell/Operational
enabled: true
type: Operational
owningPublisher: Microsoft-Windows-PowerShell
isolation: Application
channelAccess: O:BAG:SYD:(A;;0x2;;;S-1-15-2-1)(A;;0x2;;;S-1-15-3-1024-3153509613-960666767-3724611135-2725662640-12138253-543910227-1950414635-4190290187)(A;;0xf0007;;;SY)(A;;0x7;;;BA)(A;;0x7;;;SO)(A;;0x3;;;IU)(A;;0x3;;;SU)(A;;0x3;;;S-1-5-3)(A;;0x3;;;S-1-5-33)(A;;0x1;;;S-1-5-32-573)
logging:
  logFileName: %SystemRoot%\System32\Winevt\Logs\Microsoft-Windows-PowerShell%4Operational.evtx
  retention: false
  autoBackup: false
  maxSize: 15728640
publishing:
  fileMax: 1
```

To increase the maximum size of the Security log or the Microsoft-Windows-PowerShell/Operational event log to 100 MB, run `wevtutil` together with the `set-log` option:

```powershell
wevtutil set-log "Security" /ms:104857600
wevtutil set-log "Microsoft-Windows-PowerShell/Operational" /ms:104857600
```

### Turn on process creation auditing

Use the [auditpol set](/windows-server/administration/windows-commands/auditpol-set) command, [New-Item](/powershell/module/microsoft.powershell.management/new-item) cmdlet, and [New-ItemProperty](/powershell/module/microsoft.powershell.management/new-itemproperty) cmdlet to turn on process creation auditing:

```powershell
auditpol /set /category:"detailed tracking" /success:enable /subcategory:"Process Creation"

$registryPath = @{
    Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Audit'
}
New-Item @registryPath

$forceDwordOne = @{
    PropertyType = 'DWord'
    Value = 1
    Force = $True
}
New-ItemProperty @registryPath -Name 'ProcessCreationIncludeCmdLine_Enabled' @forceDwordOne
```

### Turn on PowerShell transcription

```powershell
$registryPath = @{
    Path = 'HKLM:\Software\Policies\Microsoft\Windows\PowerShell\Transcription'
    Force = $True
}
New-Item @registryPath

$dwordOne = @{
    PropertyType = 'DWord'
    Value = 1
}
New-ItemProperty @registryPath -Name 'EnableTranscripting' @dwordOne
New-ItemProperty @registryPath -Name 'EnableInvocationHeader' @dwordOne
New-ItemProperty @registryPath -Name 'OutputDirectory' -PropertyType 'String' -Value 'C:\Transcripts'
```

### Turn on PowerShell module logging

```powershell
$moduleLoggingPath = @{
    Path = 'HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging'
}
New-Item @moduleLoggingPath

$forceDwordOne = @{
    PropertyType = 'DWord'
    Value = 1
    Force = $True
}
New-ItemProperty @moduleLoggingPath -Name 'EnableModuleLogging' @forceDwordOne

$moduleNamesPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging\ModuleNames'
New-Item -Path $moduleNamesPath
New-ItemProperty -Path $moduleNamesPath -Name '*' -PropertyType String -Value '*'
```

### Turn on PowerShell script block logging

```powershell
$registryPath = @{
    Path = 'HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging'
}
New-Item @registryPath

$forceDwordOne = @{
    PropertyType = 'DWord'
    Value = 1
    Force = $True
}
New-ItemProperty @registryPath -Name 'EnableScriptBlockLogging' @forceDwordOne
```

## Understand the output

The auditing of process creation will write *Event ID 4688* and *Event ID 4689* to the Security event log. Event ID 4688 is for process creation, and includes the Process Command Line. Event ID 4689 is for process termination.

Transcription creates a text file in the *C:\\Transcripts\\\<output-date>* directory. The directory will be created automatically if it doesn't already exist.

For example:

> C:\transcripts\20201211\PowerShell_transcript.\<vm-name>.a+BWp8CT.20201211034929.txt
>
> Module logging will log Event ID 4103 to the Microsoft-Windows-PowerShell/Operational event log. The "4103" event includes the cmdlet name and output.

If you run `Write-Host $Env:ComputerName`, then the top of Event ID 4013 shows the following text, where `value="<vm-name>"` indicates that the output of the command was the name of your VM:

```output
CommandInvocation(Write-Host): "Write-Host"
ParameterBinding(Write-Host): name="Object"; value="<vm-name>"
```

Script block logging will log Event ID 4104 to the **Microsoft-Windows-PowerShell/Operational** event log. The "4104" events contain the contents of the script. Scripts that exceed the maximum message size of an event are logged as multiple "4104" events.

After you turn on the logging and reproduce the script failure, run the following script to export the relevant events to a comma-separated value (CSV) file. The following query examines the previous 24 hours (86,400,000 milliseconds) of data. Enter the value *3600000* to retrieve only the most recent hour. The value *604800000* will retrieve the most recent week.

```powershell
$path = "PSEvents_$($env:COMPUTERNAME)_$(Get-Date ((Get-Date).ToUniversalTime()) -Format yyyyMMddHHmmss).csv"

$hours = 1 # Increase this to have it query more than just the last 1 hour
$now = Get-Date
$startTimeUtc = Get-Date ($now.AddHours(-$hours).ToUniversalTime()) -Format 'yyyy-MM-ddTHH:mm:ssZ'
$endTimeUtc = Get-Date ($now.ToUniversalTime()) -Format 'yyyy-MM-ddTHH:mm:ssZ'

$filterXML = @"
<QueryList>
    <Query Id="0" Path="Security">
        <Select Path="Security">
            Event
            [
                System
                [
                    (EventID = '4688' or EventID = '4689')
                    and
                    TimeCreated
                    [
                        @SystemTime &gt;= '$startTimeUtc'
                        and
                        @SystemTime &lt;= '$endTimeUtc'
                    ]
                ]
                and
                EventData
                [
                    Data[@Name="SubjectUserSid"] = "S-1-5-18"
                ]
            ]
        </Select>
    </Query>
    <Query Id="1" Path="Microsoft-Windows-PowerShell/Operational">
        <Select Path="Microsoft-Windows-PowerShell/Operational">
            Event
            [
                System
                [
                    (EventID ='4103' or EventID ='4104')
                    and
                    Security
                    [
                        @UserID ='S-1-5-18'
                    ]
                    and
                    TimeCreated
                    [
                        @SystemTime &gt;= '$startTimeUtc'
                        and
                        @SystemTime &lt;= '$endTimeUtc'
                    ]
                ]
            ]
        </Select>
    </Query>
</QueryList>
"@

$events = Get-WinEvent -FilterXml $filterXML | Sort-Object -Property RecordId
$events = $events | Select-Object -Property RecordId,
    TimeCreated, Id, MachineName, LogName, TaskDisplayName, Message
$events | Export-Csv -Path $path -NoTypeInformation
```

## Turn off logging of PowerShell script execution

To undo the changes that you made to enable the logging of PowerShell scripting on your VM, take the following steps:

1. If you previously increased the maximum size of the Security log or the Microsoft-Windows-PowerShell/Operational log, revert those values to the default maximum sizes:

    ```powershell
    wevtutil set-log "Security" /ms:20971520
    wevtutil set-log "Microsoft-Windows-PowerShell/Operational" /ms:15728640
    ```

1. Turn off process creation auditing:

    ```powershell
    auditpol /set /category:"detailed tracking" /success:disable /subcategory:"Process Creation"
    $commandSettings = @{
        Path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Audit'
        Name = 'ProcessCreationIncludeCmdLine_Enabled'
        PropertyType = 'DWord'
        Value = 0
        Force = $True
    }
    New-ItemProperty @commandSettings
    ```

1. Turn off transcription:

    ```powershell
    $registryPath = @{
        Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription'
    }
    $forceDwordZero = @{
        PropertyType = 'DWord'
        Value = 0
        Force = $True
    }
    New-ItemProperty @registryPath -Name 'EnableTranscripting' @forceDwordZero
    New-ItemProperty @registryPath -Name 'EnableInvocationHeader' @forceDwordZero
    Remove-ItemProperty @registryPath -Name 'OutputDirectory'
    ```

1. Turn off module logging:

    ```powershell
    $moduleLoggingPath = @{
        Path = 'HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging'
    }
    $forceDwordZero = @{
        PropertyType = 'DWord'
        Value = 0
        Force = $True
    }
    New-ItemProperty @moduleLoggingPath -Name 'EnableModuleLogging' @forceDwordZero

    $moduleNamesPath = @{
        Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging\ModuleNames'
    }
    Remove-ItemProperty @moduleNamesPath -Name '*'
    ```

1. Turn off script block logging:

    ```powershell
    $registryPath = @{
        Path = 'HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging'
    }
    $forceDwordZero = @{
        PropertyType = 'DWord'
        Value = 0
        Force = $True
    }
    New-ItemProperty @registryPath -Name 'EnableScriptBlockLogging' @forceDwordZero
    ```

1. Remove the transcription folder:

    ```powershell
    Remove-Item -Path 'C:\Transcripts' -Force -Recurse
    ```

1. Either back up and clear the Security log and the Microsoft-Windows-PowerShell/Operational log:

    ```powershell
    wevtutil clear-log Security /bu:Security.evtx
    wevtutil clear-log Microsoft-Windows-PowerShell/Operational /bu:Microsoft-Windows-PowerShell_Operational.evtx
    ```

    Or clear the Security log and the Microsoft-Windows-PowerShell/Operational log without backing them up:

    ```powershell
    wevtutil clear-log Security
    wevtutil clear-log Microsoft-Windows-PowerShell/Operational
    ```

## Test Run Command logging on your VM

Download the [Test-CustomScriptExtension.ps1](https://github.com/Azure/azure-support-scripts/blob/master/Images_Extensions/PowerShell/Test-CustomScriptExtension.ps1) test script to the current local directory. Then, run the script on your VM by using the [Invoke-AzVMRunCommand](/powershell/module/az.compute/invoke-azvmruncommand) cmdlet. Use the properties of your VM to replace the placeholders for the resource group name and VM name.

```azurepowershell
$scriptUri = 'https://raw.githubusercontent.com/Azure/azure-support-scripts/master/Images_Extensions/PowerShell/Test-CustomScriptExtension.ps1'
$localFileLocation = "$PWD\Test-CustomScriptExtension.ps1"
(New-Object System.Net.WebClient).DownloadFile($scriptUri, $localFileLocation)

$commandSettings = @{
    ResourceGroupName = '<resource-group-name>'
    VMName = '<vm-name>'
    CommandId = 'RunPowerShellScript'
    ScriptPath = $localFileLocation
}
Invoke-AzVMRunCommand @commandSettings
```

## Test Custom Script Extension logging on your VM

Run the test script [Test-CustomScriptExtension.ps1](https://github.com/Azure/azure-support-scripts/blob/master/Images_Extensions/PowerShell/Test-CustomScriptExtension.ps1) on your VM by using the [Set-AzVMCustomScriptExtension](/powershell/module/az.compute/set-azvmcustomscriptextension) cmdlet. Use the properties of your VM to replace the placeholders for the resource group name, VM name, and location.

```azurepowershell
$commandSettings = @{
    ResourceGroupName = '<resource-group-name>'
    VMName = '<vm-name>'
    Name = 'CustomScriptExtension'
    FileUri = 'https://raw.githubusercontent.com/Azure/azure-support-scripts/master/Images_Extensions/PowerShell/Test-CustomScriptExtension.ps1'
    Run = 'Test-CustomScriptExtension.ps1'
    Location = '<azure-region-name-or-code>'
    ForceRerun = (Get-Date).Ticks
}
Set-AzVMCustomScriptExtension @commandSettings
```

Alternatively, you can run that test script on your VM by using the [Set-AzVMExtension](/powershell/module/az.compute/set-azvmextension) cmdlet. You'll have to specify an `ExtensionType` parameter of `CustomScriptExtension` together with several other parameter changes. Use the properties of your VM to replace the placeholders for the resource group name, VM name, and location.

```azurepowershell
$publicConfigSettings = @{
    'fileUris' = @('https://raw.githubusercontent.com/Azure/azure-support-scripts/master/Images_Extensions/PowerShell/Test-CustomScriptExtension.ps1')
    'commandToExecute' = 'powershell -File Test-CustomScriptExtension.ps1 -ExecutionPolicy Unrestricted'
}
$commandSettings = @{
    Publisher = 'Microsoft.Compute'
    ExtensionType = 'CustomScriptExtension'
    Settings = $publicConfigSettings
    ResourceGroupName = '<resource-group-name>'
    VMName = '<vm-name>'
    Name = 'CustomScriptExtension'
    TypeHandlerVersion = '1.10'
    Location = '<azure-region-name-or-code>'
}
Set-AzVMExtension @commandSettings
```

## Common errors in the Custom Script Extension test script

- **Nonzero exit code**: After you run the *Test-CustomScriptExtension.ps1* script, expect to receive the following error message:

  > Long running operation failed with status 'Failed'.  
  > Additional Info: VM has reported a failure when processing extension 'CustomScriptExtension'.  
  > Error message: "Command execution finished, but failed because it returned a non-zero exit code of: '2'"

  The test script runs the `Exit 2` command, and the Custom Script Extension is expected to fail by design if the script returns a nonzero exit code. (In this example, 2 is the nonzero exit code.) This example shows you how a failure appears in the extra PowerShell logging that you've enabled.

- **Change is in conflict**: This error indicates that the VM already has the Custom Script Extension installed as resource name **Microsoft.Compute.CustomScriptExtension**, but you're specifying a different resource name of **CustomScriptExtension** for your current execution:

  > Cannot update handlerVersion or autoUpgradeMinorVersion for VM extension 'CustomScriptExtension'.  
  > Change is in conflict with other extensions under handler 'Microsoft.Compute.CustomScriptExtension', with typeHandler version '1.10' and autoUpgradeMinorVersion 'True'.  
  > ErrorCode: OperationNotAllowed  
  > ErrorMessage: Cannot update handlerVersion or autoUpgradeMinorVersion for VM extension 'CustomScriptExtension'.  
  > Change is in conflict with other extensions under handler 'Microsoft.Compute.CustomScriptExtension', with typeHandler version '1.10' and autoUpgradeMinorVersion 'True'.  
  > ErrorTarget:  
  > StatusCode: 409  
  > ReasonPhrase: Conflict

  You can specify whatever you want for the resource name. However, if you already have the Custom Script Extension installed, you must take either of the following actions:

  - Use the same name for subsequent executions.
  - First remove that extension resource before you use a different resource name.

- **Invalid file URI configuration**: This error indicates that the Custom Script Extension was originally installed together with file URIs that are specified in protected settings, but now are specified in public settings (or vice-versa):

  > Long running operation failed with status 'Failed'.  
  > Additional Info: VM has reported a failure when processing extension 'CustomScriptExtension'.  
  > Error message: "Invalid Configuration - FileUris is present in both the protected and public configuration sections; it must be specified in only one section."

## Solutions to common errors in the Custom Script Extension test script

- To fix the "Change is in conflict" error, try to rerun `Set-AzVMCustomScriptExtension` or `Set-AzVMExtension`, but set the `-Name` parameter to the resource name of the Custom Script Extension resource that's already installed on the VM. For the sample error, when you remove the extension, specify a `-Name` parameter of *Microsoft.Compute.CustomScriptExtension*. But the `-Name` parameter has to be whatever the resource name is for the extension resource that's already installed on the VM.

  The name to use for `-Name` will be the resource name in this part of the error: "Change is in conflict with other extensions under handler '\<resource-name>'."

  You can also verify the correct resource name to use by getting it from the VM status. Enter the [Get-AzVM](/powershell/module/az.compute/get-azvm) cmdlet, as follows:

  ```azurepowershell
  $status = Get-AzVM -ResourceGroupName <resource-group> -Name <vm-name> -Status
  $status.Extensions |
  Where-Object Type -EQ 'Microsoft.Compute.CustomScriptExtension' |
  Select-Object Name
  ```

- To mitigate the "Change is in conflict" error and the "FileUris" error, you can remove the existing Custom Script Extension by entering the [Remove-AzVMCustomScriptExtension](/powershell/module/az.compute/remove-azvmcustomscriptextension) cmdlet:

  ```azurepowershell
  $params = @{
      ResourceGroupName = '<resourceGroupName>'
      VMName = '<vm-name>'
      Name = '<extension-resource-name>'
      Force = $True
  }
  Remove-AzVMCustomScriptExtension @params
  ```

  If you specify the incorrect resource name, the returned `StatusCode` value is `NoContent`:

  ```output
  RequestId IsSuccessStatusCode StatusCode ReasonPhrase
  --------- ------------------- ---------- ------------
                           True  NoContent No Content
  ```

  If you specify the correct resource name, the returned `StatusCode` value is `OK`:

  ```output
  RequestId IsSuccessStatusCode StatusCode ReasonPhrase
  --------- ------------------- ---------- ------------
                           True         OK OK
  ```

## References

- [Troubleshooting Azure Windows VM extension failures](/azure/virtual-machines/extensions/troubleshoot)
- [Script tracing and logging](/powershell/scripting/windows-powershell/wmf/whats-new/script-logging)
- [Well-known security identifiers in Windows operating systems](/windows/security/identity-protection/access-control/security-identifiers#well-known-sids)
- [Windows logging](https://materials.rangeforce.com/tutorial/2020/03/03/Windows-Logging/)
- [Audit success process creation event](https://github.com/timip/splunk/blob/master/powershell_logging.ps1)
- [Windows configuration - Set up a victim system](https://github.com/TonyPhipps/SIEM/blob/master/Lab/WindowsVictim.md)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

[!INCLUDE [Third-party disclaimer](../../includes/third-party-contact-disclaimer.md)]
