---
title: Cannot open EXE files
description: Provides a resolution for the issue that you cannot open exe files.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:setup, csstroubleshoot
ms.technology: windows-server-deployment
---
# Can't open EXE files

This article provides a resolution for the issue that you get errors when opening exe files.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 555067

This article was written by [Yuval Sinay](https://mvp.microsoft.com/en-US/PublicProfile/7674?fullName=Yuval%20Sinay), Microsoft MVP.

## Symptoms

When you try to open EXE files, you may get error messages like: "Access Deny", "Runtime error" and so on.

## Cause

Corrupt registry settings or some third-party product (or virus) can change the default configuration for running EXE files. It may lead to failed operation when you try to run EXE files.

## Resolution

1. Click Start, and then select Run.

2. Type `"command.com"`, and then press Enter. (A DOS window opens.)

3. Type the following command lines:

   ```console
   cd\

   cd \windows
   ```

   Press Enter after typing each one.

4. Type copy "regedit.exe regedit.com" and then press Enter.

5. Type "start regedit.com" and then press Enter.

6. Navigate to and select the key:

   >HKEY_CLASSES_ROOT\exefile\shell\open\command

7. In the right pane, double-click the (Default) value.

8. Delete the current value data, and then type:

    "%1" %*

   Tip: Type the characters: quote-percent-one-quote-space-percent-asterisk.

9. Close Regedit utility.

   > [!Note]
   > If you are using Windows XP and you enable "System Restore" , you need to disable "System Restore" in "Safe Mode" before using the instructions above.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).

[!INCLUDE [Community Solutions Content Disclaimer](../../includes/community-solutions-content-disclaimer.md)]