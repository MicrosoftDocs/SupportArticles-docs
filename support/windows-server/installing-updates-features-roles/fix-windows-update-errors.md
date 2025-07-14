---
title: Fix Windows Update corruptions and installation failures
description: Use the DISM tool to fix problems that prevent Windows Update from installing successfully.
ms.date: 01/15/2025
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: kaushika, chkeen, cgibson, jesko, warrenw, abjos
ms.custom:
- sap:windows servicing,updates and features on demand\windows update fails - installation stops with error
- pcy:WinComm Devices Deploy
adobe-target: true
---

<!---Internal note: The screenshots in the article are being or were already updated. Please contact "gsprad" and "christys" for triage before making the further changes to the screenshots.
--->

# Fix Windows Update corruptions and installation failures

This article offers you advanced manual methods to fix problems that prevent Windows Update from installing successfully by using the Deployment Image Servicing and Management (DISM) tool.

> [!NOTE]
> This article is intended for use by support agents and IT professionals. If you're home users and looking for more information about fixing Windows update errors, see [Fix Windows Update errors](https://support.microsoft.com/help/10164).

_Original KB number:_ 947821

## Common corruption errors

Windows updates may fail to install if there are corruption errors. You can check the Setup event log for errors. The following table lists the possible error codes for Windows Update for your reference:

|Code|Error|Description|
|---|---|---|
|0x80070002|ERROR_FILE_NOT_FOUND|The system cannot find the file specified.|
|0x800f0831|CBS_E_STORE_CORRUPTION|CBS store is corrupted.|
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
|[0x8024002E](troubleshoot-windows-update-error-code-0x8024002e.md)|WU_E_WU_DISABLED|Windows Update Client service is disabled|

For example, an update might not install if a system file is damaged. The DISM may help you fix some Windows corruption errors.

Check this page for [Windows Update troubleshooting scenarios](../../windows-client/deployment/troubleshoot-windows-update-issues.md).

## Using DISM to repair Windows Update corruptions

> [!NOTE]
> The solution mentioned in this section applies to Modern Windows versions like Windows 11, Windows 10, Windows Server 2016, or later.

To resolve Windows Update corruptions and address update installation failures, use the DISM tool. Then, install the Windows Update.

1. Open an elevated command prompt. To do this, open the **Start** menu, type _Command Prompt_, right-click **Command Prompt**, and then select **Run as administrator**. If you're prompted for an administrator password or for a confirmation, type the password, or select **Yes**.

