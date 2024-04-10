---
title: How to repair or reinstall Internet Explorer
description: Discusses how to repair or reinstall Internet Explorer in Windows.
ms.date: 10/13/2020
ms.reviewer: wellsluo, ramakoni
---
# How to reinstall or repair Internet Explorer in Windows

[!INCLUDE [](../../../includes/browsers-important.md)]

If you experience a recurring problem when you use Internet Explorer in Windows, you may try to [repair](#repair-internet-explorer-in-windows) or [reinstall](#reinstall-internet-explorer-in-windows) the program to fix the problem. Although this may sound intimidating, this article offers the most direct, trouble-free methods to perform this task.

_Original product version:_ &nbsp; Internet Explorer 11, Internet Explorer 10, Internet Explorer 9  
_Original KB number:_ &nbsp; 318378

## Repair Internet Explorer in Windows

You can reset the program settings to repair your Internet Explorer. To do this, use the following procedure:

1. Exit all programs, including Internet Explorer.
2. Press the Windows logo key+R to open the **Run** box.
3. Type _inetcpl.cpl_ and select **OK**.
4. The **Internet Options** dialog box appears.
5. Select the **Advanced** tab.
6. Under **Reset Internet Explorer** settings, select **Reset**. Then select **Reset** again.
7. Select the **Delete personal settings** check box if you also want to remove browsing history, search providers, Accelerators, home pages, Tracking Protection, and ActiveX Filtering data.
8. When Internet Explorer finishes resetting the settings, select **Close** in the **Reset Internet Explorer Settings** dialog box.
9. Start Internet Explorer again.

For more information about how to reset settings in Internet Explorer, see the following video.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/c989d6d8-f8f9-4cb5-a2f1-da6a7e89f18b]

## Disable and enable Internet Explorer

To disable and enable Internet Explorer 11, see [Disable and enable Internet Explorer on Windows](disable-internet-explorer-windows.md).

## Reinstall Internet Explorer in Windows

### Windows 8.1 and Windows 10

You can use the System File Checker tool to repair missing or corrupted system files to validate the corresponding system files.

### Windows 7, Windows Server 2008 R2, Windows Vista, and Windows Server 2008 SP2

**Step 1:** Download Internet Explorer that can be installed on your Operating system using the following table as guidance.

|Windows version |Internet Explorer version that can be installed |
|---|---|
|Windows 7, Windows Server 2008 R2 |[Download Internet Explorer 11 (Offline installer)](https://support.microsoft.com/topic/download-internet-explorer-11-offline-installer-99d492a1-3a62-077b-c476-cf028aff9a7f)|
|Windows Vista, Windows Server 2008 SP2|- Windows Internet Explorer 9 (64 Bit)<br/>- Windows Internet Explorer 9 (32 Bit)|
  
**Step 2:** Uninstall the version of Internet Explorer that you may have installed on top of Internet Explorer 8.0 (For Windows Vista it is Internet Explorer 7.0) that natively ships with and installed as part of the operating system.

> [!NOTE]
> Internet Explorer 8.0 (or Internet Explorer 7.0 on Vista) will continue to exist even after you uninstall newer versions.

Use the following procedure to remove Internet Explorer:

1. On the **Start** page, choose **Control Panel**, and then choose **Programs and Features**.

2. Under **Programs and Features**, select **View installed updates** on left pane.

3. Under Uninstall an update list, select applicable Internet Explorer version from the list (Internet Explorer 11 or Windows Internet Explorer 9) and select **Yes** to confirm uninstallation and restart your system to complete the process.

**Step 3:** Install the version of Internet Explorer that you downloaded in Step 1 and restart the system after installation.

> [!TIP]
> After you reinstall Internet Explorer, run Windows Update to apply any available updates for Internet Explorer.

## See also

- [How to disable Internet Explorer on Windows](https://support.microsoft.com/help/4013567/how-to-disable-internet-explorer-on-windows)
- [Which version of Internet Explorer am I using?](https://support.microsoft.com/help/17295/internet-explorer-which-version-am-i-using)

If you still can't access some websites, get help from the [Microsoft Community online](https://answers.microsoft.com/).
