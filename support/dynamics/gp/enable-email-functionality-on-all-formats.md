---
title: Enable Email functionality on all formats
description: Enable Email functionality on all Sales and Purchasing document formats in Microsoft Dynamics GP 2015 R2 and higher versions.
ms.reviewer: dkainz, cwaswick
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Enable Email functionality on all Sales and Purchasing document formats in Microsoft Dynamics GP 2015 R2

This article provides a solution to an issue where the Print options for Sales Orders and Purchase Orders only support **blank** document formats.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3076238

## Symptoms

The Print options for Sales Orders and Purchase Orders only support **blank** document formats. This feature will support email for any document format for all Sales Order Documents and Purchase Order documents in Microsoft Dynamics GP 2015 R2 and higher versions. This feature is supported when printing from the Transaction Entry Window, Navigation Lists, and Print Sales/Purchasing Documents window.

## Cause

New functionality.

## Resolution

To enable this new feature using the Web Client functionality, follow the steps below:

1. Open the Dex.ini file from the GP2015 R2 code folder in Notepad. This file is normally found here:

    `C:\Program Files (x86)\Microsoft Dynamics\GP2015\Data`

2. In the Dex.ini, add the following line:

    `IsWebClient=TRUE`

3. Save the file.

4. Launch Microsoft Dynamics GP. The new formats will be available options when printing SOP and POP documents.

## More Information

The above information is also published externally on [Microsoft Dynamics GP 2015 R2 New Features - Enable Email Functionality On All Sales and Purchasing Document Formats](https://community.dynamics.com/blogs/post/?postid=07296067-525e-40d2-9014-09beb62dd0b6).
