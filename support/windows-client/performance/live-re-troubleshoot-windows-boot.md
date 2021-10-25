---
title: Advanced troubleshooting Windows boot problems with LiveRE tool
description: Learn to troubleshoot by using the LiveRE tool when Windows does't start.
author: Deland-Han
ms.author: delhan
ms.reviewer: visohra, kaushika
manager: dcscontentpm
audience: itpro
ms.prod: windows-client
ms.technology: windows-client-performance
ms.custom: sap:no-boot-not-bugchecks, csstroubleshoot
ms.topic: troubleshooting
ms.date: 10/30/2021
ms.localizationpriority: medium
---
# Use LiveRE to troubleshoot Windows startup problems

The LiveRE tool creates an image that can be used to start a computer through a USB connection. This tool is helpful in troubleshooting "no boot" issues. It can also be used to provide remote access for support professionals to a non-starting computer through a jump server.

> [!NOTE]
> This article is intended for use by support agents and IT professionals.

## LiveRE to WinRE comparison

Here is a comparison of Live RE to the existing Windows Recovery Environment that's included with Windows ISOs.

| Feature | WinRE/WinPE | iDRAC/ILO | Live operating system (OS) |
|---------|-------------|-----------|--------|
| Availability | With DVD | Special hardware | Flash-drive |
| Remote Access | No | Yes | Yes |
| DISM | Yes | Via WinRE | Yes with capability to download missing payloads from internet |
| DiskPart | Yes | Via WinRE | No, but PowerShell equivalent works |
| BitLocker | Yes | Via WinRE | Yes |
| Copy/Paste to allow reduced research and log recording   | No | No | Yes |
| Invoke PowerShell scripts | No | No | Yes |
| Access to Shadow copies | No | No | Yes |

## System requirements

- Processor: 1.4Ghz 64-bit processor
- RAM: 512 MB
- Disk Space: 32 GB
- Network: Gigabit (10/100/1000baseT) Ethernet adapter (1Gbps connection is ideal)
- Optical Storage: DVD drive (if installing the OS from DVD media)
- USB 3.0 flash drive, 8 GB or greater
- Video: Super VGA (1024x768) or higher resolution (optional)
- Input Devices: Keyboard and mouse (optional)
- Internet: Broadband access (optional)

## Set up the USB flash drive

