---
title: Operating parameter limitations and specifications in Word
description: Describes operating parameter limitations and specifications in Word.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Reliability
  - CSSTroubleshoot
appliesto: 
  - Word for Microsoft 365
  - Word 2019
  - Word 2016
  - Word 2013
  - Word 2010
ms.date: 06/06/2024
---

# Operating parameter limitations and specifications in Word

This article lists the operating parameter limits of Microsoft Office Word and Microsoft Visual Basic for Applications.

## Visual Basic for Applications limits

### Word limits

**Note 1** Maximum File Size

The maximum file size is limited to 32 MB for the total document text only and does not include graphics, regardless of how the graphics image is inserted (Link to file, Save with document, or Wrapping style) into the document. Therefore, if the file contains graphics, the maximum file size can be larger than 32 MB.

**Note 2** Number of Words and Maximum File Size of Custom Dictionary

The Microsoft Word 2000 Help file lists the number of words and maximum file size of the custom dictionary incorrectly.

**Note 3** To invoke AutoComplete tips for AutoText, at least four characters of the AutoText entry must be typed.

## Word 2007 and later versions limits

|Operating parameter| Limit |
|---|---|
| Maximum number of bookmarks| 2,147,483,647 |
|(Style Definition) maximum number of styles| 4,079 |
| Maximum number of lists| 2,047 |
| Maximum number of comments| 2,147,483,647 |
| Maximum number of fields| 2,147,483,647 |
|Number of subdocuments in a master document|255|
| Maximum number of moves| 2,147,483,647 |
|(Range Permission) maximum number allowed| 2,147,483,647 |
|Size of file Word can open|512 MB|
|Maximum number of records to display in recipients list dialog|10,000|
|Maximum paper size|22" x 22"|

> [!NOTE]
> The 10,000 maximum is for the recipients' list dialog. If you search in that dialog, you are limited to the displayed records even if your data source has more records. The workaround is to filter the records, so that those records that you are looking for will fit in the dialog. Another workaround is to use the Find operation in the wizard task pane.

## Word 2007 and later versions in compatibility mode limits

|Operating parameter |Limit |
|----|---|
| Maximum number of bookmarks| 16,380 |
|(Style Definition) maximum number of styles| 4,079 |
| Maximum number of lists| 2,047 |
| Maximum number of comments| 16,380 |
|Number of subdocuments in a master document|255|
| Maximum number of fields| 2,147,483,647 |
| Maximum number of moves| 32,752 |
|(Range Permission) maximum number allowed| 32,752
|Size of file Word can open|512 MB|
|Maximum number of records to display in recipients list dialog|10,000|
|Maximum paper size|22" x 22"|

**Note 4** The 32,767 limit is for versions earlier than Word 2007.

**Note 5** Number of records to display in recipients list dialog

You are limited to 10,000 displayed records even if your data source has more records. To work around this limitation, filter the records so that they fit in the dialog, or use the Find operation from the wizard task pane.

## Related topics

[What is the maximum number of Merge Fields in Word 2016](https://answers.microsoft.com/en-us/msoffice/forum/msoffice_word-msoffice_custom-mso_2016/what-is-the-maximum-number-of-merge-fields-in-word/254cc398-2934-4745-8a4e-3216efadd67c)
