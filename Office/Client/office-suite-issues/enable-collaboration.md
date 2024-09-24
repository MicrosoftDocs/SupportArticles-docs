---
title: Features to enable collaboration and not to increase security
description: Describes features in Office products that enable specific collaboration scenarios and features that are designed to help make your documents and files more secure.
author: helenclu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Sharing\Collab
  - CSSTroubleshoot
  - CI 162681
ms.author: luche
ms.reviewer: ambroset
search.appverid: 
  - MET150
appliesto: 
  - Office 2013
  - Office 2010
  - Office 2007
  - Office 2003
ms.date: 06/06/2024
---

# Description of Office features that are intended to enable collaboration and that aren't intended to increase security

## Summary

Microsoft Office products include features that enable specific collaboration scenarios and features that are designed to help make your documents and files more secure. Features that enable collaboration scenarios function correctly in collaboration environments that don't include users who have malicious intent. 

When you use a feature that is designed to enable a collaboration scenario but isn't designed to help make your document or file more secure, for example you use the Password to Modify feature, the feature is functioning as intended even when a user with malicious intent bypasses the feature. This behavior occurs because the feature was never designed to help protect your document or file from a user with malicious intent.

The **Security** tab of the **Options** dialog box in Office applications contains both types of features. Not all features that are found on the **Security** tab are designed to help make your documents and files more secure. 

The following are examples of Office features that enable specific collaboration scenarios: 

- Password to Modify
When you don't want others to modify the formatting of your Microsoft Word document, Microsoft Excel document, or Microsoft PowerPoint presentation, you may choose to use the Password to Modify feature.

  **Note** When you use the Password to Modify feature, you only set a guideline for others to follow. When you're using the Password to Modify feature, someone else may be able to obtain your password.    
- Hidden Cells and Locked Cells
When you have a cell that you don't want others to see or to modify, you can hide or lock the cell. You can use hidden or locked cells in Excel to present data more clearly. You may choose to hide a cell that contains a formula when you think it will confuse others, or you may choose to lock a cell when you don't want others to modify the cell. 

  **Note** When you hide or lock a cell, you only set a guideline for others to follow. Hidden cells and locked cells aren't designed to allow your files to be more secure. Hidden cells can be unhidden by other users.   

The following are examples of Office features that are designed to help make your documents and files more secure: 

- Password to Open (Using RC4 Level Advanced Encryption)
 
  You can use a strong password with the Password to Open feature in conjunction with RC4 level advanced encryption to require a user to enter a password to open an Office file. 

  **Note** The Password to Open feature uses advanced encryption. Encryption is a standard method of securing the content of a file. There are several encryption methods that are available for use with Word files, Excel files, or PowerPoint presentations. Microsoft Office Outlook 2003 allows for encryption also, but also implements it by using different methods. 

   For more information about strong passwords, see the "Information About Strong Passwords" section of this article.   
