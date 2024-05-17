---
title: How to resolve Windows update corruptions and address update installation failures
description: Use the DISM tool to fix problems that prevent Windows Update from installing successfully.
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

# How to resolve Windows update corruptions and address update installation failures

This article offers you advanced manual methods to fix problems that prevent Windows Update from installing successfully by using Deployment Image Servicing and Management (DISM) tool.

> [!NOTE]
> This article is intended for use by support agents and IT professionals. If you're home users and looking for more information about fixing Windows update errors, see [Fix Windows Update errors](https://support.microsoft.com/help/10164).

_Original KB number:_ 947821

## Common corruption errors

Windows updates may fail to install if there are corruption errors. The following table lists the possible error codes for Windows Update for your reference:

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

For example, an update might not install if a system file is damaged. The DISM may help you fix some Windows corruption errors.

Check this page for [Windows Update troubleshooting scenarios](../../windows-client/deployment/troubleshoot-windows-update-issues.md).

## Solution 1: Use DISM

> [!NOTE]
> The solution mentioned in this section applies to Modern Windows versions like Windows 11, Windows 10, Windows Server 2016, or later.


To resolve this problem, use the DISM tool. Then, install the Windows update

1. Open an elevated command prompt. To do this, open the **Start** menu or **Start** screen, type _Command Prompt_, right-click **Command Prompt**, and then select **Run as administrator**. If you're prompted for an administrator password or for a confirmation, type the password, or select **Allow**.

> [!NOTE]
> Repair works best when you have connectivity to Microsoft Update servers to fetch missing/corrupted files.

2. Type the following command, and then press Enter. It may take several minutes for the command operation to be completed.

    ```console
    DISM.exe /Online /Cleanup-image /Restorehealth
    ```

    > [!IMPORTANT]
    > When you use this command, DISM will try to get the files needed to fix any corruptions from Windows Update. But if your computer can't connect to Windows Update. You can alternatively use a working Windows installation as the source for repairs, or you can use files from a Windows folder on a network or from a USB or DVD. Instead, use this command:

    ```console
    DISM.exe /Online /Cleanup-Image /RestoreHealth /Source:C:\RepairSource\Windows /LimitAccess
    ```
    
      ```console
    DISM.exe /Online /Cleanup-Image /RestoreHealth /Source:\\networkshare\c$\winsxs /LimitAccess
    ```

    > [!NOTE]
    > Replace the _C:\RepairSource\Windows_ placeholder with the location of your repair source. For more information about using the DISM tool to repair Windows, reference [Repair a Windows Image](/previous-versions/windows/it-pro/windows-8.1-and-8/hh824869(v=win.10)).

3. Type the `sfc /scannow` command and press Enter. It may take several minutes for the command operation to be completed.

4. Close the command prompt, and then run **Windows Update** again.

DISM creates a log file (_%windir%/Logs/CBS/CBS.log_) that captures any issues that the tool found or fixed. _%windir%_ is the folder in which Windows is installed. For example, the _%windir%_ folder is _C:\Windows_. 

## What does DISM Repair tool do

### Verify the integrity of resources

The DISM tool verifies the integrity of the following resources:

- Files that are located in the following directories:
  - _%SYSTEMROOT%\Servicing\Packages_
  - _%SYSTEMROOT%\WinSxS\Manifests_
- Registry data that's located under the following registry subkeys:
  - _HKEY_LOCAL_MACHINE\Components_
  - _HKEY_LOCAL_MACHINE\Schema_
  - _HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing_

This list may be updated at any time.

When the DISM detects incorrect manifests, binaries, Cabinets, or registry data, it may replace the incorrect data with a corrected version.

### Logging

The DISM tool creates a log file that captures any issues that the tool found or fixed. The log file is located here:

- _%SYSTEMROOT%\Logs\CBS\CBS.log_
- _%SYSTEMROOT%\Logs\CBS\CBS.persist.log_

## Fix errors found in the CBS log file

To manually fix corruption errors that the DISM Tool detects but can't fix, follow these steps:

1. Open _%SYSTEMROOT%\Logs\CBS\CBS.log_.

    > [!NOTE]
    > _%SYSTEMROOT%_ is an environment variable that saves the folder in which Windows is installed. For example, generally, the _%SYSTEMROOT%_ folder is _C:\Windows_.

2. Identify the packages that the tool can't fix. For example, you may find the following information in the log file:

    ```output
   Checking System Update Readiness.
    (p)	CSI Payload Corrupt			(n)	    	amd64_microsoft-windows-a..modernappmanagement_31bf3856ad364e35_10.0.19041.3636_none_23b3b3ece690d77b\EnterpriseModernAppMgmtCSP.dll
	(p)	CBS MUM Missing				(n)			Microsoft-Windows-Client-Features-Package~31bf3856ad364e35~amd64~~10.0.19041.4291
	(p)	CSI Manifest Corrupt		(w)	(Fixed)	wow64_microsoft-windows-audio-mmecore-acm_31bf3856ad364e35_10.0.19041.1_none_a12b40f4b4c7b751
    (p)	CSI Manifest Corrupt	    (n)			wow64_microsoft-windows-audio-volumecontrol_31bf3856ad364e35_10.0.19041.3636_none_4514b27cf12f35d5
	
    Summary:
    Operation: Detect and Repair
    Operation result: 0x800f081f
    Last Successful Step: Remove staged packages completes.
    Total Detected Corruption:	4
	CBS Manifest Corruption:	1
	CBS Metadata Corruption:	0
	CSI Manifest Corruption:	2
	CSI Metadata Corruption:	0
	CSI Payload Corruption:	1
    Total Repaired Corruption:	1
	CBS Manifest Repaired:	0
	CSI Manifest Repaired:	1
	CSI Payload Repaired:	0
	CSI Store Metadata refreshed:	True
    Staged Packages:
	CBS Staged packages:	0
	CBS Staged packages removed:	0
    ...
    ```

   - CSI Payload Corruption: This indicates that the payload file `EnterpriseModernAppMgmtCSP.dll` is corrupt.
   - CBS MUM Missing: The `Microsoft-Windows-Client-Features-Package` is missing a required MUM file.
   - CSI Manifest Corruption: There were two instances of manifest corruption. One was fixed `(wow64_microsoft-windows-audio-mmecore-acm)`, and the other `(wow64_microsoft-windows-audio-volumecontrol)` remains corrupt.
     
If you're a technical professional, see #NewArticleWillLink for another option on fixing errors in the Cbs.logs

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
