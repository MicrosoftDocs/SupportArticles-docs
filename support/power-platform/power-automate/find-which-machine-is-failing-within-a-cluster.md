---
title: Find which machine is failing within a cluster
description: Diagnose which machine is failing with a cluster when running UI Flows.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Find which machine is failing within a cluster

This article provides steps to find which machine is failing with a cluster when running UI Flows.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4555599

## Symptoms

Some UI flows are failing intermittently when running **as part of a flow** on a Gateway Cluster.

## Verifying issue

If flow runs are intermittently failing when running on a Gateway Cluster, it's possible that some members of the cluster may be in a bad state. Here are a few steps you can take to find whether specific machines should be recovered, and if so, which ones:

1. Go to the Connections pages under Data/ in the left pane
2. Find the desktop flows connection targeting the cluster you're interested in: Filter for **desktop flows**, and on the connection details page, check out the **Gateway** field:

   :::image type="content" source="media/find-which-machine-is-failing-within-a-cluster/gateway-details.png" alt-text="Gateway details location":::

3. Go to the **Flows using this connection**.
4. Identify the list of desktop flows running within the list of Flows.
5. Go on the desktop flow details page, and checkout the run history, taking note of the failing runs and the corresponding machine name:

   :::image type="content" source="media/find-which-machine-is-failing-within-a-cluster/check-failing-machine.png" alt-text="Check the machine on which the run fails":::

6. Verify all desktop flows runs. If the failures are all happening on the same machine, this machine might be in a bad state and need recovery.

## Solving steps

Make sure the machine is online, and reinstall the On-Premises Data Gateway and the desktop flows package if needed.
