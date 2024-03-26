---
title: Incorrect function when saving an Office file to a CD-RW or a DVD/CD-RW drive
description: Describes an issue when you try to save a file in an Office program to a CD-RW, or a DVD/CD-RW drive, the file is not saved and you receive the Incorrect function error message.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Microsoft Office
ms.date: 03/31/2022
---

# "Incorrect function" when saving a file from an Office program to a CD-RW or a DVD/CD-RW drive

## Symptoms

When you try to save a file in one of Office programs to a CD-RW or a DVD/CD-RW drive, the file is not saved. Additionally, you receive the following error message:

**Incorrect function.**

When you click **OK** in the error message, you receive the following error message:

```asciidoc
You do not have access to the folder 'drive:\'. See your administrator for access to this folder.
```

## Cause

This behavior occurs because Microsoft Office programs do not use the CD-ROM writing function that is available in some Microsoft Windows operating systems.

## Workaround

To work around this behavior, install a third-party CD-ROM recording program. A third-party CD-ROM program lets the CD-ROM writing function that is available in Windows XP work with your Office program.

> [!NOTE]
> Not all third-party CD-ROM recording programs let you save a file from an Office program directly to a CD-RW or a DVD/CD-RW drive. In this case, you must save the file to the hard disk drive, and then use the CD-ROM recording program to burn the file to a CD-RW or a DVD/CD-RW drive.

For more information about how to do this with your third-party CD-ROM recording program, look at the documentation for the program.

## More Information

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

The information and the solution in this document represent the current view of Microsoft Corporation on these issues as of the date of publication. This solution is available through Microsoft or through a third-party provider. Microsoft does not specifically recommend any third-party provider or third-party solution that this article might describe. There might also be other third-party providers or third-party solutions that this article does not describe. Because Microsoft must respond to changing market conditions, this information should not be interpreted to be a commitment by Microsoft. Microsoft cannot guarantee or endorse the accuracy of any information or of any solution that is presented by Microsoft or by any mentioned third-party provider.