- Digitally Signed VBA Macro Projects
You can use digitally signed Microsoft Office Visual Basic for Applications (VBA) macro projects. When you add a digital signature to a VBA macro project, you are supplying a verifiable signature that can vouch for the authenticity and the integrity of the VBA macro project.

  For more information about digitally signed macros, see [Digitally sign your macro project](https://support.microsoft.com/office/digitally-sign-your-macro-project-956e9cc8-bbf6-4365-8bfa-98505ecd1c01).
 
The "More Information" section contains additional information about Office features that are intended to enable specific collaboration scenarios.

## More Information

The following table contains a description of Office features that are intended to enable specific collaboration scenarios but are not intended to help make your documents and files more secure:

| Description of Features That Enable Collaboration|Applies to|
|---|---|
|Password to Modify: Use the **Password to Modify** feature to require other users to enter a password to modify a Microsoft document. To access the Password to Modify feature in Word, click **Options**, and then click the **Security** tab. **Warning** When you are using the Password to Modify feature, a malicious user may still be able to gain access to your password. For example, if you save a word (.doc) file by using the Password to Modify feature enabled in Rich Tech Format (.rtf) a malicious user may be able to gain access to your password.|Excel, Word, PowerPoint|
|Protect Document: Use the **Protect Document** feature when you want to deter users from making unauthorized changes to specific elements of a document. To protect a Word document, click **Tools**, and then click **Protect Document**. **Warning** This method isn't the most effective method to help protect the whole document because Word doesn't use encryption when you protect only select elements. For example, field codes can be viewed in a text editor such as Notepad even if forms or sections of a document are protected.| Word|
|Protect Workbook or Protect and Share Workbook: Use the **Protect Workbook** feature or the **Protect and Share Workbook** feature when you want to deter users from making unauthorized changes to specific elements of a workbook. To protect a document, click **Tools**, and then click **Protection**. Under **Protection**, click either **Protect Workbook** or **Protect and Share Workbook**. **Warning** This method isn't the most effective method to help protect the whole document because Excel doesn't use encryption when you protect only select elements.| Excel|
|Hidden Cells and Locked Cells (used with Protect Sheet feature): Use the hidden cells feature or the locked cells feature in conjunction with the Protect Sheet feature to hide or to lock cells in an Excel worksheet. To use this feature, on a protected worksheet, click **Format**, click **Cells**, click the **Protection** tab, and then click **Locked or Hidden**. **Warning** This method isn't the most effective method to help protect a workbook because Excel doesn't use encryption when you protect only specific elements of a workbook. For example, hidden cells on a protected worksheet can be viewed if a user copies across a range on the protected worksheet that includes the hidden cells, opens a new workbook, pastes, and then uses the **Unhide** command to display the cells.|Excel|
|Protect Form (in Microsoft Word): Use the Protect forms feature to protect a Word form with a password. This feature helps prevent trustworthy users from making changes to a form. To protect a Word form, click **Tools**, click **Protect Document**, click **Forms**, and then enter a password. **Warning** This method isn't the most effective method to help protect the whole document because Word doesn't use encryption when you protect only select elements of a document. When you're using the Protect form feature with a password, a malicious user may still be able to gain access to your password.|Word|
|Protect Form (in Microsoft Outlook): Use the protect forms feature to protect an Outlook form with a password. This feature helps prevent trustworthy users from making changes to a form. To protect an Outlook form, open the form, click
 **Tools**, click **Design This Form**, click **Protect Form Design** on the Properties page, and then enter a password. **Warning** This method is not the most effective method to help protect your form content because Outlook doesn't use encryption when you protect a form. When you're using the Protect Form Design feature with a password, a malicious user may still be able to gain access to your form content.|Outlook|
|Set Database Password: Use this feature to require a password when you are accessing a Microsoft Access database (.mdb) file. To use this feature, open an .mdb file with exclusive access to the file, click **Security**, and then click **Set Database Password**. **Warning** This feature is not intended to hide the contents of an .mdb file. This feature is intended to make sure that the contents of a file are not modified and helps to provide guidelines for users to follow. A malicious user may still be able to access information that is contained in an .mdb file that has been password protected.|Access |
|Embed Links: Use this feature by creating an embedded link in an Office document or an Access database (.mdb) file that links to an external data sources. **Warning** A link to an external data source may leave a password embedded in the Office file.|Access, Excel, Front Page|
|Hidden Text: Use this feature to hide text in a Word document when you do not want others to see or modify the text. To use this feature, with your text selected, click **Format**, click **Font**, and then click **Hidden**. **Warning** Hidden text is not enforceable in Word.|Word|
|E-Mail Flags: Use this feature to add a **Do not Forward** flag to an e-mail message in Outlook. To use this feature, open an e-mail message in Outlook, and then click the **Message Flag** icon. In the **Flag for Follow Up** dialog box, click **Do not Forward**. **Warning** Flags are not enforceable in Outlook, rather they are a suggestion for the recipient. The recipient can ignore a Warning Flag and forward the e-mail.|Outlook|
|Make MDE/ADE File: Use this feature to remove the VBA source code from a Microsoft Access database (.mdb) file or from a Microsoft Access project (.adp) file. To use this feature, in Access open an .mdb or an .adp file, click **Tools**, click **Database Utilities**, and then click **Make MDE File**. **Warning** This feature is not intended to prevent changes to the .mde file or to the .ade file. This feature is intended to protect intellectual property that is contained in VBA source code by allowing files to be distributed that do not contain the VBA source code. A malicious user may still be able to make some design changes to an .mde or an .ade file.|Access|

### Information About Strong Passwords

To reduce the chances of someone guessing your password, use only strong passwords.

For a password to be a strong password, it should meet all the following criteria: 

- Be at least seven characters long. Longer passwords are more secure.   
-  Include both upper and lowercase letters, numbers, and a symbol character between the second and sixth position.   
-  Look similar to random collection of characters.   
-  Have no repeated characters.   
-  Have no characters that are consecutive, for example, 1234, abcd, or qwerty.   
-  Do not use numbers or symbols instead of similar letters--for example, $ for S, or 1 for l.    
-  Do not use any part of your user name for logging on to the Internet or a network.    
-  Not be a common word, a common name, or a word that a person might guess like your own name. When a malicious user tries to bypass a password, they may use a tool that tries a number of common words to try and guess your password.    
Use a strong password that you can remember so that you do not have to write it down. If you must write down a password to remember it, store the password in a secure place.

## References

For more information about features that enable specific collaboration scenarios and features that are designed to help make your documents and files more secure in PowerPoint, see
[How password protection works with PowerPoint Show (*.pps) files](https://support.microsoft.com/help/278578).
