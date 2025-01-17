---
title: The Recycle Bin is corrupted
description: Provides a solution to an issue where the Recycle Bin is corrupted.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, rafern, v-lianna
ms.custom: sap:Windows Desktop and Shell Experience\Desktop (Shell, Explorer.exe init, themes, colors, icons, recycle bin), csstroubleshoot
---
# The Recycle Bin is corrupted

This article provides a solution to an issue where the Recycle Bin is corrupted.

When you sign in to the system or try to delete a file, you receive this error message:

> The Recycle Bin on \<Drive\> is corrupted. Do you want to empty the Recycle Bin for this drive?

> [!NOTE]
> \<Drive\> might be a logical volume or a mounted volume.

This issue occurs because of a corrupted *$Recycle.bin* file.

To resolve the issue, run the following command from an elevated command prompt and then restart the system.

```console
RD <Drive>$Recycle.bin /s /q
```
