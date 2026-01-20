---
title: Debug canvas apps with Live monitor and Trace
description: Learn how to troubleshoot canvas app issues across users and environments by using Live monitor and the Trace function to capture real-time events and diagnostic data.
ms.date: 01/15/2026
ms.reviewer: carlosff, v-shaywood
ms.custom: sap:Running Canvas App
search.audienceType: 
  - maker
---


# Debug canvas apps with Live monitor and Trace

## Summary

This article explains how to use [Live monitor](/power-apps/maker/monitor-overview) with the [Trace function](/power-platform/power-fx/reference/function-trace) to diagnose issues in Power Apps canvas apps. This approach helps you troubleshoot problems that appear only for certain users or in specific environments. Live monitor shows real-time events like network calls, data operations, errors, and performance details. The Trace function lets you add custom diagnostic records to capture values from [behavior formulas](/power-apps/maker/canvas-apps/working-with-formulas#manage-app-behavior) at key moments.

> [!NOTE]
> If you can't use Live monitor (for example, in SharePoint forms or custom portal embeddings), see [Debug canvas apps without Live monitor](monitor-debugging-canvas-apps-without-live-monitor.md) for alternative approaches.

## Prerequisites

This article builds on [Debugging canvas apps with Live monitor](/power-apps/maker/monitor-canvasapps) and [Collaborative troubleshooting using Live Monitor](/power-apps/maker/monitor-collaborative-debugging). Review those articles first if you're new to Live monitor.

## Combine Live monitor and Trace

Live monitor shows platform-level activity: data operations (`getRows`, `createRow`, `patch`), control evaluations, errors (HTTP status codes like `404` or `429`), timing, and delegation indicators.

By adding Trace calls in your behavior formulas (`OnSelect`, `OnVisible`, `OnStart`), you add context like:

- Which user is running the app
- Which environment the app is running in
- Which screen is active
- Entity counts (rows in collections, related records)
- Business flags (VIP status, discount eligibility)
- Elapsed times for operations
- Any other information that helps you understand what the app is doing

Together, Live monitor and Trace answer both "what happened" and "why."

### View data flowing over the network

Live monitor shows each data operation event with:

- Operation type (`getRows`, `createRow`, `patch`, `removeRow`)
- Data source (Dataverse table or connector name)
- Timing (start, finish, duration)
- Result (success or error status code)
- Delegation hints (non-delegable operations cause client-side processing)

Select an event to see details. Correlate events with nearby Trace records to understand *why* the operation occurred. For example, a `getRows` surge after a Trace with `phase: "ApplyFilters"` might indicate an inefficient filter expression.

> [!TIP]
> If you see HTTP 429 (throttling), look at preceding events to see whether a loop or repeated evaluation triggered excessive operations. Optimize formulas or use collections to cache data and reduce network calls.

### Use Trace effectively

The [Trace function](/power-platform/power-fx/reference/function-trace) writes a structured record to Live monitor.

Key features:

- Works only in behavior properties (`OnSelect`, `OnChange`, `OnVisible`, `OnStart`).
- Accepts text and a record payload for additional details.
- `TraceSeverity` helps filter events (Information, Warning, Error). Use Error sparingly.
- Has minimal performance impact when used appropriately. Remove or guard verbose traces before broad deployment.

#### Trace data property values with debug buttons

Because Trace can't be placed in data properties (like a label's `Text`), use temporary debug buttons to capture those values.

To create a debug button:

1. Add a button named `btnDebugSnapshot` with **Visible** set to `Param("debug") = "true"`.
1. In `OnSelect`, call Trace with a snapshot record.
1. When testing, add `&debug=true` to the app URL to show the button.

> [!TIP]
> It's also useful to trace the values used to calculate a data property, as they might indicate why the value isn't what you expect.

##### Example debug snapshot button

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
> Guard debug controls with query string parameters or role checks so end users don't see them. Remove these controls before you finalize the app.

### Debugging checklist

Use this checklist when troubleshooting canvas app issues:

1. Reproduce the issue with Live monitor open (in Studio or a published session).
1. Add Trace calls at key phases (start, decision points, end, error handlers).
1. Use query string parameters (`Param`) to tag the environment or enable debug controls.
1. Compare traces across users or environments. Look for different flags or counts.
1. Correlate Trace events with network events (throttling, errors, extra calls).
1. Remove or guard verbose Trace calls before broad deployment.

## Example scenarios

### Scenario: App works for one user but not another

User A submits orders successfully, but User B sees failures and different UI behavior (for example, a discount checkbox is disabled). You suspect the underlying data differs between their accounts.

#### Goal

Capture what the app sees about each user (email, roles, customer selection, discount eligibility) and compare it with the data operations in Live monitor.

#### Steps

1. Open the app in Power Apps Studio.
1. Add Trace calls in the `OnSelect` property of the submit button.
1. Save and publish the app.
1. Open Live monitor for the published app.
1. Select **Connect user** to invite User A.
1. As User A runs through the app, you see both the built-in events and your custom Trace calls.
1. Open a new Live monitor instance and connect User B the same way.
1. Compare the values to find the difference causing the problem.

#### Example: OnSelect formula with Trace

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

// Post-submit trace
Trace(
    "Debug: After Submit",
    TraceSeverity.Information,
    {
        orderCountForCustomer: CountIf(Orders, Customer = ddCustomer.Selected)
    }
);
```

#### Analyze the results

In Live monitor, filter by Trace events, button name, or search for "Debug:" in the info column. Compare User A vs. User B:

- Do they have different `isVIP` values? This could change discount calculations.
- Are cart counts identical? If not, upstream logic differs.
- Are error traces present only for User B? Expand the event to inspect error details.

Correlate Trace events with adjacent `getRows` or `patch` operations. If User B triggers extra data calls (for example, a non-delegable filter forcing multiple network requests), you see them in the event table.

### Scenario: App works in one environment but not another

Your app works correctly in _Test_ but fails in _Production_, for example a gallery loads no items and submission is slow. Even though the app is the same, the data in each environment can differ, this difference can cause the app to behave differently in each environment.

#### Goal

Surface environment-specific metadata and counts, then compare data operations between environments.

#### Steps

1. Add an **OnVisible** Trace on the affected screen:

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

1. Deploy the app with the new traces to production.
1. Open Live monitor in **Test** and then in **Production**. Export logs if needed.

#### Analyze the results

In the event list:

- Compare `getRows` for **Products** across environments. Does one return zero results or error codes (404 if the table is missing, 403 if access is denied, 429 if throttled)?
- Look for repeated `getRows` calls that might indicate a non-delegable formula.
- Compare the Trace values—do products have different values for `relatedOrders` or `hasDiscount`?

If you find a difference, add more Trace calls where the variable is created to see how it's populated.

If you see network errors (4xx responses), check whether tables, flows, and connectors are set up correctly in both environments.

## Related content

- [Debug canvas apps without Live monitor](monitor-debugging-canvas-apps-without-live-monitor.md)
- [Advanced monitoring](/power-apps/maker/monitor-advanced)
