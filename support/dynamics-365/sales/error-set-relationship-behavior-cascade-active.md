---
title: Error when you set Relationship Behavior to Cascade Active
description: This article provides a resolution for the problem that occurs when you try to set the Relationship Behavior to Cascade Active on certain relationships.
ms.reviewer: kenakamu, chanson
ms.topic: troubleshooting
ms.date: 
---
# You encounter an error when you set Relationship Behavior to Cascade Active on certain relationships

This article provides a resolution for the problem that occurs when you try to set the Relationship Behavior to **Cascade Active** on certain relationships.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2501791

## Symptoms

You encounter an error when you try to set the Relationship Behavior to **Cascade Active** on certain relationships.

> An error has occurred.
Error code: 0x80048204

Platform Traces show the following error:

> Crm Exception: Message: Cascade ActiveOnly is not a valid cascade link type for relationships where the referencing entity has no statecode attribute., ErrorCode: -2147188220

## Cause

This is because the Related Entity does not have StateCode field, like Note (annotation) entity.

## Resolution

This is by design. Please select different types of relationship behavior for cascading.
