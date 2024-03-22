---
title: Known issues with Power Apps V2 trigger in Power Automate
description: Provides the workarounds for the known issues when you use Power Apps V2 trigger in Microsoft Power Automate.
ms.reviewer: ralinga
ms.date: 08/10/2022
ms.custom: sap:Flow creation\Triggers
---
# Known issues with Power Apps V2 trigger

This article provides the workarounds for the known issues with Power Apps V2 trigger in Microsoft Power Automate.

## Power Apps V2 trigger doesn't support non-open API flows

The Power Apps V2 trigger doesn't support non-open API flows. Therefore, if you update your Power Apps V1 trigger to the Power Apps V2 trigger, your flow will break together with a connection error. As a workaround, after you update your flow to the Power Apps V2 trigger, remove and readd the flow, then save the app.

## Issue with updating Power Apps v2 trigger to invoker connection

The Power Apps V2 trigger supports both embedded and invoker connections. When you update the connections in your Power Apps V2 trigger to invoker connections, you must refresh or remove and readd the flow in the app and then save the app.
