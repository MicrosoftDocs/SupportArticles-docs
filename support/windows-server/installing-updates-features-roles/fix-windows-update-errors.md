---
title: Fix Windows Update errors via DISM or System Update Readiness tool
description: Use the System Update Readiness Tool or the DISM tool to fix problems that prevent Windows Update from installing successfully.
ms.date: 12/26/2023
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: high
ms.reviewer: kaushika, chkeen, cgibson, jesko
ms.custom: sap:Installing Windows Updates, Features, or Roles\Failure to install Windows Updates, csstroubleshoot
adobe-target: true
---

<!---Internal note: The screenshots in the article are being or were already updated. Please contact "gsprad" and "christys" for triage before making the further changes to the screenshots.
--->

# Fix Windows Update errors by using the DISM or System Update Readiness tool

This article offers you advanced manual methods to fix problems that prevent Windows Update from installing successfully by using the System Update Readiness Tool or the Deployment Image Servicing and Management (DISM) tool.

> [!NOTE]
> This article is intended for use by support agents and IT professionals. If you're home users and looking for more information about fixing Windows update errors, see [Fix Windows Update errors](https://support.microsoft.com/help/10164).

_Original KB number:_ 947821

## Common corruption errors

Windows updates may fail to install if there are corruption errors. The following table lists the possible error codes for Windows Update for your reference:

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

