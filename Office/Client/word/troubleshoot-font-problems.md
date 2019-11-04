---
title: Troubleshoot font problems
description: Describes general information about fonts and about how to troubleshoot font problems.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.reviewer: mmaxey
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Word 2016
- Word 2013
- Word 2010
---

# Overview of fonts and how to troubleshoot font problems in Microsoft Word

## Summary

This article contains an overview of fonts. Additionally, it describes how to troubleshoot font problems in Microsoft Office Word 2007 and later.

## More Information

### Overview of fonts

A font is a graphic design that is applied to a collection of numbers, symbols, and characters. A font specifies qualities such as typeface, size, spacing, and pitch. Fonts are used to print text on various output devices and to display text on the screen. Fonts have font styles such as italic, bold, and bold italic. 

#### Outline fonts

TrueType fonts and OpenType fonts are outline fonts that are rendered from line commands and from curve commands. OpenType is an extension of TrueType. Both TrueType fonts and OpenType fonts can be scaled and rotated. TrueType fonts and OpenType fonts look good in all sizes and on all output devices that are supported by Microsoft Windows. 

#### Screen fonts

ClearType fonts are screen fonts that are optimized for an LCD screen. On an LCD screen, ClearType fonts use sub-pixel information to smooth out the fonts' jagged edges. 

#### Printer fonts

In most programs that support printing, you can select among different printer fonts. Printers that offer the widest assortment of fonts include laser printers, ink-jet printers, and dot-matrix printers. You can divide printer fonts into the following three categories: 
 
- Internal fonts

   Internal fonts are also named resident fonts. Laser printers, ink-jet printers, and dot-matrix printers frequently use internal fonts. Internal fonts are already loaded into the printer's read-only memory (ROM). Internal fonts are always available for printing.    
- Cartridge fonts

   Cartridge fonts are stored in a cartridge or in a card that plugs into the printer. To expand a printer's set of internal fonts, you can install font cartridges. Or, you can load fonts from software.    
- Downloadable fonts

  Downloadable fonts are also named soft fonts. The computer sends downloadable fonts to the printer's memory when the fonts are required for printing. Laser printers and other page printers frequently use downloadable fonts. Some dot-matrix printers also use them. To increase printer speed, you should install downloadable fonts locally on client computers that print to Windows print servers.    
 
For each document that you print, Windows may have to send the screen fonts and the downloadable fonts that the document requires to the printer. To increase printer speed, use the following techniques: 
 
- Use fonts that do not have to be downloaded, such as internal fonts or cartridge fonts.    
- Some printers have a feature that enables the printer to keep a list of downloadable fonts. If your printer has this feature, make sure that you turn on the feature.    
 
Not all printers can use all three types of fonts. For example, pen plotters cannot ordinarily use downloadable fonts. For more information about the types of fonts that you can use, see the printer's documentation. 

#### Raster fonts

Raster fonts are also named bitmapped fonts. They are stored as bitmaps. A bitmap is a pattern of dots. Raster fonts are designed with a specific size and with a specific resolution for a specific printer. You cannot scale or rotate raster fonts. If a printer does not support raster fonts, it will not print them. The following fonts are the five raster fonts: 
 
- Courier    
- MS Sans Serif    
- MS Serif    
- Small    
- Symbol    
 
#### Vector fonts

Vector fonts are useful for output devices that cannot reproduce bitmaps. For example, pen plotters use vector fonts. Vector font characters are drawn with lines instead of with patterns of dots. You can scale characters to any size or to any aspect ratio. The following fonts are the three vector fonts: 
 
- Modern    
- Roman    
- Script    
 
### How to work with fonts in Word 2007 and Word 2010

To change the default font in Word 2007 
 
1. Create a new blank Word 2007 document.    
2. On the **Home** tab, click **Font Dialog** in the **Font** group.    
3. On the **Font** tab, select the options that you want to apply to the default font.    
4. Click **Default**.    
5. Click **Yes** to the following message: 
    
    ```adoc
    You are about to change the default font to (Default) font,font size, font style.
    
    Do you want this change to affect all new documents based on the NORMAL template? 
    ```
    
When you create a new document that is based on the Normal template (Normal.dotm), the new document uses the font settings that you selected.

To print a sample of all the available fonts in Word 2007 and Word 2010

You can use a Microsoft Visual Basic for Applications macro to generate a list of the fonts that are available to Word. Additionally, the macro displays a sample of each font. After you have run the macro, you can print a Word document that contains the list and the samples. For more information, click the following article number to view the article in the Microsoft Knowledge Base:

