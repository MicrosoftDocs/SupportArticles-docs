---
title: Power Query Text/CSV connector authentication fails
description: Resolves an issue where the Power Query Text/CSV editor authentication fails in Dynamics 365 Customer Insights - Data.
ms.date: 12/26/2023
author: m-hartmann
ms.author: mhart
ms.reviewer: mhart
---
# Power Query Text/CSV connector authentication fails

[!INCLUDE [consolidated-sku](../../includes/consolidated-sku.md)]

This article resolves the error "The credentials provided for the source are invalid" that occurs during the authentication of the [Text/CSV](/power-query/connectors/text-csv) editor in Microsoft Dynamics 365 Customer Insights - Data.

## Symptoms

When editing a Power Query data source that uses the Text/CSV connector, if you need to reauthenticate, the error message "The credentials provided for the source are invalid" occurs. After you select **Configure connection**, the error message persists, and the authentication fails.

## Resolution

To solve this issue, refresh the connections on the Power Query transformations page.

1. Open the Power Query connection.
1. On the transformations page, select **Manage connections**.
1. Refresh all listed connections.
1. Refresh the browser page.
1. Save the data source.
