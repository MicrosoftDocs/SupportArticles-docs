---
title: Manually install prerequisites of Internet Explorer 9
description: Describes the additional software and components that are bundled with Internet Explorer when you install Internet Explorer 9. These items are prerequisites for installing and running Internet Explorer 9.
ms.date: 06/09/2020
ms.prod-support-area-path: 
ms.reviewer: jmann
---
# Prerequisites for installing Internet Explorer 9

This article helps you resolve the problem that some prerequisites of Internet Explorer 9 cannot be installed automatically.

_Original product version:_ &nbsp; Internet Explorer 9  
_Original KB number:_ &nbsp; 2399238

When you install Internet Explorer 9, additional software and components are also installed as part of the process. These are Internet Explorer 9 prerequisites, and their details vary, depending on the operating system that your computer is running. However, if some of these prerequisites can't be installed automatically, the Internet Explorer 9 installation process will not finish. In that case, you have to manually install the prerequisite software and components that are described later in this article.

## Things to consider before you go the manual install route

### Make sure that no updates are being installed and that no restart is pending

Internet Explorer 9 might not automatically install prerequisite software and components if the installation of other updates is in progress, or if the system is awaiting a restart. To check whether these things are causing the problem, do one of the following steps:

- In Windows 7, click Start, click Control Panel, and then click Windows Update.
- In Windows Vista, click Security in Control Panel, and then click Windows Update.

If an update installation is in progress, let the installation finish before you try to install Internet Explorer 9. If updates have been installed but the system has not yet been restarted, restart your computer before you try to install Internet Explorer 9.

Also note that if there's a restart pending, you may receive the following error message:

> The updates were not applicable.

### Make sure you're not running a prerelease version of Windows

If you're using a prerelease version of Windows, these updates will not install. And here too, you'll receive the **updates were not applicable** error message. When you receive this error message, make sure that your computer is running a released, genuine copy of Windows 7 or Windows Vista Service Pack 2 (SP2).

If you're not sure which version of Windows is installed, follow these steps:

1. Click **Start,** type *msinfo32* in the **Start Search** or **Search programs and files** box, and then press Enter.

    :::image type="content" source="media/prerequisites-for-installing-ie-9/search.png" alt-text="screenshot of the Search box":::

2. Locate your operating system next to **OS Name** and your system architecture type next to **System Type**.

    :::image type="content" source="media/prerequisites-for-installing-ie-9/system-information.png" alt-text="screenshot of System Information":::
  
## Manually install the Internet Explorer 9 prerequisites

If you've ruled out the automatic installation issues we asked you to consider in the previous section, go ahead and manually install the prerequisite software and components. To do this, use one of the following methods, as appropriate for the operating system you're running.

### For Windows 7 or Windows Server 2008 R2

- A performance and functionality update is available for Windows 7 and Windows Server 2008 R2 ([KB2454826](https://support.microsoft.com/help/2454826))

    [Download the x86 package now.](https://go.microsoft.com/fwlink/?linkid=207219)

    [Download the x64 package now.](https://go.microsoft.com/fwlink/?linkid=207220)

### For Windows Vista or Windows Server 2008

- Information about Service Pack 2 for Windows Vista and Windows Server 2008 ([KB948465](https://support.microsoft.com/help/948465))

    [Download the x86 package now.](https://download.microsoft.com/download/e/7/7/e77cba41-0b6b-4398-bbbf-ee121eec0535/windows6.0-kb948465-x86.exe)

    [Download the x64 package now.](https://download.microsoft.com/download/4/7/3/473b909b-7b52-49fe-a443-2e2985d3dfc3/windows6.0-kb948465-x64.exe)

- Description of the Windows Graphics, Imaging, and XPS Library ([KB971512](https://support.microsoft.com/help/971512))

    [Download the x86 package now.](https://go.microsoft.com/fwlink/?linkid=194467)

    [Download the x64 package now.](https://go.microsoft.com/fwlink/?linkid=194466)

- Platform update supplement for Windows Vista and Windows Server 2008 ([KB2117917](https://support.microsoft.com/help/2117917))

    > [!NOTE]
    > You must install update 971512 before you install this update.

    [Download the x86 package now.](https://go.microsoft.com/fwlink/?linkid=192581)

    [Download the x64 package now.](https://go.microsoft.com/fwlink/?linkid=194465)

## Known issues

You may receive an error message when you try to install Internet Explorer 9. Installation problems can have various causes. For more information about how to resolve these problems, see [How to troubleshoot Internet Explorer 9 installation problems](https://support.microsoft.com/help/2409098).
