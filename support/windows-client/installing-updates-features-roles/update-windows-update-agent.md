---
title: Update Windows Update Agent to latest version
description: Provides information about updating Windows Update Agent to the latest version.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, brentdav
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
adobe-target: true
---
# Update the Windows Update Agent to the latest version

This article describes how to update the Windows Update Agent to the latest version.

_Applies to:_ &nbsp; Windows 7, Windows 8, Windows Server 2008 R2, Windows Server 2012  
_Original KB number:_ &nbsp; 949104

## Summary

If you have automatic updating turned on, the latest version of the Windows Update Agent is downloaded and installed automatically on your computer. Or, you can manually download and install the Windows Update Agent.

## Automatically download Windows Update Agent

To download the Windows Update Agent automatically, follow these steps:

1. Turn on automatic updating. Follow these steps, for the version of Windows that you are running.

    - Windows 8.1 or Windows 8

        1. Open Windows Update by swiping in from the right edge of the screen (or, if you're using a mouse, pointing to the lower-right corner of the screen and moving up the mouse pointer), tapping or clicking **Settings**, tapping or clicking **Control Panel**, and then tapping or clicking **Windows Update**.
        2. Tap or click **Change settings**.
        3. Under **Important updates**, choose **Install updates automatically**.
        4. Under **Recommended updates**, select the **Give me recommended updates the same way I receive important updates** check box, and then select **OK**.

    - Windows 7, Windows Vista, or Windows XP

        To turn on automatic updating automatically, select the **Fix it** button or link, and then select **Run** in the **View Download** dialog box. Then, follow the steps in the **Fix it** wizard.

2. Restart the Windows Update service. To do this, follow these steps:
    1. Press the Windows logo Key+R to open the **Run** box.
    2. Type _services.msc_ in the **Run** box, and then press Enter.
    3. Right-click **Windows Update** in the Services management console, and then select **Stop**. If you are running Windows XP, right-click **Automatic Updates**, and then select **Stop**.
    4. After Windows Update stops, right-click **Windows Update**, and then select **Start**. If you are running Windows XP, right-click **Automatic Updates**, and then select **Start**.
3. Wait for Windows Update to start, and then verify that the Windows Update Agent is updated.

## Manually download Windows Update Agent from Microsoft Download Center

Click the download link for your version of Windows to obtain the latest Windows Update Agent.

### Stand-alone packages for Windows 8 and Windows Server 2012

The following files are available for download from the Microsoft Download Center.

|Operating system|Update|
|---|---|
|All supported x86-based versions of Windows 8 (KB2937636)|[Download the package now.](https://www.microsoft.com/download/details.aspx?familyid=909de38f-ab20-46fc-a96a-662335b13a23) |
|All supported x64-based versions of Windows 8 (KB2937636)|[Download the package now.](https://www.microsoft.com/download/details.aspx?familyid=d414eda7-9d82-4a15-bae6-f9b94975dafc) |
|All supported x64-based versions of Windows Server 2012 (KB2937636)|[Download the package now.](https://www.microsoft.com/download/details.aspx?familyid=31ddb379-6268-4ad7-8083-d8fa42b6a3e9) |

### Stand-alone packages for Windows 7 SP1 and Windows Server 2008 R2 SP1

The following files are available for download from Windows Update.

|Operating system|Update|
|---|---|
|All supported x86-based versions of Windows 7 SP1|[Download the package now.](http://download.windowsupdate.com/windowsupdate/redist/standalone/7.6.7600.320/windowsupdateagent-7.6-x86.exe) |
|All supported x64-based versions of Windows 7 SP1|[Download the package now.](http://download.windowsupdate.com/windowsupdate/redist/standalone/7.6.7600.320/windowsupdateagent-7.6-x64.exe) |
|All supported x86-based versions of Windows Server 2008 R2 SP1|[Download the package now.](http://download.windowsupdate.com/windowsupdate/redist/standalone/7.6.7600.320/windowsupdateagent-7.6-x86.exe) |
|All supported x64-based versions of Windows Server 2008 R2 SP1|[Download the package now.](http://download.windowsupdate.com/windowsupdate/redist/standalone/7.6.7600.320/windowsupdateagent-7.6-x64.exe) |
|All supported Itanium-based versions of Windows Server 2008 R2 SP1|[Download the package now](http://download.windowsupdate.com/windowsupdate/redist/standalone/7.6.7600.320/windowsupdateagent-7.6-ia64.exe). |
  
> [!NOTE]
> Windows 8.1, Windows RT 8.1, and Windows Server 2012 R2 with update [2919355](https://support.microsoft.com/help/2919355) already include the latest version of the Windows Update Agent.

## More information

If you receive a Windows Update error, try [Solutions for common Windows Update errors](https://support.microsoft.com/help/10164/fix-windows-update-errors).

For more information about how to check which version of the Windows Update Agent is installed, follow these steps:

1. Open the `%systemroot%\system32` folder. `%systemroot%` is the folder in which Windows is installed. For example, the `%systemroot%` folder is `C:\Windows`.
2. Right-click Wuaueng.dll, and then select **Properties**.
3. Select the **Details** tab, and then locate the file version number.

> [!NOTE]
> The latest version of the Windows Update Agent for Windows 8.1 is 7.9.9600.16422. The latest version of the Windows Update Agent for Windows 8 is 7.8.9200.16693. The latest version of the Windows Update Agent for Windows 7, Windows Vista, and Windows XP is 7.6.7600.256.

### Improvements in version 7.6.7600.256 of Windows Update Agent

- A hardened infrastructure so that the Windows Update client will trust only those files that are signed by a new certificate. The certificate is used solely to protect updates to the Windows Update client.

- A more secure communication channel for the Windows Update client

### Improvements in version 7.4.7600.226 of Windows Update Agent

- Improved scan times for Windows updates.
- Improved Windows Update UI for computers that are running Windows Vista or Windows Server 2008.
- More visible and detailed descriptions of updates.
- Improvements in how users are notified about service packs.

### Issues that are fixed in version 7.2.6001.788 of Windows Update Agent

Version 7.2.6001.788 of the Windows Update Agent fixes the following issue. This issue was not previously documented in a Microsoft Knowledge Base article:

- When you try to install 80 or more updates at the same time from Windows Update or Microsoft Update, you receive a "0x80070057" error code.

### Improvements in version 7.2.6001.784 of Windows Update Agent

- Improved scan times for Windows Update
- Improved speed at which signature updates are delivered
- Support for Windows Installer reinstallation
- Improved error messaging

### Issues that are fixed by version 7.0.6000.381 of Windows Update Agent

Version 7.0.6000.381 of the Windows Update Agent fixes the following issues. These issues were not previously documented in a Microsoft Knowledge Base article:

- The Background Intelligent Transfer Service (BITS) crashes on a Windows Vista-based computer. For more information, see [An update is available to fix a Background Intelligent Transfer Service (BITS) crash on a Windows Vista-based computer](https://support.microsoft.com/help/940520).
- A fix is included that reduces the number of restarts that are required for the stand-alone installer when Multilingual User Interface Pack (MUI) files are being used.
- User interface elements in the Korean, Simplified Chinese, and Traditional Chinese languages are fixed.
- The Windows Vista installation experience is improved.

Windows Update helps keep your computer up-to-date and secure by downloading and installing the latest security and other updates from Microsoft. Windows Update determines which updates apply to your computer.

Microsoft periodically makes software updates available to users of Windows and other Microsoft software. These include updates that improve reliability and performance, updates that provide new protections against malware and other potentially unwanted software, and upgrades to Windows features. To improve the performance or the reliability of hardware components on the computer, Microsoft may also provide updates to device drivers that are supplied by the computer manufacturer.

If you turn on Windows Update, software components that are directly related to Windows Update will have to be updated occasionally on your computer. These updates must be performed before Windows Update can check for required updates or before it can install other updates. These required updates fix errors, provide ongoing improvements, and maintain compatibility with the Microsoft servers that support Windows Update. If you disable Windows Update, you will not receive these updates.

Windows Update is configured to install updates automatically when you select the recommended option during Windows Out Of Box Experience (OOBE) Setup. You can also turn on Windows Update by selecting one of following settings in the Automatic Updates item in Control Panel:

- Automatic (recommended).
- Download updates for me, but let me choose when to install them.
- Notify me, but don't automatically download or install them.

After you turn on Windows Update, the required updates to components of Windows Update will be downloaded and installed automatically without notifying you. This behavior occurs regardless of which setting you use to turn on Windows Update. If you do not want to receive required updates, you can disable automatic updates in Control Panel.

The updates to Windows Update itself typically do the following: Address feedback from customers, improve compatibility, service performance and reliability, and enable new service capabilities. When the Windows Update server is updated, a corresponding client update is typically required. During an agent self-update operation, Windows Update Agent files may be added, modified, or replaced. For example, Windows Update Agent files that help display the user experience or that determine whether updates apply to a particular system may be added. This behavior occurs when a system is set to automatically check for available updates. This does not occur when automatic updates are turned off. For example, this behavior does not occur if you select **Never check for updates** in Windows Vista and Windows 7 or if you select **Turn off Automatic Updates** in Windows XP.

Administrators will receive the latest version of the Windows Update Agent for deployment through Windows Server Update Services (WSUS).

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
