---
title: Troubleshooting the explicit misplaced SPN issue 
description: This article provides symptoms, cause, and solution for the consistent authentication issue of explicit SPN being misplaced.  
ms.date: 01/12/2024
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# Explicit misplaced SPN issue

This article helps you to resolve issues that might arise because of the explicit misplaced Service Principal Name (SPN).

## Symptoms

You might experience a consistent authentication issue because of the explicit SPNs being misplaced.

## Cause

If the SPN you specify in the connection string exists on a service account that's not used by SQL Server, you receive an Security Support Provider Interface (SSPI) context error message. The explicit misplaced SPNs can cause issues with Kerberos authentication and prevents clients from connecting to the service.

You might see the following error message when the SPN isn't registered properly.

> The target principal name is incorrect. Cannot generate SSPI context.

You will see the following message when you try to create an SPN that already exists.

> Duplicate SPN found, aborting operation!

## Resolution

If you are experiencing explicit misplaced SPNs, you might have to create or recreate the SPN for the service. Follow these steps to create or recreate the SPN using the `SETSPN` command:

1. Use the `SETSPN -L domain\svcacct` command to list SPNs on the SQL Server service account.
1. Use the `SETSPN -Q spnName` command to find what service account the SPN is registered on.
1. Use the `SETSPN -D` command to delete the SPN from the service.
1. Use the `SETSPN -A` command to add the SPN to the service.
1. Move the SPN using `SETSPN -D` and or choose an SPN that's already present in the correct account.
