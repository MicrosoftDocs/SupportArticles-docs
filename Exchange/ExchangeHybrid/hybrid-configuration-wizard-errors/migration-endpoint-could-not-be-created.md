---
title: HCW8078 error - Migration Endpoint could not be created
description: Discusses the error in the HCW when the creation of a migration endpoint fails and provides resolutions.
author: cloud-writer
ms.author: meerak
ms.reviewer: dcscontentpm
ms.topic: troubleshooting
ms.custom: Exchange Hybrid
ms.date: 10/19/2026
ai-usage: ai-assisted
---

# HCW8078 error - Migration endpoint can't be created

## Summary

This article describes the HCW8078 error that you might experience when you run the Hybrid Configuration Wizard (HCW). The article explains the cause of the error and provides options to resolve it.

## Symptoms

When you run the Hybrid Configuration Wizard (HCW), migration endpoint creation can fail with the following error:

> `HCW8078 - Migration Endpoint can't be created`. 

:::image type="content" source="media/migration-endpoint-could-not-be-created/hybrid-configuration-wizard-error.png" alt-text="Screenshot of the Office 365 Hybrid Configuration Wizard with the error.":::

Also you might see the following error in the logs:

> `MigrationServerAvailability': |Microsoft.Exchange.Management.Migration.MigrationConnectionTestedTooRecentlyException|The last connection attempt happened too recently. Please wait until <time stamp> before trying to connect to an endpoint.`

## Cause

The migration service throttles concurrent or closely spaced calls to the `New-MigrationEndpoint` command.

## Resolution

Use one of the following methods, as appropriate, to create the migration endpoint.

### Method 1: Use the latest version of the HCW

Download the latest version of the HCW from <https://aka.ms/HybridWizard>.

The HCW automatically retries creating a migration endpoint when the error occurs. It waits for the service-recommended time which is usually between 15 seconds and two minutes before retrying and then displays a retry message.  

<a id="solution-1-create-the-migration-endpoint-by-using-exchange-online-powershell"></a>

### Method 2: Use Exchange Online PowerShell

Use this method if the HCW is unable to create the migration endpoint even after retrying.

Connect to Exchange Online PowerShell and use the syntax from these [examples](https://aka.ms/MEP) to create the migration endpoint. 

:::image type="content" source="media/migration-endpoint-could-not-be-created/command-to-create-endpoint.png" alt-text="Screenshot of Exchange Online PowerShell command to create a new migration endpoint for an Exchange server.":::
