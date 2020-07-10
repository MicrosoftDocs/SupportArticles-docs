---
title: Third-party installed font does not appear in the font list in Word for Mac
description: Fixes an issue in which third-party installed font does not appear in the font list in Word for Mac.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Microsoft Word for Mac
---

# Third-party installed font does not appear in the font list in Word for Mac

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

After you install a font into the Fonts folder in the operating system and start Microsoft Word for Mac, the font unexpectedly is not available in the Font dialog box, in the drop-down list, or in the Formatting Palette.

## Cause

Third-party fonts are not directly supported in Microsoft Office for Mac applications. Some third-party fonts may work in one application and not in another. Other third-party fonts are installed in a "family". A family usually consists of the third-party font itself together with some or all of its variations (bold, italic, and so forth). Sometimes, a font may be displayed in Microsoft Word, Microsoft PowerPoint, Microsoft Excel, or Microsoft Entourage, but you may be unable to use one of its variations, such as italic.

Office does not support custom fonts. This includes any fonts that were manipulated by a font or typography program.

> [!NOTE]
> Microsoft Office for Mac technical support does not provide support for installing or configuring third-party fonts.

## Basic font troubleshooting

If the following methods don't resolve your font issue, contact the font manufacturer or the website from which you purchased the fonts.

First, restart your computer, and then test the font again. Some installations are not complete until the computer is restarted. This also makes sure that all applications are restarted after the installation.

### Method 1

1. Clear the font caches. To do this, quit all Microsoft Office applications. On the **Home** menu, click **Go **> **Applications**, and then click Apple's Font Book.
2. On the **Edit** menu, click **Select Duplicated Fonts**.
3. On the **Edit** menu, click **Resolve Duplicates**.
4. To remove all the fonts from the computer that Font Book just disabled, follow these steps:  

   1. After the duplicates have been resolved, select each disabled font, click **File** > **Reveal in Finder**, and then drag it to the trash.
   2. You may notice that Font Book sometimes turns off the newer copy of the font instead of the older one. If you prefer the newer copy, drag the older one to the trash, and then re-enable the new one.

5. Restart the computer. Apple OS X will rebuild its font cache, and Word will rebuild its font cache from that.
6. For best performance in Word, try to run with all your fonts enabled all the time. Each time that Word starts, it compares its font cache with the system font cache. If the two don't match, Word will regenerate its own font cache, which can take a few seconds. If you have dynamically enabled fonts, the system font cache will appear different nearly every time that Word runs this comparison.
7. You must do this every time you install an update, because the Microsoft installer tries to restore the disabled fonts each time.

### Method 2

Restart the computer in Safe mode. Then, restart the computer normally. For more information about how to restart your computer in Safe mode, click the following article number to view the article in the Microsoft Knowledge Base:

[2398596](https://support.microsoft.com/help/2398596/how-to-use-a-clean-startup-to-determine-whether-background-programs-are-interfering-with-office-for-mac?preview=false) How to use a "clean startup" to determine whether background programs are interfering with Office for Mac

### Method 3

Create a new user account to determine whether the problem is associated with an existing user account.

### The font is damaged, or the system is not reading the font

If the font is not a custom font and does not appear in your Office program, the font may be damaged. To reinstall the font, see [Mac OS X: Font locations and their purposes](https://support.apple.com/ht201722).

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.