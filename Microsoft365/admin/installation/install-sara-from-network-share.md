---
title: Install and maintain SaRA tool from a network share
description: Learn how to install SaRA from a network share and update the SaRA files so that SaRA installations use the latest files.
author: helenclu
ms.author: v-maqiu
manager: dcscontentpm 
audience: ITPro 
ms.topic: article
ms.prod: office 365
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
    > - You can use the quiet switch (**/q** or **/quiet**) to run Setup without any user interaction or user interface. For example, see the following screenshot.<br />
    > ![SaRA cmd line setup.](media//120760-1.png)<br />
    > If the **/q** (or **/quiet**) switch is used, SaraSetup.exe runs in the background.
    > ![SaRA runs in quiet mode.](media//120760-2.png)
    > - To run the installation and see output from the setup process in the Command Prompt window, use **/d** or **/debug** instead of **/q** (or **/quiet**) at the command prompt. For example, see the following screenshot.
    > ![SaRA installation using debug mode.](media//120760-3.png)
    > - Use the **/?**, **/h**, or **/help** switches to display the following window that shows all available command-line switches for SaraSetup.exe.
    > ![Command line switches for the SaRA setup.](media//120760-4.png)
    If SaRA is installed by using the /q, /quiet, /d, or /debug switches, the End User License Agreement (EULA) is displayed when the Support and Recovery Assistant is started for the first time.

### Manual installation

To manually install the SaRA tool, follow these steps:

1. On the computer on which you want to install SaRA, browse to the shared folder.
1. Double-click **SaraSetup.exe**.
1. Select **Install**.
   ![SaRA setup screen.](media//120760-5.png)
1.	Wait for the download and installation process to finish.
   ![SaRA setup installation progress.](media//120760-6.png)
1.	After the installation is complete, and the End User License agreement has been accepted, the first Support and Recovery screen will be displayed.
   ![The Support and Recovery screen.](media//120760-7.png)

## Maintaining the SaRA installation folder and updating SaRA

The files for SaRA are updated regularly. You should update the SaRA files on the network share so that SaRA installations use the latest files. To keep your SaRA files up-to-date, follow these steps:

1. Download SaRA by using the link that is provided in the "Installing SaRA" section.
2. In the downloaded file, extract the program files from the **ClickOnce** folder.
3. Replace the existing program files in your shared network folder with the new extracted files.

Any computer that has SaRA already installed can now be updated by using the following steps. New installations of SaRA will also use the version that is available on the network share.

1. Start SaRA on a computer on which it's already installed.
2. Select **OK**, and wait for the update to finish.

   ![Application update](./media//3.png)

   ![Installation progress bar](./media//5.png)

SaRA is now installed and ready to run troubleshooting scenarios.
![The Support and Recovery screen.](media//120760-7.png)

## SaRA version history

One or two times a month, a new build of SaRA is available through the download link that is provided at the beginning of this article. To keep SaRA updated to have the latest version, we recommend that you follow the steps in the "Maintaining the SaRA installation folder and updating SaRA" section every month.

The following table provides the versions of SaRA that were made available on the specified date.

|Release date|SaRA version|
|--------|--------|
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
|||

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
