---
title: Use Device Manager to configure devices
description: Describes how to use Device Manager to configure the hardware devices that are installed on your Windows Server 2003-based computer.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, V-LANAC
ms.custom: sap:devices-and-drivers, csstroubleshoot
---
# How to use Device Manager to configure devices in Windows Server 2003  

This article describes how to use Device Manager to configure the hardware devices that are installed on your Windows Server 2003-based computer.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 323423

## Summary

Device Manager displays a graphical view of the hardware that is installed on your computer. Use this tool when you want to view and manage hardware devices and their drivers. You must be logged on to the computer as an administrator or as a member of the Administrators group to add or remove devices or to configure device properties in Device Manager.

When you install a Plug and Play device, Windows automatically configures the device so that it works correctly with the other devices that are installed on the computer. During the configuration process, Windows assigns a unique set of system resource settings to the device. The following list describes the four types of resources that a device can use:

- Interrupt request (IRQ) line numbers
- Direct memory access (DMA) channels
- Input/output (I/O) port addresses
- Memory address ranges

Each resource that is assigned to a device is given a unique value. Occasionally, a device conflict may occur if two devices require the same resources. If this conflict occurs, you can manually configure the device to assign unique resources to each device. In some situations, depending on the device drivers and the computer, two devices can share a resource (for example, interrupts on Peripheral Component Interconnect [PCI] devices).

When you install a non-Plug and Play device, Windows doesn't automatically configure resource settings for the device. Depending on the type of device, you may have to manually configure these settings. Before you do so, either contact the hardware manufacturer, or see the documentation that is included with the device for more information.

Typically, Windows identifies devices and their resource requests, and then automatically gives the resource settings for your hardware. In most situations, you don't have to modify resource settings for your hardware. Don't change resource settings for a Plug and Play device unless it's necessary. When you manually configure a resource, the setting is fixed. So Windows can't modify resource assignments if that is required, and Windows can't assign that resource to another device.

## How to configure a device in Device Manager

To configure a device in Device Manager, follow these steps.

> [!IMPORTANT]
> Use caution when you configure resource settings for a device. If you configure resources incorrectly, you can disable your hardware, and you can cause your computer to stop working. Change resource settings only when you are sure that the settings that you want to use are unique and don't conflict with settings for other devices, or when a hardware manufacturer has provided you with specific resource settings for a device.

1. Sign in to your computer as an administrator or as a member of the Administrators group.
2. Select **Start**, point to **Administrative Tools**, and then select **Computer Management**.
3. Under **System Tools** in the console tree, select **Device Manager**.

    The devices that are installed on your computer are listed in the right pane.

4. Double-click the type of device that you want to configure--for example, **Ports (COM & LPT)**.
5. Right-click the device that you want to configure, and then select **Properties**.
6. Select the **Resources** tab.
7. Click to clear the **Use automatic settings** check box.

    > [!NOTE]
    > The **Use automatic settings** check box is unavailable and appears dimmed, both on devices for which there are no other settings to configure and on devices that are controlled by Plug and Play resources and which do not require user modification.

8. In the **Settings based on** box, select the hardware configuration that you want to modify--for example, **Basic configuration 0000**.
9. Under **Resource type** in the **Resource settings** box, select the type of resource that you want to modify--for example, **Interrupt Request**.
10. Select **Change Setting**.
11. In the **Edit Resource** dialog box, type the value that you want for the resource, and then select **OK**.
12. Repeat steps 8 through 11 to configure the resource settings that you want for the device.
13. Quit Device Manager.

## How to view resource settings in Device Manager

To view a list of resources and the devices that are using them by type or by connection, follow these steps:

1. Select **Start**, point to **Administrative Tools**, and then select **Computer Management**.
2. Under **System Tools** in the console tree, select **Device Manager**.

    The devices that are installed on your computer are listed in the right pane. The default view lists devices by type.

3. Use one of the following methods:
   - To view a list of resources by type, select **Resources by type** on the **View** menu.

   - To view a list of resources by connection type, select **Resources by connection** on the **View** menu.

## Use Device Manager to search for device conflicts

A device conflict occurs when the same resources are given to two or more devices. Use Device Manager to search for device conflicts. To do so, follow these steps:

1. Select **Start**, point to **Administrative Tools**, and then select **Computer Management**.
2. Under **System Tools** in the console tree, select **Device Manager**.

    The devices that are installed on your computer are listed in the right pane.

3. Double-click the type of device that you want to test--for example, **Sound, video and game controllers**.
4. Right-click the device that you want to test for conflicts, and then select **Properties**.
5. Select the **Resources** tab.

    Any conflicts that exist for the device are listed under **Conflicting device list**.

## Windows Hardware Troubleshooter

Use the Windows Hardware Troubleshooter to help you troubleshoot and resolve a hardware conflict or other hardware-related issues. To start the Hardware Troubleshooter, follow these steps:

1. Sign in to your computer as an administrator or as a member of the Administrators group.
2. Select **Start**, point to **Administrative Tools**, and then select **Computer Management**.
3. Under **System Tools** in the console tree, select **Device Manager**.

    The devices that are installed on your computer are listed in the right pane.

4. Double-click the type of device that you want to troubleshoot--for example, **Modems**.
5. Right-click the device that you want to troubleshoot, and then select **Properties**.
6. Select the **General** tab.
7. Select **Troubleshoot**.

## References

For more information about how to manage devices by using Device Manager, see [Error codes in Device Manager in Windows](https://support.microsoft.com/help/310123)

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