[209205 ](https://support.microsoft.com/help/209205) Macro to generate list of available fonts in Word

To find fonts that are similar 
 
1. Click **Start**, click **Run**, type control fonts, and then click **OK**.  
2. On the **View** menu, click **List Fonts By Similarity**.    
3. In the **List fonts by similarity to** box, click the font that you want to compare with the other fonts on the computer.    
 
> [!NOTE]
> Panose font mapping information is stored with the font to describe the font's characteristics. For example, these characteristics may include serif or sans serif, normal, bold, or italic. If no Panose information is available, the font appears at the bottom of the list, and it does not appear in the **List fonts by similarity to** box. 

### How to troubleshoot font problems in Word 2007 and Word 2010

#### Before you start to troubleshoot font problems

Before you start to troubleshoot font problems in Word 2007 and Word 2010, review the following general topics:  
 
- Always make sure that you have installed the latest service pack for your version of Windows. Several font problems have been corrected in Windows service packs.

- The exact number of TrueType fonts that you can install depends on the length of the TrueType font names and of the TrueType file names.    
 
#### Basic steps to troubleshoot font problems

To troubleshoot font problems in Word 2007 and Word 2010, follow these basic steps:  
 
1. Make sure that you are using the correct printer driver.

   Your problem may be that the default printer driver in Windows is a generic/text only printer driver, an installed fax driver, or a similar driver. To change the printer driver that Microsoft Word uses, use one of the following methods.

   **Important** Do not select a generic/text only printer driver or an installed fax driver as your default printer in Windows.  
    - In Word, click the **Microsoft Office Button or File Tab (Word 2010)**, and then click **Print**. In the **Name**box, click the name of an installed printer.    
    - Click **Start**, and then click **Printers and Faxes**. Right-click an installed printer, and then click **Set as Default Printer**.    
     
2. Check to see whether the problem occurs in a new document.

   Create a new Word document that is based on the Normal.dotm template. To create a new document that is based on the global template, click the **Microsoft Office Button**, and then click **New**. Click **Blank document**, and then click **Create**.

   Based on what occurs in the new document, follow these steps:  

     1. In the new document, try a different font. If you have no problems when you use a different font, the problem may be related to a specific font in Windows. Go to the next step to continue to troubleshoot.    
     2. In the new document, use the font that you used in the original Word document. If the font problem no longer occurs in the new Word document, the original document is probably damaged.

       **Note** If you used a template other than the Normal.dotm template to create the original Word document, the original document may be damaged. Or, the template from which the original document was created may be damaged. It is also possible that both the original document and its template are damaged.    
     3. If the problem with a specific font persists in the new document, try to use the font in a new WordPad document. To create a WordPad document, click **Start**, point to **All Programs**, point to **Accessories**, and then click **WordPad**.

        If the problem that you experienced in Word persists in the WordPad document, the font is probably damaged. You may have to delete and then reinstall the problem font in Windows.

        To delete a font, follow these steps:  
         1. Click **Start**, click **Run**, type control fonts, and then click **OK**.    
         2. Click the font that you want to remove.

            **Note** To select more than one font, press and hold down CTRL, and then click each font that you want to remove.    
         3. On the **File**menu, click **Delete**.    
         4. Click **Yes**to the following message: Are you sure you want to delete these fonts?      

        To reinstall the font, follow these steps:

         1. Click **Start**, click **Run**, type control fonts, and then click **OK**.
         1. On the **File**menu, click **Install New Font**.
         1. In the **Drives** box, click the drive that contains the font that you want to install.
         1. In the **Folders**list, double-click the folder that contains the font that you want to install.
         1. In the **List of fonts** list, click the font that you want to install, and then click **OK**.

              **Note** To install all the fonts that are listed, click **Select All**, and then click **OK**.     

        For more information about how to delete a font or how to install a font in Windows, contact either Microsoft Windows Technical Support or the vendor that supplies the font.

        For more information about how to obtain help with Windows XP, click **Start**, click **Help and Support Center**, and then click **Get support, or find information in Windows XP newsgroups**.

3. Check to see whether the problem occurs when you print the document at a lower resolution.

   You may have to print the document at a printer resolution that differs from the resolution at which the printer ordinarily prints. By default, most printers print at either 300 dpi (dots per inch) or at 600 dpi. To determine whether the printer resolution is the problem, follow these steps:  
     1. Click **Start**, and then click **Printers and Faxes**.    
     2. Right-click the installed printer driver, and then click **Properties**.

        **Note** The steps to change printer resolution differ depending on the printer driver. For more information, see the printer's documentation.    
     3. Click the **Graphics** tab. In the **Resolution** list, click a lower resolution setting. For example, in the **Resolution** list, click **150 dots per inch**.    
     4. Click **OK**.     
4. Check to see whether the problem occurs when you print to a different printer.

   The installed printer driver may not be able to correctly print the font that you want. To determine whether this is the problem, specify a different printer as the default printer. Then, try to print the document.

   If the different printer correctly prints the Word document, the original installed printer driver may be damaged. Or, the original installed printer driver cannot print the document correctly. To correct these problems, use one of the following methods:  
     - Remove and then reinstall the original printer driver.    
     - Download and then install an updated printer driver for the printer.    
     - Use a printer driver that is compatible with the printer.    
 
### Additional resources

Microsoft provides a typography Web site that explains the benefits and the features of TrueType. TrueType is the world's most popular digital font format. The site helps people to use type in more innovative ways in media such as print, video, and the World Wide Web.

For more information, see [Microsoft Typography](https://www.microsoft.com/typography).

The Microsoft Typography Web site includes the following resources: 
- Web Embedding Fonts Tool (WEFT)

  With WEFT you can create font objects that are linked to your Web pages. When font objects are linked to your Web pages, Internet Explorer users see the pages displayed with the font styles that are contained in the font objects.    
- Font Properties Extension

  Font Properties Extension adds several new property tabs to the default **Properties** dialog box. These tabs include the following information:  
   - Font origination    
   - Font copyright    
   - The type sizes to which hinting and smoothing are applied    
   - The code pages that are supported by extended character sets       
- ClearType Tuner PowerToy

  With ClearType Tuner PowerToy, you can enable and tune your ClearType settings in Control Panel.    
