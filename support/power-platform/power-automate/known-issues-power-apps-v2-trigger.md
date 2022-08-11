---
title: Known issues when using Power Apps V2 trigger in Power Automate
description: Learn about the known issues when using Power Apps V2 trigger in Power Automate
ms.reviewer: ralinga
ms.topic: troubleshooting
ms.date: 08/10/2022
ms.subservice: power-automate-flows
---

# Known issues when using Power Apps V2 trigger

In this article, you'll learn about known issues when working with Power Apps V2 trigger in Power Automate.

## Power Apps V2 trigger doesn't support non-open API flows

The Power Apps V2 trigger doesn't support non-open API flows. Therefore, if you update your Power Apps V1 trigger to the Power Apps V2 trigger, your flow will break with a connection error. As a workaround, after you update your flow to the Power Apps V2 trigger, remove and then re-add the flow, then save the app.

If you update your Power Apps V1 trigger to the Power Apps V2 trigger, your flow will break with a connection error. As a workaround, after you update your flow to the Power Apps V2 trigger, remove and re-add the flow, then save the app.

## Updating Power Apps v2 trigger to invoker connection

The Power Apps V2 trigger supports both embedded and invoker connections. When updating the connections in your Power Apps V2 trigger to invoker connections, you must refresh or remove and re-add the flow in the app and save the app.
