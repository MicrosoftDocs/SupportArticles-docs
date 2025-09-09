---
title: Control settings in the Format Cells dialog box
description: Explains that you can modify most of these settings in the Format Cells dialog box to change the way that your data is presented.
author: Cloud-Writer
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.reviewer: emmersp
ms.custom: 
  - Editing\Cells
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Excel 2016
  - Excel 2013
  - Excel 2010
  - Office Excel 2007
  - Office Excel 2003
ms.date: 05/26/2025
---

# How to control and understand settings in the Format Cells dialog box in Excel

## Summary

Microsoft Excel lets you change many of the ways it displays data in a cell. For example, you can specify the number of digits to the right of a decimal point, or you can add a pattern and border to the cell. You can access and modify most of these settings in the Format Cells dialog box (on the Format menu, select Cells).

The "More Information" section of this article provides information about each of the settings available in the Format Cells dialog box and how each of these settings can affect the way your data is presented. 

## More Information

There are six tabs in the Format Cells dialog box: Number, Alignment, Font, Border, Patterns, and Protection. The following sections describe the settings available in each tab.

### Number Tab

#### Auto Number Formatting

By default, all worksheet cells are formatted with the General number format. With the General format, anything you type into the cell is left as-is. For example, if you type 36526 into a cell and then press ENTER, the cell contents are displayed as 36526. It's because the cell remains in the General number format. However, if you first format the cell as a date (for example, d/d/yyyy) and then type the number 36526, the cell displays `1/1/2000`.

There are also other situations where Excel leaves the number format as General, but the cell contents are not displayed exactly as they were typed. For example, if you have a narrow column and you type a long string of digits like 123456789, the cell might instead display something like 1.2E+08. If you check the number format in this situation, it remains as General.

Finally, there are scenarios where Excel may automatically change the number format from General to something else, based on the characters that you typed into the cell. This feature saves you from having to manually make the easily recognized number format changes. The following table outlines a few examples where this behavior can occur:  

|If you type |Excel automatically assigns this number format |
|-------------|------------------------------ |
|1.0 |General|
| 1.123 |General|
 1.1%| 0.00% |
|1.1E+2 |0.00E+00|
| 1 1/2 |# ?/?|
| $1.11 |Currency, two decimal places |
|1/1/01 |Date |
|1:10| Time|

Generally speaking, Excel applies automatic number formatting whenever you type the following types of data into a cell: 

- Currency    
- Percentage    
- Date    
- Time    
- Fraction    
- Scientific    
 
#### Built-in Number Formats

Excel has a large array of built-in number formats from which you can choose. To use one of these formats, select any one of the categories below General and then select the option that you want for that format. When you select a format from the list, Excel automatically displays an example of the output in the Sample box on the Number tab. For example, if you type 1.23 in the cell and you select Number in the category list, with three decimal places, the number 1.230 is displayed in the cell.

These built-in number formats actually use a predefined combination of the symbols listed in the "Custom Number Formats" section. However, the underlying custom number format is transparent to you.

The following table lists all of the available built-in number formats:  

|Number format |Notes |
|---|---|
|Number |Options include: the number of decimal places, whether or not the thousands separator is used, and the format to be used for negative numbers.
|Currency |Options include: the number of decimal places, the symbol used for the currency, and the format to be used for negative numbers. This format is used for general monetary values.|
|Accounting| Options include: the number of decimal places, and the symbol used for the currency. This format lines up the currency symbols and decimal points in a column of data. |
|Date |Select the style of the date from the Type list box.|
|Time| Select the style of the time from the Type list box.|
|Percentage| Multiplies the existing cell value by 100 and displays the result with a percent symbol. If you format the cell first and then type the number, only numbers between 0 and 1 are multiplied by 100. The only option is the number of decimal places.|
|Fraction| Select the style of the fraction from the Type list box. If you don't format the cell as a fraction before typing the value, you may have to type a zero or space before the fractional part. For example, if the cell is formatted as General and you type 1/4 in the cell, Excel treats it as a date. To type it as a fraction, type 0 1/4 in the cell.|
|Scientific| The only option is the number of decimal places.|
|Text| Cells formatted as text treat anything typed into the cell as text, including numbers.|
|Special |Select one of the following from the Type box: Zip Code, Zip Code + 4, Phone Number, and Social Security Number.|
  
#### Custom Number Formats

