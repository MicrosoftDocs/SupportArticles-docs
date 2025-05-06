---
title: Install Microsoft Support and Recovery Assistant from a network share or internet location
description: Learn how to install SaRA from a network share and update the SaRA files so that SaRA installations use the latest files.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 110828, CI 114761, CI 115829, CI 116348, CI 117120
  - CSSTroubleshoot
  - SaRANetworkInstallFiles
ms.reviewer: gregmans, meerak
appliesto: 
  - Microsoft 365 Apps for enterprise
  - Outlook
search.appverid: MET150
ms.date: 10/17/2024
---

# Install Microsoft Support and Recovery Assistant from a network share or internet location

> [!Important]
> Microsoft Support and Recovery Assistant features have migrated to [Get Help](https://support.microsoft.com/en-us/windows/about-get-help-717c7ae9-5c45-45f0-b637-900b7437a395).

You can install Microsoft Support and Recovery Assistant on your company's Windows-based devices from the following locations:

- Shared location on a network
- Internet source for installation files

**Note**: If you're an enterprise customer, you can run [the Enterprise version of Microsoft Support and Recovery Assistant](/microsoft-365/troubleshoot/administration/sara-command-line-version).

## Install the Assistant from a network location

1. Download the installation files from the following location:  

   [Network installation files for the Assistant](https://aka.ms/SaRANetworkInstallFiles)

2. In the downloaded files, open the **ClickOnce** folder and extract the program files to a shared network folder.
3. Install the Assistant.

   Run SaraSetup.exe either at a command prompt or manually.

### Install the Assistant at a command prompt

1. Select **Start**, type *cmd*, and then press Enter to open a Command Prompt window.
2. Type the path to *SaraSetup.exe*, and then press **Enter**.

**Note**:

- To run Setup without any user interaction or user interface, use the **/q** or **/quiet**switch. If either of these switches are used, SaraSetup.exe runs in the background.
- To run the installation and see output from the Setup process in the Command Prompt window, use the **/d** or **/debug** switch instead of the **/q** or **/quiet** switch at the command prompt.
- Use the **/?**, **/h**, or **/help** switch to display a window that shows all available command-line switches for SaraSetup.exe.
- If the Assistant is installed by using the /q, /quiet, /d, or /debug switch, the End User License Agreement is displayed when the Assistant starts for the first time.

### Install the Assistant manually

1. On the computer on which you want to install the Assistant, browse to the shared network folder.
1. Double-click **SaraSetup.exe**.
1. Select **Install**.
1. Wait for the download and installation process to finish.
1. After the installation is complete, and you accept the End User License agreement, the first screen of the Assistant appears.

### Update the installation files on the network share

The network installation files for the Assistant are republished regularly. You should update the files on your network share so that all installations of the Assistant use the latest files.

To keep the Assistant files up to date, follow these steps:

1. Download the installation files from [Network installation files for the Assistant](https://aka.ms/SaRANetworkInstallFiles).
2. In the downloaded files, open the **ClickOnce** folder and extract the program files to a shared network folder.
3. Replace the existing program files in your shared network folder with the new extracted files.

New installations of the Assistant use the latest version that is available on the network share. Existing installations of the Assistant can now be updated by using the following steps:

1. Start the Assistant on a computer on which it's already installed.
2. Select **OK**, and wait for the update to finish.

The Assistant is now updated and ready to run troubleshooting scenarios.

## Script the Assistant installation from the internet source

A drawback of the network installation version of the Assistant is that you have to update the files for the Assistant on your network share manually. If this maintenance task is a roadblock to deploying the Assistant, you can use the following sample script to install the Assistant from its internet source.

If you use this approach, the Assistant will update automatically to the newest version available on the internet every time that it starts.

[Sample script to install the Assistant from the internet source](https://aka.ms/SaRAInternetInstall)

This script installs the Assistant by using the following default steps:

1.	Download SaraSetup.exe from the internet [https://aka.ms/SaRA-Internet-Setup](https://aka.ms/SaRA-Internet-Setup) into the %Temp% folder.
2.	Make sure that the download is successful (the script ends if there's a download failure).
3.	Install the Assistant without user interaction (by using the **/q** or **/quiet** switch).
4.	Log the installation process in *%Temp%\SaraSetupLog_\<timestamp\>.txt*.
5.	Make sure that the installation is successful (the script ends if the installation fails).
6.	Delete SaraSetup.exe from the %Temp% folder.

There are several variables in the script that can be modified, including the download folder, the folder location for the log file, and the log filename.

**Note**:

- Detailed instructions for the script are provided in the included comments.
- The End-User License Agreement is displayed when the Assistant starts the first time.

## Version history of the Assistant

A new build of the Assistant is released every 90 days. The following table provides the versions that were made available on the specified dates.

|Release date|Version of the Assistant|
|--------|--------|
|Nov 12, 2024|17.01.2465.000|
|Oct 8, 2024|17.01.2352.000|
|Sep 10, 2024|17.01.2276.000|
|Aug 13, 2024|17.01.2176.000|
|Jul 9, 2024|17.01.2011.000|
|Jun 11, 2024|17.01.1903.000|
|May 14, 2024|17.01.1814.000|
|April 9, 2024|17.01.1659.000|
|March 12, 2024|17.01.1602.000|
|February 20, 2024|17.01.1440.000|
|June 6, 2023|17.01.0268.003|
|April 21, 2023|17.01.0040.005|
|January 26, 2023|17.00.9663.002|
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