For example, an update might not install if a system file is damaged. The DISM or [System Update Readiness tool](#what-does-the-system-update-readiness-tool-do) may help you fix some Windows corruption errors.

Check this page for [Windows Update troubleshooting scenarios](../../windows-client/deployment/troubleshoot-windows-update-issues.md).

## Solution 1: Use DISM

> [!NOTE]
> The solution mentioned in this section applies to Modern Windows versions like Windows 11, Windows 10, Windows Server 2016, or later.
> For Windows 7 and Windows Server 2008 R2, check [Solution 2: Use the System Update Readiness tool](#solution-2-use-the-system-update-readiness-tool).

To resolve this problem, use the DISM tool. Then, install the Windows update or service pack again.

1. Open an elevated command prompt. To do this, open the **Start** menu or **Start** screen, type _Command Prompt_, right-click **Command Prompt**, and then select **Run as administrator**. If you're prompted for an administrator password or for a confirmation, type the password, or select **Allow**.

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
    > Replace the _C:\RepairSource\Windows_ placeholder with the location of your repair source. For more information about using the DISM tool to repair Windows, reference [Repair a Windows Image](/previous-versions/windows/it-pro/windows-8.1-and-8/hh824869(v=win.10)).

3. Type the `sfc /scannow` command and press Enter. It may take several minutes for the command operation to be completed.

4. Close the command prompt, and then run **Windows Update** again.

DISM creates a log file (_%windir%/Logs/CBS/CBS.log_) that captures any issues that the tool found or fixed. _%windir%_ is the folder in which Windows is installed. For example, the _%windir%_ folder is _C:\Windows_.

## Solution 2: Use the System Update Readiness tool

> [!NOTE]
> The solution mentioned in this section is applicable for Windows 7 and Windows Server 2008 R2.
> For Modern Windows versions like Windows 11, Windows 10, Windows Server 2016, or later, check [Solution 1: Use DISM](#solution-1-use-dism).

To resolve this problem, use the System Update Readiness tool. Then, install the Windows update or service pack again.

1. Download the System Update Readiness tool.

    Go to [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=947821) and download the tool that corresponds to the version of Windows that's running on your computer. For more information about how to find the version of Windows that you installed, see [Find out if your computer is running the 32-bit or 64-bit version of Windows](https://support.microsoft.com/help/15056).

    > [!NOTE]
    > This tool is updated regularly, and we recommend that you always download the latest version. This tool isn't available in every supported language.
2. Install and run the tool.
   1. Select **Download** on the Download Center webpage, and then do one of the following:
      - To install the tool immediately, select **Open** or **Run**, and then follow the instructions on your screen.
      - To install the tool later, select **Save**, and then download the installation file to your computer. When you're ready to install the tool, double-click the file.
   2. In the Windows Update Standalone Installer dialog box, select **Yes**.

      :::image type="content" source="media/fix-windows-update-errors/windows-update-standalone-installer.svg" alt-text=" Screenshot of the Windows Update Standalone Installer dialog box." border="false":::

3. When the tool is installed, it automatically runs. Although it typically takes less than 15 minutes to run, it might take much longer on some computers. Even if the progress bar seems to have stopped, the scan is still running, so don't select **Cancel**.

    :::image type="content" source="media/fix-windows-update-errors/updates-are-being-installed-progress-window.svg" alt-text="Download and Install Updates window that shows the updates are being installed." border="false":::

4. When you see Installation complete, select **Close**.

    :::image type="content" source="media/fix-windows-update-errors/installation-complete.svg" alt-text="Download and Install Updates window shows installation complete." border="false":::

5. Reinstall the update or service pack you were trying to install previously.

To manually fix corruption errors that the tool detects but can't fix, see [How to fix errors that are found in the CheckSUR log file](#fix-errors-found-in-the-checksur-log-file).

## Solution 3: Use Microsoft Update Catalog

You can also try to download the update package directly from [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/home.aspx), and then install the update package manually.

For example, you may have problems when you try to install updates from Windows Update. In this situation, you can download the update package and try to install the update manually. To do this, follow these steps:

1. Open the [Microsoft Update Catalog page for KB3006137](https://www.catalog.update.microsoft.com/Search.aspx?q=3006137).
2. Find the update that applies to your operating system appropriately in the search results, and then select the **Download** button.

   :::image type="content" source="./media/fix-windows-update-errors/select-download-button.svg" alt-text="Screenshot of the Download button of the update.":::

3. Select the link of the file to download the update.

   :::image type="content" source="./media/fix-windows-update-errors/download-update-link.svg" alt-text="Microsoft Update Catalog window shows the update download link.":::

4. Select **Close** after the download process is done. Then, you can find a folder that contains the update package in the location that you specified.
5. Open the folder, and then double-click the update package to install the update.

## What does the System Update Readiness tool do

### Verify the integrity of resources

The System Update Readiness tool verifies the integrity of the following resources:

- Files that are located in the following directories:
  - _%SYSTEMROOT%\Servicing\Packages_
  - _%SYSTEMROOT%\WinSxS\Manifests_
- Registry data that's located under the following registry subkeys:
  - _HKEY_LOCAL_MACHINE\Components_
  - _HKEY_LOCAL_MACHINE\Schema_
  - _HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing_

This list may be updated at any time.

When the System Update Readiness tool detects incorrect manifests, Cabinets, or registry data, it may replace the incorrect data with a corrected version.

### Logging

The System Update Readiness tool creates a log file that captures any issues that the tool found or fixed. The log file is located here:

- _%SYSTEMROOT%\Logs\CBS\CheckSUR.log_
- _%SYSTEMROOT%\Logs\CBS\CheckSUR.persist.log_

## Fix errors found in the CheckSUR log file

To manually fix corruption errors that the System Update Readiness tool detects but can't fix, follow these steps:

1. Open _%SYSTEMROOT%\Logs\CBS\CheckSUR.log_.

    > [!NOTE]
    > _%SYSTEMROOT%_ is an environment variable that saves the folder in which Windows is installed. For example, generally, the _%SYSTEMROOT%_ folder is _C:\Windows_.

2. Identify the packages that the tool can't fix. For example, you may find the following information in the log file:

    ```output
    Summary:
    
    Seconds executed: 264
    Found 3 errors
    CBS MUM Missing Total Count: 3
    Unavailable repair files:
    
    servicing\packages\Package_for_KB958690_sc_0~31bf3856ad364e35~amd64~~6.0.1.6.mum
    ...
    ```

    In this case, the package that's corrupted is KB958690.

3. Download the package from [Microsoft Download Center](https://www.microsoft.com/download) or [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/home.aspx).

4. Copy the package (.msu) to the `%SYSTEMROOT%\CheckSUR\packages` directory. By default, this directory doesn't exist, and you need to create it.
5. Rerun the System Update Readiness tool.

If you're a technical professional, see [How to fix errors found in the CheckSUR.log](../../windows-client/deployment/errors-in-checksur-log.md) for another option on fixing errors in the _CheckSUR.log_.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
