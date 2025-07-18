---
title: Third-party installed font doesn't appear in the font list in Word for Mac
description: Fixes an issue in which third-party installed font doesn't appear in the font list in Word for Mac.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Editing\Fonts
  - CSSTroubleshoot
appliesto: 
  - Microsoft Word for Mac
ms.date: 06/06/2024
---

# Third-party installed font doesn't appear in the font list in Word for Mac

## Symptoms

After you install a font into the Fonts folder in the operating system and start Microsoft Word for Mac, the font unexpectedly isn't available in the Font dialog box, in the drop-down list, or in the Formatting Palette.

## Cause

Third-party fonts aren't directly supported in Microsoft Office for Mac applications. Some third-party fonts may work in one application and not in another. Other third-party fonts are installed in a "family". A family usually consists of the third-party font itself together with some or all of its variations (bold, italic, and so forth). Sometimes, a font may be displayed in Microsoft Word, Microsoft PowerPoint, Microsoft Excel, or Microsoft Entourage, but you may be unable to use one of its variations, such as italic.

Office doesn't support custom fonts. This includes any fonts that were manipulated by a font or typography program.

> [!NOTE]
> Microsoft Office for Mac technical support doesn't provide support for installing or configuring third-party fonts.

## Basic font troubleshooting

If the following methods don't resolve your font issue, contact the font manufacturer or the website from which you purchased the fonts.

First, restart your computer, and then test the font again. Some installations aren't complete until the computer is restarted. This also makes sure that all applications are restarted after the installation.

### Method 1

1. Clear the font caches. To do so, quit all Microsoft Office applications. On the **Home** menu, select **Go** > **Applications**, and then select Apple's Font Book.
2. On the **Edit** menu, select **Select Duplicated Fonts**.
3. On the **Edit** menu, select **Resolve Duplicates**.
4. To remove all the fonts from the computer that Font Book disabled, follow these steps:  

   1. After the duplicates have been resolved, select each disabled font, select **File** > **Reveal in Finder**, and then drag it to the trash.
   2. You may notice that Font Book sometimes turns off the newer copy of the font instead of the older one. If you prefer the newer copy, drag the older one to the trash, and then re-enable the new one.

5. Restart the computer. Apple OS X rebuilds its font cache, and Word rebuilds its font cache from that.
6. For best performance in Word, try to run with all your fonts enabled all the time. Each time that Word starts, it compares its font cache with the system font cache. If the two don't match, Word regenerates its own font cache, which can take a few seconds. If you have dynamically enabled fonts, the system font cache appears different nearly every time that Word runs this comparison.
7. You must do this every time you install an update, because the Microsoft installer tries to restore the disabled fonts each time.

### Method 2

Restart the computer in Safe mode. Then, restart the computer normally. For more information about how to restart your computer in Safe mode, select the following article number to view the article in the Microsoft Knowledge Base:

[2398596](https://support.microsoft.com/help/2398596/how-to-use-a-clean-startup-to-determine-whether-background-programs-are-interfering-with-office-for-mac?preview=false) How to use a "clean startup" to determine whether background programs are interfering with Office for Mac

### Method 3

Create a new user account to determine whether the problem is associated with an existing user account.

### The font is damaged, or the system isn't reading the font

If the font isn't a custom font and doesn't appear in your Office program, the font may be damaged. To reinstall the font, see [macOS X: Font locations and their purposes](https://support.apple.com/HT201749).

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.
