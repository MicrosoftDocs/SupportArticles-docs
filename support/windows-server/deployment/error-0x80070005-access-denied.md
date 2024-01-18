---
title: 'Error 0x80070005 (Access denied) when you activate Windows'
description: Describes how to fix Windows activation error 0x80070005 (access denied).
ms.date: 12/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.custom: sap:activation, csstroubleshoot
ms.technology: windows-server-deployment
keywords: Windows, Activation, 0x80070005, access denied
---

# Error 0x80070005 "Access denied" when you activate Windows

This article discusses how to fix Windows activation error 0x80070005 (access denied).

_Applies to:_ &nbsp; Windows Server, all versions, and Windows client, all versions

## Symptoms

You run the `slmgr /ato` command to activate a domain-joined computer that's running Windows. However, Windows doesn't activate, and you receive the following error message:

> Windows Script Host Activating Windows(R), ServerDatacenter edition (00091344-1ea4-4f37-b789-01750ba6988c) ... Error: 0x80070005 Access denied: the requested action requires elevated privileges

Additionally, the following event is logged in the Application log:

```output
Log Name:      Application
Source:        Microsoft-Windows-Security-SPP
Date:         
Event ID:      8229
Task Category: None
Level:         Warning
Keywords:      Classic
User:          N/A
Computer:     
Description:
The rules engine failed to perform one or more scheduled actions.
Error Code:0x80070005
Path:C:\Windows\System32\SLUI.exe
```

## Cause

The SELF account doesn't have the correct DCOM permissions.

## Solution: Restore SELF account permissions

To restore the permissions of the SELF account, follow these steps:

1. In the **Search** box, type *dcomcnfg*, and then select **Component Services** (depending on your version of Windows, you might have to select **dcomcnfg Run command** instead).
1. In the left pane of the **Component Services** snap-in, select **Component Services** > **Computers**, right-click **My Computer**, and then select **Properties**.
1. In the **My Computer Properties** dialog box, select the **COM Security** tab, and then select **Edit Default** in the **Access Permissions** area.
1. In the **Access Permission** dialog box, if **SELF** doesn't appear in the **Group or user names** area, select **Add**. In the **Enter the object names to select** text box, type *SELF*, select **Check Names**, and then select **OK**.
1. In the **Group or user names** area, select **SELF**, and then select the following checkboxes in the **Allow** column:
   - **Local Access**  
   - **Remote Access**  

   :::image type="content" source="media/error-0x80070005-access-denied/dcom-access-permissions-for-activation.png" alt-text="Screenshot of the Access Permission dialog box and its parent My Computer Properties dialog box.":::
1. Select **OK** to close **Access Permission**, and then select **OK** to close **My Computer Properties**.
1. Restart the computer.
