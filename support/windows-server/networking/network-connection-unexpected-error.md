---
title: An Unexpected Error Occurred When You Open the Properties of a Network Connection
description: Provides a workaround to an issue in which an unexpected error occurred when you open the properties of a network connection.
ms.date: 07/25/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-lianna
ms.custom:
- sap:network connectivity and file sharing\tcp/ip connectivity (tcp protocol,nla,winhttp)
- pcy:WinComm Networking
---
# Error message when you open the properties of a network connection: "An unexpected error occurred"

## Symptoms

When you open the properties of a network connection in the **Network Connections** folder, you may receive the following error message:

> An unexpected error occurred.

## Cause

This problem may occur if some registry settings are damaged. The damaged registry settings may prevent you from viewing the properties of the network connection in the Network Connections folder.

## Workaround

To work around this problem, reregister the **Netshell.dll** file. To do so, follow these steps:

1. Select **Start** > **Run**.
2. In the **Open** box, type **regsvr32 %systemroot%\system32\netshell.dll**, and then select **OK**.
3. In the **RegSvr32** dialog box, select **OK**.

Test to see if you can open the properties of the network connection in the **Network Connections** folder.

If the issue is resolved, you don't have to follow the remaining steps in this article. If the issue persists, and you receive the error message that is mentioned in the "Symptoms" section of this article, follow these steps:

1. Select **Start** > **Run**.
2. In the **Open** box, type **regsvr32 %systemroot%\system32\ole32.dll**, and then select **OK**.
3. In the **RegSvr32** dialog box, select **OK**.
4. Restart the computer.
