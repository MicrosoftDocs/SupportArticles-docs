---
title: Some Office applications are not responding
description: Fix the problem that causes Office applications to stop responding because some versions of the Intel graphics driver have a heap corruption bug in the system.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Reliability
  - CI 112347
  - CSSTroubleshoot
ms.reviewer: davmcdon
appliesto: 
  - Office
search.appverid: MET150
ms.date: 06/06/2024
---

# Some Office applications are not responding

## Symptoms

Office applications stop responding in some common usage scenarios.

## Cause

Starting in Microsoft Office 2013, the Office suite of applications takes advantage of hardware acceleration if the option is available. To do this, Office uses the graphics adapter that is installed on the computer. This causes Office applications to load and use graphics driver code. For systems that use an Intel graphics adapter, some versions of the Intel graphics driver have a heap corruption bug that causes Office applications to stop responding.

The following Intel graphics driver versions cause this problem.

|Version |
| - |
|26.20.100.6951|
|26.20.100.6952|
|26.20.100.6998|
|26.20.100.6999|
|26.20.100.7000|
|26.20.100.7063|

## Resolution

Identify whether your computer has one of the affected Intel graphics drivers. To do this, follow these steps:
1. In **Control Panel**, select **Hardware and Sound** > **Device Manager**.
2. Expand the **Display adapters** item. If you have an Intel graphics adapter, the driver will appear in the list. If you see an Intel adapter, right-click the adapter, and then select **Properties**.
3. On the **Driver** tab, review the information in the **Driver Version** field.
 
If you have one of the affected graphics driver versions, use one of the following options to fix the problem.

### Option 1: Update the Intel graphics driver

The Intel graphics driver that contains the fix is version 26.20.100.7262. The best solution is to update the graphics driver to this version (or later). To do this, open the **Driver** tab in the adapter's properties dialog box, and then select the **Update Driver** button to search for an updated graphics driver.

> [!NOTE]
> If you can't find an updated graphics driver, search for a driver update through your OEM website or through the Intel website.
 
### Option 2: Update the Office version

Office has shipped a fix for specific Office versions. The fix will detect whether the computer has one of the affected Intel graphics drivers installed. If it does, Office will avoid using hardware acceleration. Instead, it will use a software rasterizer that is known as Windows Advanced Rasterization Platform (WARP).

The versions of Office that contain this fix are the following.

| Release  | Version  |
| - | - |
| 1911 (November 2019) | 16.0.12325.20120 |
| 1910 (October 2019) | 16.0.12228.20364 |
| 1907 (July 2019) | 16.0.11929.20516 |
| 1901 (January 2019) | 16.0.11328.20492 |
| Office Insiders | 16.0.12406.20000 |

To fix the problem, update your Office installation.

> [!NOTE]
> The fix in the Office versions won't work for users who have an Nvidia Optimus graphics adapter. For more information about how to work around this scenario, see the "Option 4: Nvidia Optimus" section.

### Option 3: Manually disable hardware acceleration in Office

If you can't upgrade the Intel graphics driver or update Office to a version that has the fix, you can disable hardware acceleration through the **Options** dialog box. To do this, follow these steps:

1. In any Office application, select **File** > **Options**.
2. In the **Advanced** pane, select the **Disable hardware graphics acceleration** check box.
3. Select **OK**.

> [!TIP]
> If you choose this option, we recommend that you clear the **Disable hardware graphics acceleration** check box when you update the Intel graphics driver to version 26.20.100.7262 (or later). You should do this so that Office can run by using the best performance possible.

### Option 4: Nvidia Optimus

This section is for Office users who have either of the following graphics adapters installed:

- An Intel graphics adapter that has a version of the graphics driver that causes the problem
- An Nvidia Optimus graphics adapter

For these users, updating Office to a version that has the fix will not help. This is because the Nvidia Optimus graphics adapter can indirectly load and use the faulty Intel graphics adapter. These users should follow the steps in the "Option 3: Manually disable hardware acceleration in Office" section to work around the issue.

Some computers have third-party software that dictates how the Nvidia Optimus driver operates. It might be possible to configure these computers not to use the Intel graphics adapter. Contact the third-party vendor for instructions about how to do this.

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]
