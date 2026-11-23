---
title: Power Query Text/CSV connector Authentication Fails
description: Resolve an authentication issue in the Power Query Text/CSV editor by reauthenticating and saving your data source in Dynamics 365 Customer Insights - Data.
ms.date: 11/16/2026
ms.reviewer: sstabbert, v-wendysmith
ms.custom: sap:Data Ingestion\Connect to a Power Query data source
---
# Power Query Text/CSV connector authentication fails

## Summary

This article helps you resolve the error "The credentials provided for the source are invalid" that occurs during the authentication of the [Text/CSV](/power-query/connectors/text-csv) editor in Microsoft Dynamics 365 Customer Insights - Data.

## Prerequisites

You are the owner of the connection or have administrator permissions to access all existing connections.

## Symptoms

When editing a Power Query data source that uses the Text/CSV connector, if you need to reauthenticate, the error message "The credentials provided for the source are invalid" occurs. After you select **Configure connection**, the error message persists, and the authentication fails.

## Solution

To solve this issue, refresh the connections on the [Power Query transformations page](/power-query/manage-connections).

1. Open the Power Query connection.
1. On the transformations page, select **Manage connections**.
1. Refresh all listed connections. You can find the refresh icon next to the connection name by [editing a connection](/power-query/manage-connections#edit-a-connection).
1. Refresh the browser page.
1. Save the data source.
