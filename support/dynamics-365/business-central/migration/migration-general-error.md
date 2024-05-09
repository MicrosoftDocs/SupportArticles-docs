---
title: Failed to enable your replication error
description: Provides a resolution for the Failed to enable your replication error that might occur during Business Central cloud migration.
ms.author: jswymer 
ms.reviewer: jswymer 
ms.date: 05/09/2024
---
# "Failed to enable your replication" error occurs in Cloud Migration Setup

This article solves the error message that occurs when you run the **Cloud Migration Setup** assisted setup guide in Business Central.

## Symptom

When you run the [Cloud Migration Setup assisted setup guide](/dynamics365/business-central/dev-itpro/administration/migration-setup) during the data migration process from on-premises to Business Central online, you receive the following error message:

> Failed to enable your replication. Make sure your integration runtime is successfully connected and try again.

## Cause

There can be several reasons for the error message. But the most common reason is a mismatch between the on-premises version and the online Business Central versions and the **Product Type** chosen in the **Cloud Migration Setup** guide.

## Resolution

Run the **Cloud Migration Setup**, and when you get to the **Choose Your Product** page, make sure the **Product Type** is in accordance with your on-premises and online versions. Business Central version numbers should have the *Major.Minor.Revision.Build* format, such as 20.1.12345.67890.

- If the major versions of the on-premises and online are the same, like *20*.1 for on-premises and *20*.3 for online, choose **Dynamics Business Central current version**.
- If the major versions of the on-premises and online are different, like *14*.3  for on-premises and *20*.3  for online, choose **Dynamics Business Central earlier versions**.

You can run the following SQL query to verify the on-premises database contains correct version number:

```sql
SELECT [applicationversion]
FROM [$ndo$tenantdatabaseproperty]
```
