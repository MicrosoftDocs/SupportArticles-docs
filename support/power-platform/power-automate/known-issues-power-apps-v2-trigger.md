---
title: Known issues when using Power Apps V2 trigger in Power Automate
description: Provides a workaround for the known issues when you use Power Apps V2 trigger in Microsoft Power Automate.
ms.reviewer: ralinga
ms.topic: troubleshooting
ms.date: 08/10/2022
ms.subservice: power-automate-flows
---

# Known issues when using Power Apps V2 trigger

In this article, you'll learn about known issues when you work with Power Apps V2 trigger in Microsoft Power Automate.

## Power Apps V2 trigger doesn't support non-open API flows

The Power Apps V2 trigger doesn't support non-open API flows. Therefore, if you update your Power Apps V1 trigger to the Power Apps V2 trigger, your flow will break together with a connection error. As a workaround, after you update your flow to the Power Apps V2 trigger, remove and readd the flow, then save the app.

## Updating Power Apps v2 trigger to invoker connection

The Power Apps V2 trigger supports both embedded and invoker connections. When you update the connections in your Power Apps V2 trigger to invoker connections, you must refresh or remove and readd the flow in the app and then save the app.