If one of the built-in number formats doesn't display the data in the format that you require, you can create your own custom number format. You can create these custom number formats by modifying the built-in formats or by combining the formatting symbols into your own combination.

Before you create your own custom number format, you need to be aware of a few simple rules governing the syntax for number formats:

- Each format that you create can have up to three sections for numbers and a fourth section for text.

  ```output
  <POSITIVE>;<NEGATIVE>;<ZERO>;<TEXT>
  ```

- The first section is the format for positive numbers, the second for negative numbers, and the third for zero values.    
- These sections are separated by semicolons.    
- If you have only one section, all numbers (positive, negative, and zero) are formatted with that format.    
- You can prevent any of the number types (positive, negative, zero) from being displayed by not typing symbols in the corresponding section. For example, the following number format prevents any negative or zero values from being displayed: 

  0.00;;
- To set the color for any section in the custom format, type the name of the color in brackets in the section. For example, the following number format formats positive numbers blue and negative numbers red: 

  [BLUE]#,##0;[RED]#,##0     
- Instead of the default positive, negative and zero sections in the format, you can specify custom criteria that must be met for each section. The conditional statements that you specify must be contained within brackets. For example, the following number format formats all numbers greater than 100 as green, all numbers less than or equal to -100 as yellow, and all other numbers as cyan: 

  [>100][GREEN]#,##0;[<=-100][YELLOW]#,##0;[CYAN]#,##0     
- For each part of the format, type symbols that represent how you want the number to look. See the following table for details on all the available symbols.  
 
To create a custom number format, select Custom in the Category list on the Number tab in the Format Cells dialog box. Then, type your custom number format in the Type box.

The following table outlines the different symbols available for use in custom number formats. 
 
|Format Symbol| Description/result|
|----|---|
|0 |Digit placeholder. For example, if you type 8.9 and you want it to display as 8.90, then use the format #.00|
|# |Digit placeholder. Follows the same rules as the 0 symbol except Excel doesn't display extra zeros when the number you type has fewer digits on either side of the decimal than there are # symbols in the format. For example, if the custom format is #.## and you type 8.9 in the cell, the number 8.9 is displayed.| 
|?| Digit placeholder. Follows the same rules as the 0 symbol except Excel places a space for insignificant zeros on either side of the decimal point so that decimal points are aligned in the column. For example, the custom format 0.0? aligns the decimal points for the numbers 8.9 and 88.99 in a column.|
|. (period)| Decimal point.|
|% |Percentage. If you enter a number between 0 and 1, and you use the custom format 0%, Excel multiplies the number by 100 and adds the % symbol in the cell.|
|, (comma)| Thousands separator. Excel separates thousands by commas if the format contains a comma surrounded by '#'s or '0's. A comma following a placeholder scales the number by a thousand. For example, if the format is #.0,, and you type 12,200,000 in the cell, the number 12.2 is displayed.|
|E- E+ e- e+ |Scientific format. Excel displays a number to the right of the "E" symbol that corresponds to the number of places the decimal point was moved. For example, if the format is 0.00E+00 and you type 12,200,000 in the cell, the number 1.22E+07 is displayed. If you change the number format to #0.0E+0 the number 12.2E+6 is displayed.|
|$-+/():space| Displays the symbol. If you want to display a character that is different than one of these symbols, precede the character with a backslash (\) or enclose the character in quotation marks (" "). For example, if the number format is (000) and you type 12 in the cell, the number (012) is displayed.|
| \ | Display the next character in the format. Excel doesn't display the backslash. For example, if the number format is 0\! and you type 3 in the cell, the value 3! is displayed. 
|*| Repeat the next character in the format enough times to fill the column to its current width. You can't have more than one asterisk in one section of the format. For example, if the number format is 0*x and you type 3 in the cell, the value 3xxxxxx is displayed. Note, the number of "x" characters displayed in the cell vary based on the width of the column.|
|_ (underline)| Skip the width of the next character. It's useful for lining up negative and positive values in different cells of the same column. For example, the number format _(0.0_);(0.0) align the numbers 2.3 and -4.5 in the column even though the negative number has parentheses around it.|
|"text"| Display whatever text is inside the quotation marks. For example, the format 0.00 "dollars" displays "1.23 dollars" (without quotation marks) when you type 1.23 into the cell.|
|@| Text placeholder. If there's text typed in the cell, the text from the cell is placed in the format where the @ symbol appears. For example, if the number format is "Bob "@" Smith" (including quotation marks) and you type "John" (without quotation marks) in the cell, the value "Bob John Smith" (without quotation marks) is displayed.|
|DATE FORMATS||
|m| Display the month as a number without a leading zero.|
|mm| Display the month as a number with a leading zero when appropriate.|
|mmm| Display the month as an abbreviation (Jan-Dec).|
|mmmm| Display the month as a full name (January-December).|
|d| Display the day as a number without a leading zero.|
|dd| Display the day as a number with a leading zero when appropriate.|
|ddd| Display the day as an abbreviation (Sun-Sat).|
|dddd| Display the day as a full name (Sunday-Saturday).|
|yy| Display the year as a two-digit number.|
|yyyy| Display the year as a four-digit number.|
|TIME FORMATS||
|h |Display the hour as a number without a leading zero.|
 [h]| Elapsed time, in hours. If you're working with a formula that returns a time where the number of hours exceeds 24, use a number format similar to [h]:mm:ss.|
