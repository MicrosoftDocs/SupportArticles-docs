---
title: Securely opening documents that have Dynamic Data Exchange fields
description: Introduces how to securely open  Microsoft Office documents that contain Dynamic Data Exchange (DDE) fields.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Security\Trust
  - CSSTroubleshoot
  - CI 162524
appliesto:
- Outlook
- Exchange
search.appverid: MET150
ms.reviewer: 
author: simonxjx
ms.author: v-six
ms.date: 06/06/2024
---
# Securely opening Microsoft Office documents that contain Dynamic Data Exchange (DDE) fields

## Overview

This security advisory article provides information regarding security settings for Microsoft Office applications. It provides guidance on what users can do to ensure that these applications are properly secured when processing Dynamic Data Exchange (DDE) fields.

### About Dynamic Data Exchange

Microsoft Office provides several methods for transferring data between applications. The DDE protocol is a set of messages and guidelines. It sends messages between applications that share data, and uses shared memory to exchange data between applications. Applications can use the DDE protocol for one-time data transfers and for continuous exchanges in which applications send updates to one another as new data becomes available.

#### Scenario

In an email attack scenario, an attacker could use the DDE protocol by sending a specially crafted file to the user and then convincing the user to open the file, typically by way of an enticement in an email. The attacker would have to convince the user to disable Protected Mode and click through one or more additional prompts. As email attachments are a primary method an attacker could use to spread malware, Microsoft strongly recommends that customers exercise caution when opening suspicious file attachments.

## DDE Feature Control Keys

Microsoft Office provides several feature control keys that are stored in the registry and are responsible for modifying product functionality, improving support for industry standards, and improving security. Microsoft has documented these feature control keys and recommends enabling specific feature control keys for security reasons. For more information, see [Secure and control access to Office 2016](/DeployOffice/security/secure-and-control-access-to-office).

Microsoft strongly encourages all users of Microsoft Office to review the security-related feature control keys and to enable them. Setting the registry keys described in the following sections disables automatic update of data from linked fields.

## Mitigating DDE Attack Scenarios

Users who wish to take immediate action can protect themselves by manually creating and setting registry entries for Microsoft Office. Use the following instructions to set the registry keys based on the Office applications installed on your system.

> [!WARNING]
> If you use Registry Editor incorrectly, you could cause serious problems that could require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk.

### Microsoft Excel

Excel depends on the DDE feature to launch documents.

To prevent automatic update of links from Excel (including DDE, OLE, and external cell or defined name references), refer to the following table for the registry key version string to set for each version:

|Office Version| Registry Key \<version> string |
|---|---|
| Office 2007| 12.0 |
| Office 2010| 14.0 |
| Office 2013| 15.0 |
| Office 2016| 16.0 |
|||

- To disable the DDE feature from the user interface:

  Go to **File** > **Options** > **Trust Center** > **Trust Center Settings** > **External Content,** set **Security settings for Workbook Links** to **Disable automatic update of Workbook Links**.

- To disable the DDE feature by using the Registry Editor, add the following registry key:

  **Location**: `HKEY_CURRENT_USER\Software\Microsoft\Office\<version>\Excel\Security`  
  **Name**: WorkbookLinkWarnings  
  **Value type**: DWORD  
  **Value**: 2

> [!NOTE]
>
> Impact of mitigation:
>
> Disabling this feature could prevent Excel spreadsheets from updating dynamically if disabled in the registry. Data might not be completely up-to-date because it is no longer being updated automatically via live feed. To update the worksheet, the user must start the feed manually. In addition, the user will not receive prompts to remind them to manually update the worksheet.

### Microsoft Outlook

Refer to the following table for the registry key version string to set for each Office version:

| Office Version| Registry Key \<version> string |
|---|---|
| Office 2010| 14.0 |
| Office 2013| 15.0 |
| Office 2016| 16.0 |
|||