1. Download the [LiveRE image](https://download.microsoft.com/download/7/e/b/7ebcc4f5-e67f-45b1-b00f-48870d9350a5/LiveRE.wim).
2. Connect a USB flash drive.
3. Check whether the non-booting computer is set up for BIOS boot or UEFI boot. Format the USB drive accordingly:

   - For UEFI:

     ```console
     Diskpart
     List disk
     Sel disk <the number of the flash drive>
     Clean
     Convert gpt
     Create part pri
     Exit
     ```

     Format the partition for the FAT32 file system.

   - For MBR boot:

     ```console
     Diskpart
     List disk
     Sel disk <the number of the flash drive>
     Clean
     Convert mbr
     Create part pri
     List part
     Sel part 1
     active
     Exit
     ```

     Format the partition for the NTFS file system.

4. Run the following commands:

   ```console
   dism /Apply-Image /ImageFile:<complete path of the LiveOS.wim> /Index:1 /ApplyDir:<flash drive letter>:\
   <flash drive letter>:\Windows\System32\bcdboot <flash drive letter>:\Windows /s <flash drive letter>: /f ALL
   ```

After the USB flash drive is ready, start the affected server from the flash drive.

## Create user account for remote access

The following steps help create a user to enable remote access through a jump server:

1. Start the non-booting computer by using the USB flash drive. Accept the EULA to proceed to the Help console.
2. Press Enter to access PowerShell.
3. Run the following cmdlets:

   ```powershell
   $Password = Read-Host -AsSecureString
   
   New-LocalUser "user_name" -Password $Password
   Add-LocalGroupMember -Group "Administrators" -Member "user_name"
   ```

   > [!NOTE]
   > Enter Password after the first cmdlet.

The computer is now set up for remote access through a jump server. The following screenshot shows a sample setup.

:::image type="content" source="./media/live-re-troubleshoot-windows-boot/live-re-input-add-user.png" alt-text="Run cmdlet in LiveRE":::

## Connect from the jump server

1. Get the IP address from the LiveRE screen.

   :::image type="content" source="./media/live-re-troubleshoot-windows-boot/get-ip-address-from-live-re.png" alt-text="Get IP address":::

2. On a working computer in the same network as the nonstarting computer, open PowerShell ISE, and run the following script:

   ```powershell
   $ip = "172.25.80.68"
   Set-Item WSMan:\localhost\Client\TrustedHosts $ip
   $user = "$ip\user_name"  
   Enter-PSSession -ComputerName $ip -Credential $user
   ```

3. When prompted, enter the password.
4. You will be connected to the broken computer through WinRM.

   :::image type="content" source="./media/live-re-troubleshoot-windows-boot/connect-to-broken-computer-using-winrm.png" alt-text="Connect via WinRM":::

If you experience issues when you connect through WinRM, check whether WinRM is enabled. If it isn't, run the `winrm qc` command to enable WinRM. 

If you receive an error message that reassembles the following, this means the network connections is set to **Public**.

:::image type="content" source="./media/live-re-troubleshoot-windows-boot/run-winrm-qc-error-0x80338169.png" alt-text="0x80338169 error when enabling WinRM":::

You can find which one using the following command:
  
```powershell
Get-NetConnectionProfile | select InterfaceAlias, NetworkCategory
```

The following is a sample output:

:::image type="content" source="./media/live-re-troubleshoot-windows-boot/get-netconnectionprofile-output.png" alt-text="Output of Get-NetConnectionProfile cmdlet":::

You can either disable the ones that are showing public or change them to private after taking permission from customer. To do so, use this command:

```powershell
Set-NetConnectionProfile -interfacealias "vEthernet (Internal LAN)" -NetworkCategory Private
```

## Unlock BitLocker drives from LiveRE

1. Run `Get-Volume` to find the drive letter:

   :::image type="content" source="./media/live-re-troubleshoot-windows-boot/run-get-volume-to-find-drive-letter.png" alt-text="Get-Volume to find drive letter":::

2. Run the following command:

   ```powershell
   Unlock-BitLocker -MountPoint <drive letter> -RecoveryPassword <recovery password>
   ```

## Disk configuration

Since *Diskpart.exe* is not available in the LiveRE, use PowerShell to achieve similar results. Here are a few commands:

1. Check Disk: `Get-Disk`.
2. Check partitions in a disk: `Get-Partition -DiskNumber <number>`.
3. Set a partition to active: `Set-Partition -DiskNumber <number> -PartitionNumber <number> -IsActive $true`.
4. Check properties of a partition: `Get-Partition -DiskNumber <number> -PartitionNumber <number> |fl`.

For more information, see [Windows Storage Management-specific cmdlets](/powershell/module/storage/)

## Registry configuration

There is no registry editor is Live OS. In order to change the registry, access the share for affected OS drive by using the *\\\\\<IP Address\>\\c$* path.

Get the hives from *\\windows\\system32\\config*, make the changes to the hives, and then proceed with further steps.

## Access shadow copies

LiveRE allows access to shadow copies from disks of a machine which is not booting, this can be used to replace previous versions of files.

You can use the following steps to access previous versions of the files:

```powershell
Get-CimInstance -ClassName Win32_ShadowCopy | select volumename,ID,InstallDate,DeviceObject
Get-Volume | select Driveletter,path to get the volume name association with Volume ID
```

> [!NOTE]
> The OS date and time has to be adjusted as per time zone to get the correct date and time, LiveOS uses Greenwich Mean Time (GMT) zone.

Copy the DeviceObject for the shadow copy you want to access, and then run these commands:

```console
$sobj="<DeviceObject>" + "\"
cmd /c mklink /d c:\shadowcopy "$sobj"
```

You can now access the previous versions of the file from PowerShell by browsing to *\\\\\<IP\>\\c$\\shadowcopy*.

## Injecting Drivers

If you have a Redundant Array of Independent Disk (RAID) disk setup, we need to install RAID drivers from Original Equipment Manufacturer (OEM) to make the volumes visible to OS.

In LiveRE, you can just extract the RAID drivers to the folder *\<USB\>:\\\<driver folder\>* folder.

Then, when you are booted in LiveRE, press the 4 key to install the drivers.

Another way to install drivers is:

1. Download and extract the drivers in a folder in the LiveRE flash drive.
2. Once connected to affected machine, run the command:

   ```powershell
   pnputil /add-driver <location of raid driver.inf>
   
   Add-WindowsDriver -Path <flash drive letter>:\ -Driver <path of driver folder> -Recurse
   ```
