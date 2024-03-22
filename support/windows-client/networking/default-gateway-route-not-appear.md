---
title: Default gateway route doesn't appear in Routing Table
description: Provides a solution to an issue where default gateway route doesn't appear in the Routing Table.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-access, csstroubleshoot
---
# Default gateway route doesn't appear in the Routing Table after you re-add a Routing and Remote Access interface

This article provides a solution to an issue where default gateway route doesn't appear in the Routing Table.

_Applies to:_ &nbsp; Windows Server - all editions  
_Original KB number:_ &nbsp; 816905

## Symptoms

When you add a network interface to a remote access server in the Routing and Remote Access utility, a default route for that interface may not appear in the routing table.

## Cause

This issue may occur if both of the following conditions are true:

- You remove a network interface from the remote access server.
- You re-add that network interface to the remote access server.

To work around this issue, use one of the following methods.

## Workaround 1: Manually add the default route for the Interface

Use the Route Add command to manually add the default route for the network interface that you added.

1. Click **Start**, click **Run**, type *cmd* in the **Open** box, and then click **OK**.
2. Type route print, and then press ENTER to view the routing table. Note the interface number of the network interface that you re-added.
3. Type the following command, and then press ENTER route add 0.0.0.0 mask 0.0.0.0 **gateway IP** metric **30** if **Interface number**  
where **gateway IP** is the IP address of the default gateway for this interface, and where **Interface number** is the number that corresponds to the network interface that you added (for example, 2). For example, if your default gateway IP address is 192.168.1.1 and the interface number is 2, type the following command, and then press ENTER:

    ```console
    route add 0.0.0.0 mask 0.0.0.0 192.168.1.1 metric 30 if 2
    ```

4. Type route print to verify that the new default route appears in the routing table.
5. Close the command prompt.

## Workaround 2: Restart the remote access service

Restart the remote access service. The default route for the re-added network interface is added to the Windows routing table.

1. Start the Routing and Remote Access utility.
2. Under **Routing and Remote Access**, right-click the server where you re-added the network interface, point to **All Tasks**, and then click **Restart**.

## Workaround 3: Restart the server

Restart the remote access server. The default route for the re-added network interface is added to the Windows routing table.
