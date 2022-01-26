---
title: Heartbeat alerts are generated in maintenance mode
description: Describes an issue that a computer agent unexpectedly continues to generate heartbeat alerts after you put the computer agent into maintenance mode in System Center Operations Manager.
ms.date: 06/30/2020
ms.reviewer: v-jomcc
---
# A computer agent unexpectedly generates heartbeat alerts after you put it into maintenance mode

This article describes a by-design behavior that a computer agent unexpectedly continues to generate heartbeat alerts after you put the computer agent into maintenance mode in System Center Operations Manager.

_Original product version:_ &nbsp; System Center 2016 Operations Manager, System Center 2012 R2 Operations Manager, System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 942866

## Symptoms

In System Center Operations Manager, you put a computer agent into maintenance mode. Then, the following information appears in the **Maintenance Mode Settings** dialog box:

> These features are temporarily suspended for objects in Maintenance mode:
>
> - Rules and monitors
> - Notifications
> - Automatic responses
> - State changes
> - New alerts

However, the computer that's running the agent unexpectedly continues to generate heartbeat alerts.

> [!NOTE]
> For more information about how to put an agent into maintenance mode, see the [Steps to reproduce the behavior](#steps-to-reproduce-the-behavior) section.

## Cause

This behavior occurs if you do not put the following features into maintenance mode:

- Health Service
- Health Service Watcher

By design, System Center Operations Manager verifies that the agent is functioning correctly even if the computer is not being monitored. If the Health Service feature and the Health Service Watcher feature for the particular agent are not in maintenance mode, you experience the behavior that is mentioned in the [Symptoms](#symptoms) section.

## Resolution

To resolve this behavior by putting the Health Service feature and the Health Service Watcher feature into maintenance mode, follow these steps:

1. Start the Operations console if it is not already running.
2. Select **Monitoring**, expand the **Monitoring** node, and then select **Computers**.
3. Select the computer that you want to put into maintenance mode, and then select **Start Maintenance Mode** in the **Actions** pane.
4. In the **Maintenance Mode Settings** dialog box, select **OK**.
5. Under the **Monitoring** node, select **Discovered Inventory**.
6. In the **Actions** pane, select **Change target type**.
7. In the **Select a Target Type** dialog box, select **Health Service**, and then select **OK**.
8. Select the agent for which you want to put the Health Service into maintenance mode, and then select **Start Maintenance Mode** in the **Actions** pane.
9. In the **Maintenance Mode Settings** dialog box, select **OK**.
10. In the **Discovered Inventory** view, select **Change target type** in the **Action** pane.
11. In the **Select a Target Type** dialog box, select **View all targets**, select **Health Service Watcher**, and then select **OK**.
12. Select the agent for which you want to put the Health Service Watcher into maintenance mode, and then select **Start Maintenance Mode** in the **Actions** pane.
13. In the **Maintenance Mode Settings** dialog box, select **OK**.

## Status

This behavior is by design.

## More information

Administrators may want to make sure that the agent is functioning even if the computer isn't being monitored. If the agent isn't being monitored, hidden agent-related errors may occur that affect the overall monitoring of the computer when the computer is no longer in maintenance mode. Therefore, when a computer is put into maintenance mode, the Operations Manager Health Service isn't also put into maintenance mode.

## Steps to reproduce the behavior

1. Start the Operations console.
2. Select **Monitoring**, expand the **Monitoring** node, and then select **Computers**.
3. In the **Computers** pane, select an agent, and then select **Start Maintenance Mode**.
4. In the **Maintenance Mode Settings** dialog box, select **Selected objects and all their contained objects**.

    > [!NOTE]
    > The following entries appear under **These features are temporarily suspended for objects in Maintenance Mode**:
    >
    > - **Rules and monitors**
    > - **Notifications**  
    > - **Automatic responses**  
    > - **State changes**  
    > - **New alerts**

5. Select **OK**.
6. On the agent, stop the **OpsMgr Health Service**.

Notice that in approximately three minutes (if you use the default heartbeat settings), you receive a **Health Service Heartbeat Failure** alert for this agent in the **Active Alerts** view.
