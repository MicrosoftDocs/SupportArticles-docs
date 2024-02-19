---
title: You cannot set page files on a partition that is larger than 2 terabytes
description: Describes a problem that occurs when you try to set page files on a partition that is larger than 2 terabytes
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: adityah, kaushika
ms.custom: sap:applications, csstroubleshoot
---
# You cannot set page files on a partition that is larger than 2 terabytes

This article provides a workaround for an issue that occurs when you try to set page files on a partition that is larger than 2 terabytes.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 973423

## Symptoms

On a Windows-based computer, when you try to set a page file on a partition that is larger than 2 terabytes (TB), you receive the following error message:  

> Drive **X**: is too small for the maximum paging file size specified. Please enter a smaller number.

:::image type="content" source="./media/cannot-set-page-files-on-partition-larger-than-2-tb/drive-too-small.jpg" alt-text="The warning message that is shown in the System Properties." border="false":::

This problem occurs when you try to set page files in the Virtual Memory user interface in the **Advanced System Settings**. This is true regardless of whether the page file is a customized page file or a system-managed page file.

## Cause

This problem occurs because the Virtual Memory user interface calculates incorrectly the maximum space that is required to create the page file.

## Workaround

To work around this problem, use Windows Management Instrumentation (WMI) instead of the Virtual Memory user interface to set page files.

To create a page file, run the following command:  

```console
wmic.exe pagefileset creates name="<X>:\\pagefile.sys"
```

> [!NOTE]
> In this command, <**X**> is the letter of the drive on which you want to create the page file.

To set the size of the page file, run the following command:  

```console
wmic.exe pagefileset where name="<X>:\\pagefile.sys" set InitialSize=300000,MaximumSize=3000000
```

> [!NOTE]
> In this command, the page file size is set to 300,000 megabytes.

If you do not have to have the page file on drive C, run the following command to delete it:  

```console
wmic.exe pagefileset where name="C:\\pagefile.sys" delete
```

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed at the beginning of this article.
