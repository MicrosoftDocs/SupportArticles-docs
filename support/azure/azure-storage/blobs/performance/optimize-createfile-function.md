---
title: Best practice to optimize CreateFile() function performance in Azure
description: Introduce a best practice to optimize the performance of the CreateFile() function in Azure.
author: genlin
ms.author: genli
ms.service: azure-file-storage
ms.date: 08/14/2020
ms.reviewer: 
ms.custom: sap:Performance and Throughput
---
# Best practice to optimize CreateFile() function performance in Azure

This article introduces a best practice to optimize performance when you call the [CreateFile()](/windows/win32/api/fileapi/nf-fileapi-createfilea?redirectedfrom=MSDN) function for a file on Microsoft Azure Server.

_Original product version:_ &nbsp; Files Storage  
_Original KB number:_ &nbsp; 4021343

When you call the [CreateFile()](/windows/win32/api/fileapi/nf-fileapi-createfilea?redirectedfrom=MSDN) function to create or open a file on Azure Server, you should use both Read and Write access permissions. That is, specify **GENERIC_READ | GENERIC_WRITE** instead of only **GENERIC_WRITE** for the **dwDesiredAccess** parameter.

This is because a Write-Only handle cannot cache small writes locally, even if it is the only opened handle for the file. Using a Write-Only handle imposes a severe performance penalty.

> [!NOTE]
> Calling the **fopen()** function in "a" mode also opens a W rite-Only handle.

## More information

- [Generic Access Rights](/windows/win32/secauthz/generic-access-rights?redirectedfrom=MSDN)
- [File Security and Access Rights](/windows/win32/fileio/file-security-and-access-rights?redirectedfrom=MSDN)
- [File Access Rights Constants](/windows/win32/fileio/file-access-rights-constants?redirectedfrom=MSDN)
- [ACCESS_MASK](/windows/win32/secauthz/access-mask?redirectedfrom=MSDN)

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
