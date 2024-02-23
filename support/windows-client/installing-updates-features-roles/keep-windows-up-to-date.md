---
title: How to keep Windows up to date
description: This article introduces solutions for keeping the latest updates on Windows computers.
ms.date: 12/26/2023
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-jomcc
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# How to keep your Windows computer up to date

This article helps your computer obtain the latest updates to protect the computer and make it run smoothly.

_Applies to:_ &nbsp; Windows XP  
_Original KB number:_ &nbsp; 311047

## Install high priority updates

Microsoft Update is the online extension of Windows that helps you keep your computer up to date. Microsoft Update includes updates from Windows Update and from Office Update, in addition to updates for other Microsoft products and for third-party device drivers. Use Microsoft Update to install updates for your computer's operating system, software, and hardware.

New content is added to the site regularly so that you can obtain recent updates and fixes to help protect your computer and to keep it running smoothly. To use the Microsoft Update site to install all critical updates for your computer, follow these steps:

1. Connect to the Internet, and then start Internet Explorer.
2. On the **Tools** menu, select **Windows Update**.
3. If Microsoft Update is not installed, select **Microsoft Update**. Otherwise, go to step 7.
4. On the **Try Microsoft Update today** Web page, select **Start Now**, and then select **Continue** on the **Review the license agreement** web page.
5. In the **Security Warning** dialog box, select **Install** to install Microsoft Update.

6. On the **Welcome to Microsoft update** web page, select **Check for Updates**
7. On the **Keep your computer up-to-date** web page, select **Express** to install high priority updates.

8. On the **Review and Install Updates** web page, select **Install Updates**, and then follow the instructions on the screen to complete the installation.

9. After you install the high priority updates, you can repeat these steps to install other updates. To do this, select **Custom** on the **Keep your computer up-to-date** web page. Then, you can select updates from the sections that are listed on the navigation pane.

## Automatic Updates feature

You can also use the Automatic Updates feature to install updates. By using Automatic Updates, you do not have to visit the Microsoft Update Web site to scan for updates. Instead, Windows automatically delivers them to your computer.

Automatic Updates recognizes when you are online, and searches for updates from the Windows Update Web site. An icon appears in the notification area at the far right of the taskbar every time that new updates are available. You can specify how and when you want Windows to update your computer. For example, you can configure Windows to automatically download and to install updates on a schedule that you specify. Or you can have Windows notify you when it finds updates that are available for your computer, and then download the updates in the background. This enables you to continue to work uninterrupted. After the download is completed, an icon appears in the notification area with a message that the updates are ready to be installed. When you select the icon or the message, you can install the new updates in a few steps. For more information about the Automatic Updates feature, see [Description of the Automatic Updates feature in Windows](https://support.microsoft.com/help/294871).

## Download Windows updates

Administrators can download updates from the **Microsoft Download Center** or the **Windows Update Catalog** to deploy to multiple computers. If you want to obtain updates to install later on one or more than one computer, use either the following web sites.

- [Windows Update Catalog](https://www.catalog.update.microsoft.com/home.aspx)

  For more information about how to download updates from the Windows Update Catalog, see [How to download updates that include drivers and hotfixes from the Windows Update Catalog](https://support.microsoft.com/help/323166).

- [Microsoft Download Center](https://www.microsoft.com/download/search.aspx)

  For more information about how to download files from the Microsoft Download Center, see [How to obtain Microsoft support files from online services](https://support.microsoft.com/help/119591).

## Install multiple Windows updates or hotfixes with only one restart

Administrators and IT professionals can install multiple Windows updates or hotfixes with only one restart.

## References

For more information about security tools and checklists, see [Microsoft Security Response Center](https://www.microsoft.com/msrc?rtc=1).

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
