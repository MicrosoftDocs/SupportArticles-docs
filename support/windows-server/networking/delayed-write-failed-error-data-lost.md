---
title: Delayed Write Failed error
description: Helps to fix the error message "Delayed Write Failed" which states that your data has been lost.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
---
# If you receive a "Delayed Write Failed" error message, it states that your data has been lost

This article helps to fix the error message "Delayed Write Failed" which states that your data has been lost.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2021074

## Symptoms

When writing to a network share, a failure may cause the following event to be written to the event log:  
>Event ID: 50 {Delayed Write Failed} Windows was unable to save all the data for the file \<file>. The data has been lost. This error may be caused by a failure of your computer hardware or network connection. Please try to save this file elsewhere.  

## Cause

This error can occur if there are pending cached writes to a file located on a remote network share and the connection to that file is unexpectedly terminated.  The connection to the file could have been terminated for various reasons, including network communication failures and filter drivers on either the client or the server canceling the write I/O.  When this error occurs, the pending cached write I/O in memory cannot be written to the target file on the remote network share.  The delayed write fails and the target file may now be corrupt.  

## More information

It is the responsibility of the application to handle this error.  Some applications may try to reconnect to the remote file and retry the write operation.  Other applications may ignore the error or fail altogether and leave the target file corrupted. Some applications like Windows Explorer may report the error to the user if a file copy fails.  In the scenario of a failed file copy, the source file remains unchanged and copy operation can be restarted, overwriting the corrupted targeted remote file.  
For more information, see the following link:  
[https://support.microsoft.com/kb/816004](https://support.microsoft.com/kb/816004)
