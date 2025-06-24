---
title: Office documents opened via a hyperlink from SharePoint document libraries may be missing the Server Message Bar with buttons needed to check out and/or edit files or open/edit workflow tasks
description: Describes an issue where Server Message bar is missing for Office documents opened via a hyperlink. Provides a solution.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Administration\Files and Documents
  - CSSTroubleshoot
appliesto: 
  - SharePoint Foundation 2010
  - SharePoint Server 2010
  - Office Professional 2010
  - Office Professional Plus 2010
  - Office Standard 2010
ms.date: 12/17/2023
---

# Server Message bar is missing for Office documents opened via a hyperlink

## Symptoms  

Users of Office 2007 or Office 2010 on any client Operating System click a hyperlink that points to an Office document, which is located in a SharePoint Server 2010 document library. The hyperlink itself is located in an Outlook email message. Instead of opening the document from the server in the Office client application, the document opens in the Office application from the Temporary Internet Files cache of the local machine. Therefore it is not treated as a server document. The following symptoms are seen by the user:  

- Word: There is no server bar with an "Edit Document" button    
- Excel: There is no server bar with an "Edit Workbook" button   
- PowerPoint: There is no server bar with an "Edit Presentation" button      

Or, if the document library requires a checkout:   

- Word: there is no server bar with a "Check out Document" button   
- Excel: There is no server bar with a "Check out Workbook" button   
- PowerPoint: There is no server bar with a "Check out Presentation" button

Additionally, the document cannot be saved back to the SharePoint site while it is open in the Office application. Users may be able to save changes, but the changes are being saved to the file in the Temporary Internet Files folder, not back to the SharePoint server.   

Also, if the document is part of a workflow, the Edit this Task  or Open this Task  button and any other buttons associated with the workflow will be missing, causing the workflow not to be started. Typically users will receive workflow tasks in email and the email will contain a hyperlink to the document located on the SharePoint server.   

This only occurs with the newer Office file formats: .docx, .pptx and .xlsx. It does not occur with the older, legacy Office file formats: .doc, .ppt and .xls. In addition, this only occurs when:  

The server is a SharePoint server 2010 and  

- When the client computer is running Office 2007, the problem occurs with .docx, .dotx, .xlsx and .pptx documents  
or   
- When the client computer is running Office 2010, the problem occurs with .pptx documents.     

This issue does not occur when the server is running Office SharePoint Server 2007 and the client computer is running Office 2007 or Office 2010.   

NOTE: This only happens when opening the Office document BY CLICKING ON A HYPERLINK in an Outlook email message and the Office document is located in a SharePoint 2010 document library. If the user browses to the SharePoint 2010 document library and opens the file from there, this issue does not occur.   

## Cause  

SharePoint 2010 implements a new security feature called 'Permissive or Strict browser file handling'. Each type of file delivered from a web server has an associated MIME type (also called a "content-type") that describes the nature of the content (for example, image, text, application, etc.). Internet Explorer (IE) has a MIME-sniffing feature that will attempt to determine the content-type for each downloaded resource. For Office files, if the Content-Type sent by the server is not found in the MIME database in the registry of the client machine, IE "sniffs" the MIME content types to see if there is another similar MIME type in the client machine's MIME database and will open the file using the similar MIME type. However, Strict browser file handling is enabled on each web application in SharePoint 2010 by default and this disallows the sniffing of Content-Types, so if no exact match of the Content-Type sent in the server response is found in the client's MIME database in the registry, the file will open from the Temporary Internet Files of the client machine instead of being opened from the server. MIME-sniffing also can lead to security problems for servers hosting untrusted content.

For example: When opening a .docx file from a hyperlink that points to a document located in a SharePoint 2010 document library, the Content Type sent by the SharePoint 2010 server in the response is "vnd.ms-word.document.12" along with a header "X-Content-Type-Options: nosniff" which looks like this:   

```
HTTP/1.1 200 OK   
Content-Length: 108   
Date: Day, [Date and Time] GMT   
Content-Type: vnd.ms-word.document.12   
X-Content-Type-Options: nosniff   
```

Since this exact content type is not present in the MIME area of the registry of the Office client computer and no MIME sniffing will be done, the document opens from the Temporary Internet files.   

There may be other causes mentioned below in the More Information section.  

## Resolution  

Use one of the following solutions:  

### Server-side Workaround   

Eliminate the no-sniff header sent from SharePoint 2010  

- Browse to the Central Administration site, click Manage Web Applications  under Application Management.    
- Select the web application  and click onGeneral Settings  from the ribbon   
- Scroll down to Browser File Handling, and choose Permissive  instead of Strict.  

NOTE: This reduces security. Browser File Handling  specifies whether additional security headers are added to documents served to web browsers. These headers specify that a browser should show a download prompt for certain types of files (for example, .html) and to use the server's specified MIME type for other types of files. "Permissive" specifies no headers are added, which provides a more compatible user experience. "Strict" adds headers that force the browser to download certain types of files. The forced download improves security for the server by disallowing the automatic execution of Web content that contributors upload.  

### Client-side Workarounds

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:   

