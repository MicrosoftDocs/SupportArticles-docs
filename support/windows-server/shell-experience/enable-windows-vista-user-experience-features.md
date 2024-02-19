---
title: How to enable Windows Vista user experience features on a computer that is running Windows Server 2008
description: Describes how to configure Windows Server 2008 as a workstation computer.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:windows-media-player, csstroubleshoot
---
# How to enable Windows Vista user experience features on a computer that is running Windows Server 2008

This article describes how to configure the user experience features that are available in Windows Vista on a computer that is running Windows Server 2008.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 947036

## Introduction

You may want to perform the actions that are described in this article if you intend to use a Windows Server 2008-based computer as a client workstation.

## More information

To enable the user experience features that are available in Windows Vista on a computer that is running Windows Server 2008, perform the actions that are described in the following sections.

### Desktop Experience

As a first step to enable these user experience features in Windows Server 2008, install the Desktop Experience feature. When you install this feature, the following components are also installed:

- Windows Media Player
- Media codecs
- Windows Mail

    > [!NOTE]
    > This program was formerly known as Microsoft Outlook Express.
- Windows Calendar
- Sound Recorder
- Windows Messenger
- ActiveSync
- Sync Manager
- File sync

    > [!NOTE]
    > This program enables client-side caching.

- Device Sync
- Video Capture
- Video for Windows
- Themes
- Character map (Charmap)
- Data cleaner
- Folder cleaner
- Cleaner manager
- Portable Media Devices
- Scanners and Cameras
- Photo Experience
- Three dimensional (3-D) screensavers
- Windows Defender

The following Windows Vista features are not available in Windows Server 2008:

- Sidebar
- Support for IrDA hardware
- Windows Movie Maker
- Bluetooth support
- Game Controllers
- Parental Controls
- Inbox Games
- Games Explorer
- Windows Vista Photo Experience
- RSS Client
- Peer-to-Peer (P2P) meeting application
- Wallpapers or screensavers other than the following:
  - The default wallpapers and screensavers
  - 3-D screensavers
- Animated cursors
- Sample files, such as music sample files and video sample files
- PIF manager
- Tablet support
- Mobility Center
- Media Center
- Speech Recognition

To install Desktop Experience, follow these steps:

1. Start Server Manager.
2. In the details pane, locate the **Features Summary** area, and then click **Add Features**.
3. In the Add Features Wizard, click to select the **Desktop Experience** check box, and then click **Next**.
4. Click **Install**.
5. After the Desktop Experience feature is installed, click **Close** to exit the Add Features Wizard, and then click **Yes** to restart the computer.

### Windows Aero

Windows Server 2008 supports the Windows Aero user interface experience. However, by default, Windows Aero isn't turned on in Windows Server 2008. Also, Windows Server 2008 doesn't include Windows Aero-capable graphics drivers. To enable Windows Aero, you must obtain graphics drivers from a third-party vendor or from the graphics adapter manufacturer.

#### To obtain graphics adapter drivers

