---
title: Back up a Visual SourceSafe database
description: This article describes how to back up a Visual SourceSafe database.
ms.date: 10/26/2020
ms.prod-support-area-path: 
ms.topic: how-to
---
# Back up a Visual SourceSafe database

This article describes how to back up a Visual SourceSafe database.

_Original product version:_ &nbsp; Visual SourceSafe  
_Original KB number:_ &nbsp; 244016

## Summary

This article describes how to back up a Visual SourceSafe database.

## More information

1. Make sure that no one is using the database and that Analyze will not begin to run while you are backing up the database.
2. Copy the following folders:

    - *\DATA*
    - *\Temp
    - *\USERS**

3. Copy the *User.txt* and *Srcsafe.ini* files.

When you follow this procedure, you can do a full restore of the database by replacing the existing Users, Temp, and Data folders as well as the *Users.txt* and *Srcsafe.ini* files with the copied versions.

You can also use this procedure to move the database to another location by placing the copied files into a new folder. To open the database, on the **File** menu in the Visual SourceSafe Explorer, click **Open SourceSafe Database** to browse to the new location.
