---
title: Performance issues when using custom default user profile in Windows 10, Windows Server 2016, or Windows Server 2019
description: Address a performance issue with customize default user profile. Event log ID 454 is received when the issue occurs.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:slow-performance, csstroubleshoot
---
# Performance is poor when using custom default user profile in Windows

This article provides a solution to issues that occur when you use customize default user profiles.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2019, Windows Server 2016  
_Original KB number:_ &nbsp; 4056823

## Symptom

Consider the following scenario:

- You create a new default user profile and enable it.
- A new user logs on by using a profile that is created from the default profile on a Windows 10, Windows Server 2016, or Windows Server 2019-based computer.

In this scenario, you encounter one or more of the following issues:

- Desktop icons take a long time to appear.
- Performance is poor when you start or browse in Internet Explorer or Microsoft Edge.
- ESENT errors like the following are recorded in the Event Log:

    > EventLogID: 454  
    TaskHostW: (pid)  
    WebCacheLocal: "Database recovery/restore failed with unexpected error -1907"

    > [!NOTE]
    > The full event log message may also indicate an association with a different user folder location, such as C:\\Users\\Administrator.

## Cause

These issues occur because the default user profile includes a locked copy of another user's cache database.

When a new user logs on to the computer, the default user profile content is incorporated into their new profile. As the Windows shell and desktop begin to load, the database can't be fully initialized for use. Applications that use the database experience negative performance or report errors.

## Resolution

To fix the issue, following these steps:

1. Log on to each affected computer by using an account that has administrative credentials, and then delete the following hidden file and folder if they exist:

    File: C:\\Users\\Default\\AppData\\Local\\Microsoft\\Windows\\WebCacheLock.dat  
    Folder: C:\\Users\\Default\\AppData\\Local\\Microsoft\\Windows\\WebCache

2. For each user account on the computer, make sure that the user is logged off completely and the profile has unloaded fully, and then delete the following hidden file and folder if they exist:

    File: C:\\Users\\\<affectedUserFolder>\\AppData\\Local\\Microsoft\\Windows\\WebCacheLock.dat  
    Folder: C:\\Users\\\<affectedUserFolder>\\AppData\\Local\\Microsoft\\Windows\\WebCache

> [!NOTE]
> \<affectedUserFolder> is a placeholder for the user profile folder name. For example, for the Administrator user account, the folder is under C:\\Users\\Administrator. You must remove the above files and folders for each affected user account on the computer.

### How to view hidden files

To view hidden files, follow these steps:

1. In Windows Explorer, select **File**, and then select **Options**.
2. On the **View** tab, select the **Show hidden files, folders, and drives** option.
3. Unselect the **Hide protected operating system files (Recommended)** option, and then click **OK**.

> [!NOTE]
> We recommend that you re-select the two options after the issue is fixed.

## More information

Because the cache database is designed to be generated per-user at the time of initial log on to an individual computer, Microsoft does not recommend or support the inclusion of the cache database in the default or any other user profile that is intended to be used as a template.
