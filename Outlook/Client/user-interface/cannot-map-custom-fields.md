---
title: Can't import an XLS or CSV file into the Outlook Hebrew version
description: Describes a problem in which you cannot import contact information from an XLS or CSV file into the Hebrew language version of Outlook 2010 using the import wizard.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: danv, brunosg
appliesto: 
  - Microsoft Outlook 2010
  - Outlook 2010 with Business Contact Manager
search.appverid: MET150
ms.date: 10/30/2023
---
# Can't map custom fields when importing an XLS or CSV file in the Hebrew version of Outlook 2010

_Original KB number:_ &nbsp; 2567286

## Symptoms

The Microsoft Outlook 2010 import wizard cannot import contact information from an XLS or CSV file into the Hebrew language version of Outlook 2010.

## Cause

The Outlook 2010 import wizard cannot match fields because of a "right to left" localization issue. The applicable sides of the **Map Custom Fields** dialog box are reversed from the English version.

## Resolution

A workaround exists to resolve this problem. It consists of editing the XLS or CSV file before you import it into Outlook 2010. To apply the workaround, follow these steps:

1. Open the CSV file in Microsoft Excel.
2. Open Outlook 2010 and create a new contact.
3. Look at the fields that are available in the contact information and match the information to the fields that are written in the Microsoft Excel CSV file.

    > [!NOTE]
    > The fields in the CSV file are displayed in line 1.

4. Replace all fields in the CSV file with the Hebrew equivalent fields in Outlook.

    Example: If cell A1 is 'First Name', replace it with 'שם פרטי'.

5. Save your file.
6. On the **File** menu in Outlook 2010, select **Open**.
7. Click **Import**.
8. Follow the **Import and Export Wizard** steps to import your file.

## More information

Here is a list of some fields and their Hebrew translation:

|Field|Hebrew translation|
|---|---|
|First Name|שם פרטי|
|Last Name|שם משפחה|
|Company|חברה|
|Middle Name|שם שני|
|Title|תואר|
|Suffix|סיומת|
|Email Address|דואר אלקטרוני|
|Work|עבודה|
|Home|בית|
|Fax|פקס|
|Mobile|נייד|

This article also applies to any right-to-left languages, such as Arabic.
