---
title: HCW8078 error - Migration Endpoint could not be created
description: Description here
author: cloud-writer
ms.author: meerak
ms.reviewer: dcscontentpm
ms.topic: troubleshooting
ms.custom: Exchange Hybrid
ms.date: 06/03/2026
---

# HCW8078 error - Migration endpoint can't be created

## Summary

This article describes the HCW8078 error that you might experience when you run the Hybrid Configuration Wizard (HCW). The article explains the cause of the error and provides resolution options to resolve it.

## Symptoms

When you run the Hybrid Configuration Wizard (HCW), it fails with the following error:

> `HCW8078 - Migration Endpoint can't be created`. 

:::image type="content" source="media/migration-endpoint-could-not-be-created/hybrid-configuration-wizard-error.png" alt-text="Screenshot of the Office 365 Hybrid Configuration Wizard with the error.":::

Also you might see the following error in the logs:

> `MigrationServerAvailability': |Microsoft.Exchange.Management.Migration.MigrationConnectionTestedTooRecentlyException|The last connection attempt happened too recently. Please wait until <time stamp> before trying to connect to an endpoint.`

## Cause

The error occurs because the GRAPH endpoint is throttling requests from the HCW application. 

## Resolution

Use one of the following solutions as appropriate for your scenario.

### Solution 1: Create the migration endpoint by using Exchange Online PowerShell

Use this solution if you're in the process of migration and want to create the migration endpoint.

Connect to Exchange Online PowerShell and create the migration endpoint. You can use the syntax from the examples provided [here](https://aka.ms/MEP).

:::image type="content" source="media/migration-endpoint-could-not-be-created/command-to-create-endpoint.png" alt-text="Screenshot of Exchange Online PowerShell command to create a new migration endpoint for an Exchange server.":::

## Solution 2: Rerun HCW and skip the Migration Endpoint option

Use this solution if you're don't have a current migration from or to Exchange on-premises to Exchange Online.

1. Rerun HCW. At the option selection, select **Choose Exchange Hybrid Configuration** and select **Next**.

   :::image type="content" source="media/migration-endpoint-could-not-be-created/hybrid-options.png" alt-text="Screenshot of the Office 365 Hybrid Configuration Wizard configuration page showing options for Full and Modern Hybrid Topologies.":::

1. Uncheck the **Migration Endpoint** option and select **Next**.

   :::image type="content" source="media/migration-endpoint-could-not-be-created/uncheck-migration-endpoint.png" alt-text="Screenshot of the Office 365 Hybrid Configuration wizard showing Migration Endpoint option unchecked":::

1. Select the rest of the configuration as required and complete running the wizard.

   :::image type="content" source="media/migration-endpoint-could-not-be-created/hybrid-configuration-wizard-success.png" alt-text="Screenshot of the successful configuration of hybrid configuration wizard.":::
