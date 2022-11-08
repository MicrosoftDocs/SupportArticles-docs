---
title: Azure Virtual Machine - Network Store Interface service is not starting
description: Troubleshoot Network Store Interface service not starting
ms.date: 12/20/2021
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-cannot-connect
ms.collection: windows
---

# Azure Virtual Machine - Network Store Interface (NSI) service is not starting

## Symptoms

1. The virtual machine (VM) screenshot shows the operating system (OS) fully loaded and waiting for credentials.

   :::image type="content" source="media/azure-vm-nsi-not-starting/1-waiting.png" alt-text="Screenshot of the V M screen, which shows the OS fully loaded and waiting for credentials.":::

2. If you view the Guest OS Logs, you'll see that the core networking service, **Network Store Interface (NSI)**, is not starting or failing to start. This issue could be due to a hang, a crash of this service, or any required service to be run before it.

   ```cmd
      Log Name:      System
      Source:        Service Control Manager
      Date:          12/16/2015 11:19:36 AM
      Event ID:      7022
      Task Category: None
      Level:         Error
      Keywords:      Classic
      User:          N/A
      Computer:      myvm.contoso.net
      Description:
      The Network Store Interface service hung on starting.
   ```

   ```cmd
      Log Name:      System
      Source:        Service Control Manager
      Date:          2/25/2016 11:59:08 AM
      Event ID:      7001
      Task Category: None
      Level:         Error
      Keywords:      Classic
      User:          N/A
      Computer:      myvm.contoso.net
      Description:
      The DHCP Client service depends on the Network Store Interface service which failed to start because of the following error: 
      The service cannot be started, either because it is disabled or because it has no enabled devices associated with it.
   ```

   ```cmd
      Log Name:      System
      Source:        Service Control Manager
      Date:          12.08.2016 15:35:22
      Event ID:      7000
      Task Category: None
      Level:         Error
      Keywords:      Classic
      User:          N/A
      Computer:      myvm.contoso.net
      Description:
      The Network Store Interface Service service failed to start due to the following error: 
      The account specified for this service is different from the account specified for other services running in the same process.
   ```

### Connect to the VM using Serial console (Troubleshoot cause)

If you're unable to successfully RDP to the virtual machine (VM), use PowerShell and [Serial Console](/azure/virtual-machines/troubleshooting/serial-console-windows) to check for the log entries.

1. On the command line, launch PowerShell by running `powershell.exe`.
2. In PowerShell, execute the following commands:

```ps
psCopy
```

```ps
remove-module psreadline
```

```ps
Get-WinEvent -FilterHashtable @{LogName='System'; StartTime=(Get-Date).AddDays(-1); ProviderName='Service Control Manager'}
```

## Cause

The NSI service is not running on the Virtual Machine. This issue happens in the following scenarios:

1. The NSI service was set to **disabled**.
2. The NSI is not responding, or is crashing.
3. Another required service is not running.

## Solution

Backup the VM OS disk using your preferred method.

One method that you can use is to [take a snapshot of the disk](/azure/virtual-machines/windows/snapshot-copy-managed-disk).

### Connect to the VM using Serial console (Solution)

Connect to the VM using [Serial Console](/azure/virtual-machines/troubleshooting/serial-console-windows) to attempt to get the NSI service started.

1. In the Serial Console, execute this command:

   `sc query NSI`

2. If the service is shown as:

   1. **Stopped** – Try to start the service:

      `sc start NSI`

      1. If the service starts without error and you can connect to the VM, then stop here.

   2. **Starting/Stopping** - Try stopping and starting the service again with these commands:

      `sc stop NSI`

      `sc start NSI`

3. If the NSI service is disabled:

   1. First set the service to automatic:

      `sc config NSI start=auto`

   1. Start the NSI service:

      `sc start NSI`

   1. Check if the NSI service is running:

      `sc query NSI`

4. IF the NSI service fails due to a dependency, you can try the above process on the dependency that was listed.
Once the NSI service is running you can try accessing the VM via RDP.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
