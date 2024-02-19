---
title: Windows SMB server is unresponsive
description: Provides recommendations from Escalation Engineering about what to do when a Windows SMB server is unresponsive
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, tatec, amanjain
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# Windows SMB server is unresponsive

This article explains why a Windows Server Message Block (SMB) server becomes unresponsive and how to troubleshoot the problem.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 3061415

## Symptoms

When \\\\**servername**\\share does not work, what do you do next?

## Cause

Incoming SMB traffic is handled in the kernel through the Srv2.sys driver (smb2) and the Srv.sys driver (smb1). For an unresponsive file server, which may be pingable but unresponsive at the SMB level, the underlying cause is often that these two drivers are blocked either temporarily or permanently. The data required to examine these kernel threads is most easily obtained by forcing a kernel memory dump (crash or Stop error) of the server.

Because obtaining a memory dump of the box is an extreme troubleshooting step, you must make sure that you've completed all other appropriate troubleshooting steps first. The following flow chart explains what you must do before dumping the box.

:::image type="content" source="media/smb-server-unresponsive/troubleshooting-before-dumping-flow-chart.png" alt-text="Screenshot of a flow chart which explains what you must do before dumping the box.":::

## Resolution

By examining the memory dump file through the Debugging Tools for Windows (WinDbg), you should be able to determine whether there are blocked kernel threads (srv.sys and or srv2.sys), and the debug team at Microsoft will help investigate that. This article will be updated when a resolution is available.

## More information

For detailed information about how to dump a kernel, see [How to generate a kernel or a complete memory dump file in Windows Server 2008 and Windows Server 2008 R2](https://support.microsoft.com/help/969028).
