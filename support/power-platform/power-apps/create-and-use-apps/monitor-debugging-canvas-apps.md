---
title: Debugging canvas apps with Live monitor and Trace
description: Learn how to debug canvas apps across users and environments using Live monitor and the Trace function.
author: carlosff
ms.subservice: troubleshoot
ms.topic: how-to
ms.custom: canvas
ms.date: 01/15/2026
ms.author: carlosff
search.audienceType: 
  - maker
contributors:
  - carlosff
---

# Debugging canvas apps with Live monitor and Trace

You can use the [Live monitor](/power-apps/maker/monitor-canvasapps) together with the [Trace function](/power-platform/power-fx/reference/function-trace) to quickly diagnose issues in canvas apps—even those issues that appear only for certain users or in specific environments. The live monitor shows real-time events—network calls, data operations, errors, performance details—while Trace lets you emit structured diagnostic records that help you follow the values from behavior formulas at key moments in your app's logic.

This article builds on [Debugging canvas apps with Live monitor](/power-apps/maker/monitor-canvasapps) and [Collaborative troubleshooting using Live Monitor](/power-apps/maker/monitor-collaborative-debugging). Review those pages first if you're new to Live monitor.

## Why combine Live monitor and Trace

Live monitor gives you visibility into platform-level activity: data operations (`getRows`, `createRow`, `patch`), control evaluations, errors (HTTP status codes like 404 or 429), timing, and delegation indicators. By adding targeted Trace calls in your [behavior formulas](power-apps/maker/canvas-apps/working-with-formulas#manage-app-behavior) (for example, `OnSelect`, `OnVisible`, `OnStart`), you enrich those platform events with domain context: which user, which environment, which screen, entity counts, business flags, elapsed times, and any information that may help you better understand what the app is doing when it runs. Together they answer both "what happened" and "why it happened."

## Scenario 1: Works for one user but not another

Let's start with a common scenario that we see in many support requests: User A can submit orders successfully, while User B sees intermittent failures and the UI behaves differently (a discount checkbox is disabled for User B). You suspect the underlying data (for example, a missing role assignment or a flag value) differs between their accounts.

### Goal
Capture what the app believes about the current user (email, roles, customer selection, discount eligibility) and correlate it with the data operations the platform performs.

### Steps

1. Open the app in Power Apps Studio.
2. Add Trace calls in the `OnSelect` of the submit button (or in the logic that encapsulates submit).
3. Save / publish the app.
4. Open the Live monitor for the published app.
5. To invite User A, select the 'Connect user' option
6. As the User A runs through the app, you see the out-of-the-box events from the live monitor instrumented with the new Trace calls.
7. Open a new instance of the Live monitor for the published app. Do the same for User B (invite the user, then have them play the app). You can now see the runtime details for that user.
8. Compare the values, and try to find the difference that caused the app to behave incorrectly for one of the users.

**Example `OnSelect` formula with Trace**

```powerfx
// Emit pre-submit context
Trace(
    "Debug: Before Submit",
    TraceSeverity.Information,
    {
        user: User().Email,
        customerId: ddCustomer.Selected.Id,
        cartCount: CountRows(colCart),
        orderCountForCustomer: CountIf(Orders, Customer = ddCustomer.Selected),
        isVIP: ddCustomer.Selected.'VIP Flag',
        env: Param("env"),
        screen: App.ActiveScreen.Name
    }
);

// Perform data operations (simplified)
ForAll(colCart,
    Patch(Orders, Defaults(Orders), {
        Customer: ddCustomer.Selected,
        Product: ThisRecord.Product,
        Quantity: ThisRecord.Quantity
    })
);

// Post-submit trace with elapsed time and any collected errors
Trace(
    "Debug: After Submit"
    TraceSeverity.Information,
    {
        orderCountForCustomer: CountIf(Orders, Customer = ddCustomer.Selected)
    }
);
```

### Analyze

In Live monitor, filter by the Trace event type (or search for the name of the button, or for "Debug:" in the info). Compare User A vs User B:

* Do they have different `isVIP` values? That information could change the calculation for discounts.
* Are cart counts identical? If not, upstream logic differs.
* Are error traces present only for User B? Expand the event to inspect error payload details.

Then correlate Trace events with adjacent `getRows` / `patch` operations. If User B triggers extra data calls (perhaps a non-delegable `Filter` forcing multiple network requests), you can see them directly in the event table.

## Scenario 2: Works in one environment but not another

Your app behaves correctly in the **Test** environment but fails when deployed to **Production**: a gallery loads no items and submission is slow. Differences in the data between the two environments may be the cause—even though the app is the same, the data that comes through it can be different on different environments.

### Goal
Surface environment-specific metadata and counts, then compare the sequence and status codes of data operations between environments. In this example, the app has one screen with a form where a **Product** selected from a gallery can be updated—and the update works on **Test** but fails in **Production**.

### Steps

1. On the test environment, add an `OnVisible` Trace on the affected screen (for example, order entry screen) to emit information about the selected product:

```powerfx
Trace(
    "Debug: OnVisible on " & App.ActiveScreen.Name,
    TraceSeverity.Information,
    {
        recordId: varSelectedProduct.Id,
        hasDiscount: varSelectedProduct.HasDiscount,
        relatedOrders: CountIf(Orders, ProductId = varSelectedProduct.Id)
    }
);
```

2. Deploy the app with the new traces in the production environment.
3. Open Live monitor in **Test** and then in **Production**; capture and export logs if needed (use the export option in Live monitor).

### Analyze network events

In the event list:

* Compare initial `getRows` for `Products` across environments—does one return 0 results or error codes (404 if table missing, 403 if access denied, 429 if throttled)?
* Look for repeated `getRows` calls that may indicate a non-delegable formula being reevaluated.
* In the trace emitted for the screen's OnVisible property, do the products have different values for `relatedOrders` or `hasDiscount`?

If you find a difference—for example, in the hasDiscount property for varSelectedProduct—you can go back to the place where that variable was created, and add more Trace calls to see how it was populated.

If there are errors in the network calls (such as 4xx responses), check whether the tables / flows / connectors are set up correctly in both the **Test** and **Production** environment.

## Viewing data flowing over the network

Live monitor surfaces each data operation event with:

* Operation type (`getRows`, `createRow`, `patch`, `removeRow`)
* Data source (Dataverse table, connector name)
* Timing (start/finish, duration)
* Result (success, error status code like 429 for throttling)
* Delegation hints (non-delegable operations cause client-side processing and more data traffic)

Select an event to inspect details and correlate them with nearby Trace events to understand *why* the operation occurred. For example, a `getRows` surge following a Trace with `phase: "ApplyFilters"` may indicate an inefficient filter expression.

> [!TIP]
> When you see HTTP 429 (throttling), look at preceding network events to see whether a loop, or repeated evaluation triggered excessive operations (similar to the analysis in [Debugging canvas apps with Live monitor](/power-apps/maker/monitor-canvasapps)). Optimize formulas or introduce caching (collections) to reduce churn.

## Using Trace effectively

The [Trace function](/power-platform/power-fx/reference/function-trace) writes a structured record to Live monitor. Key points:

* Works only in behavior properties (for example, `OnSelect`, `OnChange`, `OnVisible`, `OnStart`).
* Accepts simple text values, but also a record payload—where we can include more details for the information being traced.
* TraceSeverity helps filter (Information, Warning, Error). Use Error severity sparingly for true failures.
* Minimal performance impact when used judiciously; remove or guard traces in production if they become noisy.

### Tracing data property values (debug-only buttons)

Because Trace can't be placed directly inside data properties (like a label's `Text`), you can surface those values through temporary debug-only controls. It's also useful to trace the values that are used to calculate the data property, as they may indicate why the value isn't the expected one.

