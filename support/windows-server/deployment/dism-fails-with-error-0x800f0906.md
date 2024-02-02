---
title: Fail to convert Windows Server Core to GUI
description: Describes an issue where converting Windows Server 2012 R2 Core to Server with a GUI by using a DISM or PowerShell command fails with error 0x800f0906.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:servicing, csstroubleshoot
---
# DISM fails with 0x800f0906 or runs continuously when you convert Windows Server 2012 R2 Core to Server with a GUI

This article discusses an issue where converting Windows Server Core to GUI by using a DISM or PowerShell command fails with error 0x800f0906.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3023427

## Symptoms

This issue occurs when you run a DISM command, an equivalent Windows PowerShell command, or another similar method to convert to GUI.

The DISM command that is used for conversion contains the following switches:

`/enable-feature /featurename:ServerCore-FullServer /featurename:Server-Gui-Mgmt /featurename:Server-Gui-Shell`

You receive one of the following information clusters on the command prompt:

- Information for failure with error code 0x800f0906:

    ```console
    Dism.exe /online /enable-feature /featurename:ServerCore-FullServer /featurename:Server-Gui-Mgmt /featurename:Server-Gui-Shell /source:wim:d:\sources\install.wim:4
    ```

    > Deployment Image Servicing and Management tool  
    Version: 6.3.9600.17031  
    Image Version: 6.3.9600.17031  
    Enabling feature(s)  
    [===========================66.7%====== ]  
    Error: 0x800f0906  
    The source files could not be downloaded.  
    Use the "source" option to specify the location of the files that are required to restore the feature. For more information on specifying a source location, see `http://go.microsoft.com/fwlink/?LinkId=243077`.

    The DISM log file can be found at C:\Windows\Logs\DISM\dism.log.

- Information for the DISM command that continues to run for a long time without stopping:

    ```console
    Dism.exe /online /enable-feature /featurename:ServerCore-FullServer /featurename:Server-Gui-Mgmt /featurename:Server-Gui-Shell /source:wim:d:\sources\install.wim:4
    ```

    > Deployment Image Servicing and Management tool  
    Version: 6.3.9600.17031  
    Image Version: 6.3.9600.17031  
    Enabling feature(s)  
    [===========================66.7%====== ]

> [!NOTE]
> The progress bar on the command prompt always remains at 66.7%. The size of the CBS.log file that is under the %windir%\logs\cbs path will continue to increase.

## Errors in CBS logs

The CBS.log file shows one of the following two errors:

- Error 1

    > *\<DateTime>*, Info CBS Session: 30409734_2213032090 initialized by client WindowsUpdateAgent.  
    *\<DateTime>*, Info CBS Opened cabinet package, package directory: \\\\?  \C:\Windows\SoftwareDistribution\Download\ea6d57731136ce0c61adfa2056bd76ba\, sandbox location: \\\\?  \C:\Windows\SoftwareDistribution\Download\ea6d57731136ce0c61adfa2056bd76ba\, cabinet location: \\\\?  \C:\Windows\SoftwareDistribution\Download\ea6d57731136ce0c61adfa2056bd76ba\windows8.1-kb3000850-x64-express.cab, manifest location: \\\\?  \C:\Windows\SoftwareDistribution\Download\ea6d57731136ce0c61adfa2056bd76ba\update.mum  
    . . .  
    . . .  
    . . .  
    *\<DateTime>*, Info DPX Extraction of file: amd64_microsoft-windows-c..  t-resources-mrmcore_31bf3856ad364e35_6.3.9600.17418_none_dc8ca600359fa9c4\mrmcorer.dll failed because it is not present in the container.  
    *\<DateTime>*, Info CBS Asynchronous Session: 30409734_2213032090 finalized. [HRESULT = 0x80070002 - ERROR_FILE_NOT_FOUND]

- Error 2

    > *\<DateTime>*, Info CBS Not able to find package: Package_for_KB2959977~31bf3856ad364e35~amd64~6.3.1.1 from the cached windows update index. [HRESULT = 0x800f090d - CBS_E_MISSING_PACKAGE_MAPPING_INDEX]  
    *\<DateTime>*, Info CBS Failed to find package: Package_for_KB2959977~31bf3856ad364e35~amd64~~6.3.1.1 from the index mapping [HRESULT = 0x800f090d - CBS_E_MISSING_PACKAGE_MAPPING_INDEX]

> [!NOTE]
> The updates that appear during the error may different. The cause of these errors is in the CBS component and the index file, not the updates themselves. The sample output and the list of updates that are mentioned in the error are based on internal testing of a default but updated Windows Server 2012 R2 Core installation that has no additional features or roles enabled.

## Cause of Error 1 in CBS logs

This issue occurs when the conversion requires files to be downloaded for updates that are bundled as a part of a single updateID.

Local testing shows that presence of the following updates on the Core server will cause the conversion to fail with the DPX Extraction 0x80070002 errors:

- 3000850
- 3003057
- 3014442
- 2919355
- 2959977

> [!NOTE]
> To see sample values for updateID, open the wuindex.xml file under the %windir%\servicing\packages path, and search for the updateID string.

## Cause of Error 2 in CBS logs

The cause is the entry \<Map Package="package_for_kb2959977~31bf3856ad364e35~amd64~~6.3.1.1"/> is missed under updateID 8452bac0-bf53-4fbd-915d-499de08c338b, inside the file %windir%\servicing\packages\wuindex.xml.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
