---
title: Windows.edb becomes larger than expected
description: Address an issue in which Windows.edb becomes larger than expected when PST files are indexed in Windows 10, 8.1, or 8.
ms.date: 10/12/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:cortana-and-search, csstroubleshoot
ms.subservice: shell-experience
---
# Windows.edb is larger than expected when a PST file is indexed

This article provides a workaround for an issue where Windows.edb becomes larger than expected when PST files are indexed in Windows 10, 8.1, or 8.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2952967

## Symptoms

When you index a PST file from **Control Panel** > **Indexing options**, the size of the Windows.edb file (which is located under `%ProgramData%\Microsoft\Search\Data\Applications\Windows`) grows in proportion to the size of the PST file. This issue can result in low disk space and other performance issues. This issue doesn't occur in Windows 7.

## Cause

There are two reasons why Windows.edb is larger in Windows 8, Windows 8.1 and Windows 10 than in Windows 7:

- Both properties and persistent indexes are stored in Windows.edb starting with Windows 8. in Windows 7, only properties are stored in Windows.edb-p persistent indexes are stored separately, in *.ci files.  

- Windows 8, Windows 8.1 and Windows 10 indexes the entire contents of files, regardless of their size. Windows 7 indexes only the first part of large documents.

Neither of these behaviors is configurable on Windows 8, Windows 8.1 or Windows 10. This behavior improves recall for searches and general performance of indexing and querying.

## Workaround

To work around this issue, follow these steps:

1. Index less content. If you have a lot of content, Windows.edb can be expected to grow very large. In this case, the only option to reduce disk usage is to index less content locally (by having Outlook cache less mail locally or by changing scopes in Indexing **Options** > **Modify**, followed by rebuilding the index from **Advanced** > **Rebuild**).

2. Run an offline defrag of the .edb file from a command prompt by running the following commands:

    ```console
    Sc config wsearch start=disabled
    Net stop wsearch

    EsentUtl.exe /d %AllUsersProfile%\Microsoft\Search\Data\Applications\Windows\Windows.edb

    Sc config wsearch start=delayed-auto

    Net start wsearch
    ```
