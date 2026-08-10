---
title: Troubleshoot Canvas Apps if Live Monitor Is Unsupported
description: Debug Power Apps canvas apps and capture intermittent issues with Application Insights, Dataverse, or on-screen diagnostics. Learn the alternatives to Live monitor.
ms.date: 08/10/2026
ms.reviewer: carlosff, v-shaywood
ms.custom: sap:Running Canvas App
ai-usage: ai-assisted
search.audienceType: 
  - maker
---

# Debug canvas apps without Live monitor

## Summary

This article discusses alternative debugging approaches for Microsoft Power Apps [canvas apps](/power-apps/maker/canvas-apps/getting-started) in scenarios that don't support [Live monitor](/power-apps/maker/monitor-canvasapps). Use these techniques for SharePoint integrated forms, custom pages, or custom portal embeddings in which you can't open Live monitor alongside the app. It also covers intermittent issues that don't happen often enough to catch while Live monitor is connected.

Live monitor is the recommended tool for debugging canvas apps because it shows real-time events and works together with the [Trace function](/power-platform/power-fx/reference/function-trace). But some hosted or embedded scenarios don't support it, and some issues occur too rarely to capture in a live session. This article covers alternatives like Application Insights, [Dataverse](/power-apps/maker/data-platform/data-platform-intro) logging tables, SharePoint list logging, and on-screen diagnostics panels.

> [!NOTE]
> For scenarios in which Live monitor is supported and available, see [Debug canvas apps with Live monitor and Trace](monitor-debugging-canvas-apps.md).

## Alternative debugging approaches

If Live monitor isn't available, choose one of the following alternative debugging methods based on your environment and needs.

