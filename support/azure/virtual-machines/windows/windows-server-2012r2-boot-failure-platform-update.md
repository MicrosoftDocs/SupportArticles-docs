---
title: Windows Server 2012 R2 boot failure after Azure platform update (INACCESSIBLE_BOOT_DEVICE)
description: Provides a workaround for a Windows Server 2012 R2 VM that doesn't start after an Azure platform update with error INACCESSIBLE_BOOT_DEVICE.
ms.date: 04/09/2026
ms.reviewer: scotro, azurevmcptcic
ms.service: azure-virtual-machines
ms.collection: windows
ms.custom: sap:My VM is not booting
---

# Windows Server 2012 R2 boot failure after Azure platform update

**Applies to:** :heavy_check_mark: Windows VMs

This article provides a workaround for an issue where a Windows Server 2012 R2 virtual machine (VM) doesn't start after an Azure platform update and generates an INACCESSIBLE_BOOT_DEVICE error.

## Symptoms

A Windows Server 2012 R2 VM that was previously running without issues fails to boot after an Azure host platform update. When you use [Boot diagnostics](/azure/virtual-machines/boot-diagnostics) to view the screenshot of the VM, you see one of the following screens:

**Symptom 1:** The VM is stuck on the Hyper-V splash screen.

:::image type="content" source="media/windows-server-2012r2-boot-failure-platform-update/woa-hyper-v-splash.png" alt-text="Screenshot of the VM stuck on the Hyper-V splash screen.":::

**Symptom 2:** The VM displays the INACCESSIBLE_BOOT_DEVICE stop error (blue screen).

:::image type="content" source="media/windows-server-2012r2-boot-failure-platform-update/woa-inaccessible-boot-device.png" alt-text="Screenshot of the INACCESSIBLE_BOOT_DEVICE blue screen error.":::

**Symptom 3:** The VM boots into the Windows Recovery Environment instead of the normal Windows desktop.

:::image type="content" source="media/windows-server-2012r2-boot-failure-platform-update/woa-windows-recovery-environment.png" alt-text="Screenshot of the Windows Recovery Environment screen.":::

> [!NOTE]
> The VM works correctly in an on-premises or nested Hyper-V environment. The issue occurs only on Azure.

## Cause

Recent Azure Hyper-V host updates changed how virtual hardware (ACPI/VMBus devices) is presented to guest operating systems. Specifically, certain Hyper-V ACPI device identifiers were updated on the host side:

- `ACPI\VMBus` was updated to `ACPI\MSFT1000`
- `ACPI\Hyper_V_Gen_Counter_V1` was updated to `ACPI\MSFT1002`

Windows Server 2012 R2 is no longer in Extended Support and its boot-time storage stack can't adapt to these newer ACPI device identifiers. During early boot, the operating system fails to bind the storage driver correctly, which causes the INACCESSIBLE_BOOT_DEVICE error.

This issue affects only legacy guest operating systems (Windows Server 2012 and Windows Server 2012 R2). Newer supported guest OS versions (Windows Server 2016 and later) aren't affected.

## Workaround

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