|hh| Display the hour as a number with a leading zero when appropriate. If the format contains AM or PM, then the hour is based on the 12-hour clock. Otherwise, the hour is based on the 24-hour clock.|
|m| Display the minute as a number without a leading zero.|
|[m] |Elapsed time, in minutes. If you're working with a formula that returns a time where the number of minutes exceeds 60, use a number format similar to [mm]:ss.|
|mm| Display the minute as a number with a leading zero when appropriate. The m or mm must appear immediately after the h or hh symbol, or Excel displays the month rather than the minute.|
|s| Display the second as a number without a leading zero.|
|[s]| Elapsed time, in seconds. If you're working with a formula that returns a time where the number of seconds exceeds 60, use a number format similar to [ss].|
|ss| Display the second as a number with a leading zero when appropriate. Note that if you want to display fractions of a second, use a number format similar to h:mm:ss.00.|
|AM/PM, am/pm, A/P, a/p  |Display the hour using a 12-hour clock. Excel am/pm displays AM, am, A, or a for times from midnight A/P until noon, and PM, pm, P, or p for times from noon a/p until midnight.  |

#### Displayed Value versus Stored Value

Microsoft Excel displays a number according to the format of the cell that contains it. Therefore, the number that you see in the cell may differ from the number stored by Excel and from the number used in calculations that refer to the cell. For example, if you type 1.2345 in a cell where you only want two digits to the right of the decimal to be displayed, the cell displays the value 1.23. Note however, if you use that cell in a calculation, the full four digits to the right of the decimal are used.

### Alignment Tab

You can position text and numbers, change the orientation and specify text control in cells by using the Alignment tab in the Format Cells dialog box.
 
#### Text Alignment

Under **Text alignment**, you control the horizontal, vertical alignment and indention. The following table lists available settings for text alignment:
 
|Group |Setting |Description |
|---|---|---|
|Horizontal| General |Text data is left-aligned, and numbers, dates, and times are right-aligned. Changing the alignment doesn't change the type of data.|
| |Left (Indent)| Aligns contents at the left edge of the cell. If you specify a number in the Indent box, Microsoft Excel indents the contents of the cell from the left by the specified number of character spaces. The character spaces are based on the standard font and font size selected on the General tab of the Options dialog box (Tools menu).|
|  | Center |Centers the text in the selected cells. |
|  | Right| Aligns contents at the right edge of the cell.|
|  | Fill| Repeats the contents of the selected cell until the cell is full. If blank cells to the right also have the Fill alignment, they're filled as well.|
|  | Justify| Aligns wrapped text within a cell to the right and left. You must have more than one line of wrapped text to see the justification. |
|  |Center Across Selection |Centers a cell entry across the selected cells. |
|  Vertical |Top |Aligns cell contents along the top of the cell. |
|  |Center |Centers cell contents in the middle of the cell from top to bottom.|
|  | Bottom |Aligns cell contents along the bottom of the cell.|
|   |Justify| Justifies the cell contents up and down within the width of the cell.  |

#### Text Control

There are some more miscellaneous text alignment controls in the Text Control section of the Alignment tab. These controls are Wrap Text, **Shrink to Fit** and Merge Cells.

Select Wrap Text to wrap the text in the selected cell. The number of wrapped lines depends on the width of the column and the length of the cell contents.

> [!NOTE]
> To start a new line when the Wrap Text option is selected, press ALT+ENTER while typing in the formula bar.

