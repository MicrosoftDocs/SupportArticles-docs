---
title: Troubleshooting wrong database name in connection string 
description: This article provides symptoms and resolution for troubleshooting the wrong database name in connection string error.
ms.date: 11/23/2023
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Wrong database name in connection string

This article helps you resolve the issue related to the wrong database name in the connection string.

## Symptoms

The driver might generate the following error message:

"Cannot open database "northwind" requested by the login. The login failed."

Some drivers might also show the "Login failed for user CONTOSO\user1" error message.

The SQL Server Errorlog will have the following message:
"Login failed for user 'CONTOSO\User1'. Reason: Failed to open the explicitly specified database 'northwind'."

## Resolution

Make sure if the database name is the same in the error message and the ERRORLOG entry. Change the connection string, if incorrect, or grant the user the required permissions.
