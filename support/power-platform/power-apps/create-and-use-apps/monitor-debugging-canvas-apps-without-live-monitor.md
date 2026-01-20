---
title: Debug canvas apps without Live monitor
description: Learn alternative approaches to debug Power Apps canvas apps when Live monitor isn't available, such as in SharePoint forms or custom portal embeddings.
ms.date: 01/20/2026
ms.reviewer: carlosff, v-shaywood
ms.custom: sap:Running Canvas App
---

<!-- [CUSTOMER INTENT: As a Power Apps maker, I want to debug canvas app issues when I can't use Live monitor, so I can troubleshoot problems in embedded or hosted scenarios.] -->

# Debug canvas apps without Live monitor

This article describes alternative debugging approaches for Power Apps canvas apps when [Live monitor](/power-apps/maker/monitor-canvasapps) isn't available. Use these techniques for SharePoint integrated forms, custom pages, or custom portal embeddings where you can't open Live monitor alongside the app.

## Summary

Live monitor is the recommended tool for debugging canvas apps because it shows real-time events and works with the [Trace function](/power-platform/power-fx/reference/function-trace). However, some hosted or embedded scenarios don't support it. This article covers alternatives like Application Insights, Dataverse logging tables, SharePoint list logging, and on-screen diagnostics panels.

For scenarios where Live monitor is available, see [Debug canvas apps with Live monitor and Trace](monitor-debugging-canvas-apps.md).

## Alternative debugging approaches

When Live monitor isn't available, choose an alternative based on your environment and needs:

| Alternative | Best for | Notes |
| ----------- | -------- | ----- |
| [Application Insights](#application-insights-integration) | Centralized telemetry and performance monitoring | Requires Azure setup. Emits traces and metrics outside Power Apps. |
| [Dataverse logging table](#write-debug-records-to-dataverse) | Ad-hoc diagnostics and audit trails | Create a custom table. Use guarded logic to write records when debugging. |
| [SharePoint list logging](#write-debug-records-to-sharepoint) | Lightweight environments without Dataverse | Use `Collect` or `Patch` to a list. Prune entries to control size. |
| [On-screen diagnostics panel](#create-an-on-screen-diagnostics-panel) | Immediate feedback during testing | Only for secure audiences. Remove before broad rollout. |

## Application Insights integration

[Application Insights](/power-apps/maker/canvas-apps/application-insights) provides centralized telemetry for canvas apps. It captures performance metrics, errors, and custom traces in Azure Monitor, where you can analyze data across sessions and users.

This approach requires:

- An Azure subscription
- An Application Insights resource
- Configuration in the Power Apps app settings

For setup instructions, see [Analyze app telemetry using Application Insights](/power-apps/maker/canvas-apps/application-insights).

## Write debug records to Dataverse

If your environment includes Dataverse, create a custom **Debug Logs** table to capture diagnostic information. This approach works well for ad-hoc troubleshooting and audit trails.

### Create the Debug Logs table

1. In [Power Apps](https://make.powerapps.com), go to **Tables** and create a new table named **Debug Logs**.
1. Add the following columns:
   - **Title** (Single line of text): A label for the log entry.
   - **UserEmail** (Single line of text): The email of the user.
   - **Timestamp** (Date and time): When the event occurred.
   - **Payload** (Multiple lines of text): Additional data in JSON format.
   - Add other columns as needed for your scenario (for example, **CartCount**, **ScreenName**).

### Example: Write a debug record to Dataverse

Use a guarded `Patch` call to write records only when a debug query string parameter is present:

```powerfx
If(Param("debug") = "true",
    Patch(
        'Debug Logs',
        Defaults('Debug Logs'),
        {
            Title: "BeforeSubmit",
            UserEmail: User().Email,
            CartCount: CountRows(colCart),
            Timestamp: Now(),
            Payload: JSON({customerId: ddCustomer.Selected.Id})
        }
    )
);
```

### Run the app in debug mode

To enable debug logging, add `&debug=true` to the app URL:

```text
https://apps.powerapps.com/play/e/[environment-id]/a/[app-id]?debug=true
```

After reproducing the issue, open the **Debug Logs** table in Dataverse to review the captured records.

> [!NOTE]
> Remove or disable debug logging before you deploy the app broadly. Periodically delete old log entries to manage storage.

## Write debug records to SharePoint

For lightweight environments without Dataverse, use a SharePoint list to capture debug information.

### Create the debug list

1. In SharePoint, create a new list named **AppDebugLogs**.
1. Add columns for **Title**, **UserEmail**, **Timestamp**, **Payload**, and any other data you want to capture.

### Example: Write a debug record to SharePoint

```powerfx
If(Param("debug") = "true",
    Patch(
        AppDebugLogs,
        Defaults(AppDebugLogs),
        {
            Title: "BeforeSubmit",
            UserEmail: User().Email,
            Timestamp: Now(),
            Payload: JSON({customerId: ddCustomer.Selected.Id, cartCount: CountRows(colCart)})
        }
    )
);
```

> [!NOTE]
> SharePoint lists have storage limits. Prune old entries regularly to prevent the list from growing too large.

## Create an on-screen diagnostics panel

For immediate feedback during testing, create a diagnostics panel that displays debug information directly in the app. This approach is useful when you need to see values in real time.

### Step 1: Collect debug data

Instead of using Trace, collect data to a local collection:

```powerfx
If(
    Param("debug") = "true",
    Collect(
        debugTraces,
        {
            Timestamp: Now(),
            Data: $"Before submit for {User().Email} with {CountRows(colCart)} items in the cart"
        }
    )
)
```

### Step 2: Add a text control to display traces

Add a text control to the screen that shows the collected traces. Set its **Visible** property so it only appears in debug mode.

**Control properties:**

| Property | Value |
| -------- | ----- |
| **Text** | `Concat(debugTraces, $"[{Text(Timestamp, "hh:mm:ss.fff")}] {Data}", Char(10))` |
| **Visible** | `Param("debug") = "true"` |
| **Height** | 200 |
| **Width** | 300 |
| **X** | `Parent.Width - 320` |
| **Y** | 20 |

This displays a scrollable list of debug messages that you can copy and analyze outside the app.

### Example YAML for the text control

If you're using Power Apps Studio's YAML view:

```yaml
- TextDebugPanel:
    Control: Text@0.0.51
    Properties:
      Height: =200
      Size: =12
      Text: |-
        =Concat(
            debugTraces,
            $"[{Text(Timestamp,"hh:mm:ss.fff")}] {Data}",
            Char(10))
      Visible: =Param("debug") = "true"
      Width: =300
      X: =Parent.Width - 320
      Y: =20
```

> [!IMPORTANT]
> Remove or hide the diagnostics panel before deploying the app to end users. Users who open the app with the debug parameter shouldn't see internal diagnostic information.

## Best practices for alternative debugging

- **Guard debug controls**: Use query string parameters (`Param("debug") = "true"`) or role checks to show debug features only during testing.
- **Clean up before deployment**: Remove debug controls, logging calls, and diagnostic panels before you deploy broadly.
- **Manage log storage**: For Dataverse or SharePoint logging, periodically delete old entries.
- **Use meaningful labels**: Include descriptive titles like "BeforeSubmit" or "OnVisible_OrderScreen" to make logs easier to analyze.
- **Include context**: Log the user email, screen name, and relevant data values so you can correlate entries across sessions.

## Related content

- [Debug canvas apps with Live monitor and Trace](monitor-debugging-canvas-apps.md)
- [Analyze app telemetry using Application Insights](/power-apps/maker/canvas-apps/application-insights)
- [Collaborative debugging with Live monitor](/power-apps/maker/monitor-collaborative-debugging)
- [Live monitor overview](/power-apps/maker/monitor-overview)
- [Trace function reference](/power-platform/power-fx/reference/function-trace)
