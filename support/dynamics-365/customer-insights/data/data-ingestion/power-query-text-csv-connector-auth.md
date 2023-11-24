---
title: PowerQuery Text/CSV connector authentication fails
description: Troubleshoot an issue with Power Query connectors if the authentication of the Text/CSV editor fails.
ms.date: 11/22/2023
author: m-hartmann
ms.author: mhart
ms.reviewer: mhart
---

# PowerQuery Text/CSV connector authentication fails

## Symptoms

While editing a Power Query data source that uses the Text/CSV connector, if you need to reauthenticate and see the error message "The credentials provided for the source are invalid". The error message persists after you select **Configure connection** and authentication fails.

## Resolution

Refresh the connections in the Power Query transformations screen.

1. Open the Power Query connection.
1. On the transformations screen, select **Manage connections**.
1. Refresh all listed connections.
1. Refresh the browser page.
1. Save the data source.