2. Type the following command, and then press Enter. It may take several minutes for the command operation to be completed.

    ```console
    DISM.exe /Online /Cleanup-image /Restorehealth
    ```

    > [!IMPORTANT]
    > DISM repair works best when you connect to Microsoft Update servers to fetch missing or corrupted files. When you use the proceeding command, DISM gets the files needed to fix any corruptions from Windows Update. However, if your computer can't connect to Windows Update, you can alternatively use a working Windows installation as the repair source, or you can use files from a Windows folder on a network or from a USB or DVD. Instead, use this command:

    ```console
    DISM.exe /Online /Cleanup-Image /RestoreHealth /Source:\\<servername>\c$\winsxs /LimitAccess
    ```

    > [!NOTE]
    > Replace \<servername\> with the computer name of the computer you are using as a repair source. The repair source computer must be running the same operating system version. For more information about using the DISM tool to repair Windows, reference [Repair a Windows Image](/previous-versions/windows/it-pro/windows-8.1-and-8/hh824869(v=win.10)). If the scan result is "The restore operation completed successfully", go to the next step. If not, try to [analyze the CBS.log file](#step-1-analyze-the-cbslog-file) and fix errors.

3. Type the `sfc /scannow` command and press Enter. It may take several minutes for the command operation to be completed.

4. Close the command prompt, and then run **Windows Update** again.

DISM creates a log file (_%windir%\\Logs\\CBS\\CBS.log_) that captures any issues that the tool found or fixed. _%windir%_ is the folder in which Windows is installed. For example, the _%windir%_ folder is _C:\\Windows_.

## How does DISM Repair work?

DISM is a command-line tool that is used to service and repair Windows images, including the Windows Recovery Environment, Windows Setup, and Windows PE (WinPE). It can also be used to repair the local Windows image on your computer.

To give you a better understanding, here's a summary of the resources that the DISM tool checks for integrity:

- Files that are located in the following directories:
  - _%SYSTEMROOT%\Servicing\Packages_
  - _%SYSTEMROOT%\WinSxS\Manifests_
- Registry data that's located under the following registry subkeys:
  - _HKEY_LOCAL_MACHINE\Components_
  - _HKEY_LOCAL_MACHINE\Schema_
  - _HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing_

This list may be updated at any time. When the DISM detects incorrect manifests, Cabinets, or registry data, it may replace the incorrect data with a corrected version.

### Logging

The DISM tool creates a log file that captures any issues that the tool found or fixed. The log file is located here:

- _%SYSTEMROOT%\Logs\CBS\CBS.log_
- _%SYSTEMROOT%\Logs\CBS\CBS.persist.log_

## Advanced guide to fix CBS corruption manually using DISM utility

### Step 1: Analyze the CBS.log file

After running the DISM commands, go to *%WinDir%\\Logs\\CBS\\CBS.log* to view the results. The log file provides a summary of the scan and details of any errors found.

Here's an example of the log summary:

```output
Checking System Update Readiness.
    (p)      CSI Payload Corrupt              (n)           amd64_microsoft-windows-a..modernappmanagement_31bf3856ad364e35_10.0.19045.3636_none_23b3b3ece690d77b\EnterpriseModernAppMgmtCSP.dll
       (p)    CBS MUM Missing                         (n)                 Microsoft-Windows-Client-Features-Package~31bf3856ad364e35~amd64~~10.0.19045.4291
       (p)    CSI Manifest Corrupt             (w)    (Fixed)       wow64_microsoft-windows-audio-mmecore-acm_31bf3856ad364e35_10.0.19045.1_none_a12b40f4b4c7b751
    (p)      CSI Manifest Corrupt          (n)                    wow64_microsoft-windows-audio-volumecontrol_31bf3856ad364e35_10.0.19045.3636_none_4514b27cf12f35d5


Summary:
Operation: Detect and Repair 
Operation result: 0x800f081f
Last Successful Step: Remove staged packages completes.
Total Detected Corruption: 2
    CBS Manifest Corruption: 2
    CBS Metadata Corruption: 0
    CSI Manifest Corruption: 0
    CSI Metadata Corruption: 0
    CSI Payload Corruption: 0
Total Repaired Corruption: 1
    CBS Manifest Repaired: 1
    CSI Manifest Repaired: 0
    CSI Payload Repaired: 0
    CSI Store Metadata refreshed: False
Staged Packages:
    CBS Staged packages: 0
    CBS Staged packages removed: 0
```

> [!NOTE]
> CSI Payload Corruption: This indicates that the payload file *EnterpriseModernAppMgmtCSP.dll* is corrupt.
>
> CBS MUM Missing: A required MUM file is missing from the package (*Microsoft-Windows-Client-Features-Package*).
> 
> CSI Manifest Corruption: There were two instances of manifest corruption. One was fixed (*wow64_microsoft-windows-audio-mmecore-acm*), and the other (*wow64_microsoft-windows-audio-volumecontrol*) remains corrupt.

### Step 2: Download the missing files

1. Identify the missing or corrupted files.

    Review the *CBS.log* file to identify the missing or corrupted files. For example:

    ```output
    (p) CSI Payload Corrupt (n) amd64_microsoft-windows-a..modernappmanagement_31bf3856ad364e35_10.0.19045.3636_none_23b3b3ece690d77b\EnterpriseModernAppMgmtCSP.dll
    (p) CBS MUM Missing (n) Microsoft-Windows-Client-Features-Package~31bf3856ad364e35~amd64~~10.0.19045.4291
    (p) CSI Manifest Corrupt (n) wow64_microsoft-windows-audio-volumecontrol_31bf3856ad364e35_10.0.19045.3636_none_4514b27cf12f35d5
    ```

2. Determine the update containing the missing files.

    From the log entries, identify the Update Build Revision (UBR) numbers within the file paths:

    - In the *EnterpriseModernAppMgmtCSP.dll* file, the UBR number is `10.0.19045.3636`.
    - In the `Microsoft-Windows-Client-Features-Package` package, the UBR number is `10.0.19045.4291`.

3. Match the UBR number to the KB number:

   1. Go to the [Windows update history page](/windows/release-health/release-information#windows-10-release-history) for your version (for example, Windows 10, version 22H2).
   2. Match the UBR number (`3636` or `4291`) to the listed updates to find the KB number.

   For example:

    - UBR `3636` might correspond to KB5031445.
    - UBR `4291` might correspond to KB5036892.

4. Search for and download the update by the KB number:

    1. Use the identified KB numbers to search for the updates in the [Microsoft Update Catalog](https://catalog.update.microsoft.com).
    2. Download the updates associated with each KB number to restore the missing or corrupted files.

### Step 3: Extract the .msu and .cab files

To address the corrupted files identified in the *CBS.log* file, extract the missing files into a specific folder. Follow these steps to extract the `.msu` and `.cab` files by using the provided [PowerShell script](../support-tools/scripts-extract-msu-cab-files.md), and then copy the necessary files to the *C:\\temp\\Source* folder.

1. Create the necessary folders.

    Run the following command to create the *C:\\temp\\Source* folder if it doesn't exist:

    ```console
    mkdir C:\temp\Source
    ```

2. Use the instructions and script in [Scripts: Extract .msu and .cab files](../support-tools/scripts-extract-msu-cab-files.md) to extract the `.msu` files by providing the destination paths of the `.msu` files.

### Step 4: Repair the corrupted files by using the source files

1. Copy the correct versions of the corrupted files.

    Copy the correct versions of all the corrupted files that belong to this update to the *C:\\temp\\Source* folder. For example, run the following command:

    ```powershell
    Copy-Item "C:\path\extractedFiles\corruptedfile.dll" -Destination "C:\temp\Source"
    ```

    Repeat this process for each corrupted file identified in the log until all the corrupted files are copied to the *C:\\temp\\Source* folder.

2. Rerun the DISM command.

    Open a command prompt as an administrator and run the following DISM command with the `/Source` option:

    ```console
    DISM /Online /Cleanup-Image /RestoreHealth /Source:C:\temp\Source\ /LimitAccess
    ```

### Step 5: Verify and confirm

1. Rerun the DISM command.

    Rerun the following DISM command to verify that the issues have been resolved:

    ```console
    DISM /Online /Cleanup-Image /ScanHealth
    ```

2. Check the *CBS.log* file.

    Review the *CBS.log* file to ensure there are no remaining errors.

### Example DISM command output

The output of the DISM restore command provides crucial information about the corruption that was detected and repaired:

```output
Checking System Update Readiness.

(p) CBS MUM Missing (n) Microsoft-Windows-Client-Features-Package~31bf3856ad364e35~amd64~~10.0.19045.4291
Repair failed: Missing replacement mum/cat pair.
(p) CBS MUM Missing (w) (Fixed) Microsoft-Windows-Client-Features-Package~31bf3856ad364e35~amd64~~10.0.19045.4412

Summary:
Operation: Detect and Repair 
Operation result: 0x800f081f
Last Successful Step: Remove staged packages completes.
Total Detected Corruption: 2
    CBS Manifest Corruption: 2
    CBS Metadata Corruption: 0
    CSI Manifest Corruption: 0
    CSI Metadata Corruption: 0
    CSI Payload Corruption: 0
Total Repaired Corruption: 1
    CBS Manifest Repaired: 1
    CSI Manifest Repaired: 0
    CSI Payload Repaired: 0
    CSI Store Metadata refreshed: False
Staged Packages:
    CBS Staged packages: 0
    CBS Staged packages removed: 0
```

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
