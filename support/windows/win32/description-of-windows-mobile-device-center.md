---
title: Description of Windows Mobile Device Center
description: This article describes the new application that replaces ActiveSync in Windows Vista.
ms.date: 01/21/2021
ms.prod-support-area-path: 
ms.topic: troubleshooting
---
# Description of Windows Mobile Device Center

This article describes the new application that replaces ActiveSync in Windows Vista.

_Applies to:_ &nbsp; Windows  
_Original KB number:_ &nbsp; 931937

> [!IMPORTANT]
> The content in this article is for Windows Mobile Device Center which is no longer supported. The corresponding downloads have been removed from the Microsoft Download Center. Here are some additional references for Windows 10 environments.

To access your phone on your PCs, you can use Your Phone application on your system. For more information review [Your Phone app help & learning - Microsoft Support](https://support.microsoft.com/your-phone-app) and [Your Phone updates - Windows Insider Program | Microsoft Docs](/windows-insider/apps/your-phone#march-12-2019).

To learn more about mobile device management on Windows 10 review [Mobile device management - Windows Client Management | Microsoft Docs](/windows/client-management/mdm/).

For more information on configuring Windows 10 mobile devices review [Configure Windows 10 Mobile devices - Configure Windows | Microsoft Docs](/windows/configuration/mobile-devices/configure-mobile).

## Introduction

Microsoft Windows Mobile Device Center replaces ActiveSync for Windows Vista.

Windows Mobile Device Center offers device management and data synchronization between a Windows Mobile-based device and a computer.

For Windows XP or earlier operating systems, you must use Microsoft ActiveSync.

## More information

Download and install Windows Mobile Device Center 6.1 if you run Windows Vista on your computer and you want to sync content between your mobile phone and your computer. Windows Mobile Device Center is compatible only with Windows Vista.

> [!NOTE]
> If you run Windows XP or an earlier version of Windows, you have to download Microsoft ActiveSync.

You can use Windows Mobile Device Center 6.1 only with phones that run Windows Mobile 2003 or a later version. ActiveSync and Windows Mobile Device Center do not work with Windows Embedded CE 4.2 or 5.0, Pocket PC 2002, or Smartphone 2002 devices.

To determine which Windows Mobile operating system you're using if your phone doesn't have a touch screen, click **Start**, click **Settings**, and then click **About**.

If your phone has a touch screen, tap **Start**, tap the **System** tab, and then tap **About**. To sync content to any of these devices, you must use a USB or serial cable, your computer's Internet connection, and File Explorer.

Windows Mobile Device Center includes the following features:

- Streamlined setup

  Windows Mobile Device Center has a new, simplified partnership wizard and has improved partnership management.

- Robust synchronization

  ![Robust synchronization](./media/description-windows-mobile-device-center/windows-mobile-device-center.jpg)  

- Photo management

  The photo management feature helps you detect new photos on a Windows Mobile-based device. Then, this feature helps you tag the photos and import the photos to the Windows Vista Photo Gallery.

- Media synchronization

  You can use Microsoft Windows Media Player to synchronize music files and to shuffle music files on a Windows Mobile-based device.

- File browsing

  A new device browsing experience lets you quickly browse files and folders. Additionally, you can open documents that are on a Windows Mobile-based device directly from a computer.

  > [!NOTE]
  > You must use Microsoft Outlook 2002, Outlook 2003, or Office Outlook 2007 to sync your email, contacts, tasks, and notes from your computer.

- Enhanced user interface

  Windows Mobile Device Center has a simple user interface that helps you quickly access important tasks and configure a Windows Mobile-based device.

## Frequently asked questions

- **Q1: How do I start Windows Mobile Device Manager?**

  A1: First, make sure that your device is connected to the computer. A splash screen will be displayed when Windows Mobile Device Center detects your phone and starts. You must use a USB cable to connect your phone to your computer the first time that you use Windows Mobile Device Center to sync.

- **Q2: Can I install Windows Mobile Device Manager on Windows XP?**

  A2: No, you have to use ActiveSync with Windows XP or earlier Windows operating systems.

- **Q3: How do I sync my Windows Mobile phone with Windows Device Manager on Windows Vista?**

  A3: Follow these steps to set your phone's sync settings your phone with Windows Vista:

    1. Plug your device into your computer by using the USB cable or cradle. The Windows Mobile Device Center Home screen appears on your computer.
    1. On your computer, click **Mobile Device Settings**.
    1. Click **Change content sync settings**.
    1. Select the check box next to each information type that you want to synchronize, and then click **Next**.
    1. To synchronize with an Exchange Server, enter server information that was provided by a network administrator, and then click **Next**. Otherwise, click **Skip**.
    1. Enter the **Device name**, and then clear the check box if you do not want a shortcut for WMDC created on your desktop.

- **Q4: Does Windows Mobile Device Manager work with phones that don't run Windows Mobile?**

  A4: No.

## Device will not connect

The driver installation may not have completed successfully. If you think this may be the case, follow these steps:

1. Keep your Mobile device connected to the computer.
1. From the desktop, click **Start**, and then type devmgmt.msc in the **Search programs and files** box.
1. In the Device Manager window, look under the **Network adapters** node for **Microsoft Windows Mobile Remote Adapter**. If this is not present, go to step 5. Otherwise, right-click **Microsoft Windows Mobile Remote Adapter**, and then select **Uninstall**.
1. Look under the **Mobile Devices** node for **Microsoft USB Sync**. If this is not present, go to step 6. Otherwise, right-click **Microsoft USB Sync**, and select **Uninstall**.
1. Disconnect and then reconnect your device. Your device driver will be reinstalled, and Windows Mobile Device Center will be launched.For more information about connectivity-related problems, see the ActiveSync USB connection troubleshooting guide.

## Device is disconnected when syncing large files

If you have problems syncing music, pictures, or other large files in which the connection suddenly closes, there may be an issue with a serial driver that is installed on the device. Unless you are using a VPN server or a firewall that is blocking your large files from synchronization, you may try switching your device into RNDIS mode to fix your large file sync problem. If your device has a **USB to PC** option, you might use this workaround:

1. On the device, go to **Settings** and then **Connections**. Look for a **USB to PC** option.
1. To enable RNDIS USB, select the **Enable advanced network functionality** check box in the **USB to PC** options, and then tap **OK**.

    > [!NOTE]
    > If this option is already selected, do not clear this selection or this workaround will not work.

1. Warm-boot the device. To do this, hold down the power button and then press the reset button, or remove the battery.
1. Turn on the device.
1. When the device is restarted, dock the device and try again.

    > [!NOTE]
    > RNDIS takes a little while to connect. Please be patient and wait for the device to connect.

1. If, after you follow the previous steps, you cannot connect at all, just switch back to serial USB to sync.
