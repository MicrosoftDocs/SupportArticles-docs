---
title: Link.exe crashes when you use /WHOLEARCHIVE
description: Fixes an issue in which link.exe crashes with a fatal LNK1000 error when you use /WHOLEARCHIVE switch.
ms.date: 04/20/2020
ms.custom: sap:Language or Compilers\C++
ms.reviewer: kgao, denizd
---
# Link.exe crashes with a fatal LNK1000 error when you use /WHOLEARCHIVE switch

This article helps you resolve the problem that link.exe crashes with a LNK1000 error when you use **/WHOLEARCHIVE** switch.

_Original product version:_ &nbsp; Visual Studio 2015  
_Original KB number:_ &nbsp; 4020481

## Symptoms

If you use the **/WHOLEARCHIVE** switch together with link.exe in Microsoft Visual Studio 2015, you receive an error message that resembles the following:

> LINK : fatal error LNK1000: unknown error at 000000013FA24241; consult documentation for technical support options

## Cause

This problem occurs in rare cases because link.exe might not handle import objects and incremental linking correctly if it uses the **/WHOLEARCHIVE** switch.

## Resolution

The following file is available for download from the Microsoft Download Center:  
[Download the hotfix package now](https://download.microsoft.com/download/8/1/d/81dbe6bb-ed92-411a-bef5-3a75ff972c6a/vc14-kb4020481.exe)

For more information about how to download Microsoft support files, see [How to obtain Microsoft support files from online services](https://support.microsoft.com/help/119591/how-to-obtain-microsoft-support-files-from-online-services).

Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help prevent any unauthorized changes to the file.

### Prerequisites

To apply this hotfix, you must have Visual Studio 2015 Update 3 installed.

### Restart requirement

You may have to restart the computer after you apply this hotfix if no instance of Visual Studio is being used.

### Hotfix replacement information

This hotfix doesn't replace other hotfixes.

## References

For more information about the **/WHOLEARCHIVE** switch, see [/WHOLEARCHIVE (Include All Library Object Files)](/cpp/build/reference/wholearchive-include-all-library-object-files?&view=vs-2019&preserve-view=true).
