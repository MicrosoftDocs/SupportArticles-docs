---
title: Error 80004005 when using ADO or ODBC to connect an Access database
description: You receive 80004005 when using ActiveX Data Objects (ADO) or ODBC to connect to an Access database.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Microsoft Access
ms.date: 03/31/2022
---

# PRB: Error 80004005 "The Microsoft Jet Database Engine cannot open the file '(unknown)'"

## Symptoms

When you use ActiveX Data Objects (ADO) or ODBC to connect to a Microsoft Access database, you may receive the following error message:

```asciidoc
Microsoft OLE DB Provider for ODBC Drivers error '80004005'
[Microsoft][ODBC Microsoft Access 97 Driver] The Microsoft Jet database engine cannot open the file '(unknown)'. It is already opened exclusively by another user, or you need permission to view its data.
```

## Cause

There are several causes for this error message:

- The account that Microsoft Internet Information Server (IIS) is using (which is usually IUSR) does not have the correct Windows NT permissions for a file-based database or for the folder that contains the file.
- The file and the data source name are marked as Exclusive.
- Another process or user has the Access database open.
- The error may be caused by a delegation issue. Check the authentication method (Basic versus NTLM), if any. If the connection string uses the Universal Naming Convention (UNC), try to use Basic authentication, or an absolute path, such as C:\Mydata\Data.mdb. This problem can occur even if the UNC points to a resource that is local to the IIS computer.
- This error may also occur when you access a local Microsoft Access database that is linked to a table where the table is in an Access database on a network server.

## Resolution

The following items correspond to the previous list of causes:

- Check the permissions on the file and the folder. Make sure that you have the ability to create and/or destroy any temporary files. Temporary files are usually created in the same folder as the database, but the file may also be created in other folders such as the WINNT folder.

  If you use a network path to the database (UNC or mapped drive), check the permissions on the share, the file, and the folder.

- Verify that the file and the data source name (DSN) are not marked as Exclusive.
- The "other user" may be Microsoft Visual InterDev. Close any Visual InterDev projects that contain a data connection to the database.
- Simplify. Use a System DSN that uses a local drive letter. If necessary, move the database to the local drive to test.

## References

To check for file access failures, use the Windows NT File Monitor. To download the File Monitor, see [Windows Sysinternals](/sysinternals/).
