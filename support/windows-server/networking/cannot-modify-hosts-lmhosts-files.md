---
title: Can't modify the Hosts or Lmhosts file
description: This article describes how to modify the Hosts file or the Lmhosts file in Windows 7.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dns, csstroubleshoot
---
# You can't modify the Hosts file or the Lmhosts file in Windows 7

This article provides a workaround for a problem where you fail to modify the Hosts file or the Lmhosts file in Windows 7.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 923947

## Symptoms

When you try to change the Hosts file or the Lmhosts file in Windows 7 with Service Pack 1, you may receive an error message that resembles either of the following.

- Error message 1

    > Access to C:\Windows\System32\drivers\etc\ hosts was denied

- Error message 2

    > Cannot create the C:\Windows\System32\drivers\etc\hosts file.  
    > Make sure that the path and file name are correct.

This issue occurs even though you log on by using an account that has administrative credentials.

## Workaround

1. Click **Start**, click **All Programs**, click **Accessories**, right-click **Notepad**, and then click **Run as administrator**.

    If you're prompted for an administrator password or for a confirmation, type the password, or click **Allow** or **Yes**.

2. Open the Hosts file or the Lmhosts file, make the necessary changes, and then click **Save** on the **File** menu.