Selecting the **Shrink to Fit** option decreases the font size of the text in a cell until all the contents of the cell can be displayed. This feature is helpful when you want to avoid changing the column width for the entire column. The applied font size isn't changed.

The Merge Cells option combines two or more selected cells into a single cell. A "merged cell" is a single cell created by combining two or more selected cells. The cell reference for a merged cell is the upper-left cell in the original selected range. 

#### Orientation

You can set the amount of text rotation in the selected cell by using the Orientation section. Use a positive number in the Degree box to rotate the selected text from lower left to upper right in the cell. Use negative degrees to rotate text from upper left to lower right in the selected cell.

To display text vertically from top to bottom, select the vertical Text box under Orientation. This gives a stacked appearance to text, numbers and formulas in the cell. 

### Font Tab

The term font refers to a typeface (for example, Arial), along with its attributes (point size, font style, underlining, color, and effects). Use the Font tab in the Format Cells dialog box to control these settings. You can see a preview of your settings by reviewing the Preview section of the dialog box.

> [!NOTE]
> You can use this same Font tab to format individual characters. To do so, select the characters in the formula bar and select Cells on the Format menu. 

#### Typeface, Font Style, and Size

The Font option on the Font tab allows you to choose a typeface. You choose your typeface for the selected cell by selecting a name in the Font list or typing a name in the Font box. There are three types of typefaces you can use, as described in the following table:  

|Font type| Icon (Left of Name)| Description (bottom of dialog box)| 
|----|---|--|
|TrueType| TT |The same font is used on both the printer and the screen. |
|Screen Display| none| This font is installed for screen display only. The closest available font is used for printing. |
|Printer| Printer |This is a printer-resident font. What is printed may not match exactly what is on the screen.|

After you select a typeface in the Font list, the Size list displays the available point sizes. Keep in mind that each point is 1/72 of an inch. If you type a number in the Size box that isn't in the Size list, you see the following text at the bottom of the Font tab: 

"This font's size isn't installed on the system. The closest available font will be used."

#### Typeface Styles

The list of choices in the Font Style list varies depending on the font that is selected in the Font list. Most fonts include the following styles: 
 
- Regular    
- Italic    
- Bold    
- Bold italic    
 
#### Underline

In the Underline list, you can select an underlining option to format the selected text. The following table describes each underlining option: 

|Underline type| Description| 
|----|----|
|None| No underlining is applied.|
|Single| A single underline is placed under each character in the cell. The underline is drawn through the descenders of characters like "g" and "p." |
|Double| Double underlines are placed under each character in the cell. The underlines are drawn through the descenders of characters like "g" and "p." |
|Single Accounting| A single underline is placed across the entire width of the cell. The underline is drawn below the descenders of characters like "g" and "p."|
|Double Accounting |Double underlines are placed across the entire width of the cell. The underlines are drawn below the descenders of characters like "g" and "p."  |

#### Color, Effects, and Normal Font Settings

Choose a color for the font by selecting a color in the Color list. You can rest the mouse over a color to see a ToolTip with the color name. The Automatic color is always black unless you change the window font color on the Appearance tab of the Display Properties dialog box. (Double-click the Display icon in the Control Panel to open the Display Properties dialog box.)

Select the **Normal font** check box to set the font, font style, size, and effects to the Normal style. This is essentially resetting the cell formatting to defaults.

Select the Strikethrough check box to draw a line through selected text or numbers. Select the Superscript check box to format the selected text or numbers as superscripts (above). Select the Subscript check box to format the selected text or numbers as subscripts (below). You typically want to use subscripts and superscripts for individual characters in a cell. To do this, select the characters in the formula bar and select Cells on the Format menu.
 
### Border Tab

In Excel, you can put a border around a single cell or a range of cells. You can also have a line drawn from the upper-left corner of the cell to the lower-right corner, or from the lower-left corner of the cell to the upper-right corner.

You can customize these cells' borders from their default settings by changing the line style, line thickness or line color.

The following settings are available on the Border tab of the Format Cells dialog box:  