[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows.  

Update the registry of the Office client computer to install the needed content types into the MIME database of the registry by using one of the following two methods. This registry update works on either Office 2007 or Office 2010.  

1. To update the registry manually, copy the following to a text file, name it with a .reg  extension and run it.

   ```
   Windows Registry Editor Version 5.00  
   [HKEY_CLASSES_ROOT\MIME\Database\Content Type\application/vnd.ms-excel.12]  
   "Extension"=".xlsx"  
   [HKEY_CLASSES_ROOT\MIME\Database\Content Type\application/vnd.ms-powerpoint.presentation.12]  
   "Extension"=".pptx"  
   [HKEY_CLASSES_ROOT\MIME\Database\Content Type\application/vnd.ms-word.document.12]  
   "Extension"=".docx"  
   [HKEY_CLASSES_ROOT\MIME\Database\Content Type\application/vnd.ms-word.template.12]  
   "Extension"=".dotx"  
   [HKEY_CLASSES_ROOT\MIME\Database\Content Type\application/vnd.ms-powerpoint.template.12]  
   "Extension"=".potx"  
   [HKEY_CLASSES_ROOT\MIME\Database\Content Type\application/vnd.ms-powerpoint.show.macroEnabled.12]  
   "Extension"=".ppsm"  
   [HKEY_CLASSES_ROOT\MIME\Database\Content Type\application/vnd.ms-powerpoint.show.12]  
   "Extension"=".ppsx"  
   [HKEY_CLASSES_ROOT\MIME\Database\Content Type\application/vnd.ms-powerpoint.macroEnabled.12]  
   "Extension"=".pptm"  
   [HKEY_CLASSES_ROOT\MIME\Database\Content Type\application/x-mspublisher]  
   "Extension"=".pub"  
   [HKEY_CLASSES_ROOT\MIME\Database\Content Type\application/vnd.ms-excel.binary.12]  
   "Extension"=".xlsb"  
   [HKEY_CLASSES_ROOT\MIME\Database\Content Type\application/vnd.ms-excel.macroEnabled.12]  
   "Extension"=".xlsm"  
   [HKEY_CLASSES_ROOT\MIME\Database\Content Type\application/vnd.ms-excel.macroEnabledTemplate.12]  
   "Extension"=".xltm"  
   [HKEY_CLASSES_ROOT\MIME\Database\Content Type\application/vnd.ms-excel.template.12]  
   "Extension"=".xltx"  
   [HKEY_CLASSES_ROOT\MIME\Database\Content Type\application/vnd.ms-word.document.macroEnabled.12]  
   "Extension"=".docm"  
   [HKEY_CLASSES_ROOT\MIME\Database\Content Type\application/vnd.ms-word.template.macroEnabled.12]  
   "Extension"=".dotm"  
   [HKEY_CLASSES_ROOT\MIME\Database\Content Type\application/vnd.ms-powerpoint.template.macroEnabled.12]  
   "Extension"=".potm"  
   [HKEY_CLASSES_ROOT\MIME\Database\Content Type\application/vnd.ms-powerpoint.presentation.macroEnabled.12]  
   "Extension"=".pptm"  
   [HKEY_CLASSES_ROOT\MIME\Database\Content Type\application/vnd.ms-excel.sheet.macroEnabled.12]  
   "Extension"=".xlsm"  
   [HKEY_CLASSES_ROOT\MIME\Database\Content Type\application/vnd.ms-excel.addin.12]  
   "Extension"=".xlam"  
   [HKEY_CLASSES_ROOT\MIME\Database\Content Type\application/onenote]  
   "Extension"=".one"  
   ```  

2. To install the content types into the registry's MIME database on Office computers automatically, go to the "Here's an easy fix" section.   

## More Information  

SharePoint workflow task buttons may be missing in Office documents for other reasons than those described in this article. Some other reasons may be:  

- Message Bar is disabled in Trust Center Settings.   
- You are using a low-value license of Office (Home and Business, Home and Student) or other product from retail channel. See [All about Approval workflows](https://office.microsoft.com/powerpoint-help/manage-the-document-approval-process-using-a-workflow-ha010220203.aspx).   
- Workflow for the document you have open has not been started yet.   
- User does not have Edit Items  permissions. They may also need Manage Lists  permissions depending on the workflow settings.    
- The Server read-only bar with the [Edit Document ] or [Edit Workbook ] or [Edit Presentation ] button bar may be missing for other reasons when clicking on a hyperlink to an Office 2010 document stored on a SharePoint site for the first time. Subsequent clicks on the link will render the Server read-only bar.     

   :::image type="content" source="media/message-bar-is-missing-when-open-office-documents-via-link-from-library/read-only.png" alt-text="Screenshot of the Server read-only bar under the ribbon of Word 2010.":::  

To force the Server read-only bar to show on first click of the hyperlink, add the below registry key to the client machine.   

```
Key: HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Internet   
Name: OptimisticBHO   
Type: DWORD   
Value: 1  
```

If the Server bar still does not appear with the [Edit Document] button even after the OptimisticBHO key is enabled, make sure that the "Office Document Cache Handler" Add-on is Enabled in Internet Explorer's Tools>Manage Add-ons.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
