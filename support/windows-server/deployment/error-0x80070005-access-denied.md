---
title: 'Error 0x80070005 "Access denied" when you activate Windows Server 2012 R2'
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
keywords: Windows Server 2012 R2, Activation, 0x80070005, access denied
---

# Error 0x80070005 "Access denied" when you activate Windows Server 2012 R2

This article describes how to fix Windows activation error 0x80070005 (access denied).

_Applies to:_ &nbsp; Windows Server 2012 R2

## Symptoms

You run the `slmgr /ato` command to activate a domain-joined computer that's running Windows Server 2012 R2. However, Windows does not activate and you see the following message:

> Windows Script Host Activating Windows(R), ServerDatacenter edition (00091344-1ea4-4f37-b789-01750ba6988c) ... Error: 0x80070005 Access denied: the requested action requires elevated privileges

Additionally, you see the following event in the Application event log:

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

## Solution

To restore the permissions of the SELF account, follow these steps:

1. In the **Search** box, type **dcomcnfg**, and then select Component Services.
1. In the left pane of the Component Services tool, select **Component Services** > **Computers**, right-click **My Computer**, and then select **Properties**.
1. Select **COM Security**, and then under **Access Permissions** select **Edit Default**.
1. If **SELF** does not appear in the **Group or user names list**, select **Add**. In **Enter the object names to select**, type **SELF**, select **Check Names**, and then select **OK**.
1. In the **Access Permission** dialog box, select **SELF**, and then in the **Allow** column, select the following check boxes:

   - **Local Access**  
   - **Remote Access**  
   :::image:::
1. Select **OK** to close **Access Permission**, and then select **OK** to close **My Computer properties**.
1. Restart the computer.
