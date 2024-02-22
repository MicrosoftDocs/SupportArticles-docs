---
title: Contact is listed twice when selecting email recipient
description: Describes a behavior where some recipient addresses are listed twice when you select Contacts in the Address Book in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: JEFFBE, TasitaE
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office Outlook 2003
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 10/30/2023
---
# Contacts with both an e-mail address and a fax number are listed twice when you select an e-mail recipient in Outlook

_Original KB number:_ &nbsp; 305361

## Symptoms

When you open the Address Book in Microsoft Outlook, and then select **Contacts**, some recipient addresses are listed two times. One listing has an e-mail appended to the address, and the second listing has a fax appended to the address.

## Cause

This behavior is by design in the Outlook Address Book. Recipients who have both an e-mail address and a fax number are listed two times; one time for the e-mail address and one time for the fax number.

## Workaround

If you are not using Outlook to send faxes, you can avoid this behavior by storing fax numbers in a field that is not specific to faxing. For example, you can store fax numbers in the Other field in the telephone numbers section of the **name**-Contact dialog box. This way, the fax number is still available, but it is not considered an alternative method for delivery by Outlook or by the Check Names feature.

If you have already stored fax telephone numbers in a fax telephone number field, you can work around this behavior by globally moving the fax numbers from the current field to another field that is not related to faxing.

Back up the Contacts folder or make a copy of the exported file before you make any changes, or import them back to Outlook, to avoid accidentally losing any contacts in the process.

Use the following methods to globally move fax numbers from one field to another:

- Export the current Contacts folder to a .CSV (Comma Separated Values) file
- Edit the exported data file in Microsoft Excel.
- Import the changed data back to Outlook.

## How to export the current Contacts folder

1. Open the **Import and Export Wizard** in Outlook. To do this, follow the steps for your version of Outlook.

   - Outlook 2013 or later versions: On the **File** tab, select **Open & Export**, and then select **Import/Export**.
   - Outlook 2010: On the **File** tab, select **Open**, and then select **Import**.
   - Outlook 2007 or earlier versions: On the **File** menu, select **Import and Export**.
2. In the **Import and Export Wizard** dialog box, select **Export to a file**, and then select **Next**.

3. In the **Export to a File** dialog box, select **Comma Separated Values (Windows)**, and then select **Next**.
4. Select **Contacts**, and then select **Next**.
5. In the **Save exported file as** box, specify the location and the name of the exported file, and then select **Next**.
6. Select **Finish**.

## How to edit the exported data file

1. Open the exported file in Excel.
2. Change the name of the fax number column to OtherPhone (without the quotation marks), and then delete the original, blank OtherPhone column.
3. If the original OtherPhone column contains information, select another column that is blank, change the name of the fax number column to the name of that column, and then delete the original column.
4. Save the changes in Excel.

    > [!NOTE]
    > If you receive a prompt to keep this format when you save the changes to your data file in Excel, select **Yes**.

5. Quit Excel.

## How to import the changed data back to Outlook

1. Open the **Import and Export Wizard** in Outlook. To do this, follow the steps for your version of Outlook.

   - Outlook 2013 or later versions: On the **File** tab, select **Open & Export**, and then select **Import/Export**.
   - Outlook 2010: On the **File** tab, select **Open**, and then select **Import**.
   - Outlook 2007 or earlier versions: On the **File** menu, select **Import and Export**.

2. In the **Import and Export Wizard** dialog box, select **Import from another program or file**, and then select **Next**.
3. In the **Import a File** dialog box, select **Comma Separated Values (Windows)**, and then select **Next**.
4. In the **File to import** box, type the location and the name of the file that you just changed, select **Replace duplicates with items imported**, and then select **Next**.
5. Select **Contacts**, and then select **Next**.
6. Select **Finish**.

The recipients should be listed only once in the **Select Names** dialog box.

## More information

Duplicate entries double the size of the list that you need to search in order to address a message. In addition, if you use the Check Names feature when you address an e-mail message, you are forced to choose between the fax number and the e-mail address listings, even though you are sending an e-mail message.
