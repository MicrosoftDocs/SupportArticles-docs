---
title: Unable to export or publish a table to a SharePoint list
description: You get an error attempting to export an Access table or publish an Access database to SharePoint when an Attachment in the Access table has an invalid SharePoint file name.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Access 2010
  - Microsoft Office Access 2007
search.appverid: MET150
ms.date: 05/26/2025
---
# Access errors publishing or exporting to SharePoint when attachment file name is invalid

_Original KB number:_ &nbsp; 2711562

## Symptoms

You receive one of the following errors when you attempt to export a Microsoft Access table to a SharePoint list:

> There was an error copying data to a SharePoint list. The Microsoft Access database engine encountered an error while communicating with SharePoint. More detailed information:

-OR-

> There was an error copying data to a SharePoint list. Network I/O error.

You receive the following error when you attempt to publish a Microsoft Access 2010 database to a SharePoint Server:

> Publish Failed. Your application has encountered errors while attempting to publish. The publish operation has failed and the target site has not been created.

When you click to view the details for the message, the first error entry is:

> "There was an error uploading the data in the tables being created on the server. The Microsoft Access database engine encountered an error while communicating with SharePoint. More detailed information: "

## Cause

A table in the database has an Attachment field that contains a file or files which have names that are invalid in SharePoint. For instance:

- The file name has two periods (..) in front of the file extension, such as, "James Wittrell, Ph.D..jpg"
- The file name contains any of the following characters: \ / : * ? " < > | # { } % ~ &

## Resolution

1. Open the table in datasheet view in Microsoft Access.
2. Double-click on the Attachment field to open the Attachments window.
3. Select the file that contains the invalid character or characters.
4. Click **Save As...** and save to your desktop.
5. Click **Remove** to remove the file from the Attachments list.
6. Click **Ok** and Save the table.
7. Rename the file you just exported to your desktop so that it no longer contains invalid characters.
8. Add the file back to the record as an Attachment.

## More Information

If you attempt to import a file that contains invalid characters directly to a SharePoint list you receive one of the following errors:

> The file name is invalid or the file is empty. A file name cannot contain any of the following characters:<br/>
> \ / : * ? " < > | # { } % ~ &

-OR-

> The file name contains one or more invalid characters. Make sure the name of the file does not include the following characters:<br/>
> \ / : * ? " < > | # { } % ~ &
