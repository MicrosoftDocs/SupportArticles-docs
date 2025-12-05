---
title: Troubleshoot CyberArk Connection Failures for RDP Automation
description: Troubleshoot CyberArk connection failures for RDP automation in Power Automate. Find solutions to ensure seamless remote desktop connections.
ms.reviewer: iomimtso, iopanag, v-shaywood
ms.custom: sap:Desktop flows\UI or browser automation
ms.date: 11/20/2025
---
# CyberArk connections aren't supported for RDP automation

This article helps you resolve an issue in which you can't connect to a computer through CyberArk when you use Remote Desktop Protocol (RDP) automation in Microsoft Power Automate for desktop.

## Symptoms

When you try to connect to a computer through CyberArk by using RDP automation, the Power Automate agent for virtual desktops doesn't establish communication with Power Automate for desktop, and you receive the following error message:

> A device attached to the system is not functioning.

:::image type="content" source="media/cyberark-connection-not-supported/rdp-connection-failed.png" alt-text="The error message that you receive when you try to connect through CyberArk.":::

However, when you connect directly to the computer by using RDP without CyberArk, the connection works as expected, and Power Automate for desktop successfully communicates with the agent.

## Cause

CyberArk creates a nested remote connection path. This condition interferes with the agent-to-desktop communication that's required for UI and browser automation. Power Automate for desktop doesn't support nested remote connections.

## Solution

To resolve this issue:

- Use a direct RDP connection to the target computer instead of connecting through CyberArk.
- Make sure that the Power Automate agent for virtual desktops is running and correctly registered on the computer.

[!INCLUDE [Third-party disclaimer](../../../../../includes/third-party-disclaimer.md)]
