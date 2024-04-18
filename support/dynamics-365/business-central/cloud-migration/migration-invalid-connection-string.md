---
title: Troubleshoot "Invalid database connection string provided"
description: Troubleshooting article for invalid database connection string issues in Business Central cloud migration.
ms.author: jswymer 
ms.reviewer: jswymer 
ms.topic: troubleshooting 
ms.date: 04/18/2024
---

# Troubleshoot "Invalid database connection string provided"

This article explains how to troubleshoot the **Invalid database connection string provided** error in Business Central cloud migration.

## Prerequisites

## Symptom

The symptom is the following error message:

- **Invalid database connection string provided**

This issue often appears together with the **Keyword not supported:**  or  **Value cannot be null** error.

## Cause

The wrong SQL connection string was configured in the **Cloud Migration Setup** guide.

## Resolution

Run the **Cloud Migration Setup** guide again and verify the connection string is correct. For more information, see [Define the SQL Connection](/dynamics365/business-central/dev-itpro/administration/migration-setup.md).
