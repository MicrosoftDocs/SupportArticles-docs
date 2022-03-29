---
title: Install and maintain SaRA tool from a network share
description: Learn how to install SaRA from a network share and update the SaRA files so that SaRA installations use the latest files.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 110828, CI 114761, CI 115829, CI 116348, CI 117120
  - CSSTroubleshoot
  - SaRANetworkInstallFiles
ms.reviewer: gregmans
appliesto: 
  - Microsoft 365 Apps for enterprise
  - Outlook
search.appverid: MET150
---
# How to install and maintain Microsoft Support and Recovery Assistant (SaRA) from a network share

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

If you want to install and start Microsoft Support and Recovery Assistant (SaRA) from a shared location on a network instead of the default internet location, don't use the download link in the [About the Microsoft Support and Recovery Assistant](https://support.office.com/article/about-the-microsoft-support-and-recovery-assistant-e90bb691-c2a7-4697-a94f-88836856c72f) article. Instead, follow these steps.

> [!NOTE]
> If you're an enterprise customer, you can also run [the command-line version of Microsoft Support and Recovery Assistant](/office365/troubleshoot/administration/sara-command-line-version).

## Installing SaRA

1. Download SaRA by using the following link:  

   [SaRA network installation files](https://aka.ms/SaRANetworkInstallFiles)

2. In the downloaded file, extract the files from the **ClickOnce** folder to a shared network folder.
3. Install the SaRA tool. You can install it either at a command prompt or manually.

### By command

1. Select **Start**, type **cmd**, and then press Enter to open a Command Prompt window.
2. Type the path to SaraSetup.exe, and then press **Enter**.
    > [!NOTE]
    >
    > - You can use the quiet switch (**/q** or **/quiet**) to run Setup without any user interaction or user interface. For example, see the following screenshot.</br>
    > :::image type="content" source="media/install-sara-from-network-share/install-sara-by-using-command.png" alt-text="Microsoft Support and Recovery Assistant cmd line setup.":::
    > If the **/q** (or **/quiet**) switch is used, SaraSetup.exe runs in the background.
    > :::image type="content" source="media/install-sara-from-network-share/sarasetup-runs-in-background.png" alt-text="Microsoft Support and Recovery Assistant runs in quiet mode.":::
    > - To run the installation and see output from the setup process in the Command Prompt window, use **/d** or **/debug** instead of **/q** (or **/quiet**) at the command prompt. For example, see the following screenshot.
    > :::image type="content" source="media/install-sara-from-network-share/install-sara-by-using-debug-mode.png" alt-text="Microsoft Support and Recovery Assistant installation using debug mode.":::
    > - Use the **/?**, **/h**, or **/help** switches to display the following window that shows all available command-line switches for SaraSetup.exe.
    > :::image type="content" source="media/install-sara-from-network-share/all-command-line-switches-for-sarasetup.png" alt-text="All available command-line switches for SaraSetup.exe.":::
    If SaRA is installed by using the /q, /quiet, /d, or /debug switches, the End User License Agreement (EULA) is displayed when the Support and Recovery Assistant is started for the first time.

### Manual installation

To manually install the SaRA tool, follow these steps:

1. On the computer on which you want to install SaRA, browse to the shared folder.
1. Double-click **SaraSetup.exe**.
1. Select **Install**.
   :::image type="content" source="media/install-sara-from-network-share/manual-installation-of-sara.png" alt-text="Microsoft Support and Recovery Assistant manual setup page.":::
1. Wait for the download and installation process to finish.
   :::image type="content" source="media/install-sara-from-network-share/sara-installation-process-status.png" alt-text="Microsoft Support and Recovery Assistant setup installation progress.":::
1. After the installation is complete, and the End User License agreement has been accepted, the first Support and Recovery screen will be displayed.
   :::image type="content" source="media/install-sara-from-network-share/the-first-screen-shown-after-sara-installation-complete.png" alt-text="The Support and Recovery screen.":::

## Maintaining the SaRA installation folder and updating SaRA

The files for SaRA are updated regularly. You should update the SaRA files on the network share so that SaRA installations use the latest files. To keep your SaRA files up-to-date, follow these steps:

1. Download SaRA by using the link that is provided in the "Installing SaRA" section.
2. In the downloaded file, extract the program files from the **ClickOnce** folder.
3. Replace the existing program files in your shared network folder with the new extracted files.

Any computer that has SaRA already installed can now be updated by using the following steps. New installations of SaRA will also use the version that is available on the network share.

1. Start SaRA on a computer on which it's already installed.
2. Select **OK**, and wait for the update to finish.

   :::image type="content" source="media/install-sara-from-network-share/update-sara.png" alt-text="Microsoft Support and Recovery Assistant application update.":::

   :::image type="content" source="media/install-sara-from-network-share/sara-update-progress-status.png" alt-text="Microsoft Support and Recovery Assistant updating progress bar.":::

SaRA is now installed and ready to run troubleshooting scenarios.

:::image type="content" source="media/install-sara-from-network-share/the-first-screen-shown-after-sara-installation-complete.png" alt-text="The Support and Recovery screen.":::

## SaRA version history

One or two times a month, a new build of SaRA is available through the download link that is provided at the beginning of this article. To keep SaRA updated to have the latest version, we recommend that you follow the steps in the "Maintaining the SaRA installation folder and updating SaRA" section every month.

The following table provides the versions of SaRA that were made available on the specified date.

|Release date|SaRA version|
|--------|--------|
|March 17, 2022|17.00.8419.012|
|February 25, 2022|17.00.8006.010|
|January 13, 2022|17.00.7792.012|
|November 10, 2021|17.00.7513.007|
|October 20, 2021|17.00.7405.002|
|October 7, 2021|17.00.7332.000|
|July 12, 2021|17.00.6880.004|
|June 30, 2021|17.00.6805.016|
|March 16, 2021|17.00.6271.008|
|February 11, 2021|17.00.6125.006|
|January 25, 2021|17.00.5991.013|
|November 11, 2020|17.00.5665.007|
|October 20, 2020|17.00.5555.000|
|September 24, 2020|17.00.5390.006|
|September 15, 2020|17.00.5275.009|
|July 24, 2020|17.00.5057.004|
|July 2, 2020|17.00.4949.009|
|June 11, 2020|17.00.4840.008|
|May 28, 2020|17.00.4732.006|
|April 23, 2020|17.00.4589.001|
|April 6, 2020|17.00.4478.003|
|March 20, 2020|17.00.4376.007|
|March 11, 2020|17.00.4376.002|
|February 27, 2020|17.00.4304.006|
|February 5, 2020|17.00.4163.010|
|January 14, 2020|17.00.4058.000|
|December 9, 2019|17.00.3891.009|
|December 2, 2019|17.00.3711.012|

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
