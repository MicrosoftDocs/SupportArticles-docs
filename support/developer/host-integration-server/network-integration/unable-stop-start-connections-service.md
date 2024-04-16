---
title: Can't stop/start connections or service
description: This article provides resolutions for problem that occurs when you open SNA Manager, there is no ability to Stop and Start the Services or Connections in HIS 2010 and HIS 2009.
ms.date: 05/11/2020
ms.custom: sap:Network Integration (SNA Gateway)
---
# Unable to stop or start connections or service

This article helps you resolve the problem where there is no ability to stop and start the services or connections in Systems Network Architecture (SNA) Manager in Microsoft Host Integration Server 2010.

_Original product version:_ &nbsp; Host Integration Server 2010  
_Original KB number:_ &nbsp; 2655605

## Symptoms

When you open SNA Manager, you observe that there is no ability to stop and start the services or connections.

## Cause

Something became disassociated within the SNA engine.

## Resolution

Open the Host Integration Service Configuration Wizard:

- In the left pane, select **Network Integration**.
- In the right pane, in **Microsoft service** box, select (**...**) next to the **Account** box.
- Type in the **User name** (Domain\User Name) and select the **Browse** button to let the user name be authenticate against the network.
- Type in the **Password** and select **OK**.
- In the upper left-hand corner, select **Apply Configuration**.
- Stop and restart SNA Base.
