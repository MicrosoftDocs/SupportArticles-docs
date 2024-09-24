---
title: Performance issues with Auto-Recover location on network share
description: If the Auto-Recover file location points to a network share, a general performance degradation is visible after an Auto-Save operation. This includes sluggish typing and slow refresh when scrolling.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Save\AutoSave
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Word 2010
  - Word 2013
ms.date: 06/06/2024
---

# Performance issues with Auto-Recover location on network share

## Symptoms

You're working with a complex Word document. After an Auto-Save operation (the default interval is 10 minutes), you notice a general performance degradation when editing the document:

- sluggish typing
- slow screen refreshes when scrolling

## Cause

The Auto-Recover file location points to a network share. This will force Word to use files located on a network share as temporary or scratch files. 

## Resolution

In order to resolve this problem, you need to set the Auto-Recover file location to a local path. The default path is %APPDATA%\Microsoft\Word. Also ensure that %APPDATA% (or Roaming Application Data) points to a local folder.

To change this setting, please go to File - Options - Save and modify the Text Box "Auto-Recover file location:". Type in a valid local path.

## More Information

Since the temporary files that Word uses are file-access-driven, accessing them through the network is not optimal. 

File-access-driven means that the computer uses special file access commands that the operating system provides to read and write data to the file.
This is not efficient on WAN or LAN links because WAN and LAN links use network-access-driven methods.

For more information on how Word creates and stores temporary files, please check [Description of how Word creates temporary files](https://support.microsoft.com/help/211632).

A similar performance degradation occurs in Outlook if the PST file is located on the network. More information about that on [Limits to using personal folders (.pst) files over LAN and WAN links](https://support.microsoft.com/help/297019).
