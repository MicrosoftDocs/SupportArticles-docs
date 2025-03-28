---
title: Collecting debug logs from agent for Virtual desktops
description: Guide on how to collect debug logs from remote agent to further investigate issues.
ms.reviewer: amitrou
ms.author: iopanag
author: iopanag
ms.custom: sap:Desktop flows\UI or browser automation
ms.date: 03/28/2025
---

# Collecting debug logs from agent for Virtual desktops

This article will help you collect debug logs from remote Agent for Virtual Desktops. Most of the times this is not needed. However, when you have exhausted all troubleshooting methods for an RDP/Citrix issue, collecting debug logs from the remote machine might help with investigation.

## How to enable

1. Login on the remote machine that is affected and set an environment variable either machine-wide or to specific affected user.

    - Name: **PAD_DEBUG_RDP**
    - Value: **true**

> [!NOTE]
> You might need administrator rights on the remote machine to change environment variables.

2. Log out of the remote affected session and log back in for the variable to take effect.
3. Run the agent and try to perform the usual automation the user is trying to do.
4. Afterwards check on the remote session Desktop folder for a folder named **PAD_RDP_DEBUG**
5. Copy this folder to the desired machine.
6. Check the logs for information you might not want to share.
7. Remove the **PAD_DEBUG_RDP** environment variable from the remote machine to avoid to disable writing logs.

## More information

[Automate on virtual desktops](/power-automate/desktop-flows/virtual-desktops)