> [!IMPORTANT]
> This workaround is a temporary mitigation. Future Azure host updates might reintroduce the issue. The only permanent resolution is to [upgrade to a supported Windows Server version](#permanent-resolution).

To resolve this issue, use a repair VM to apply an offline registry fix that maps the legacy ACPI device identifiers to the updated ones.

### Step 1: Create a repair VM and attach the OS disk

1. Use steps 1-3 of the [VM Repair Commands](/azure/virtual-machines/troubleshooting/repair-windows-vm-using-azure-virtual-machine-repair-commands) to prepare a repair VM.
2. Take a snapshot of the affected VM's OS disk before proceeding.
3. Attach the OS disk as a data disk to the repair VM.
4. Connect to the repair VM by using Remote Desktop Connection.
5. Note the drive letter assigned to the attached OS disk (for example, **F:**).

### Step 2: Apply the registry fix

Open an elevated command prompt on the repair VM and run the following commands. Replace **F:** with the drive letter of the attached OS disk.

```cmd
reg load HKLM\TempHive F:\Windows\System32\Config\SYSTEM
reg copy "HKLM\TempHive\ControlSet001\Enum\ACPI\VMBus" "HKLM\TempHive\ControlSet001\Enum\ACPI\MSFT1000" /s
reg copy "HKLM\TempHive\ControlSet001\Enum\ACPI\Hyper_V_Gen_Counter_V1" "HKLM\TempHive\ControlSet001\Enum\ACPI\MSFT1002" /s
reg unload HKLM\TempHive
```

This copies the legacy ACPI device enumerations to the new identifiers that the updated Azure host expects.

If you receive an **"Access is denied"** error during the registry copy, follow the steps in [Step 2 (alternative): Run the fix as SYSTEM](#step-2-alternative-run-the-fix-as-system).

### Step 2 (alternative): Run the fix as SYSTEM

The `Enum` registry keys under HKLM\SYSTEM are protected and owned by NT AUTHORITY\SYSTEM. If the direct registry copy returns "Access is denied," use the following approach:

1. On the repair VM, create a script file at **C:\acpi_fix.cmd** with the following content. Replace **F:** with the drive letter of the attached OS disk:

    ```cmd
    @echo off
    setlocal
    set "OS=F:"
    rem Load offline SYSTEM hive from attached OS disk
    reg load HKLM\TempHive "%OS%\Windows\System32\Config\SYSTEM" || goto :err
    rem Detect active ControlSet from Select\Current
    for /f "tokens=3" %%A in ('reg query HKLM\TempHive\Select /v Current ^| find /i "Current"') do set CUR=%%A
    set "CS=ControlSet001"
    if /i "%CUR%"=="0x2" set "CS=ControlSet002"
    if /i "%CUR%"=="0x3" set "CS=ControlSet003"
    if /i "%CUR%"=="0x4" set "CS=ControlSet004"
    echo Using %CS% (Current=%CUR%)
    rem Recreate destination keys
    reg delete "HKLM\TempHive\%CS%\Enum\ACPI\MSFT1000" /f >nul 2>&1
    reg delete "HKLM\TempHive\%CS%\Enum\ACPI\MSFT1002" /f >nul 2>&1
    reg add "HKLM\TempHive\%CS%\Enum\ACPI\MSFT1000" /f
    reg add "HKLM\TempHive\%CS%\Enum\ACPI\MSFT1002" /f
    rem Copy legacy identifiers to updated Hyper-V/Azure identifiers
    reg copy "HKLM\TempHive\%CS%\Enum\ACPI\VMBus" "HKLM\TempHive\%CS%\Enum\ACPI\MSFT1000" /s /f
    reg copy "HKLM\TempHive\%CS%\Enum\ACPI\Hyper_V_Gen_Counter_V1" "HKLM\TempHive\%CS%\Enum\ACPI\MSFT1002" /s /f
    rem Unload hive
    reg unload HKLM\TempHive
    echo Done
    exit /b 0
    :err
    echo Failed to load offline hive. Verify %OS%\Windows\System32\Config\SYSTEM exists.
    exit /b 1
    ```

2. Verify that the offline Windows path exists:

    ```cmd
    dir F:\Windows\System32\Config\SYSTEM
    ```

3. Create a scheduled task to run the script as SYSTEM:

    ```cmd
    schtasks /create /tn ACPI_FIX /sc ONCE /st 23:59 /ru SYSTEM /rl HIGHEST /tr "cmd.exe /c \"C:\acpi_fix.cmd\" > C:\acpi_fix_out.txt 2>&1" /f
    schtasks /run /tn ACPI_FIX
    ```

4. Validate the output:

    ```cmd
    type C:\acpi_fix_out.txt
    ```

5. Clean up the scheduled task:

    ```cmd
    schtasks /delete /tn ACPI_FIX /f
    ```

### Step 3: Rebuild the VM

1. Detach the OS disk from the repair VM.
2. Attach the disk back to the original VM as the OS disk.
3. Start the VM.

## Permanent resolution

Windows Server 2012 R2 exited Extended Support on October 10, 2023. Extended Security Updates (ESU), which may be active for your server, provide security patches only until October 13, 2026. ESU doesn't include bug fixes, compatibility updates, or platform behavior changes. Microsoft doesn't plan to release a permanent OS-level fix for this compatibility issue.

The only supported and permanent resolution is to upgrade or migrate the workload to a supported Windows Server version (Windows Server 2019 or later). Upgrading the guest OS fully resolves the compatibility issue and restores platform support, stability, and future update reliability.

For more information about upgrading, see [Upgrade Windows Server](/windows-server/get-started/perform-in-place-upgrade).

## More information

- [Troubleshoot Azure VM boot errors](boot-error-troubleshoot.md)
- [Windows boot error INACCESSIBLE_BOOT_DEVICE in an Azure VM](windows-boot-failure.md)
- [Boot diagnostics for Azure virtual machines](/azure/virtual-machines/boot-diagnostics)
- [Windows Server end of support and Extended Security Updates](/windows-server/get-started/extended-security-updates-overview)
