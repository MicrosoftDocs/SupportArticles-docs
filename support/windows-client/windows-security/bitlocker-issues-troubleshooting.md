---
title: BitLocker issues troubleshooting
description: Describes approaches for investigating BitLocker issues, including how to gather diagnostic information.
ms.date: 11/21/2022
ms.subservice: windows-security
ms.service: windows-client
manager: dcscontentpm
ms.collection: Windows Security Technologies\BitLocker
ms.topic: troubleshooting
ms.custom: sap:bitlocker, csstroubleshoot
ms.reviewer: kaushika, v-tappelgate
audience: itpro
localization_priority: medium
---
# Guidelines for troubleshooting BitLocker

This article addresses common issues in BitLocker and provides guidelines to troubleshoot these issues. This article also provides information such as what data to collect and what settings to check. This information makes the troubleshooting process much easier.

## Review the event logs

Open **Event Viewer** and review the following logs under **Applications and Services Logs** > **Microsoft** > **Windows**:

- **BitLocker-API**. Review the **Management** log, the **Operational** log, and any other logs that are generated in this folder. The default logs have the following unique names:

  - **Microsoft-Windows-BitLocker-API/Management**
  - **Microsoft-Windows-BitLocker-API/Operational**
  - **Microsoft-Windows-BitLocker-API/Tracing** - only displayed when **Show Analytic and Debug Logs** is enabled

- **BitLocker-DrivePreparationTool**. Review the **Admin** log,  the **Operational** log, and any other logs that are generated in this folder. The default logs have the following unique names:

  - **Microsoft-Windows-BitLocker-DrivePreparationTool/Admin**
  - **Microsoft-Windows-BitLocker-DrivePreparationTool/Operational**

Additionally, review the **Windows Logs** > **System** log for events that were produced by the TPM and TPM-WMI event sources.

To filter and display or export logs, the [wevtutil.exe](/windows-server/administration/windows-commands/wevtutil) command-line tool or the [Get-WinEvent](/powershell/module/microsoft.powershell.diagnostics/get-winevent?view=powershell-6&preserve-view=true) PowerShell cmdlet can be used.

For example, to use *wevtutil.exe* to export the contents of the operational log from the BitLocker-API folder to a text file that is named *BitLockerAPIOpsLog.txt*, open a Command Prompt window, and run the following command:

```cmd
wevtutil.exe qe "Microsoft-Windows-BitLocker/BitLocker Operational" /f:text > BitLockerAPIOpsLog.txt
```

To use the **Get-WinEvent** cmdlet to export the same log to a comma-separated text file, open a Windows PowerShell window and run the following command:

```powershell
Get-WinEvent -logname "Microsoft-Windows-BitLocker/BitLocker Operational"  | Export-Csv -Path Bitlocker-Operational.csv
```

The Get-WinEvent can be used in an elevated PowerShell window to display filtered information from the system or application log by using the following syntax:

- To display BitLocker-related information:

   ```powershell
   Get-WinEvent -FilterHashtable @{LogName='System'} | Where-Object -Property Message -Match 'BitLocker' | fl
   ```

   The output of such a command resembles the following:

   ![Screenshot of output that is produced by using Get-WinEvent and a BitLocker filter.](media/bitlocker-issues-troubleshooting/psget-winevent-bitlocker.png)

- To export BitLocker-related information:

   ```powershell
   Get-WinEvent -FilterHashtable @{LogName='System'} | Where-Object -Property Message -Match 'BitLocker' | Export-Csv -Path System-BitLocker.csv
   ```

- To display TPM-related information:

   ```powershell
   Get-WinEvent -FilterHashtable @{LogName='System'} | Where-Object -Property Message -Match 'TPM' | fl
   ```

- To export TPM-related information:

   ```powershell
   Get-WinEvent -FilterHashtable @{LogName='System'} | Where-Object -Property Message -Match 'TPM' | Export-Csv -Path System-TPM.csv
   ```

   The output of such a command resembles the following.

   ![Screenshot of output that is produced by using Get-WinEvent and a TPM filter.](media/bitlocker-issues-troubleshooting/psget-winevent-tpm.png)

> [!NOTE]
> When contacting Microsoft Support, it is recommended to export the logs listed in this section.

## Gather status information from the BitLocker technologies

Open an elevated Windows PowerShell window, and run each of the following commands:

