---
title: Service Manager console becomes slow after SQL Server upgrade
description: System Center Service Manager console becomes slow after you upgrade to SQL Server 2014 or a later version.
ms.date: 03/14/2024
ms.reviewer: khusmeno
---
# System Center Service Manager Console is slow after SQL Server upgrade

This article helps you fix an issue in which Service Manager console becomes slow after you upgrade to Microsoft SQL Server 2014 or a later version.

_Original product version:_ &nbsp; System Center 2016 Service Manager, System Center 2012 R2 Service Manager  
_Original KB number:_ &nbsp; 4056822

## Symptom

After you upgrade to SQL Server 2014 or a later version of the program, System Center Service Manager console becomes slow.

Additionally, after you add a user to the **Administrators** role, the performance for that user is normal.

## Cause

The issue occurs because Service Manager queries are designed to run against SQL Server 2012 Cardinality Estimator.

## Resolution

First, check the current compatibility level by using the following SQL query:

```sql
Use ServiceManager
Select Name, Compatibility_Level from sys.databases Where name = 'ServiceManager'
```

- If the current compatibility level is **110**, this article doesn't apply to your system.
- If the current compatibility level is higher than 110, use one of the following methods to improve performance.

### Method 1: Change the compatibility level of the ServiceManager database to 110 (SQL Server 2012)

To do this, use the following query:

```sql
ALTER DATABASE ServiceManager
SET COMPATIBILITY_LEVEL = 110
```

### Method 2: Set the existing instance of SQL Server to run with trace flag 9481 to use SQL Server 2012 Cardinality Estimator

To do this, following these steps:

1. Open SQL Server Configuration Manager and select **SQL Server Services**.
2. Right-click the instance of SQL Server that you use, select **Properties**, and then select the **Startup Parameters** tab.
3. Type **-T9481** in the text box, and then select **Add**.

> [!NOTE]
> If you have other databases running in the same instance of SQL Server, the performance of the other databases may be affected.

### Method 3: Change the ServiceManager stored procedure `p_UserRoleSelectAccessToMultipleEntities` by adding `OPTION (QUERYTRACEON 9481)`

To do this, use the following query:

```sql
IF (0 = @ReturnUserRoleInfo)
 BEGIN
       INSERT INTO #BaseManagedEntityWithUserRoleInstanceScope
       SELECT T.[BaseManagedEntityId], T.[UserRoleId], NULL AS [ScopeId]
       FROM
       (
            SELECT E.[BaseManagedEntityId], E.UserRoleId
            FROM #BaseManagedEntityWithUserRoleOperationTypeScope E
            INNER JOIN dbo.[RecursiveMembership] as RM
            ON E.[BaseManagedEntityId] = RM.[ContainedEntityId]
            INNER JOIN #UserRoleWithScope AS L
            ON E.[UserRoleId] = L.[UserRoleId]
            INNER JOIN dbo.[UserRoleGroupType] AS URIS
            ON (URIS.[GroupId] = RM.[ContainerEntityId] OR (URIS.[GroupId] IS NULL))
            AND (URIS.TypeId IS NULL)
            AND (URIS.[ScopeType] = 2 OR URIS.[ScopeType] = 8)
            AND (URIS.[ScopeId] = L.[ScopeId])
            UNION ALL
            SELECT E.[BaseManagedEntityId], E.UserRoleId
            FROM #BaseManagedEntityWithUserRoleOperationTypeScope E
            INNER JOIN dbo.[RecursiveMembership] as RM
            ON E.[BaseManagedEntityId] = RM.[ContainedEntityId]
            INNER JOIN dbo.[TypedManagedEntity] AS TMECONTAINER
            ON RM.[ContainerEntityId] = TMECONTAINER.BaseManagedEntityId
            INNER JOIN dbo.[DerivedManagedTypes] AS DMTCONTAINER
            ON TMECONTAINER.[ManagedTypeId] = DMTCONTAINER.DerivedTypeId
            INNER JOIN #UserRoleWithScope AS L
            ON E.[UserRoleId] = L.[UserRoleId]
            INNER JOIN dbo.[UserRoleGroupType] AS URIS
            ON  (URIS.TypeId = DMTCONTAINER.[BaseTypeId])
            AND (URIS.TypeId IS NOT NULL)
            AND (URIS.[ScopeType] = 2 OR URIS.[ScopeType] = 8)
            AND (URIS.[ScopeId] = L.[ScopeId])
       ) AS T OPTION (QUERYTRACEON 9481)
```

> [!NOTE]
> This method doesn't fix any other SQL queries that may have also been configured to work with SQL Server 2012 Cardinality Estimator.
