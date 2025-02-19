--- 
title: Generate picking work immediately when load is released 
description: Provides steps to set up the wave template accordingly if work must be created immediately when the load is released.
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
 
# Picking work isn't generated immediately when outbound load is released

## Symptoms

You create an outbound load by using a sales or transfer order and release the load to the warehouse. However, you notice that no picking work has yet to be generated.

## Resolution

If work must be generated immediately when the load is released, you must configure the wave template accordingly. On the wave template, set the following options to **Yes**:

- **Automate wave creation**
- **Process wave at release to warehouse**
- **Automate wave release**
