---
title: Client health dashboard displays some failed devices
description: Work around an issue in which some devices are reported as failure on the Status Messages bar of the client health dashboard.
ms.date: 09/03/2021
ms.reviewer: payur
author: simonxjx
ms.author: v-six
ms.prod-support-area-path:
---
# Some devices are reported as failure on the Status Messages bar of the client health dashboard

In [version 1902 of Configuration Manager current branch](/mem/configmgr/core/plan-design/changes/whats-new-in-version-1902#client-health-dashboard), the client health dashboard is available to assess the health of Configuration Manager clients in your environment. This article describes an issue in which some devices are reported as **Failure** unexpectedly on the **Status Messages** bar of the **Scenario Health** bar chart. This article also provides some insights on the internals and calculations of the **Scenario Health** bar chart.

_Applies to:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4643234

## Symptoms

In the **Scenario Health** bar chart of the client health dashboard, some devices are reported as **Failure** on the **Status Messages** bar unexpectedly. The corresponding information is also reflected on the **Combined (Any)** bar.

:::image type="content" source="media/failed-devices-client-health-dashboard/scenario-health-bar-chart.png" alt-text="Screenshot of the scenario health bar chart.":::

## Cause

A Configuration Manager client sends a status message in the following scenarios.

- You run a legacy software distribution such as a classic package on the client.
- Something is changed or broken on the client. For example, software inventory isn't completed within the timeout.

If you use only the Modern Software Distribution technologies and deploy software updates, no status message will be sent and the last status message timestamp in the database will not be updated.

> [!NOTE]
> Hidden legacy package deployments such as Configuration Manager Client Upgrade packages may update the last status message timestamp.

## Workaround

You can deploy a dummy legacy package (such as the `cmd /c echo` cmdlet) to a client of concern to generate a constant status message flow. Then, a status message timestamp will be updated regularly, and the client will be reported as **Success** on the **Status Messages** bar. Alternatively, you can also ignore or hide the **Status Messages** bar.

## More information

The client health dashboard displays the summarized client health information. To view a client information in the Configuration Manager console, administrators can add the columns (such as **Policy Request** or **Status Message**) or check the **Client Activity** section of the client.

:::image type="content" source="media/failed-devices-client-health-dashboard/client-health-dashboard-scenario-health.png" alt-text="Screenshot of client health dashboard scenario health in the Configuration Manager console.":::

By default, the health information is summarized on a site server once a day. In the **Client Status Settings Properties** dialog box on the **Client Activity** site, administrator can also configure the settings to [monitor client status](/mem/configmgr/core/clients/manage/monitor-clients). If the recent status message was created within seven days, it is considered as a client active via **Monitoring** > **Overview** > **Client Status** > **Client Activity**.

:::image type="content" source="media/failed-devices-client-health-dashboard/client-status-settings-properties.png" alt-text="Screenshot of the Client Status Settings Properties dialog box.":::

In Configuration Manager, administrators can use a maintenance task ([Delete Aged Status Messages](/mem/configmgr/core/servers/manage/reference-for-maintenance-tasks#delete-aged-status-messages)) to delete status messages older than 30 days (by default) as configured in [status filter rules](/mem/configmgr/core/servers/manage/use-status-system#manage-status-filter-rules).

:::image type="content" source="media/failed-devices-client-health-dashboard/delete-aged-status-messages.png" alt-text="A task setting to delete aged status messages.":::

The SQL Stored Procedure (`spGetClientHealthDashboard`) calculates the **Success** and **Failure** status for individual clients as follows:

- The timestamp of the recent status message is less than seven days, or there is no status message, the client is reported as the **Success** status.
- The timestamp of the recent status message is older than seven days, and the status message is not deleted, the client is reported as the **Failure** status.

> [!NOTE]
> This algorithm is also applicable to other bars. However, there is no cleanup mechanism for inventory timestamps.

By default, the client health dashboard displays the health information of clients that were online in the last three days.

:::image type="content" source="media/failed-devices-client-health-dashboard/client-health-dashboard-settings.png" alt-text="Settings of the client health dashboard.":::

## See also

[MMS: ConfigMgr State and Status Messages](https://mms2014.sched.com/event/Z78Zmr/configmgr-state-and-status-messages-under-the-hood)

[!INCLUDE [Third-party contact disclaimer](../../includes/third-party-contact-disclaimer.md)]
