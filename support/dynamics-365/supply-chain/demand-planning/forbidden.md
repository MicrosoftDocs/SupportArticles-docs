---
title: Import failing with a forbidden error
description: Provides a way to solve the forbidden error.
author: fistamos
ms.date: 02/29/2024
ms.topic: troubleshooting
audience: Application User
ms.search.region: Global
ms.author: fistamos
ms.search.validFrom: 2024-03-01
---

# Import failing with a forbidden error

## Symptoms

The **Dynamics 365 Finance and Operations job execution** contains an error mentioning **Forbidden**.


## Resolution

1. Navigate to **Data Management Workspace** > **Framework parameters** > **General**
2. Change the value of **Shared access signature expiration time in minutes** from 0 to 120
