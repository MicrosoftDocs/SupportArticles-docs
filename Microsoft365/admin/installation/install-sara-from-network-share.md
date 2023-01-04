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
ms.date: 3/31/2022
---
# How to install and maintain Microsoft Support and Recovery Assistant (SaRA) from a network share or Internet location

If you manage Windows devices for your company and you want to install the Microsoft Support and Recovery Assistant (also referred to as Assistant) on multiple machines, you have a couple of installation options:

 - Shared location on a network
 - Internet location

> [!NOTE]
> If you're an enterprise customer, you can also run [the Enterprise version of Microsoft Support and Recovery Assistant](/microsoft-365/troubleshoot/administration/sara-command-line-version).

## Installing the Assistant from a network location

1. Download the Assistant:  

   [SaRA network installation files](https://aka.ms/SaRANetworkInstallFiles)

2. In the downloaded file, extract the files from the **ClickOnce** folder to a shared network folder.
3. Install the Assistant. 

   Use SaraSetup.exe to either install it at a command prompt or manually.

### Command prompt installation of the Assistant

1. Select **Start**, type **cmd**, and then press Enter to open a Command Prompt window.
2. Type the path to SaraSetup.exe, and then press **Enter**.
    > [!NOTE]
    >
    > - You can use the quiet switch (**/q** or **/quiet**) to run Setup without any user interaction or user interface.
    > If the **/q** (or **/quiet**) switch is used, SaraSetup.exe runs in the background.
    > - To run the installation and see output from the setup process in the Command Prompt window, use **/d** or **/debug** instead of **/q** (or **/quiet**) at the command prompt.
    > - Use the **/?**, **/h**, or **/help** switches to display a window that shows all available command-line switches for SaraSetup.exe.
    > - If the Assistant is installed by using the /q, /quiet, /d, or /debug switches, the End User License Agreement (EULA) is displayed when the Support and Recovery Assistant is started for the first time.

### Manual installation of the Assistant

To manually install the Assistant, follow these steps:

1. On the computer on which you want to install the Assistant, browse to the shared folder.
1. Double-click **SaraSetup.exe**.
1. Select **Install**.
1. Wait for the download and installation process to finish.
1. After the installation is complete, and the End User License agreement has been accepted, the first Assistant screen is displayed.

### Maintaining the network installation folder and updating the Assistant

The files for the Assistant are republished regularly. You should update the files on the network share so that installations of the Assistant use the latest files. 

To keep the Assistant files up-to-date, follow these steps:

1. Download the Assistant by using the link that is provided in the "Installing the Assistant from a network location" section.
2. In the downloaded file, extract the program files from the **ClickOnce** folder.
3. Replace the existing program files in your shared network folder with the new extracted files.

Any computer that has the Assistant already installed can now be updated by using the following steps. New installations of the Assistant will also use the new version that is available on the network share.

1. Start the Assistant on a computer on which it's already installed.
2. Select **OK**, and wait for the update to finish.

The Assistant is now installed and ready to run troubleshooting scenarios.

## Scripted installation from the Internet

The main drawback to the network installation version of the Assistant is that you have to manually keep the files for the Assistant updated on your network share. If this maintenance task is either a roadblock to deploying the Assistant or you simply want to instead deploy the Assistant a different way, you can use the following sample script to install the Assistant from its Internet source.

If you use this approach to install the Assistant, updating of the Assistant automatically occurs each time the Assistant is started (assuming there is a newer build available on the Internet).

[Download sample script to install the Assistant from the Internet](https://aka.ms/SaRAInternetInstall)

This script installs the Assistant using the following default steps:
1.	Download SaraSetup.exe from the Internet (https://aka.ms/SaRA-Internet-Setup) into the %Temp% folder.
2.	Ensure the download is successful (script ends if there's a download failure)
3.	Install the Assistant without user interaction (using the /quiet switch)
4.	Log the installation process in %Temp%\SaraSetupLog _<timestamp>.txt
5.	Ensure the installation is successful (script ends if the installation fails)
6.	Delete SaraSetup.exe from the %Temp% folder

    There are several variables in the script that can be modified to control, for example, the download folder, the folder location for the log file, and the log filename.
  
    > [!NOTE]
    >
    > Detailed instructions for the script are provided in the comments included with the script.
    >
    > Note, the End-User License Agreement (EULA) is shown on first launch of the Assistant.

## SaRA version history

One or two times a month, a new build of SaRA is available through the download link that is provided at the beginning of this article. To keep SaRA updated to have the latest version, we recommend that you follow the steps in the "Maintaining the SaRA installation folder and updating SaRA" section every month.

The following table provides the versions of SaRA that were made available on the specified date.

|Release date|SaRA version|
|--------|--------|
|October 20, 2022|17.00.9167.015|
|September 20, 2022|17.00.9001.010|
|August 25, 2022|17.00.8900.012|
|July 7, 2022|17.00.8713.001|
|May 20, 2022|17.00.8433.013|
|April 15, 2022|17.00.8291.010|
|March 17, 2022|17.00.8149.012|
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
