---
title: Incorrect holidays in .hol files
description: This article documents a known issue with the Outlook 2010 holiday (.hol) file. The same issue is present in the updated .hol file that was released for Outlook 2007 in August 2012.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz, alexcolt
appliesto: 
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
search.appverid: MET150
ms.date: 10/30/2023
---
# Incorrect holidays in Outlook 2007 and Outlook 2010 .hol files

_Original KB number:_ &nbsp; 2764690

## Symptoms

After you import the Microsoft Office Outlook 2007 holiday (.hol) file released on August 28, 2012, you notice that some holidays are listed incorrectly. Additionally, the .hol file that is included with Microsoft Outlook 2010 lists the same incorrect dates.

Here is an example of two holidays which are displayed incorrectly.

|Holiday|Incorrect Date|Correct Date|
|---|---|---|
|Pfingstsonntag|2015/5/28|2015/5/24|
|Whit Sunday|2015/5/28|2015/5/24|
|Pfingstmontag|2015/5/29|2015/5/25|
|Whit Monday|2015/5/29|2015/5/25|

## Workaround

To work around this issue, edit the .hol file. In the examples in this section, the Whit Monday and Whit Sunday holidays are corrected in the .hol file.

### Method 1 - Before importing the .hol for the first time

1. Exit Outlook if it is running.
2. In Microsoft Windows Explorer, locate the following file:

    *drive*:\Program Files\Microsoft Office\Office **xx**\\*LCID*\outlook.hol

    where **xx** is 12 for 2007 Microsoft Office and 14 for Office 2010.

    > [!NOTE]
    > *LCID* is your locale identification (LCID) number. For more information about LCID numbers, see the More Information section.
3. Make a backup copy of the file.
4. Using a text editor, such as Notepad, open the Outlook.hol file.
5. Search for Whit Sunday.
6. Change Whit Sunday,2015/5/28 to Whit Sunday,2015/5/24.
7. Do this for every occurrence of Whit Sunday.
8. Search for Whit Monday.
9. Change Whit Monday,2015/5/29 to Whit Monday,2015/5/25 .
10. Do this for every occurrence of Whit Monday.
11. Save and close Outlook.hol.Now you can import the corrected Holidays into your calendar.

### Method 2 - After importing the .hol file that has incorrect holidays

This method can be used if you already imported the .hol file in your Outlook.

#### Step 1: Delete the incorrect holidays and events

Follow these steps to delete the holidays and events that are not showed correctly in your calendar. You can also use the following steps to delete any duplicate holidays that were added while you were adding holidays to your calendar.

1. Navigate to your Calendar.
2. On the **View** tab of the ribbon, select **Change View**, and then select **Events**.
3. Select the holidays that you want to delete. To select multiple rows, hold down the Ctrl key, and then select other rows.
    > [!NOTE]
    > To select the row, select the icon.
4. Press Delete.

To quickly delete all the holidays for a country/region, select the **Location** column heading to sort the list of events so that it displays all the holidays for a country/region together.

#### Step 2: Create custom holiday and event files

Create your own custom holiday set to replace the Holidays that you deleted in step 1.

1. Exit Outlook.
2. In Microsoft Windows Explorer, locate the following file:

    *drive*:\Program Files\Microsoft Office\Office *xx*\\**LCID**\outlook.hol

    where *xx* is 12 for 2007 Microsoft Office and 14 for Office 2010.

    > [!NOTE]
    > **LCID** is your locale identification (LCID) number. For more information about LCID numbers, see the More Information section.
3. Make a backup copy of the file.
4. Using a text editor, such as Notepad, open the Outlook.hol file.
5. Press Ctrl+End to position the cursor at the end of the file.
6. Type a new header and custom events by using the format described here.

    [Country/Region or Description] **###**  
    Holiday or event description, yyyy/mm/dd  
    Holiday or event description, yyyy/mm/dd

    **###** is the total number of items that are listed for a particular country/region or description. There is a space between the closing bracket and the number, as well as a carriage return at the end of the line. On each holiday line, there are a comma and a space between the holiday description and the date, and a carriage return at the end of the line. For example:

    [2015 Whit Sunday and Whit Monday] 2  
    Whit Sunday, 2015/5/24  
    Whit Monday, 2015/5/25

7. Save and close the Outlook.hol file.

The next time that you run Outlook, you can import the changed holiday file for 2015.
