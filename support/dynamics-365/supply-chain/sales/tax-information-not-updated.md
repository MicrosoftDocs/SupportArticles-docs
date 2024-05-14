--- 
title: Tax information not updated if sales order location is changed 
description: Introduces a by-design behavior where you should manually update tax information if the site, warehouse, or delivery address is changed on a sales order header.
author: Henrikan 
ms.date: 05/08/2024
ms.topic: troubleshooting 
# ms.search.form: 
audience: Application User 
ms.reviewer: kamaybac
ms.search.region: Global 
ms.author: henrikan 
ms.search.validFrom: 2021-06-24 
ms.dyn365.ops.version: 10.0.20 
ms.custom: sap:Sales order processing\Issues with sales order processing
--- 

# Tax information isn't updated if location on a sales order header is changed

## Symptoms

If the site, warehouse, or delivery address is changed on a sales order header, the case tax information isn't updated on the lines.

## Resolution

This behavior is by design. The issue occurs because the delivery address, site, and warehouse aren't automatically changed at the line level. You must update them manually.