1. Add a button `btnDebugSnapshot` with `Visible = Param("debug") = "true"`.
2. In its `OnSelect`, call Trace with a snapshot record.
3. When playing the app under the live monitor, add a query string parameter (`&debug=true`) to show the button.

**Example debug snapshot button**

```powerfx
// Visible property: Param("debug") = "true"
// OnSelect:
Trace(
    "Debug: Label value: " & Label1.Text,
    TraceSeverity.Information,
    {
        kind: "DataSnapshot",
        user: User().Email,
        customerCount: CountRows(Customers),
        productCount: CountRows(Products),
        maxPrice: Max(Products, Price),
        selectedProductId: If(!IsBlank(galProducts.Selected), galProducts.Selected.ProductId)
    }
);
```

> [!NOTE]
> Guard debug-only controls with query string parameters (like `debug=true`) or role checks so end users don't see them. While **Trace** calls have minimum performance impact, those "debug controls" do add some complexity to the app, so you should remove them before finalizing the app once they aren't needed anymore.

## When Live monitor can't be used

Some hosted or embedded scenarios (for example, SharePoint integrated forms, custom pages, certain custom portal embeddings) don't support opening Live monitor alongside the app. In these cases, consider alternatives:

| Alternative | Use case | Notes |
|-------------|----------|-------|
| [Application Insights integration](/power-apps/maker/canvas-apps/application-insights) | Centralized telemetry & performance | Requires setup; emits traces and metrics outside Power Apps. |
| Dataverse logging table | Ad-hoc diagnostics, audit trails | Create a `Debug Logs` table; use guarded Trace-like logic that uses `Patch` to create records when `Param("debug")="true"`. |
| SharePoint list logging | Lightweight environments without Dataverse | Use `Collect` / `Patch` to a list; prune entries to control size. |
| On-screen diagnostics panel | Immediate user feedback | Only for secure audiences; remove before broad rollout. |

**Example: Writing a debug record to Dataverse when Live monitor isn't available**

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

**Example: creating a diagnostics panel on the screen when Live monitor isn't available**

1. In places where a `Trace` call would be made, change it to a `Collect` call to a local collection
2. Add a text control to the screen, only visible for certain users or depending on a query string parameter, that displays the locally collected traces

```powerfx
// "Tracing" data to the collection
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

Add this label to the screen, which shows the traces that can be copied and viewed outside the app
```yaml
- TextCanvas1:
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
      Width: =200
      X: =Parent.Width - 220
      Y: =20
```

> [!NOTE]
> Once you understand the issue, remove the debug controls (or make them invisible) to prevent users from accidentally seeing them if they open the app with the debug query string parameter.

## Checklist for effective debugging

1. Reproduce with Live monitor open (Studio or published session).
2. Add Trace calls at key phases (start, decision, end, error handlers) when further details are needed.
3. Use query string parameters (`Param`) to tag environment or enable debug controls.
4. Compare traces across users/environments; look for divergent flags or counts.
5. Correlate Trace phases with network events (throttling, errors, extra calls).
7. Remove or guard Trace calls before broad deployment if verbose.

## Next steps

[Collaborative debugging with Live monitor](/power-apps/maker/monitor-collaborative-debugging)  
[Advanced monitoring](/power-apps/maker/monitor-advanced)
[Live monitor overview](/power-apps/maker/monitor-overview)  
[Trace function reference](/power-platform/power-fx/reference/function-trace)

### See also

[Debugging canvas apps with Live monitor](/power-apps/maker/monitor-canvasapps)  
