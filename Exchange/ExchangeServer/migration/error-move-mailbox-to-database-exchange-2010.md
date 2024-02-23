---
title: Could not find part of the path error when you move a mailbox to a database in Exchange Server 2010
description: Resolves an issue in which you can't move a mailbox between mailbox databases in Exchange Server 2010. Additionally, you receive a Could not find a part of the path error message.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: v-9prpra, charray, v-six
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Error when you move a mailbox to a database in Exchange Server 2010: Could not find part of the path D:\Temp

_Original KB number:_ &nbsp;2834158

## Symptoms

When you try to move a mailbox between mailbox databases in Microsoft Exchange Server 2010, you receive a message like this one:

> Error: "Could not find part of the path D:\Temp"  
> Warning:  
> An unexpected error has occurred and a Watson dump is being generated: Could not find a part of the path 'D:\TEMP\<filename>.tmp'.

## Cause

This issue occurs because the path value of TEMP and TMP environment variables that are used by the Microsoft Exchange Information Store service to move the database is invalid.

> [!NOTE]
> The Microsoft Exchange Information Store service uses the TEMP and TMP folders as temporary storage for various operations, such as message conversion and mailbox move operations.

## Resolution

To resolve this issue, set the correct path for TEMP and TMP environment variables. The default path for TEMP and TMP environment variables is *%Userprofile%\Temp*.

For more information about how to the set correct path for TEMP and TMP environment variables, go to the following Microsoft TechNet website: [How to Move the TEMP and TMP Directories](/previous-versions/tn-archive/aa998945(v=exchg.65))