To obtain graphics adapter drivers, visit the [AMD Web site](https://www.amd.com/support).

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft doesn't guarantee the accuracy of this third-party contact information.  

> [!NOTE]
> To use Windows Aero in Windows Server 2008, you must install the following items:
>
> - The Desktop Experience feature
> - Windows Aero-capable graphics drivers

To enable Windows Aero, follow these steps:

1. Start the Themes service. To do this, follow these steps:
      1. Click **Start**, click **Run**, type *services.msc*, and then click **OK**.
      2. In the list of installed services, right-click **Themes**, and then click **Properties**.
      3. In the **Startup type** list, click **Automatic**, click **Apply**, click **Start**, and then click **OK**.
2. Enable Windows Aero. To do this, follow these steps:
      1. Right-click a blank area of the desktop, and then click **Personalize**.
      2. In the **Personalization** dialog box, click **Window Color and Appearance**.
      3. In the **Color scheme** list, click **Windows Aero**, and then click **OK**.

    > [!NOTE]
    > If **Windows Aero** does not appear in the **Color scheme** list, the graphics adapter may not support Windows Aero, or you may have to update the graphics adapter drivers.

### Windows Audio

Windows Server 2008 supports audio playback. However, by default, the Windows Audio service is not started in Windows Server 2008. To enable the Windows Audio service, follow these steps:

1. In the notification area, right-click the speaker icon, and then click **Sounds**.
2. In the following message that appears, click **Yes**:

    > The computer cannot play audio because the Windows Audio Service is not enabled.  
    Would you like to enable the Windows Audio Service?

### Windows Search

The Windows Search feature is required for many other search features, such as the Start menu Search tool and the 2007 Office Outlook Search functionality. To install Windows Search, follow these steps:

1. Start Server Manager.
2. In the details pane, locate the **Roles Summary** area, and then click **Add Roles**.
3. On the **Before You Begin** page of the Add Roles Wizard, click **Next**.
4. On the **Select Server Roles** page, click to select the **File Services** check box, and then click **Next** two times.
5. On the **Select Role Services** page, click to select the **Windows Search Service** check box, and then click **Next**.
6. Click to select the check box or check boxes that correspond to the volumes that you want to index, and then click **Next**.
7. Click **Install**.
8. After Windows Search is installed, click **Close** to exit the Add Roles Wizard.

### Shadow copies

To enable shadow copies for a particular volume, follow these steps:

1. Click **Start**, point to **Administrative Tools**, and then click **Share and Storage Management**.
2. In the details pane, click the **Volumes** tab.
3. Right-click the volume for which you want to enable shadow copies, and then click **Properties**.
4. In the **DriveName Properties** dialog box, click the **Shadow Copies** tab.
5. Click **Enable**, and then click **Yes** to enable shadow copies for the particular volume.

### Internet Explorer Enhanced Security Configuration

By default, Internet Explorer Enhanced Security Configuration is turned on. If you use Windows Server 2008 as a workstation, you may want to turn off Internet Explorer Enhanced Security Configuration. To do this, follow these steps:

1. Exit any instances of Internet Explorer.
2. Start Server Manager.
3. In the details pane, locate the **Security Information** area that appears under the **Server Summary** area.
4. In the **Security Information** area, click **Configure IE ESC**.
5. In the **Internet Explorer Enhanced Security Configuration** dialog box, click one of the following options:
   - If your user account is a member of the Administrators group, click **Off** under **Administrators**.
   - If your user account is a member of a standard users' group, click **Off** under **Users**.

    > [!IMPORTANT]
    > We recommend that you do not turn off Internet Explorer Enhanced Security Configuration for a group for which that you are not a member.
6. Click **OK**.

### Sleep

Windows Server 2008 supports the sleep feature. However, this feature depends on the following conditions:

- Computer hardware that supports sleep
- Computer Basic Input/Output Settings (BIOS) that support sleep

    > [!NOTE]
    > Some BIOS settings let you enable or disable sleep on the computer. To use sleep, you may have to verify that support for this feature is enabled in the computer BIOS.
- Drivers that support sleep

    > [!NOTE]
    > The graphics driver must support this feature. The Windows Server 2008 Super VGA (SVGA) driver does not support sleep.

To enable sleep in Windows Server 2008, follow these steps:

1. Click **Start**, click **Control Panel**, and then double-click **Power Options**.
2. Under the power plan that is configured, click **Change plan settings**, and then click **Change advanced power settings**.
3. Expand **Sleep**, and then modify the sleep configuration settings as appropriate for your requirements.

    > [!NOTE]
    > If **Sleep** does not appear on the **Advanced Settings** tab of the **Power Options** dialog box, the computer does not meet the requirements to support the sleep feature. In this scenario, you may have to update the drivers or the devices on the computer.

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.
