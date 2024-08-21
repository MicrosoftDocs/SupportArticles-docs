---
title: Saving documents to network server is slow
description: Describes an issue in which saving documents to a remote server takes longer than expected when you are using EFS.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Save
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - office 2016
  - Office 2013
  - Office 2010
ms.date: 06/06/2024
---

# Saving Office documents to a network server is slow when using EFS

## Symptoms

Assume that you use the Encrypting File System (EFS) to help secure the Temporary Internet Files folder. You save Microsoft Office documents to a remote server than can support encryption, but the server is not configured to do remote encryption. In this situation, it takes longer than expected to save the documents. 

## Cause

When you save documents, the Office applications (Excel, Word, and PowerPoint) create a temporary file in secure subfolders named "Content.MSO" and "Content.Word" in the Temporary Internet Files folder. If the subfolder is encrypted by using EFS, the file that is then copied to the server will have the encrypted attribute applied to it also. If the server supports encryption but is not configured to do it, multiple attempts to keep the file encrypted occur, and this slows the save process.  

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To work around this issue, use one of the following methods:

- Remove the encryption from the "Content.MSO" and "Content.Word" subfolders in the Temporary Internet Files folder.   
- Disable EFS encryption support on the server by changing the following registry entry:

  - PATH: HKLM\SYSTEM\CurrentControlSet\Control\FileSystemValue
  - DWORD: NtfsDisableEncryption
  - VALUE: 1

  **Note** A value of 0 means encryption is enabled, while a value of 1 means encryption is disabled.   
- Enable delegated authentication for the server. This allows the server to impersonate the client, and to then create a profile that has the certificate for encryption on the server. For information about how to do this, see[Enabling delegated authentication](https://technet.microsoft.com/library/cc780217%28v=ws.10%29.aspx). 
- Save the file locally, then drag the file to the desired network location.   

## More Information

By default, the "Content.MSO" and "Content.Word" subfolders are used by Excel, Word, and PowerPoint. They are hidden, system-protected subfolders of the Temporary Internet Files folder, as seen in the following example path:

C:\User\\\<**user name**>\AppData\Local\Microsoft\Windows\Temporary Internet Files\Content.MSO

In Windows 8, the Temporary Internet Files folder is now known as the "INetCache" folder. Therefore, the path to the "Content.MSO" subfolder would be as follows:

C:\Users\\\<**user name**>\AppData\Local\Microsoft\Windows\INetCache\Content.MSO
