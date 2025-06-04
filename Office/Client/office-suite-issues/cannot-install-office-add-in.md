---
title: We can't Start this App When Installing an Office Add-in
description: Resolves an error that occurs when you try to install an Office add-in from the Office Store.
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)
  - CSSTroubleshoot
ms.topic: troubleshooting
appliesto: 
  - Microsoft 365 Apps
  - Office 2024
  - Office 2021
  - Office 2019
  - Office 2016
ms.date: 06/04/2025
---
# Error "We can't start this app" when you install an Office add-in

## Symptoms

When you try to install an add-in from the Office Store, you receive the following error message:

> We can't start this app because it isn't set up properly.

## Cause

This issue occurs because of incorrect information in the Windows registry.

## Resolution

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft can't guarantee that these problems can be solved. Modify the registry at your own risk.

To resolve this problem, follow these steps:

1. Exit any open Office applications.
1. Start Registry Editor. To do so, press the Windows key+R to open the Run window, type *regedit*, and then press Enter.
1. Locate and select the following subkey:

   `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\WEF\Providers`
1. For each subkey under **Providers**, follow these steps:

   1. Select the subkey and check the value data for its `UniqueId` value.
   1. If the value of `UniqueId` is one of the following values, delete the subkey.

      - **\<GUID\>_ADAL**: \<GUID\> is a random set of numbers and letters, such as 3a975b5d-ad3e-4e3d-84b0-a7e6776ba6a6.
      - **Anonymous**

     For example, the subkey under `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\WEF\Providers` is `KpwDSnL9jumf9ZJTx_XF_Q==`, and the value of its `UniqueId` is `3a975b5d-ad3e-4e3d-84b0-a7e6776ba6a6_ADAL`. In this case, delete the `KpwDSnL9jumf9ZJTx_XF_Q==` subkey.
1. Exit Registry Editor.
1. Open File Explorer and delete the following folder:

   `C:\Users\<your username>\AppData\Local\Microsoft\Office\16.0\Wef`

   If you can't locate the folder, press the Windows key+R to open the Run window, type the following path, and then select **OK**:

   ```console
   %localappdata%\microsoft\office\16.0\Wef
   ```
