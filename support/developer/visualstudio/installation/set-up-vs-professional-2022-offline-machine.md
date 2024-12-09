---
title: Set Up Visual Studio Professional 2022 on an Offline Machine
description: Describes how to set up Visual Studio Professional 2022 on an offline machine.
ms.date: 12/09/2024
ms.reviewer: khgupta
ms.custom: sap:Installation\Offline Install
ms.topic: how-to
---
# Set up Visual Studio Professional 2022 on an offline machine

To set up Visual Studio Professional 2022 on an offline machine, follow these steps:

1. Download the [web installer]( https://aka.ms/vs/17/release/vs_professional.exe) for the latest version of Visual Studio Professional 2022.
1. Create an offline installer for Visual Studio Professional 2022 using the command line `vs_professional.exe --LayOut "C:\Temp\VS2022Offline" --Lang en-US`.
1. After successfully creating the offline installer for Visual Studio Professional 2022, copy **C:\Temp\VS2022Offline** to the target offline machine.
1. Once the **C:\Temp\VS2022Offline** folder is copied to the target offline machine, execute the following command lines from an administrator command prompt:

   ```cmd
   "C:\Temp\VS2022Offline\vs_professional.exe" --noWeb --channelURI
   "C:\Temp\VS2022Offline\channelManifest.json"
   ```

1. Follow the remaining instructions in the setup wizard to complete the installation.
1. Once the installation is completed successfully, open any browser and browse to the [Microsoft M365 admin center](https://admin.microsoft.com/adminportal/home#/subscriptions/vlnew).
1. Sign in with your Visual Studio subscription account.
1. Navigate to the **Downloads and Keys** tab.
1. Search for **Visual Studio Professional 2022** and select **Key**.
1. Select the 25-digit volume license key and copy it.
1. Launch the Visual Studio 2022 shortcut as an administrator.
1. On the menu bar, select **Help** > **Register Product**.
1. Select the **Unlock with a Product Key** link.
1. Enter the 25-digit product key, and then select **Apply**.
