---
title: Some .CHM files may not render properly on Windows Vista and Windows 7
description: This article describes the fixing steps for some .CHM file not render properly.
ms.date: 09/10/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:file-explorer/windows-explorer, csstroubleshoot
ms.subservice: shell-experience
---
# Some .CHM files may not render properly on Windows Vista and Windows 7

This article provides the steps for fixing the issue that some .CHM files do not render properly.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2021383

## Symptoms

When attempting to open a Compiled HTML Help (.CHM) file on Windows Vista or Windows 7, the file may open but display one of the following messages instead of the expected content:

- > Navigation to the webpage was canceled.
- > Action canceled.

## Cause

This will occur if the .CHM file has been flagged as downloaded from an untrusted source, such as the Internet.

## Resolution

To resolve this issue, carry out the following steps:

1. Right-click the .CHM file and choose **Properties**.
2. On the **General** tab, click the button labeled **Unblock**.
3. Click **OK**.

## More information

This behavior is a function of the Attachment Manager, which applies a Zone Identifier to files downloaded from any source that is considered untrusted or at risk, such as the Internet Zone.
