---
title: Power Query Text/CSV connector authentication fails
description: Resolves an issue where the Power Query Text/CSV editor authentication fails in Dynamics 365 Customer Insights - Data.
ms.date: 01/03/2024
author: m-hartmann
ms.author: mhart
ms.reviewer: mhart
ms.custom: sap:Data Ingestion\Connect to a Power Query data source
---
# Power Query Text/CSV connector authentication fails

[!INCLUDE [consolidated-sku](../../includes/consolidated-sku.md)]

This article resolves the error "The credentials provided for the source are invalid" that occurs during the authentication of the [Text/CSV](/power-query/connectors/text-csv) editor in Microsoft Dynamics 365 Customer Insights - Data.

## Symptoms

When editing a Power Query data source that uses the Text/CSV connector, if you need to reauthenticate, the error message "The credentials provided for the source are invalid" occurs. After you select **Configure connection**, the error message persists, and the authentication fails.

## Resolution

> [!NOTE]
> To perform the following steps, you should be the owner of the connection or have administrator permissions to access all existing connections.

To solve this issue, refresh the connections on the [Power Query transformations page](/power-query/manage-connections).

1. Open the Power Query connection.
1. On the transformations page, select **Manage connections**.
1. Refresh all listed connections. You can find the refresh icon next to the connection name by [editing a connection](/power-query/manage-connections#edit-a-connection).
1. Refresh the browser page.
1. Save the data source.
