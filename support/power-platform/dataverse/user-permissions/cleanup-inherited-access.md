---
title: How to clean up inherited access
description: Introduces how to remove inherited access to records when the cascade configuration of a table changes in Microsoft Dataverse.
ms.date: 04/17/2025
author: paulliew
ms.author: paulliew
ms.reviewer: jdaly
ms.custom: sap:User permissions\User able to access record when not expected
search.audienceType: 
  - developer
search.app: 
  - PowerApps
  - D365CE
contributors: 
  - JimDaly
  - phecke
  - SEOKK-MSFT
---
# How to clean up inherited access

This article introduces how to remove inherited access for records when the cascade configuration of a table changes in Microsoft Dataverse.

## Symptoms

After the [cascading behavior of a table relationship](/power-apps/developer/data-platform/configure-entity-relationship-cascading-behavior#reset-cascade-inherited-access) for the **Reparent** or **Share** action is changed to **No Cascade**, you continue to have access to the related records that should be removed.

## How to verify the access to related records

Users may report that they have unexpected access to records. There are two ways that you can verify the access to the related records: using the **Check Access** feature or the `RetrieveAccessOrigin` message.

#### Use the Check Access feature

Use the [Check Access](/power-apps/user/access-checker) feature in model-driven apps to check who has access to a record. Administrators can use this feature to check individual users or all users who have access to a record.

When using the access checker, you see a list of reasons why a user has access. Some of these reasons indicate that the sharing was granted due to access to a related record. For example:

- Record was shared with me because I have access to related record.
- Record was shared with team(s) that I'm a member of because the team has access to related record.

#### Use the RetrieveAccessOrigin message

Developers can use the `RetrieveAccessOrigin` message to detect which users have access to a record. This message returns a sentence describing why the user has the access. Any of the following results indicate that the access was granted due to the sharing of a related record:

```output
PrincipalId is owner of a parent entity of object (<record ID>)
PrincipalId is member of team (<team ID>) who is owner of a parent entity of object (<record ID>)
PrincipalId is member of organization (<organization ID>) who is owner of a parent entity of object (<record ID>)
PrincipalId has access to (<parent record ID>) through hierarchy security. (<parent record ID>) is owner of a parent entity of object (<record ID>)
```

For more information, see [Determine why a user has access with code](/power-apps/developer/data-platform/security-sharing-assigning#determine-why-a-user-has-access).

## Cause

When the cascading behavior for a table relationship changes, Dataverse starts an asynchronous job to remove the access users were previously granted. However, this job may fail, resulting in users retaining access.

## Resolution

The first step to resolve this issue is to recreate the system job to remove access. If the job fails, a developer can use the `ResetInheritedAccess` message to apply the change to a specified set of records.

### Recreate the system job to remove access

Developers can use the `CreateAsyncJobToRevokeInheritedAccess` message to try creating an asynchronous job again.

#### [SDK for .NET](#tab/sdk)

Use the [Microsoft.Xrm.Sdk.Messages.CreateAsyncJobToRevokeInheritedAccessRequest class](xref:Microsoft.Xrm.Sdk.Messages.CreateAsyncJobToRevokeInheritedAccessRequest).

```csharp
/// <summary>
/// Creates and executes an asynchronous cleanup job to revoke inherited access granted through cascading inheritance.
/// </summary>
/// <param name="service">The authenticated IOrganizationService instance to use.</param>
/// <param name="relationshipSchemaName">The schema name of the entity relationship.</param>
public static void CreateAsyncJobToRevokeInheritedAccessExample(IOrganizationService service, string relationshipSchemaName)
{
    var request = new Microsoft.Xrm.Sdk.Messages.CreateAsyncJobToRevokeInheritedAccessRequest()
    {
        RelationshipSchema = relationshipSchemaName
    };

    service.Execute(request);
}
```

[Learn more about using messages with the SDK for .NET](/power-apps/developer/data-platform/org-service/use-messages?tabs=sdk).

#### [Web API](#tab/webapi)

Use the [CreateAsyncJobToRevokeInheritedAccess action](xref:Microsoft.Dynamics.CRM.CreateAsyncJobToRevokeInheritedAccess).

**Request**:

```http
POST [Organization URI]/api/data/v9.2/CreateAsyncJobToRevokeInheritedAccess
Accept: application/json
Content-Type: application/json; charset=utf-8
OData-MaxVersion: 4.0
OData-Version: 4.0

{
  "RelationshipSchema": "<schema name>"
}
```

**Response**:

```http
HTTP/1.1 204 No Content
OData-Version: 4.0
```

[Learn more about Web API actions](/power-apps/developer/data-platform/webapi/use-web-api-actions).

---

The `CreateAsyncJobToRevokeInheritedAccess` action creates a new asynchronous job named `RevokeInheritedAccess`. You can monitor the success of this job, but there isn't any way to preview the records that will be affected. For more information, see [monitoring system jobs](/power-platform/admin/manage-dataverse-auditing#monitoring-system-jobs) or [managing system jobs with code](/power-apps/developer/data-platform/asynchronous-service#managing-system-jobs).

### Reset inherited access

If [recreating the system job to remove access](#recreate-the-system-job-to-remove-access) fails, a developer with system administrator or system customizer privileges can use the `ResetInheritedAccess` message to target a subset of matching records. You may need to use this message several times to remove access to all the records.

# [SDK for .NET](#tab/sdk)

```csharp
/// <summary>
/// Resets the inherited access for the matching records.
/// </summary>
/// <param name="service">The authenticated IOrganizationService instance to use.</param>
/// <param name="fetchXml">The fetchxml query.</param>
public static void OutputResetInheritedAccess(IOrganizationService service, string fetchXml)
{
    var parameters = new ParameterCollection()
    {
        { "FetchXml", fetchXml}
    };

    var request = new OrganizationRequest()
    {
        RequestName = "ResetInheritedAccess",
        Parameters = parameters
    };

    var response = service.Execute(request);

    Console.WriteLine(response.Results["ResetInheritedAccessResponse"]);
}
```

[Learn more about using messages with the SDK for .NET](/power-apps/developer/data-platform/org-service/use-messages?tabs=sdk).

# [Web API](#tab/webapi)

**Request**:

```http
GET [Organization URI]/api/data/v9.0/ResetInheritedAccess(FetchXml=@fetchXml)?@fetchXml=%3Cfetch%3E%3Centity%20name%3D%22principalobjectaccess%22%3E%3Cattribute%20name%3D%22principalobjectaccessid%22%2F%3E%3Cfilter%20type%3D%22and%22%3E%3Ccondition%20attribute%3D%22principalid%22%20operator%3D%22eq%22%20value%3D%229b5f621b-584e-423f-99fd-4620bb00bf1f%22%20%2F%3E%3Ccondition%20attribute%3D%22objectid%22%20operator%3D%22eq%22%20value%3D%22B52B7A48-EAFB-ED11-884B-00224809B6C7%22%20%2F%3E%3C%2Ffilter%3E%3C%2Fentity%3E%3C%2Ffetch%3E
Accept: application/json  
OData-MaxVersion: 4.0  
OData-Version: 4.0
```

**Response**:

```http
HTTP/1.1 200 OK  
Content-Type: application/json; odata.metadata=minimal  
OData-Version: 4.0  
{
   "@odata.context": "[Organization URI]/api/data/v9.2/$metadata#Microsoft.Dynamics.CRM.ResetInheritedAccessResponse",
   "ResetInheritedAccessResponse": "Resetting the inherited access job is successfully created. ExecutionMode : Sync"
}
```

[Learn more about Web API functions](/power-apps/developer/data-platform/webapi/use-web-api-functions).

---

The `ResetInheritedAccess` message tries to execute synchronously when there aren't many matching records. Then the `ResetInheritedAccessResponse` value ends with `ExecutionMode : Sync`. If there are many matching records, the operation takes longer, and the value ends with `ExecutionMode : Async`. A system job named `Denormalization_PrincipalObjectAccess_principalobjectaccess:<caller ID>` is created, and you can monitor the success of that job. For more information, see [monitoring system jobs](/power-platform/admin/manage-dataverse-auditing#monitoring-system-jobs) or [managing system jobs with code](/power-apps/developer/data-platform/asynchronous-service#managing-system-jobs).

The `ResetInheritedAccess` message requires a FetchXml query to identify the records. This query must meet the following requirements:

- Use the `principalobjectaccess`(POA) table.
- Return only the `principalobjectaccessid` column.
- Must not include any `link-entity` elements. You can't add a join to another table.
- Only filter on columns of the `principalobjectaccess` table.

This table is available to the Web API as the [principalobjectaccess entity type](xref:Microsoft.Dynamics.CRM.principalobjectaccess). It isn't included in the [Dataverse table/entity reference](/power-apps/developer/data-platform/reference/about-entity-reference) because the POA table doesn't support any kind of direct data modification operation. You need to know the columns of this table to compose the FetchXml query.

#### POA table columns

You need to compose a FetchXml query using only these columns.

|Logical name |Type|Description|
|---------|---------|---------|
|`accessrightsmask`|Integer|Contains the combined [AccessRights enum](xref:Microsoft.Dynamics.CRM.AccessRights) member values for the access rights that the principal has directly. |
|`changedon`|DateTime|The last date that the principal's access to the record changed.|
|`inheritedaccessrightsmask`|Integer|Contains the combined [AccessRights enum](xref:Microsoft.Dynamics.CRM.AccessRights) member values for the access rights that are applied due to inheritance.|
|`objectid`|Unique Identifier|The ID of the record that the principal has access to.|
|`objecttypecode`|Integer|The [EntityMetadata.ObjectTypeCode](xref:Microsoft.Xrm.Sdk.Metadata.EntityMetadata.ObjectTypeCode) value that corresponds to the table. This value isn't necessarily the same for different environments. For custom tables, it's assigned based on the order in which the table was created. To get this value, you may need to view the metadata for the table. There are several community tools to find this. Here's a solution from Microsoft: [Browse table definitions in your environment](/power-apps/developer/data-platform/browse-your-metadata).|
|`principalid` |Unique Identifier|The ID of the user or team that has access.|
|`principalobjectaccessid`|Unique Identifier|The primary key of the POA table.|
|`principaltypecode`|Integer|The type code of the principal. `SystemUser` = 8, `Team` = 9.|

The following [AccessRights enum](xref:Microsoft.Dynamics.CRM.AccessRights) member values apply to the `accessrightsmask` and `inheritedaccessrightsmask` columns:

|Access type|Value|Description|
|---------|---------|---------|
|`None`|0|No access.|
|`Read`|1|The right to read a record.|
|`Write`|2|The right to update a record.|
|`Append`|4|The right to append the specified record to another record. |
|`AppendTo`|16|The right to append another record to the specified record. |
|`Create`|32|The right to create a record.|
|`Delete`|65,536|The right to delete a record.|
|`Share`|262,144|The right to share a record.|
|`Assign`|524,288|The right to assign the specified record to another user or team.|

You may see that the `inheritedaccessrightsmask` value is commonly 135,069,719. This value includes all the access types except for `Create`, which isn't necessary because these rights only apply to records already created.

#### FetchXml examples

This section includes some examples of FetchXml queries you might use with the `ResetInheritedAccess` message. For more information, see [Use FetchXML to construct a query](/power-apps/developer/data-platform/use-fetchxml-construct-query).

##### Reset inherited access given to a certain user for a specific account

```xml
<fetch>
    <entity name="principalobjectaccess">
        <attribute name="principalobjectaccessid"/>
        <filter type="and">
            <condition attribute="principalid" operator="eq" value="9b5f621b-584e-423f-99fd-4620bb00bf1f" />
            <condition attribute="objectid" operator="eq" value="B52B7A48-EAFB-ED11-884B-00224809B6C7" />
        </filter>
    </entity>
</fetch>
```

##### Reset inherited access given to all child rows for a specified object type

```xml
<fetch>
    <entity name="principalobjectaccess">
        <attribute name="principalobjectaccessid"/>
        <filter type="and">
            <condition attribute="objecttypecode" operator="eq" value="10042" />
        </filter>
    </entity>
</fetch>
```

##### Reset inherited access given to a specified user for all object types

```xml
<fetch>
    <entity name="principalobjectaccess">
        <attribute name="principalobjectaccessid"/>
        <filter type="and">
            <condition attribute="principalid" operator="eq" value="9b5f621b-584e-423f-99fd-4620bb00bf1f" />
        </filter>
    </entity>
</fetch>
```
