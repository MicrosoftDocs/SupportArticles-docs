---
title: Troubleshoot CyberArk Connection Failures for RDP Automation
description: Troubleshoot CyberArk connection failures for RDP automation in Power Automate. Find solutions to ensure seamless remote desktop connections.
ms.reviewer: iomimtso, iopanag, v-shaywood
ms.custom: sap:Desktop flows\UI or browser automation
ms.date: 11/20/2025
---
# CyberArk connections aren't supported for RDP automation

This article helps you resolve an issue where you can't connect to a machine through CyberArk when using Remote Desktop Protocol (RDP) automation in Power Automate for desktop.

## Symptoms

When you try to connect to a machine through CyberArk by using RDP automation, the connection fails and you receive the following error message:

> A device attached to the system is not functioning.

:::image type="content" source="media/cyberark-connection-not-supported/rdp-connection-failed.png" alt-text="Screenshot showing the error message when attempting to connect through CyberArk.":::

However, when you connect directly to the machine by using RDP without CyberArk, the connection works as expected.

## Cause

CyberArk creates a nested remote connection path. Power Automate for desktop doesn't support nested remote connections.

## Solution

Use a direct RDP connection to the target machine instead of connecting through CyberArk.

[!INCLUDE [Third-party disclaimer](../../../../../includes/third-party-disclaimer.md)]
