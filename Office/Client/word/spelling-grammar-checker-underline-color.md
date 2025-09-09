---
title: Customize the color of the spelling and grammar checker underlines in Word
description: Describes how to customize the color of spelling and grammar checker underlines in Word 2007 and Word 2010. Provides step-by-step directions and hexadecimal values of colors.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Editing\Spellcheck
  - CSSTroubleshoot
ms.author: meerak
appliesto: 
  - Word for Microsoft 365
  - Word 2019
  - Word 2016
  - Word 2013
  - Word 2010
ms.date: 06/06/2024
---

# How to customize the color of the spelling and grammar checker underlines in Microsoft Word

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure to back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [Windows registry information for advanced users](https://support.microsoft.com/help/256986).

## Introduction

This article describes how to customize the color of the spelling and grammar checker underlines in Microsoft Word 2007 and later. These underlines indicate the following items:

- Spelling errors   
- Grammar errors   
- Contextual spelling errors   
- Smart tags   

## More Information

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall your operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

To change the color of the wavy underline that indicates spelling errors, follow these steps:

1. Click **Start**, click **Run**, type regedit, and then click **OK**.    
2. Locate and then click the following registry subkey:

    **HKEY_CURRENT_USER\Software\Microsoft\Shared Tools\Proofing Tools**
1. If the **SpellingWavyUnderlineColor** entry exists, go to step 6.

    If the **SpellingWavyUnderlineColor** entry does not exist, go to step 4.
4. On the **Edit** menu, point to **New**, and then click **DWORD Value**.    
5. In the right pane, type SpellingWavyUnderlineColor. This is the name of the new entry.   
6. In the right pane, double-click **SpellingWavyUnderlineColor**.    
7. In the **Edit DWORD Value** dialog box, click **Hexadecimal**.   
8. In the **Value data** box, type the hexadecimal number that represents the color that you want to use, and then click **OK**.   
9. Repeat steps 3 to 8 to change the underline color for other proofing tools. Use the registry entry that corresponds to the underline color of the proofing tool that you want to change instead of the SpellingWavyUnderlineColor registry entry, as follows:
      - To change the color of the wavy underline that indicates grammar errors, use the GrammarWavyUnderlineColor registry entry.   
      - To change the color of the wavy underline that indicates contextual spelling errors, use the ContextualSpellingWavyUnderlineColor registry entry.   
      - To change the color of the dotted underline that indicates smart tags, use the SmartTagUnderlineColor registry entry.   

10. Exit Registry Editor, and then restart your computer.   

The registry uses eight-digit hexadecimal values to define colors. The values for some common colors are indicated in the following table. 

|Color|Red|Green|Blue|Registry Value|
|---|---|---|---|---|
|White|255|255|255|00FFFFFF|
|Black|0|0|0|00000000|
|Red|255|0|0|00FF0000|
|Green|0|255|0|0000FF00|
|Blue|0|0|255|000000FF|
|Cyan|0|255|255|0000FFFF|
|Magenta|255|0|255|00FF00FF|
|Yellow|255|255|0|00FFFF00|
|Dark Gray|127|127|127|007F7F7F|
|Light Gray|191|191|191|00BFBFBF|
|Dark Red|127|0|0|007F0000|
|Dark Green|0|127|0|00007F00|
|Dark Blue|0|0|127|0000007F|
|Teal|0|127|127|00007F7F|
|Purple|127|0|127|007F007F|
|Tan|127|127|0|007F7F00|
