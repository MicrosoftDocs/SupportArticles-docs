--- 
title: Invalid license plate when scanning ID in mobile app 
description: Provides a resolution for the invalid license plate error that occurs when you scan a license plate ID in the Warehouse Management mobile app.
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
# Invalid license plate error when scanning license plate ID in the mobile app

## Symptoms

When you scan a license plate ID in the Warehouse Management mobile app, you might receive the following error message:

> Invalid license plate.

## Resolution

Make sure the license plate ID exists in the license plates table, and that the items and quantities on the license plate are available (in other words, they aren't blocked).
