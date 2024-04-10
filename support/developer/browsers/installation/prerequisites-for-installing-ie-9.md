---
title: Manually install prerequisites of Internet Explorer 9
description: Describes the software and components that are bundled with Internet Explorer when you install Internet Explorer 9. These items are prerequisites for installing and running Internet Explorer 9.
ms.date: 06/09/2020
ms.reviewer: jmann
---
# Prerequisites for installing Internet Explorer 9

[!INCLUDE [](../../../includes/browsers-important.md)]

This article helps you resolve the problem that some prerequisites of Internet Explorer 9 can't be installed automatically.

_Original product version:_ &nbsp; Internet Explorer 9  
_Original KB number:_ &nbsp; 2399238

When you install Internet Explorer 9, additional software and components are also installed as part of the process. They are Internet Explorer 9 prerequisites. Their details vary, depending on the operating system that your computer is running. If some of these prerequisites can't be installed automatically, the Internet Explorer 9 installation process won't finish. In that case, you must manually install the prerequisite software and components that are described later in this article.

## Things to consider before you go the manual install route

### Make sure that no updates are being installed and that no restart is pending

Internet Explorer 9 might not automatically install prerequisite software and components if one of the following conditions is true:

- The installation of other updates is in progress.
- The system is awaiting a restart.

To check whether these things are causing the problem, do one of the following steps:

- In Windows 7, click Start, click Control Panel, and then click Windows Update.
- In Windows Vista, click Security in Control Panel, and then click Windows Update.

If an update installation is in progress, let the installation finish before you try to install Internet Explorer 9. If updates have been installed but the system hasn't yet been restarted, restart your computer before you try to install Internet Explorer 9.

Also note that if there's a restart pending, you may receive the following error message:

> The updates were not applicable.

### Make sure you're not running a prerelease version of Windows

If you're using a prerelease version of Windows, these updates won't install. And you'll receive the **updates were not applicable** error message. When you receive this error message, make sure that your computer is running a released, genuine copy of Windows 7 or Windows Vista Service Pack 2 (SP2).

If you're not sure which version of Windows is installed, follow these steps:

1. Click **Start,** type *msinfo32* in the **Start Search** or **Search programs and files** box, and then press Enter.

    :::image type="content" source="media/prerequisites-for-installing-ie-9/search.png" alt-text="Screenshot of the Search box, with msinfo32 input.":::

2. Locate your operating system next to **OS Name** and your system architecture type next to **System Type**.

    :::image type="content" source="media/prerequisites-for-installing-ie-9/system-information.png" alt-text="Screenshot of System Information, highlighting OS name and System Type items.":::
  
## Manually install the Internet Explorer 9 prerequisites

If you've ruled out the automatic installation issues we asked you to consider in the previous section, go ahead and manually install the prerequisite software and components. To do so, use one of the following methods, as appropriate for the operating system you're running.

### For Windows 7 or Windows Server 2008 R2

- A performance and functionality update is available for Windows 7 and Windows Server 2008 R2 ([KB2454826](https://support.microsoft.com/help/2454826))

    [Download the packages now.](https://www.catalog.update.microsoft.com/Search.aspx?q=2454826)

### For Windows Vista or Windows Server 2008

- Information about Service Pack 2 for Windows Vista and Windows Server 2008 ([KB948465](https://support.microsoft.com/help/948465))

- Description of the Windows Graphics, Imaging, and XPS Library ([KB971512](https://support.microsoft.com/help/971512))

- Platform update supplement for Windows Vista and Windows Server 2008 ([KB2117917](https://support.microsoft.com/help/2117917))

    > [!NOTE]
    > You must install update 971512 before you install this update.

## Known issues

You may receive an error message when you try to install Internet Explorer 9. Installation problems can have various causes. For more information about how to resolve these problems, see [How to troubleshoot Internet Explorer 9 installation problems](https://support.microsoft.com/help/2409098).
