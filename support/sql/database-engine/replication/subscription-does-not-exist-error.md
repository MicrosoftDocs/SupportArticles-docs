---
title: The subscription does not exist error occurs
description: This article provides a workaround for the subscription does not exist error that occurs when a distributor primary replica fails over to a replica that does not use the same agent profile.
ms.date: 07/22/2020
ms.custom: sap:Replication, change tracking, change data capture
ms.reviewer: akbarf, liweiyin
---
# The subscription does not exist when a distributor primary replica fails over to a replica that does not use the same agent profile

This article helps you work around the **The subscription does not exist** error that occurs when a distributor primary replica fails over to a replica that does not use the same agent profile.

_Original product version:_ &nbsp; SQL Server 2017 Developer, SQL Server 2017 Enterprise, SQL Server 2017 Enterprise Core  
_Original KB number:_ &nbsp; 4488815

## Symptoms

Consider the following scenario:

- In SQL Server 2017, you have a distribution agent that doesn't use a default agent profile.
- The distribution database is added to the availability group (AG).
- The primary replica of the distribution database fails over to a replica that does not use the exact same agent profile.

In this scenario, the distribution agent fails, and you receive the following error message:

> The subscription does not exist.

## Cause

Agent profiles are managed and persisted in the `msdb` database. Changes to an agent profile are persisted in `msdb` and can't be sent to other distributors in the distribution database AG.

Replication agents are associated with profile through `profile_id`. After a failover, the agent might be unable to find the correct profile. Alternatively, it might find the wrong profile. Because a nondefault profile in one distributor could differ from another distributor, or it may never have existed, or it may have a different `profile_id`.

The distribution agent job issues the `sp_MShelp_distribution_agentid` stored procedure to get the agent ID when it starts. If the profile does not exist, or if the profile IDs are different, the distribution agent job does not get the agent ID, and it returns **the subscription does not exist** error message.

## Workaround

To work around this issue, use one of the following methods:

- Specify the parameters in the distribution agent command directly, instead of using the agent profile. Also, apply the changes to the distribution agent job in all Distributor replicas.

- Make sure that the agent profile is created in all Distributors that are participating in the distribution database in the AG, and make sure that the profile IDs are the same.

The distribution agent runs the `sp_MShelp_distribution_agentid` stored procedure to get the agent profile. If the agent profile does not exist, or if the profile ID is different, the correct agent profile is not found, and the **The subscription does not exist** error message is returned.  

To prevent this issue, specify the correct agent profile (profile ID) in the `sp_MShelp_distribution_agentid` stored procedure.

The following is a code segment of the `sp_MShelp_distribution_agentid` stored procedure:

```sql
SELECT distribAgent.id,
    distribAgent.name,
    distribAgent.publisher_database_id,
    distribAgent.publisher_db,
    distribAgent.subscriber_db,
    profileName.profile_id,
    profileName.profile_name
FROM MSdistribution_agents AS distribAgent
INNER JOIN msdb..MSagent_profiles AS profileName
    ON distribAgent.profile_id = profileName.profile_id
```