|Command |Notes | More Info |
| --- | --- | --- |
|**`Get-Tpm > C:\TPM.txt`** |PowerShell cmdlet that exports information about the local computer's Trusted Platform Module (TPM). This cmdlet shows different values depending on whether the TPM chip is version 1.2 or 2.0. This cmdlet isn't supported in Windows 7. | [Get-Tpm](/powershell/module/trustedplatformmodule/get-tpm)|
|**`manage-bde.exe -status > C:\BDEStatus.txt`** |Exports information about the general encryption status of all drives on the computer. | [manage-bde.exe status](/windows-server/administration/windows-commands/manage-bde-status) |
|**`manage-bde.exe c: -protectors -get > C:\Protectors`** |Exports information about the protection methods that are used for the BitLocker encryption key.  | [manage-bde.exe protectors](/windows-server/administration/windows-commands/manage-bde-protectors)|
|**`reagentc.exe /info > C:\reagent.txt`** |Exports information about an online or offline image about the current status of the Windows Recovery Environment (WindowsRE) and any available recovery image. | [reagentc.exe](/windows-hardware/manufacture/desktop/reagentc-command-line-options) |
|**`Get-BitLockerVolume \| fl`** |PowerShell cmdlet that gets information about volumes that BitLocker Drive Encryption can protect. | [Get-BitLockerVolume](/powershell/module/bitlocker/get-bitlockervolume) |

## Review the configuration information

1. Open an elevated Command Prompt window, and run the following commands:

   |Command |Notes | More Info |
   | --- | --- | --- |
   |**`gpresult.exe /h <Filename>`** |Exports the Resultant Set of Policy information, and saves the information as an HTML file. | [gpresult.exe](/windows-server/administration/windows-commands/gpresult) |
   |**`msinfo.exe /report <Path> /computer <ComputerName>`** |Exports comprehensive information about the hardware, system components, and software environment on the local computer. The **/report** option saves the information as a .txt file. |[msinfo.exe](/windows-server/administration/windows-commands/msinfo32) |

2. Open Registry Editor, and export the entries in the following subkeys:

   - **`HKLM\SOFTWARE\Policies\Microsoft\FVE`**
   - **`HKLM\SYSTEM\CurrentControlSet\Services\TPM\`**

## Check the BitLocker prerequisites

Common settings that can cause issues for BitLocker include the following scenarios:

- The TPM must be unlocked. Check the output of the *get-tpm* PowerShell cmdlet command for the status of the TPM.

- Windows RE must be enabled. Check the output of the *reagentc.exe* command for the status of WindowsRE.

- The system-reserved partition must use the correct format.

  - On Unified Extensible Firmware Interface (UEFI) computers, the system-reserved partition must be formatted as FAT32.
  - On legacy computers, the system-reserved partition must be formatted as NTFS.

- If the device being troubleshot is a slate or tablet PC, use <https://gpsearch.azurewebsites.net/#8153> to verify the status of the **Enable use of BitLocker authentication requiring preboot keyboard input on slates** option.

For more information about the BitLocker prerequisites, see [BitLocker basic deployment: Using BitLocker to encrypt volumes](/windows/security/information-protection/bitlocker/bitlocker-basic-deployment#using-bitlocker-to-encrypt-volumes)

## Next steps

If the information examined so far indicates a specific issue (for example, WindowsRE isn't enabled), the issue may have a straightforward fix.

Resolving issues that don't have obvious causes depends on exactly which components are involved and what behavior is being see. The gathered information helps narrow down the areas to investigate.

- If the device being troubleshot is managed by Microsoft Intune, see [Enforcing BitLocker policies by using Intune: known issues](enforcing-bitlocker-policies-by-using-intune-known-issues.md).

- If BitLocker doesn't start or can't encrypt a drive and errors or events that are related to the TPM are occurring, see [BitLocker cannot encrypt a drive: known TPM issues](bitlocker-cannot-encrypt-a-drive-known-tpm-issues.md).

- If BitLocker doesn't start or can't encrypt a drive, see [BitLocker cannot encrypt a drive: known issues](bitlocker-cannot-encrypt-a-drive-known-issues.md).

- If BitLocker Network Unlock doesn't behave as expected, see [BitLocker Network Unlock: known issues](bitlocker-network-unlock-known-issues.md).

- If BitLocker doesn't behave as expected when an encrypted drive is recovered, or if BitLocker unexpectedly recovered a drive, see [BitLocker recovery: known issues](bitlocker-recovery-known-issues.md).

- If BitLocker or the encrypted drive doesn't behave as expected, and errors or events that are related to the TPM are occurring, see [BitLocker and TPM: other known issues](bitlocker-and-tpm-other-known-issues.md).

- If BitLocker or the encrypted drive doesn't behave as expected, see [BitLocker configuration: known issues](bitlocker-configuration-known-issues.md).

It's recommended to keep the gathered information handy in case Microsoft Support is contacted for help with resolving the issue.
