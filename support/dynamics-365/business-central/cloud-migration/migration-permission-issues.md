---
title: Troubleshoot permission issues in Business Central cloud migration
description: Troubleshooting article for permission issues in Business Central cloud migration
ms.author: jswymer 
ms.reviewer: jswymer 
ms.topic: troubleshooting 
ms.date: 04/18/2024
---

# Troubleshoot permission issues in Business Central cloud migration

This article explains how to diagnose and fix problems that you might encounter when you try to set up cloud migration.

## Prerequisites

## Symptoms

The symptom can be one of the following:

- **Operation on target NotifyBusinessCentral failed: Invoking Web Activity failed with HttpStatusCode - '500': A user setting up Cloud Migration does not have enough permissions: either not a Delegated Admin, or a Delegated Admin without a customer consent.**
- **You do not have permission to create or run scheduled tasks**

## Cause

The user who runs the cloud migration setup has insufficient permissions.

## Resolution

- Make sure the user running the setup is assigned the SUPER permission set in Business Central online. 
- If the user running the setup is a delegated admin, make sure that the customer has consented.

For more information, see [Run cloud migration setup](/dynamics365/business-central/dev-itpro/administration/migration-setup.md).