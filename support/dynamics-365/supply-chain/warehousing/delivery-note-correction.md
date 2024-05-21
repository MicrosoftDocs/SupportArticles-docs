--- 
title: Delivery note correction can't be processed
description: Explains how to correct posted packing slips for items enabled for WMS when you correct a posted delivery note and receive an error.
author: Mirzaab 
ms.date: 06/24/2021 
ms.topic: troubleshooting 
# ms.search.form:  
audience: Application User 
ms.reviewer: kamaybac 
ms.search.region: Global 
ms.author: mirzaab 
ms.search.validFrom: 2021-06-24 
ms.dyn365.ops.version: 10.0.20 
ms.custom: sap:Warehouse management
--- 
# Delivery note correction can't be processed

## Symptoms

After you post a delivery note, you can't cancel it because the **Cancel** button is unavailable. You also can't correct the delivery note. If you try, you receive the following error message:

> The delivery note correction can't be processed. The delivery note only contains items that are subject to warehouse management processes, as these are not supported by Delivery Note correction.

## Resolution

To correct posted packing slips for items that are enabled for advanced warehouse management (WMS), you must do the posting from the load, not directly from the order.
