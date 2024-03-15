---
title: A single-byte font to replace a double-byte font error in PowerPoint 2010
description: Provides a workaround for an issue in which you receive the You selected a single-byte font to replace a double-byte font error message when you try to replace a Japanese font in PowerPoint 2010.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - PowerPoint 2010
ms.date: 03/31/2022
---

# "You selected a single-byte font to replace a double-byte font" when replacing a Japanese font

## Symptoms

Consider the following scenario. You open a Microsoft PowerPoint 2010 presentation that contains Japanese font sets. On the **Home** tab, in the **Editing** group, under **Replace**, you click **Replace Fonts**. In the **Replace** drop-down list, you select a Japanese font that you want to replace. You select a different Japanese font in the **With** drop-down list. Then, you click **Replace**.

In this scenario, the font is not replaced. Additionally, you receive the following error message:

**You selected a single-byte font to replace a double-byte font. Please select a double-byte font.**

## Cause

This issue occurs if the following conditions are true:

- The Japanese font that you want to replace is not installed on your computer.
- This Japanese font is a single-byte font.

When these conditions are true, you cannot replace the font, and you receive the error message.

## Workaround

### Method 1: Manually replace the font

To work around this issue, you can locate each text object that uses the font that you want to replace, and then select the text. Then, on the **Home** tab, in the **Font** group, on the **Font** drop-down list, select the font that you want to replace the old font with.

### Method 2: Replace the font on a computer that has the font installed

To work around this issue, you can either install the font that you want to replace, or you can replace the font in the presentation on a computer that has the font already installed.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.