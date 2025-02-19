--- 
title: Cluster profile could not be found 
description: Make sure cluster profiles are set up correctly if you receive the cluster profile can't be found error when working with inbound warehouse operations.
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
# Cluster profile can't be found

## Symptoms

When working with inbound warehouse operations, you might receive the following error message:

> "Quality order %1 has been generated. Cluster profile could not be found. Please check your configuration."

This error message is related to a receiving process where quality management (QMS) is turned on. Depending on the configurations in your environment, additional details about the transaction that is generating the error message might help fix the issue.

## Resolution

First, review the cluster picking setup and make sure that your cluster profiles are set up correctly. You can't use a mobile device menu item for cluster picking unless cluster profiles are set up. Depending on your environment, you might also have to review other related configurations.
