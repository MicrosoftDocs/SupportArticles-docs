---
title: Chinese IME dictionaries shows "not ready yet" in Windows Server 2022
description: Provides a workaround to fix the issue that occurs in Windows Server 2022 when you enable Chinese keyboard layouts.
ms.date: 45286
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: yyan, v-sidong
ms.custom: sap:installing-or-upgrading-windows, csstroubleshoot
---

# Chinese IME dictionaries shows "not ready yet" in Windows Server 2022

This article provides a workaround to resolve the issue that occurs when a Standard user enables the Chinese keyboard layouts.

## Error: Chinese IME dictionaries are not ready yet

In Windows Server 2022, when a Standard user enables a Chinese keyboard layout, like **Chinese (Simplified, China)**, **Chinese (Traditional, HongKong SAR)** or **Chinese (Traditional, Taiwan)**, the user can't input Chinese characters and sees an error message that resembles the following one:

> Simplified Chinese IME dictionaries are not ready yet.  
  Please check the status from language setting.

The issue occurs because the Chinese IME dictionaries are included in the **basic typing** package of [Features on Demand](/windows-hardware/manufacture/desktop/features-on-demand-v2--capabilities) (FODs) instead of Windows image files.

> [!NOTE]
> Adding the **basic typing** package of FODs requires administrator permission.

## Workarounds

To work around the issue, use one of the following methods as an administrator:

- To use the offline command to work around the issue, follow these steps:

    1. Run the following [Deployment Image Servicing and Management](/windows-hardware/manufacture/desktop/what-is-dism) (DISM) command in your **Command Prompt** window to mount your Windows image:

        ```cmd
        md C:\mount\windows
        Dism /Mount-Image /ImageFile:install.wim /Index:1 /MountDir:"C:\mount\windows"
        ```

    1. Add the FODs package by running the command `Dism /Image:"C:\mount\windows" /Add-Package /PackagePath:"<FilePath>\<PackageName>.cab"` in your **Command Prompt** window. For example:

        ```cmd
        Dism /Image:"C:\mount\windows" /Add-Package /PackagePath:"C:\users\Administrator\Desktop\Microsoft-Windows-LanguageFeatures-Basic-zh-cn-Package~31bf3856ad364e35~amd64~~.cab"
        ```

    1. Unmount the image by running the following command in your **Command Prompt** window:

        ```cmd
        Dism /Unmount-Image /MountDir:C:\mount\windows /Commit
        ```

- To work around the issue by using the online command, run the command `Dism /online /Add-Package /PackagePath:"<FilePath>\<PackageName>.cab"` in your **Command Prompt** window to add FODs. For example:

    ```cmd
    Dism /online /Add-Package /PackagePath:"C:\users\Administrator\Desktop\Microsoft-Windows-LanguageFeatures-Basic-zh-cn-Package~31bf3856ad364e35~amd64~~.cab"
    ```

    > [!NOTE]
    > When running the command, use your own file path and the cab package you downloaded.

## More information

- [Add languages to Windows images](/windows-hardware/manufacture/desktop/add-language-packs-to-windows)

- [Adding or removing Features on Demand](/windows-hardware/manufacture/desktop/features-on-demand-v2--capabilities#adding-or-removing-features-on-demand)

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
