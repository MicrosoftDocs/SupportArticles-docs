---
title: WEDU reoffers downloaded updates
description: This article provides a resolution for the issue where Windows Embedded Developer Update for Windows Embedded Standard 7 (WES7) Service Pack 1 (SP1) reoffers updates that were already downloaded and seemingly imported to a distribution share (DS).
ms.date: 08/27/2020
ms.subservice: general
---
# Windows Embedded Developer Update reoffers updates that were already downloaded in Windows Embedded 7

This article helps you resolve the issue where Windows Embedded Developer Update (WEDU) for Windows Embedded Standard 7 (WES7) Service Pack 1 (SP1) reoffers updates that were already downloaded and seemingly imported to a distribution share (DS).

_Original product version:_ &nbsp; Windows Embedded Standard 7 Service Pack 1, Windows Embedded Standard 7  
_Original KB number:_ &nbsp; 3138095

## Symptoms

WEDU for WES7 SP1 reoffers updates that were already downloaded and seemingly imported to a DS.

## Cause

In this situation, the downloaded items were not imported to the distribution share. After the *regindex* file reaches its maximum size, you cannot import any more updates, and the import process silently fails. The maximum value for the *regindex* setting depends on the memory and configuration of the computer.

## Resolution

To resolve this issue, follow these steps:

1. In the distribution share path, rename the *regindex* file. The following is the default installation location for the WES7 SP1 distribution share:

    `C:\Program Files (x86)\Windows Embedded Standard 7\DS64SP1`

2. To reimport the updates, select the updates that were reoffered.
3. Click **Download and Install**, and then let WEDU finish the installation process. A new *regindex* file will be created automatically.
4. To verify that the previously offered updates are no longer being reoffered, click **Start Scan**. After scanning is complete, the items that were reoffered earlier should not be listed.

> [!IMPORTANT]
> The `Search Registry` feature of the **Find** dialog box in Image Configuration Editor will no longer return items from the previous *regindex* file. It will return items only from the newly created *regindex* file. All other functions of the **Find**  dialog box will continue to work as expected.

## More information

[Distribution Shares in Standard 7 (Standard 7 SP1)](/previous-versions/windows/embedded/ff794652(v=winembedded.60)).
