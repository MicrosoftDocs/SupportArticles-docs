---
title: Price change tracking batch job issues in Dynamics 365 Commerce
description: Resolves batch job issues with the price change tracking feature in Microsoft Dynamics 365 Commerce.
author: leshe
ms.author: leshe
ms.reviewer: josaw, brstor
ms.date: 10/07/2023
---
# Batch job issues with the price change tracking feature

This article provides a resolution for the common issues with price change tracking batch jobs in Microsoft Dynamics 365 Commerce.

## Symptoms

The Microsoft Dynamics 365 Commerce [price change tracking](/dynamics365/commerce/price-change-tracking) feature triggers batch jobs that run in the background. Here are common issues with the batch jobs:

- A price change tracking batch job takes a long time.
- Too many price change tracking batch jobs are triggered and waiting in the queue.

## Resolution

To solve the issues, follow these steps:

#### Step 1: Stop creating more batch jobs

To stop creating more batch jobs, follow these steps:

1. In Commerce headquarters, go to **Retail and Commerce** > **Headquarters setup** > **Parameters** > **Commerce shared parameters** > **Prices and discounts**.
1. Under **Price change tracking**, remove all legal entities from the grid, and then select **Save**.
1. Restart the Application Object Server (AOS).

In general, Microsoft recommends that you [specify a batch group for price change tracking batch jobs](/dynamics365/commerce/price-change-tracking#specify-batch-group-for-price-change-tracking-batch-jobs) prior to enabling the price change tracking feature. This action limits the impact of the price change tracking batch jobs to AOS instances, instead of blocking the default batch job pool.

#### Step 2: Stop and clear existing batch jobs

To stop and clear existing batch jobs, run the following SQL script in the Commerce headquarters database.

```sql
-- find the existing executing jobs
select count(*) from BATCH where CAPTION like '%Price change%' and status = 2 --executing
select count(*) from BATCHJOB where CAPTION like '%Price change%' and status = 2 --executing

-- update the job status (DO NOT update to 0-Hold status; when the batch service restarts, they will be picked up again.) 
update BATCH set STATUS = 3 where CAPTION like '%Price change%' and STATUS = 2 --set to error
Update BATCHJOB set STATUS = 3 where CAPTION like '%Price change%' and STATUS = 2 --set to error

-- clear the jobs
delete from BATCH where CAPTION like '%Price change%' and status = 3 --error
delete from BATCHJOB where CAPTION like '%Price change%' and status = 3 --error
```
