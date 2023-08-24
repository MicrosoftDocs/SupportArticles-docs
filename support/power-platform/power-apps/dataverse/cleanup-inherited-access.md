---
title: Clean up inherited access
description: Learn how to remove inherited access for records when the cascade configuration of a table changes.
ms.date: 08/23/2023
author: SEOKK-MSFT
ms.author: seokk
ms.reviewer: jdaly
search.audienceType: 
  - developer
search.app: 
  - PowerApps
  - D365CE
contributors: 
  - JimDaly
  - phecke
---
# Clean up inherited access

## Symptoms

After a change in the configuration of a table relationship, users have access to records that they shouldn't.

### Use access checker to verify access to a record

The [check access command](/power-apps/user/access-checker) lets you check  which users have access to a record. Administrators can use the check access command to check individual users who have access to a record or all users who have access to a record.

When using the access checker, you will see a list of reasons why a user has access. Some of these reasons indicate that the sharing was due to access to a related record. For example:

- Record was shared with me because I have access to related record
- Record with shared with team(s) that I'm a member of because the team has access to related record.

If access to the record is unexpected, and the access is provided for these reasons, see the [Resolution](#resolution).

### Use the RetrieveAccessOrigin message to verify access to a record

Developers can use the `RetrieveAccessOrigin` message to detect which users have access to a record. This message returns a sentence describing why the user has the access they do. The following results indicate that the access was due to sharing of a related record:

```
PrincipalId is owner of a parent entity of object (<record ID>)
PrincipalId is member of team (<team ID>) who is owner of a parent entity of object (<record ID>)
PrincipalId is member of organization (<organization ID>) who is owner of a parent entity of object (<record ID>)
PrincipalId has access to (<parent record ID>) through hierarchy security. (<parent record ID>) is owner of a parent entity of object (<record ID>)
```

More information: RetrieveAccessOrigin documentation



## Cause

## Resolution