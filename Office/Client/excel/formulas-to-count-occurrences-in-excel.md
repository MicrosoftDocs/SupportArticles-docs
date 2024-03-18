---
title: Formulas to count the occurrences of text, characters, and words in Excel
description: Provides examples to describe formulas that calculate the number of occurrences of text, characters, and words.
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
  - Excel 2016
  - Excel 2013
ms.date: 03/31/2022
---

# Description of formulas to count the occurrences of text, characters, and words in Excel

## Summary

This article contains and describes formulas that calculate the following:

- The number of occurrences of a text string in a range of cells.
- The number of occurrences of a character in one cell.
- The number of occurrences of a character in a range of cells.
- The number of words (or text strings) separated by a character in a cell.   

## More Information

### Formula to Count the Number of Occurrences of a Text String in a Range

=SUM(LEN(**range**)-LEN(SUBSTITUTE(**range**,"text","")))/LEN("text")

Where **range** is the cell range in question and "text" is replaced by the specific text string that you want to count.

> [!NOTE]
> The above formula must be entered as an array formula. To enter a formula as an array in Excel for Windows, press CTRL+SHIFT+ENTER. To enter a formula as an array in Excel for Macintosh, press COMMAND+RETURN.

The formula must be divided by the length of the text string because the sum of the character length of the range is decreased by a multiple of each occurrence of the text string. This formula can replace all later formulas in this article except the formula to count the number of words in a cell.

#### Example 1: Counting the Number of Occurrences of a Text String in a Range

1. Start Excel, and then open a new workbook.

2. Type the following on sheet1:

    ```AsciiDoc
    A1: Fruit
    A2: apple,apple
    A3: orange
    A4: apple,orange
    A5: grape
    A6: orange,grape
    A7: grape, apple
    A8: =SUM(LEN(A2:A7)-LEN(SUBSTITUTE(A2:A7,"apple","")))/LEN("apple")
    ```
    The value of cell A8 is 4 because the text "apple" appears four times in the range.

### Formula to Count the Number of Occurrences of a Single Character in One Cell

=LEN(**cell_ref**)-LEN(SUBSTITUTE(**cell_ref**,"a",""))

Where **cell_ref** is the cell reference, and "a" is replaced by the character you want to count.

> [!NOTE]
> This formula does not need to be entered as an array formula.

#### Example 2: Counting the Number of Occurrences of a Character in One Cell

Use the same data from the preceding example; assuming you want to count the number of occurrences of the character "p" in A7. Type the following formula in cell A9:

```A9: =LEN(A7)-LEN(SUBSTITUTE(A7,"p",""))```

The value of cell A9 is 3 because the character "p" appears three times in A7.

### Formula to Count the Number of Occurrences of a Single Character in a Range

=SUM(LEN(**range**)-LEN(SUBSTITUTE(**range**,"a","")))

Where **range** is the cell range in question, and "a" is replaced by the character you want to count.

> [!NOTE]
> The above formula must be entered as an array formula. To enter a formula as an array formula in Excel, press CTRL+SHIFT+ENTER. 

#### Example 3: Counting the Number of Occurrences of a Character in a Range

Use the same data from the preceding example; assuming you want to count the number of occurrences or the character "p" in A2:A7. Type the following formula in cell A10:

```A10: =SUM(LEN(A2:A7)-LEN(SUBSTITUTE(A2:A7,"p","")))```

> [!NOTE]
> The above formula must be entered as an array formula. To enter a formula as an array formula in Excel, press CTRL+SHIFT+ENTER.

The value of cell A10 is 11 because the character "p" appears 11 times in A2:A7.

### Formula to Count the Number of Words Separated by a Character in a Cell

=IF(LEN(TRIM(**cell_ref**))=0,0,LEN(**cell_ref**)-LEN(SUBSTITUTE(**cell_ref**,**char**,""))+1)

Where **cell_ref** is the cell reference, and **char** is the character separating the words.

> [!NOTE]
> There are no spaces in the above formula; multiple lines are used only to fit the formula into this document. Do not include any spaces when you type it into the cell. This formula does not need to be entered as an array formula.

#### Example 4: Counting the Number of Words Separated by a Space in a Cell

To count the number of words in a cell where the words are separated by a space character, follow these steps:

1. Start Excel, and then open a new workbook.

2. Type the following on sheet1:

    ```AsciiDoc
    A1: The car drove fast
    A2: =IF(LEN(TRIM(A1))=0,0,LEN(TRIM(A1))-LEN(SUBSTITUTE(A1," ",""))+1)
    ```
  
The formula in cell A2 returns a value of 4 to reflect that the string contains four words separated by spaces. If words are separated by multiple spaces or if words start or end in a space, it does not matter. The TRIM function removes extra space characters and starting and ending space characters in the text of the cell.

In Excel, you can also use a macro to count the occurrences of a specific character in a cell, or range of cells. 

## References

For additional information about counting occurrences of text, click the following article number to view the article in the Microsoft Knowledge Base:

[89794](https://support.microsoft.com/help/89794) How to use Visual Basic for Applications to count the occurrences of a character in a selection in Excel