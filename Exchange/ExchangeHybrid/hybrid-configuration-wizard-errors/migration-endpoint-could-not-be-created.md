---
title: HCW8078 - Migration Endpoint could not be created
description: Description here
ms.author: batre
ms.date: 06/03/2026
author: Batre-MSFT
---

# HCW8078 - Migration endpoint can't be created

When you run the Hybrid Configuration Wizard (HCW), the wizard fails with the error "HCW8078 - Migration Endpoint can't be created". This article helps you resolve this error so that you can complete the hybrid configuration between Exchange On-Premises and Exchange Online.

## Symptoms

HCW fails with the error message "HCW8078 - Migration Endpoint could not be created".

:::image type="content" source="media/migration-endpoint-could-not-be-created/hcw-error.png" alt-text="Screenshot of the Office 365 Hybrid Configuration Wizard with the error.":::

If you open the logging folder, you might see the following error:

```
MigrationServerAvailability': |Microsoft.Exchange.Management.Migration.MigrationConnectionTestedTooRecentlyException|The last connection attempt happened too recently. Please wait until <time stamp> before trying to connect to an endpoint.
```

## Cause

The error indicates that the GRAPH endpoint is throttling requests from the HCW application.

## Solution 1: Create the migration endpoint by using Exchange Online PowerShell

Use this solution if you're in the process of migration and want to create the migration endpoint.

Connect to Exchange Online PowerShell and create the migration endpoint. You can use the syntax from the examples provided [here](https://aka.ms/MEP).

:::image type="content" source="media/migration-endpoint-could-not-be-created/commandtocreateendpoint.png" alt-text="Screenshot of Exchange Online PowerShell command to create a new migration endpoint for an Exchange server.":::

## Solution 2: Re-run HCW and skip the Migration Endpoint option

Use this solution if you're not doing any migrations from or to Exchange On-Premises to Exchange Online.

1. Re-run HCW. At the option selection, select **Choose Exchange Hybrid Configuration** and select **Next**.

   :::image type="content" source="media/migration-endpoint-could-not-be-created/hybrid-options.png" alt-text="Screenshot of the Office 365 Hybrid Configuration Wizard configuration page showing options for Full and Modern Hybrid Topologies.":::

1. Uncheck the **Migration Endpoint** option and select **Next**.

   :::image type="content" source="media/migration-endpoint-could-not-be-created/uncheck-migration-endpoint.png" alt-text="Screenshot of the Office 365 Hybrid Configuration wizard showing Migration Endpoint option unchecked":::

1. Select the rest of the configuration as required and complete the wizard.

   :::image type="content" source="media/migration-endpoint-could-not-be-created/hcw-success.png" alt-text="Screenshot of the successful configuration of hybrid configuration wizard.":::