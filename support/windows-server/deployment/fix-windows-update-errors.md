---
title: Fix Windows Update errors via DISM or System Update Readiness tool
description: Use the System Update Readiness Tool or the DISM tool to fix problems that prevent Windows Update from installing successfully.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, chkeen, cgibson, jesko
ms.prod-support-area-path: Servicing
ms.technology: windows-server-deployment
adobe-target: true
---
# Fix Windows Update errors by using the DISM or System Update Readiness tool

_Applies to:_ &nbsp; Windows 10, version 1809 and later versions, Windows 8.1, Windows Server 2012 R2, Windows 7, Windows Server 2008 R2  
_Original KB number:_ &nbsp; 947821

## Symptom

Windows updates and service packs may fail to install if there are [corruption errors](#description-of-the-common-corruption-errors). For example, an update might not install if a system file is damaged. The DISM or [System Update Readiness tool](#what-does-the-system-update-readiness-tool-do) may help you to fix some Windows corruption errors.

This article is intended for Support agents and IT professionals. If you are home users and looking for more information about fixing Windows update errors, see [Fix Windows Update errors](https://support.microsoft.com/help/10164).

## Resolution for Windows 8.1, Windows 10 and Windows Server 2012 R2

To resolve this problem, use the inbox Deployment Image Servicing and Management (DISM) tool. Then, install the Windows update or service pack again.

1. Open an elevated command prompt. To do this, open **Start** menu or **Start** screen, type *Command Prompt*, right-select **Command Prompt**, and then select **Run as administrator**. If you are prompted for an administrator password or for a confirmation, type the password, or select **Allow**.

2. Type the following command, and then press Enter. It may take several minutes for the command operation to be completed.

    ```console
    DISM.exe /Online /Cleanup-image /Restorehealth
    ```

    > [!IMPORTANT]
    > When you run this command, DISM uses Windows Update to provide the files that are required to fix corruptions. However, if your Windows Update client is already broken, use a running Windows installation as the repair source, or use a Windows side-by-side folder from a network share or from a removable media, such as the Windows DVD, as the source of the files. To do this, run the following command instead:

    ```console
    DISM.exe /Online /Cleanup-Image /RestoreHealth /Source:C:\RepairSource\Windows /LimitAccess
    ```

    > [!NOTE]
    > Replace the *C:\RepairSource\Windows* placeholder with the location of your repair source. For more information about using the DISM tool to repair Windows, reference [Repair a Windows Image](/previous-versions/windows/it-pro/windows-8.1-and-8/hh824869(v=win.10)).

3. Type the `sfc /scannow` command and press Enter. It may take several minutes for the command operation to be completed.

4. Close the command prompt, and then run **Windows Update** again.

DISM creates a log file (%windir%/Logs/CBS/CBS.log) that captures any issues that the tool found or fixed. %windir% is the folder in which Windows is installed. For example, the %windir% folder is C:\Windows.

## Resolution for Windows 7 and Windows Server 2008 R2

To resolve this problem, use the System Update Readiness tool. Then, install the Windows update or service pack again.

1. Download the System Update Readiness tool.

    Go to [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=947821) and download the tool that corresponds to the version of Windows that is running on your computer. For more information about how to find the version of Windows that you installed, see [Find out if your computer is running the 32-bit or 64-bit version of Windows](https://support.microsoft.com/help/15056).

    > [!NOTE]
    > This tool is updated regularly, we recommend that you always download the latest version. This tool is not available in every supported language. Check the link below to see if it is available in your language.

2. Install and run the tool.
   1. Select **Download** on the Download Center webpage, then do one of the following:
      - To install the tool immediately, select **Open** or **Run**, and then follow the instructions on your screen.
      - To install the tool later, select **Save**, and then download the installation file to your computer. When you're ready to install the tool, double-select the file.
   2. In the Windows Update Standalone Installer dialog box, select **Yes**.

      :::image type="content" source="media/fix-windows-update-errors/windows-update-standalone-installer.png" alt-text="Windows Update Standalone Installer dialog box" border="false":::

3. When the tool is being installed, it automatically runs. Although it typically takes less than 15 minutes to run, it might take much longer on some computers. Even if the progress bar seems to stop, the scan is still running, so don't select **Cancel**.

    :::image type="content" source="media/fix-windows-update-errors/updates-are-being-installed-progress-window.png" alt-text="Download and Install updates - The updates are being installed progress window" border="false":::

4. When you see Installation complete, select **Close**.

    :::image type="content" source="media/fix-windows-update-errors/installation-complete.png" alt-text="Download and install Updates - Installation complete" border="false":::

5. Reinstall the update or service pack you were trying to install previously.

To manually fix corruption errors that the tool detects but can't be fixed, see [How to fix errors that are found in the CheckSUR log file](#how-to-fix-errors-that-are-found-in-the-checksur-log-file).

## Resolution - Download the package from Microsoft Update Catalog directly

You can also try to directly download the update package from [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/home.aspx), and then install the update package manually.

For example, you may have problems when you try to install updates from Windows Update. In this situation, you can download the update package and try to install the update manually. To do this, follow these steps:

1. Open [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/home.aspx) in Internet Explorer.

    :::image type="content" source="media/fix-windows-update-errors/microsoft-update-catalog.jpg" alt-text="Microsoft Update Catalog in Internet Explorer" border="false":::

2. In the search box, input the update number that you want to download. In this example, input 3006137. Then, select **Search**.

    :::image type="content" source="media/fix-windows-update-errors/search-in-microsoft-update-catalog.jpg" alt-text="Microsoft Update Catalog - Search" border="false":::

3. Find the update that applies to your operating system appropriately in the search results, and then select **Add** to add the update to your basket.

    :::image type="content" source="media/fix-windows-update-errors/search-results-in-microsoft-update-catalog.jpg" alt-text="Microsoft Update Catalog search results" border="false":::

4. Select **view basket** to open your basket.

    :::image type="content" source="media/fix-windows-update-errors/view-basket.jpg" alt-text="Microsoft Update Catalog - view basket" border="false":::

5. Select **Download** to download the update in your basket.

    :::image type="content" source="media/fix-windows-update-errors/download-the-update-in-your-basket.jpg" alt-text="Microsoft Update Catalog - your basket":::

6. Select **Browse** to choose a location for the update you are downloading, and then select **Continue**.

    :::image type="content" source="media/fix-windows-update-errors/download-options.jpg" alt-text="Microsoft Update Catalog - Download Options":::

7. Select **Close** after the download process is done. Then, you can find a folder that contains the update package in the location that you specified.
8. Open the folder, and then double-select the update package to install the update.

If the Windows update or service pack installed successfully, you are finished. If the problem is not fixed, or if System Update Readiness Tool cannot find the cause, [contact us for more help](https://support.microsoft.com/contactus/).

## Description of the common corruption errors

The following table lists the possible error code with Windows Update for your reference:

|Code|Error|Description|
|---|---|---|
|0x80070002|ERROR_FILE_NOT_FOUND|The system cannot find the file specified.|
|0x8007000D|ERROR_INVALID_DATA|The data is invalid.|
|0x800F081F|CBS_E_SOURCE_MISSING|The source for the package or file not found.|
|0x80073712|ERROR_SXS_COMPONENT_STORE_CORRUPT|The component store is in an inconsistent state.|
|0x800736CC|ERROR_SXS_FILE_HASH_MISMATCH|A component's file does not match the verification information present in the component manifest.|
|0x800705B9|ERROR_XML_PARSE_ERROR|Unable to parse the requested XML data.|
|0x80070246|ERROR_ILLEGAL_CHARACTER|An invalid character was encountered.|
|0x8007370D|ERROR_SXS_IDENTITY_PARSE_ERROR|An identity string is malformed.|
|0x8007370B|ERROR_SXS_INVALID_IDENTITY_ATTRIBUTE_NAME|The name of an attribute in an identity is not within the valid range.|
|0x8007370A|ERROR_SXS_INVALID_IDENTITY_ATTRIBUTE_VALUE|The value of an attribute in an identity is not within the valid range.|
|0x80070057|ERROR_INVALID_PARAMETER|The parameter is incorrect.|
|0x800B0100|TRUST_E_NOSIGNATURE|No signature was present in the subject.|
|0x80092003|CRYPT_E_FILE_ERROR|An error occurred while Windows Update reads or writes to a file.|
|0x800B0101|CERT_E_EXPIRED|A required certificate is not within its validity period when verifying against the current system clock or the time stamp in the signed file.|
|0x8007371B|ERROR_SXS_TRANSACTION_CLOSURE_INCOMPLETE|One or more required members of the transaction are not present.|
|0x80070490|ERROR_NOT_FOUND|Windows could not search for new updates.|
|0x800f0984|PSFX_E_MATCHING_BINARY_MISSING|Matching component directory exist but binary missing|
|0x800f0986|PSFX_E_APPLY_FORWARD_DELTA_FAILED|Applying forward delta failed|
|0x800f0982|PSFX_E_MATCHING_COMPONENT_NOT_FOUND|Can't identify matching component for hydration|
||||

## What does the System Update Readiness tool do

### Verify the integrity of resources

The System Update Readiness tool verifies the integrity of the following resources:

- Files that are located in the following directories:
  - %SYSTEMROOT%\Servicing\Packages
  - %SYSTEMROOT%\WinSxS\Manifests
- Registry data that is located under the following registry subkeys:
  - HKEY_LOCAL_MACHINE\Components
  - HKEY_LOCAL_MACHINE\Schema
  - HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing

This list may be updated at any time.

When the System Update Readiness tool detects incorrect manifests, Cabinets, or registry data, it may replace the incorrect data with a corrected version.

### Logging

The System Update Readiness tool creates a log file that captures any issues that the tool found or fixed. The log file is located here:

- %SYSTEMROOT%\Logs\CBS\CheckSUR.log
- %SYSTEMROOT%\Logs\CBS\CheckSUR.persist.log

## How to fix errors that are found in the CheckSUR log file

To manually fix corruption errors that the System Update Readiness tool detects but can't fix, follow these steps:

1. Open %SYSTEMROOT%\Logs\CBS\CheckSUR.log.

    > [!NOTE]
    > %SYSTEMROOT% is an environment variable that saves the folder in which Windows is installed. For example, generally the %SYSTEMROOT% folder is C:\Windows.

2. Identify the packages that the tool can't fix. For example, you may find the following in the log file:

    ```output
    Summary:
    
    Seconds executed: 264  
    Found 3 errors  
    CBS MUM Missing Total Count: 3  
    Unavailable repair files:  
    
    servicing\packages\Package_for_KB958690_sc_0~31bf3856ad364e35~amd64~~6.0.1.6.mum  
    ...
    ```

    In this case, the package that is corrupted is KB958690.

3. Download the package from [Microsoft Download Center](https://www.microsoft.com/download) or [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/home.aspx).

4. Copy the package (.msu) to the `%SYSTEMROOT%\CheckSUR\packages` directory. By default, this directory doesn't exist and you need to create the directory.
5. Rerun the System Update Readiness tool.

If you are a technical professional, see [How to fix errors found in the CheckSUR.log](https://support.microsoft.com/help/2700601) for a more option on fixing errors in the CheckSUR.log.
