---
title: '"USB Device not recognized" error'
description: Helps resolve the "USB Device not recognized error" that occurs when trying to access a USB external hard drive.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:storage-hardware, csstroubleshoot
adobe-target: true
---
# "USB Device not recognized" error when you try to access a USB external hard drive

This article provides methods to solve the **USB Device not recognized** error that occurs when you try to access a USB external hard drive.

## Symptoms

When you try to access data on an external USB hard drive, you may receive the following error:

> USB Device not recognized: One of the devices attached to this computer has malfunctioned and windows does not recognize it.

_Applies to:_ &nbsp; Windows 10, version 1709, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2654149

## Cause

This issue can be caused if any of the following situations exist:

- The currently loaded USB driver has become unstable or corrupt.
- Your PC requires an update for issues that may conflict with a USB external hard drive and Windows.
- Windows may be missing other important updates hardware or software issues.
- Your USB controllers may have become unstable or corrupt.
- Your external drive may be entering selective suspend.
- Your PC motherboard may need updated drivers.

## Resolution 1 - Uninstall and then reconnect the external hard drive

This method resolves issues where the currently loaded USB driver has become unstable or corrupt.

1. Select **Start**, type *Device Manager* in the **Search** box.
2. Select **Device Manager** from the returned list.
3. Select Disk Drives from the list of hardware.
4. Press and hold (or right-click) the USB external hard drive with the issue, and select Uninstall.
5. After the hard drive is uninstalled, unplug the USB cable.
6. Wait for 1 minute and then reconnect the USB cable. The driver should automatically load.
7. Check for the USB drive in Windows Explorer.

> [!NOTE]
> Connecting your USB external hard drive into a non-powered USB hub can cause a lack of enough power to operate the external drive. Instead, plug it directly into your computer.

If this method does not solve your issue, proceed to resolution 2.

## Resolution 2 - Install hotfixes that resolve issues that may exist on Windows 7

The hotfixes in this method can resolve a known conflict with a USB external hard drive and Windows.

1. Go to [KB976972 You encounter problems when you move data over USB from a Windows 7-based computer that has an NVIDIA USB EHCI chipset and at least 4 GB of RAM](https://support.microsoft.com/help/976972).

1. Under Update information, select **Download the update package now** that corresponds with your version of Windows 7.
   1. If you're unsure of which version of Windows 7 you are running, select the **Start** button, press and hold (or right-click) **Computer** > **Properties**.
      - If 64-bit Operating System is listed next to System type, you're running the 64-bit version of Windows 7.
      - If 32-bit Operating System is listed next to System type, you're running the 32-bit (x86) version of Windows 7.
1. Select **Continue**. If a User Account Control permission prompt occurs, select **Yes**.
1. Select **Download** > **Open**.
1. The download should start in 30 seconds. If it does not, select **Start Download** > **Open**.
1. Follow the onscreen instructions to complete the download and installation.
1. Go to [KB974476 The computer stops responding when an USB device resumes from the USB Selective Suspend state in Windows 7](https://support.microsoft.com/help/974476).
1. Select View and request hotfix downloads > Select hotfix.
1. If prompted, review the license agreement. If you agree to the terms, select **I Accept**.
1. Check the box next to your version of Windows 7, then enter your email in the boxes below.
1. Enter the word verification, then select **Request hotfix**.
1. Check your email. You will soon see an email from Microsoft with a download link for the hotfix. Select the link and follow the onscreen instructions to download and install the hotfix.
1. Restart your computer.

If your problem still persists, proceed to resolution 3.

## Resolution 3 - Install the latest Windows Updates

This method will install the latest device drivers for your USB external hard drive.

1. Select the **Start** button, type *Windows Update* in the **Search** box, and then select **Windows Update** in the results pane.
2. Select **Check for Updates**. After the scan is complete, select **Review optional updates**.
3. Select the check box next to the updates, then select **Install updates**.
4. If prompted, review the license agreement, then select **I Accept**.
5. Follow the onscreen instructions to download and install the updates.
6. If prompted, reboot your computer.

If your problem still exits, proceed to resolution 4.

## Resolution 4 - Reinstall USB controllers

This method resolves steps where the currently loaded USB driver has become unstable or corrupted.

1. Select **Start**, then type device manager in the **Search** box, and then select **Device Manager**.
2. Expand Universal Serial Bus controllers. Press and hold (or right-click) a device and select Uninstall. Repeat for each device.
3. Once complete, restart your computer. Your USB controllers will automatically install.

If your problem still exists, proceed to resolution 5.

## Resolution 5 - Disable USB selective suspend setting

This method prevents your USB external drive from powering down.

1. Select the **Start** button, type *power plan* in the **Search** box, and then select **Choose a power plan**.
2. Next to your currently selected plan, select **Change Plan Settings**.
3. Select **Change advanced power settings**.
4. Select the box to expand **USB Settings** > **USB selective suspend settings**.
5. Select **Plugged in**, select the drop-down menu, and then select **disabled**.
6. If you're using a laptop, select **Battery**, select the drop-down menu, and then select **disabled**.
7. Select **Apply** > **OK**.

If this doesn't resolve your issue, proceed to resolution 6.

## Resolution 6 - Install your motherboard's latest chipset drivers

This method updates your motherboard's chipset drivers, so your computer will recognize your USB external hard drive.

1. Review your computer's documentation that should contain the name of the motherboard manufacturer.
2. Visit your computer manufacturer's support website. For a list of computer manufacturers' support sites, see [Computer manufacturers' contact information](https://support.microsoft.com/help/14148).
3. Navigate their website to find the appropriate drivers for your motherboard. For assistance, contact your computer manufacturer.

If your issue still exists, we recommend contacting Microsoft product support.

## More information

For more information, see [Windows Update](https://support.microsoft.com/hub/4338813).
