---
title: Fail to attach PCI Express expansion chassis
description: Provides workarounds for errors that occur when you attach a PCI Express expansion chassis to a computer.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika, v-sanair
ms.custom: sap:devices-and-drivers, csstroubleshoot
ms.technology: windows-client-deployment
---
# Error message when you attach a PCI Express expansion chassis to a Windows-based computer: "Code 12" or "Code 31"

This article provides workarounds for errors that occur when you attach a PCI Express expansion chassis to a computer.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 942959

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

## Symptoms

Consider the following scenario:

- A PCI Express expansion chassis is connected to a computer.
- There are devices connected to the PCI Express expansion chassis.  

In this scenario, the devices may not be enumerated correctly, or they may not start correctly. Additionally, you may receive one of the following error messages when you view the device properties in Device Manager:  

- Error 1:  
  > This device cannot find enough free resources that it can use. (Code 12)

- Error 2:  
  > The device is not working properly because Windows cannot load the drivers required for this device. (Code 31)

## Cause

### Cause of error 1

This issue may occur because of the initial state of the PCI Express bridge device in the expansion chassis. By default, when you start or reset PCI Express bridge devices, the initial values of the limit register for the bridge resource window are less than the initial values of the base register for the bridge resource window. This behavior is interpreted as an indication that the bridge resource window is disabled. Additionally, no bridge resource window requirements for the PCI Express bridge device are generated. Therefore, any PCI Express bridge device that requires resources from the bridge resource window will fail enumeration. In this situation, a Code 12 error is generated.

### Cause of error 2

This issue may occur if the operating system runs out of Peripheral Component Interconnect (PCI) bus numbers. Typically, the computer BIOS configures a limited bus-number range for PCI Express bridge devices. When an expansion chassis that contains a PCI Express complex switch together with a deep device hierarchy is added to the computer, the operating system runs out of available bus numbers. Therefore, the system cannot start devices in the expansion chassis.

## Workaround

### Workaround for error 1

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk. To work around this issue, follow these steps:  

1. Click **Start**, type **regedit** in the **Start Search** box, and then click **regedit** in the **Programs** list.

    If you are prompted for an administrator password or for confirmation, type the password, or click **Continue**.
2. Locate the following registry subkey, and then click it:  
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PnP\Pci`  

3. If the HackFlags registry entry is not present, follow these steps:  

   1. On the **Edit** menu, point to **New**, and then click **DWORD (32-bit) Value**.
   2. Type HackFlags, and then press ENTER.
   3. On the **Edit** menu, click **Modify**.
   4. In the **Value data** box, type 400, click **Hexadecimal** in the **Base** area, and then click **OK**.
   5. Exit Registry Editor.  

4. If the HackFlags registry entry is present, follow these steps:  

   1. Right-click **HackFlags**, and then click **Modify**.
   2. In the **Value data** box, type 400, click **Hexadecimal** in the **Base** area, and then click **OK**.
   3. Exit Registry Editor.

### Workaround for error 2

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk. To work around this issue, follow these steps:  

1. Click **Start**, type **regedit** in the **Start Search** box, and then click **regedit** in the **Programs** list.

    If you are prompted for an administrator password or for confirmation, type the password, or click **Continue**.
2. Locate the following registry subkey, and then click it:  
   `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PnP\Pci`  

3. If the HackFlags registry entry is not present, follow these steps:  

   1. On the **Edit** menu, point to **New**, and then click **DWORD (32-bit) Value**.
   2. Type HackFlags, and then press ENTER.
   3. On the **Edit** menu, click **Modify**.
   4. In the **Value data** box, type 200, click **Hexadecimal** in the **Base** area, and then click **OK**.
   5. Exit Registry Editor.  

4. If the HackFlags registry entry is present, follow these steps:
   1. Right-click **HackFlags**, and then click **Modify**.
   2. In the **Value data** box, type 200, click **Hexadecimal** in the **Base** area, and then click **OK**.
   3. Exit Registry Editor.

### Enable the workarounds for error 1 and error 2 at the same time

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.  

1. Click **Start**, type **regedit** in the **Start Search** box, and then click **regedit** in the **Programs** list.

    If you are prompted for an administrator password or for confirmation, type the password, or click **Continue**.
2. Locate the following registry subkey, and then click it:  
  `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PnP\Pci`  

3. If the HackFlags registry entry is not present, follow these steps:
   1. On the **Edit** menu, point to **New**, and then click **DWORD (32-bit) Value**.
   2. Type HackFlags, and then press ENTER.
   3. On the **Edit** menu, click **Modify**.
   4. In the **Value data** box, type 600, click **Hexadecimal** in the **Base** area, and then click **OK**.
   5. Exit Registry Editor.

4. If the HackFlags registry entry is present, follow these steps:
   1. Right-click **HackFlags**, and then click **Modify**.
   2. In the **Value data** box, type 600, click **Hexadecimal** in the **Base** area, and then click **OK**.
   3. Exit Registry Editor.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