|Group| Setting |Description |
|---|---|---|
|Presets |None |Turns off all borders that are currently applied to the selected cell(s).|
|  | Outline| Places a border on all four sides of a single cell or around a selected group of cells.|
|  | Inside| Places a border on all interior sides of a group of selected cells. This button is unavailable (dimmed) if a single cell is selected.| 
|Border| Top |Applies a border with the currently selected style and color to the top of the cell(s) in the selected region.|
|  | Inside Horizontal |Applies a border with the currently selected style and color to all horizontal sides in the interior of the currently selected group of cells. This button is unavailable (dimmed) if a single cell is selected. |
|   |Bottom| Applies a border with the currently selected style and color to the bottom of the cell(s) in the selected region. |
|  |Diagonal (bottom-left to upper-right| Applies a border with the currently selected style and color from the bottom-left corner to the upper-right corner for all cells in the selection.|
| | Left| Applies a border with the currently selected style and color to the top of the cell(s) in the selected region.|
|  | Inside Vertical| Applies a border with the currently selected style and color to all vertical sides in the interior of the currently selected group of cells. This button is unavailable (dimmed) if a single cell is selected.|
|  | Right| Applies a border with the currently selected style and color to the right side of the cell(s) in the selected region. |
|  |Diagonal (upper-left to bottom-right) |  Applies a border with the currently selected style and color from the upper-left corner to the lower-right corner for all cells in the selection.|
|  Line |Style| Applies the selected line style to the border. Choose from dotted, dashed, solid and double border lines. |
|  |Color| Applies the specified color to the border.  |

#### Applying Borders

To add a border to a single cell or a range of cells, follow these steps: 
 
1. Select the cells that you want to format.    
2. On the Format menu, select Cells.    
3. In the Format Cells dialog box, select the Border tab.

   > [!NOTE]
   > Some buttons on the Border tab are unavailable (dimmed) when you only have a single cell selected. This is because these settings are only applicable when you apply borders to a range of cells.    
4. Select any one of the line styles in the Style list.    
5. Select the Color drop-down arrow and select any one of the colors.    
6. Select any one of buttons listed under Presets or Border.

   This displays a line with your settings in the sample region.    
7. If you want to remove a specific border, select the button for that border a second time.    
8. If you want to change the line color or style, select the style or color that you want, and then select the button for the border again.    
 
### Patterns Tab

Use the Patterns tab in the Format Cells dialog box to set the background color of the selected cells. You can also use the Pattern list to apply two-color patterns or shading for the background of the cell.

> [!NOTE]
> The color palette on the Patterns tab is the same color palette from the Color tab of the Options dialog box. select Options on the Tools menu to access the Options dialog box.

To shade cells with patterns, follow these steps: 
 
1. Select the cells to which you want to apply shading.    
2. On the Format menu, select Cells, and then select the Patterns tab.    
3. To include a background color with the pattern, select a color in the **Cell shading** box.    
4. select the arrow next to the Pattern box, and then select the pattern style and color that you want.    

If you do not select a pattern color, the pattern is black.

You can return the background color formatting for the selected cells to their default state by selecting No Color.

### Protection Tab

The Protection tab offers you two options for protecting your worksheet data and formulas: 
 
- Locked    
- Hidden    

However, neither of these two options takes effect unless you also protect your worksheet. To protect a worksheet, point to Protection on the Tools menu, select Protect Sheet, and then select the Contents check box. 

#### Locked

By default, all cells in a worksheet have the Locked option turned on. When this option is turned on (and the worksheet is protected), you cannot do the following: 
 
- Change the cell data or formulas.    
- Type data in an empty cell.    
- Move the cell.    
- Resize the cell.    
- Delete the cell or its contents.    

> [!NOTE]
> If you want to be able to type data in some cells after protecting the worksheet, make sure to clear the Locked check box for those cells.

#### Hidden

By default, all cells in a worksheet have the Hidden option turned off. If you turn on this option (and the worksheet is protected) the formula in a cell does not appear in the formula bar. However, you do see the results of the formula in the cell.

> [!IMPORTANT]
> The **Locked** and **Hidden** settings enable specific collaboration scenarios to function correctly in collaboration environments that do not include users who have malicious intent. You cannot enable a strong encryption file by using these settings.

To protect the document or the file from a user who has malicious intent, use Information Rights Management (IRM) to set permissions that will protect the document or the file.

For more information about the Office features that help enable collaboration, see [Description of Office features that are intended to enable collaboration and that are not intended to increase security ](https://support.microsoft.com/help/822924).  

## References

For more information about cell formatting, select **Microsoft Excel Help** on the **Help** menu, type worksheet formatting in the Office Assistant or the Answer Wizard, and then select **Search** to view the topics returned.
