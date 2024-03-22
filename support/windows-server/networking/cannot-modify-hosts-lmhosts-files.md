---
title: Can't modify the Hosts or Lmhosts file
description: This article provides a workaround for a problem that prevents you from modifying the Hosts file or the Lmhosts file.
ms.date: 03/08/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dns, csstroubleshoot
---
# You can't modify the Hosts file or the Lmhosts file

This article provides a workaround for a problem in which you can't modify the Hosts file or the Lmhosts file.

_Applies to:_ &nbsp; Windows, all versions, and Windows Server, all versions  
_Original KB number:_ &nbsp; 923947

## Symptoms

When you try to change the Hosts file or the Lmhosts file, Windows might deny you access to the file and then generate an error message that resembles either of the following messages.

- Error message 1

    > Access to C:\Windows\System32\drivers\etc\ hosts was denied

- Error message 2

    > Cannot create the C:\Windows\System32\drivers\etc\hosts file.  
    > Make sure that the path and file name are correct.

This problem occurs even though you sign in by using an account that has administrative credentials.

## Workaround

1. Select **Start** > **All Programs** > **Accessories**, right-click **Notepad**, and then select **Run as administrator**.

    If you're prompted for an administrator password or for a confirmation, type the password, or select **Allow** or **Yes**.

2. Open the Hosts file or the Lmhosts file, make the necessary changes, and then select **Save** on the **File** menu.
