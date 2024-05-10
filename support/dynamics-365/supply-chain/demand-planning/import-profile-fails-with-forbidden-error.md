---
title: Import profile job fails with a forbidden error
description: Provides a resolution for the Forbidden error that occurs when an import profile job fails in Microsoft Dynamics 365 Supply Chain Management.
author: fistamos
ms.date: 05/10/2024
audience: Application User
ms.search.region: Global
ms.author: fistamos
ms.search.validFrom: 2024-03-01
---
# An import profile job fails with a "Forbidden" error

This article provides a resolution for the "Forbidden" error that occurs when an import profile job fails in Microsoft Dynamics 365 Supply Chain Management.

## Symptoms

The Dynamics 365 Finance and Operations job execution details contains an error mentioning "Forbidden."

## Resolution

To solve this issue,

1. Navigate to **Data Management Workspace** > **Framework parameters** > **General**.
2. Change the value of **Shared access signature expiration time in minutes** from **0** to **120**.

## More information

- [Demand planning import profile troubleshooting guide](import-landing-page.md)
- [Import profile job fails because of time-out.](project-time-out.md)
- [Import profile job fails because of special characters.](special-characters.md)
- [Import profile job fails because of insufficient permissions.](user-insufficient-permissions.md)
- [Import data into Demand planning](/dynamics365/supply-chain/demand-planning/import-data)
