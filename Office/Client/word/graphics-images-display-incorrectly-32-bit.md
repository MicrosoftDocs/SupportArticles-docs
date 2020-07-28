---
title: Microsoft Word 32-bit version doesn't display graphics and images correctly
ms.author: v-todmc
author: McCoyBot
manager: dcscontentpm
ms.date: 4/16/2020
audience: Admin
ms.topic: article
ms.prod: word
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Microsoft Word
ms.custom: 
- CI 116005
- CSSTroubleshoot 
ms.reviewer: akeeler  
description: Resolves an issue with the 32-bit version of Microsoft Word if the graphics and images don't display correctly.
---

# Graphics and images don't display correctly in 32-bit version of Word

## Symptoms

You find that after upgrading to Windows 10, graphics or images do not display correctly in the 32-bit version of Microsoft Word.

## Cause

An older version of the file "d2d1.dll.mui" exists in the folder \windows\syswow64\en-us.

## Resolution

To resolve this issue, delete the following file:

```
\windows\syswow64\en-us\d2d1.dll.mui
```

Restart Word. Word will then use the correct version of the file.


## More information

Still need help? Go to [Microsoft Community](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fanswers.microsoft.com%2F&data=02%7C01%7Cv-todmc%40microsoft.com%7C98910814456c474880f108d7cf62d97d%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637205895885805857&sdata=9%2FYStDGvrU5ZIYXB7guowmaPlKazab0U%2BTpiBIItDaQ%3D&reserved=0).