- For Office 2010 and later versions, to disable the DDE feature by using the Registry Editor, add the following registry key:

  **Location**: `HKEY_CURRENT_USER\Software\Microsoft\Office\<version>\Word\Options\WordMail`  
  **Name**: DontUpdateLinks  
  **Type**: DWORD  
  **Value**: 1

- For Office 2007, to disable the DDE feature by using the Registry Editor, add the following the registry key:

  **Location**: `HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Word\Options\vpref`  
  **Name**: fNoCalclinksOnopen_90_1  
  **Type**: DWORD  
  **Value**: 1

> [!NOTE]
>
> Impact of mitigation:
>
> Setting this registry key will disable automatic update for DDE field and OLE links. Users can still enable the update by right-clicking on the field and selecting "Update Field".

### Microsoft Publisher

A Word document using the DDE protocol that is imbedded within a Publisher document could be a possible attack vector. You can help prevent this attack vector by applying the Word registry key modification. See the following section for the Word registry key values.

### Microsoft Word

Refer to the following table for the registry key version string to set for each Office version:

| Office Version**| Registry Key \<version> string |
|---|---|
| Office 2010| 14.0 |
| Office 2013| 15.0 |
| Office 2016| 16.0 |
|||

- For Office 2010 and later versions, to disable the DDE feature by using the Registry Editor, add the following the registry key:

  **Location**: `HKEY_CURRENT_USER\Software\Microsoft\Office\<version>\Word\Options`  
  **Name**: DontUpdateLinks  
  **Type**: DWORD  
  **Value**: 1

- For Office 2007, to disable the DDE feature by using the Registry Editor, add following the registry key:

  **Location**: `HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Word\Options\vpref`  
  **Name**: fNoCalclinksOnopen_90_1  
  **Type**: DWORD  
  **Value**: 1

> [!NOTE]
>
> Impact of mitigation:
>
> Setting this registry key will disable automatic update for DDE field and OLE links. Users can still enable the update by right-clicking on the field and selecting "Update Field".

## About Windows 10 Fall Creator Update (version 1709)

Users of the Windows 10 Fall Creator Update can use Windows Defender Exploit Guard to block DDE-based malware with Attack Surface Reduction (ASR).

Attack Surface Reduction is a component within Windows Defender Exploit Guard that provides enterprises with a set of built-in intelligence that can block the underlying behaviors used by malicious documents to execute attacks without hindering product operation. By blocking malicious behaviors independent of what the threat or exploit is, ASR can protect enterprises from never-before-seen zero-day attacks like these recently discovered vulnerabilities: [CVE-2017-8759](https://www.microsoft.com/security/blog/2017/09/12/exploit-for-cve-2017-8759-detected-and-neutralized/?ocid=cx-blog-mmpc?source=mmpc), [CVE-2017-11292](https://helpx.adobe.com/security/products/flash-player/apsb17-32.html), and [CVE-2017-11826](https://nvd.nist.gov/vuln/detail/CVE-2017-11826).

For Office apps, ASR can:

- Block Office apps from creating executable content
- Block Office apps from launching child process
- Block Office apps from injecting into process
- Block Win32 imports from macro code in Office
- Block obfuscated macro code

Emerging exploits like [DDEDownloader](https://www.microsoft.com/en-us/wdsi/threats/malware-encyclopedia-description?Name=Exploit:O97M/DDEDownloader.A) use the Dynamic Data Exchange (DDE) popup in Office documents to run a PowerShell downloader; however, in doing so, they launch a child process that the corresponding child process rule blocks.

To learn more about Windows Defender Exploit Guard, see [Windows Defender Exploit Guard: Reduce the attack surface against next-generation malware](https://www.microsoft.com/security/blog/2017/10/23/windows-defender-exploit-guard-reduce-the-attack-surface-against-next-generation-malware/?source=mmpc).

Microsoft is researching this issue further and will post more information in this article when the information becomes available.
