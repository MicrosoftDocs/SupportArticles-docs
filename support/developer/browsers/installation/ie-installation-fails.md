---
title: Cannot install Internet Explorer 11
description: Discusses how to troubleshoot a Internet Explorer installation that fails. Provides instructions and resources for various issues.
ms.date: 04/24/2020
---
# Troubleshooting a failed installation of Internet Explorer 11

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides the system requirements before installing Internet Explorer 11 and checks for possible problems that may occur after installation.

_Original product version:_ &nbsp; Internet Explorer 11  
_Original KB number:_ &nbsp; 2872074

## Summary

When you try to install Internet Explorer 11, the installation may fail and generate an error message. This can occur for various reasons. To resolve common installation issues, try one or more of the following troubleshooting methods. Here is the checklist before you install Internet Explorer 11:

## Make sure that your system meets the minimum operating system requirements

To successfully install Internet Explorer 11, make sure that your system meets one of the following minimum operating system requirements:

- Windows 7, 32-bit with Service Pack 1 (SP1), or later versions.
- Windows 7, 64-bit with Service Pack 1 (SP1), or later versions.
- Windows Server 2008 R2 with Service Pack 1 (SP1), or later versions.

If you're running Windows 7 or Windows Server 2008 R2, make sure that you have installed [Service pack 1 (SP1)](https://support.microsoft.com/help/976932) or a later version.

> [!NOTE]
> Internet Explorer 11 is included with Windows 8.1 and Windows Server 2012 R2. Therefore, you don't have to install Internet Explorer 11 on these operating systems.

For more information about the minimum operating system requirements for Internet Explorer 11, see [System requirements for Internet Explorer 11](/internet-explorer/ie11-deploy-guide/system-requirements-and-language-support-for-ie11).

## Make sure that you have prerequisite updates installed

During the installation process, you may receive the following error message:

> Internet Explorer needs an update before installing.

Internet Explorer 11 tries to install required software and components automatically. If this installation fails, Internet Explorer stops the installation process. In this situation, you must install the prerequisite software manually before you can install Internet Explorer 11.

For more information, see [Prerequisite updates for Internet Explorer 11](https://support.microsoft.com/help/2847882) to obtain the prerequisite updates for Internet Explorer 11 for Windows 7.

Additionally, you may review the *IE11_main.log* file under the Windows folder (for example, *C:\Windows*) to find out what prerequisite update is not installed correctly.

## Make sure that your video card driver is compatible

Some computers that have hybrid video adapters are not yet compatible with Internet Explorer 11 for Windows 7. Internet Explorer 11 will not install on these systems until updated hardware drivers are installed. For more information about this issue, see [Internet Explorer 11 does not install on some hybrid graphics systems](https://support.microsoft.com/help/2823483).

## Make sure that the installation of other updates is complete

Internet Explorer 11 for Windows 7 cannot automatically install prerequisites if any update installation is in progress or if a system restart is pending. To check whether you have an ongoing update installation or a pending restart in Windows 7, follow these steps:

1. Open **Control Panel**.
2. Click **System and Security**.
3. Click **Windows Update**.

If you have ongoing activity, do the following before you try to install Internet Explorer 11 for Windows 7, as appropriate:

- If an update installation is in progress, let that installation finish.
- If all updates are installed but a system restart is pending, restart your computer.

## Make sure that you use the correct installer version

You have to use the correct installer version for your operating system version. See [How can I tell if my computer is running a 32-bit or a 64-bit version of Windows?](https://support.microsoft.com/help/827218) to determine whether your system is 32-bit or 64-bit.

Then, download the correct Internet Explorer 11 installer for your system version. To do this, go to [Download Internet Explorer 11 (Offline installer)](https://support.microsoft.com/help/18520), and then locate the download file for 32-bit systems or 64-bit systems, as appropriate.

> [!NOTE]
> Also make sure that you select the appropriate installer for you active language.

## Uninstall Internet Explorer 9 before you install Internet Explorer 11

During the installation process of Internet Explorer 11, you may receive the *9C59* error. To resolve this issue, you may uninstall Internet Explorer 9, restart your computer, and then install Internet Explorer 11. Steps to uninstall Internet Explorer 9:

1. Click the **Start** button, type *Programs and Features* in the search box, and then click **View installed updates** in the left pane.
2. Under **Uninstall an update**, scroll down to the **Microsoft Windows** section.
3. Right-click **Windows Internet Explorer 9**, click **Uninstall**, and then, when prompted, click **Yes**.
4. Click **Restart now** to finish the process of uninstalling Internet Explorer 9.

After your computer restarts, try to install Internet Explorer 11.

## Other installation issues

### Some gadgets are corrupted or disappear in Windows 10 after you install Internet Explorer 11

This issue occurs when the custom text size (DPI) on your computer is set to a value that is larger than the default value. To work around this issue, you can follow the steps in [change the size of text in Windows 10](https://support.microsoft.com/help/4028566) to set the custom text size (DPI) back to Smaller - 100%. Or, you may uninstall Internet Explorer 11 temporarily.

### Installing a localized version of Internet Explorer 11

You can install Internet Explorer 11 in your localized environment by using either the English version of the installer or a supported language version of the installer for your localized environment.

If you don't use the English version of the Internet Explorer 11 installer, make sure that the language version of the installer matches the active language of your operating system. If the language versions don't match, Internet Explorer 11 stops the installation. Additionally, you receive the following error message:

> Wrong version of Internet Explorer installer.

For example, you experience a language mismatch if you try to install a Spanish version of Internet Explorer 11 on a computer that is running the Catalan-localized version of Windows. Although Spanish is the base language for the Catalan Language Interface Pack (LIP) language, you must use the specific Catalan version of the Internet Explorer 11 installer in this environment.

To install Internet Explorer 11 in your active language, download the correct Internet Explorer 11 installer for your operating system version. To do this, go to [Download Internet Explorer 11 (Offline installer)](https://support.microsoft.com/help/18520), and then locate the download file for 32-bit systems or 64-bit systems, as appropriate.

> [!NOTE]
> This information applies only to non-English versions of the Internet Explorer 11 installer. If you use the English version of the installer in a supported non-English environment, the installation process continues in English, but the installed program will match your operating system language.  

### Temporarily disabling antispyware and antivirus software

> [!WARNING]
> This workaround may make a computer or a network more vulnerable to attack by malicious users or by malicious software such as viruses. We do not recommend this workaround, but we are providing this information so that you can implement this workaround at your own discretion. Use this workaround at your own risk.

If you choose to temporarily disable antispyware or antivirus software before you install Internet Explorer 11, follow these steps:

1. [Turn on Windows Firewall](https://support.microsoft.com/help/4028544).

2. Disable the antispyware and antivirus software on your computer. To do this, right-click the icon for the antispyware or antivirus software in the notification area, and then click **Exit** or **Disable**.

3. After the antispyware or antivirus software is disabled, try to install Internet Explorer.

4. After the Internet Explorer installation is finished, re-enable the antispyware and antivirus software that you disabled.

5. Go to Windows Update to install the latest updates for the program and for your system.

## Reinstalling Internet Explorer 11

If you try to reinstall Internet Explorer 11 after you recently uninstalled the program, the installation process may not be successful. This issue may occur because the system has not finished removing temporary setup files that are required for the initial installation of the program. If this issue occurs, we recommend that you wait 20 minutes before you try to reinstall Internet Explorer 11.
