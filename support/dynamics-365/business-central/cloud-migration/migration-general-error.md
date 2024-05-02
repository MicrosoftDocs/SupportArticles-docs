---
title: "Failed to enable your replication"
description: Troubleshooting article for general error messages during Business Central cloud migration.
ms.author: jswymer 
ms.reviewer: jswymer 
ms.topic: troubleshooting 
ms.date: 04/24/2024
---

# "Failed to enable your replication"

This error is a general error message that's shown to the user when running the **Cloud Migration Setup** assisted setup guide in Business Central, which is part the data migration process from on-premises to Business Central online. [Learn more about cloud migration setup](/dynamics365/business-central/dev-itpro/administration/migration-setup).

## Symptom

You get the **Failed to enable your replication. Make sure your integration runtime is successfully connected and try again.** error message.

## Cause

There can be several reasons for the error message. But the most common reason is a mismatch between the on-premises version and the online Business Central versions and the **Product Type** chosen in the **Cloud Migration Setup** guide.

## Resolution

Run the **Cloud Migration Setup**, and when you get to the **Choose Your Product** page, make sure the **Product Type** is in accordance with your on-premises and online versions. Business Central version numbers have the format *Major.Minor.Revision.Build*, such as 20.1.12345.67890.

- If the major versions of the on-premises and online are the same, like *20*.1 for on-premises and *20*.3 for online, choose **Dynamics Business Central current version**. 
- If the major versions of the on-premises and online are different, like *14*.3  for on-premises and *20*.3  for online, choose **Dynamics Business Central earlier versions**

You can run the following SQL query to verify the on-premises database contains correct version number:

```sql
SELECT [applicationversion]
FROM [$ndo$tenantdatabaseproperty]
```
