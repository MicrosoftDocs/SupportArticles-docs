---
title: Chinese IME dictionaries are not ready yet
description: Provides a workaround to resolve the issue that occurs when you enable the Chinese (CHS, CHT) keyboard layouts by using the function InstallLayoutOrTip.
ms.date: 03/09/2022
ms.reviewer: yyan
ms.technology: windows-dev-apps-desktop-app-ui-dev
---

# Chinese IME dictionaries are not ready yet in Windows Server 2022

This article provides a workaround to resolve the issue that occurs when a Standard user enables the Chinese keyboard layouts by using the function `InstallLayoutOrTip`.

## Symptoms

In Windows Server 2022, when a Standard user uses the function `InstallLayoutOrTip` to enable the Chinese keyboard layouts (CHS or CHT), the user can't input Chinese and sees an error message that resembles the following one:

> Simplified Chinese IME dictionaries are not ready yet.  
  Please check the status from language setting.

## Cause

The issue occurs because the Chinese IME dictionaries are included in [Features on Demand](/windows-hardware/manufacture/desktop/features-on-demand-v2--capabilities) (FODs) instead of Windows image files.

> [!NOTE]
> Adding the FODs "basic typing" requires administrator permission.

## Workarounds

To work around the issue, use one of the following methods:

- Pre-install the FODs in the Windows image.

- Run the following [Deployment Image Servicing and Management](/windows-hardware/manufacture/desktop/what-is-dism) (DISM) command to add FODs with administrator privilege:

    ```cmd
    DISM.exe /image:C:\mount\Windows /add-package /packagepath:E:\Microsoft-Windows-Holographic-Desktop-FOD-Package~31bf3856ad364e35~amd64~~.cab`
    ```

    For more information, see [Adding or removing Features on Demand](/windows-hardware/manufacture/desktop/features-on-demand-v2--capabilities#adding-or-removing-features-on-demand).