| Alternative | Best for | Notes |
| --- | --- | --- |
| [Application Insights](#application-insights-integration) | Centralized telemetry and performance monitoring | Requires Azure setup. Emits traces and metrics outside Power Apps. |
| [Dataverse logging table](#write-debug-records-to-dataverse) | Ad-hoc diagnostics and audit trails | Create a custom table. Use guarded logic to write records when debugging. |
| [SharePoint list logging](#write-debug-records-to-sharepoint) | Lightweight environments without Dataverse | Use `Collect` or `Patch` to write to a list. To control size, prune entries. |
| [On-screen diagnostics panel](#create-an-on-screen-diagnostics-panel) | Immediate feedback during testing | Only for secure audiences. Remove before a broad rollout. |

## Application Insights integration

[Application Insights](/power-apps/maker/canvas-apps/application-insights) provides centralized telemetry for canvas apps. It captures performance metrics, errors, and custom traces in Azure Monitor, where you can analyze data across sessions and users.

This approach requires:

- An Azure subscription
- An Application Insights resource
- Setup in the Power Apps app settings

For setup instructions, see [Analyze app telemetry using Application Insights](/power-apps/maker/canvas-apps/application-insights).

## Write debug records to Dataverse

To capture diagnostic information if your environment includes Dataverse, create a custom `Debug Logs` table. This approach works well for ad-hoc troubleshooting and audit trails.

### Create the Debug Logs table

1. In [Power Apps](https://make.powerapps.com), go to **Tables**, and create a new table that's named `Debug Logs`.
1. Add the following columns:
   - `Title`: A label for the log entry
   - `UserEmail`: The email address of the user
   - `Timestamp`: When the event occurred
   - `Payload`: Additional data in JSON format
   - Other columns as necessary for your scenario, like `CartCount` and `ScreenName`

### Example: Write a debug record to Dataverse

Use a guarded [Patch](/power-platform/power-fx/reference/function-patch) call to write records only if a debug query string parameter is present.

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

To turn on debug logging, add `&debug=true` to the app URL. For more information about query string parameters, see [Launch and Param functions](/power-platform/power-fx/reference/function-param).

After you reproduce the issue, open the `Debug Logs` table in Dataverse to review the captured records.

> [!NOTE]
> Remove or turn off debug logging before you deploy the app broadly. To manage storage, periodically delete old log entries.

## Write debug records to SharePoint

For lightweight environments without Dataverse, use a [SharePoint](/connectors/sharepointonline/) list to capture debug information.

### Create the debug list

1. In SharePoint, create a list that's named `AppDebugLogs`.
1. Add the following columns:
   - `Title`: A label for the log entry
   - `UserEmail`: The email address of the user
   - `Timestamp`: When the event occurred
   - `Payload`: Additional data in JSON format
   - Other columns as necessary for your scenario

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
> SharePoint lists have storage limits. To prevent the list from growing too large, regularly remove old entries.

## Capture intermittent issues for later analysis

Some issues occur too infrequently to reproduce while Live monitor is connected. For these issues, use Application Insights or a Dataverse or SharePoint logging destination to capture diagnostic information each time the affected operation runs. Include enough context to compare successful and failed attempts.

Add the following identifiers to each trace or log record:

- `EntraObjectId`: Use [`User().EntraObjectId`](/power-platform/power-fx/reference/function-user) to identify the user in Microsoft telemetry.
- `SessionId`: Use [`Host.SessionID`](/power-platform/power-fx/reference/object-host) to identify the specific app session and correlate it with server-side processing.
- `Timestamp`: Record when the operation occurred.
- `Event`: Identify the operation or stage, like `BeforeSubmit` or `SubmitFailed`.
- Relevant input and calculated values: Capture the values that control the behavior, especially intermediate values that might unexpectedly be blank.

For Application Insights, include these fields in the custom record passed to `Trace`.

```powerfx
Trace(
    "BeforeSubmit",
    TraceSeverity.Information,
    {
        EntraObjectId: User().EntraObjectId,
        SessionId: Host.SessionID,
        ScreenName: App.ActiveScreen.Name,
        CustomerId: ddCustomer.Selected.Id,
        CalculatedRequiredValue: varRequiredValue
    }
)
```

For a Dataverse table or SharePoint list, add `EntraObjectId` and `SessionId` text columns, and then include the identifiers in each record, as shown in the following example.

```powerfx
Patch(
    AppDebugLogs,
    Defaults(AppDebugLogs),
    {
        Title: "BeforeSubmit",
        UserEmail: User().Email,
        EntraObjectId: Text(User().EntraObjectId),
        SessionId: Host.SessionID,
        Timestamp: Now(),
        Payload: JSON(
            {
                screenName: App.ActiveScreen.Name,
                customerId: ddCustomer.Selected.Id,
                calculatedRequiredValue: varRequiredValue
            }
        )
    }
)
```

For example, suppose that form submissions fail for a small number of users because a required field is blank. Log the inputs to the expression that calculates the field, the calculated result, and the identifiers immediately before submission. Compare successful and failed records to check which input or condition produces the blank value. If you have to open a Microsoft support request, provide the Entra object ID, session ID, and timestamp for an affected attempt so that support can correlate the event with Microsoft telemetry.

> [!IMPORTANT]
> Limit access to diagnostic data, and don't log passwords, access tokens, or other sensitive values. Remove or reduce verbose logging after you fix the issue.

## Create an on-screen diagnostics panel

For immediate feedback during testing, create a diagnostics panel that shows debug information directly in the app. This approach is useful if you need to see values in real time.

### Collect debug data

Instead of using `Trace`, add data to a local [collection](/power-apps/maker/canvas-apps/create-update-collection), as shown in the following example.

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

### Add a text control to show traces

Add a text control to the screen that shows the collected traces. Set the **Visible** property of the text control so that the control appears only in debug mode.

#### Control properties

| Property | Value |
| --- | --- |
| **Text** | `Concat(debugTraces, $"[{Text(Timestamp, "hh:mm:ss.fff")}] {Data}", Char(10))` |
| **Visible** | `Param("debug") = "true"` |
| **Height** | 200 |
| **Width** | 300 |
| **X** | `Parent.Width - 320` |
| **Y** | 20 |

This setup shows a scrollable list of debug messages that you can copy and analyze outside the app.

#### Example YAML for the text control

If you use the YAML view in Power Apps Studio, apply the following configuration.

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
> Remove or hide the diagnostics panel before you deploy the app to users. Users who open the app by using the debug parameter shouldn't see internal diagnostic information.

## Best practices for alternative debugging

If you use an alternative debugging approach, follow these guidelines:

- *Guard debug controls*: Use query string parameters like `Param("debug") = "true"` or role checks to show debug features only during testing.
- *Clean up before deployment*: Remove debug controls, logging calls, and diagnostic panels before you run a broad deployment.
- *Manage log storage*: To manage storage for Dataverse or SharePoint logging, periodically delete old entries.
- *Use meaningful labels*: To make logs easier to analyze, include descriptive titles like "BeforeSubmit" or "OnVisible_OrderScreen."
- *Include context*: Log the user email, screen name, and relevant data values so you can correlate entries across sessions.

## Related content

- [Collaborative debugging with Live monitor](/power-apps/maker/monitor-collaborative-debugging)
- [Live monitor overview](/power-apps/maker/monitor-overview)
