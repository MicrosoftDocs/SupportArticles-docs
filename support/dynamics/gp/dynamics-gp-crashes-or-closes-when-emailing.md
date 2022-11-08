---
title: Dynamics GP crashes or closes when emailing
description: Microsoft Dynamics GP crashes/closes when emailing in Microsoft Dynamics GP. Provides resolutions.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Microsoft Dynamics GP crashes/closes when emailing in Microsoft Dynamics GP

This article provides resolutions for the Microsoft Dynamics GP crash issue when emailing in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4481244

## Symptoms

When e-mailing word templates in Microsoft dynamics GP and accessing any email/outlook functionality, the system will crash. This just started happening.

## Cause

This behavior may be caused by:

- Cause 1 - Office updates  (To check your Office version, go to **File** > **Office account** in Outlook.)

  common errors:

  APPCRASH ilmapi32.dll  
  APPCRASH olmapi32.dll  
  APPCRASH mso.dll

- Cause 2 - third-party products are installed.

## Resolution 1 - Roll back Microsoft office updates

Steps to roll back Microsoft office to the last build:

1. Disable office updates, go to **File** > **Office account** > **Update options** > **Disable updates**.
2. Open an elevated command prompt:
   1. **Start** > type *cmd*.
   2. Right-click on `CommandpPrompt`.
   3. Run as administrator.
   4. Provide your administrator credentials or confirm the User Account Control dialog when prompted.
3. Type *cd %programfiles%\Common Files\Microsoft Shared\ClickToRun\\*.
4. You can specify the built number to return to in the following way:

    **officec2rclient.exe /update user updatetoversion=\<build number>**  
    **OfficeC2RClient.exe /update user updatetoversion=16.0.11001.20074 (standard build)**  
    **OfficeC2RClient.exe /update user updatetoversion=16.0.11001.20038 (insiders build)**

5. Replace \<build number> with the build number that you want to return to.
   - There is an overview of build numbers you can return to for Office 2016.

6. After pressing Enter, a **Checking for updates** dialog will open shortly followed by a **Downloading office updates** dialog. Once this dialog closes, the rollback has been completed.

7. Open outlook and go back to: **File** > **Office account**.
8. In the Office updates section, it should now list the version that you specified.

## Resolution 2

Disable third-party products, or run a repair on your Microsoft Dynamics GP installation (to remove third parties, and then add them back one by one and test in-between to see which one is causing it.)

Rename Dynamics GP code folder and run a repair (to remove third-party products). Steps are:

1. Rename the GP20XX folder to bakGP20XX.
2. The run a repair on Microsoft Dynamics GP (this creates a clean install of Microsoft Dynamics GP).
3. Run Dynamics utilities.
4. Run Microsoft Dynamics GP.
5. Reinstall third-party apps one at a time and test.
