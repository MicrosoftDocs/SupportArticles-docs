---
title: Troubleshoot "The EXECUTE (or SELECT) permission was denied on the object"
description: Troubleshooting article for EXECUTE (or SELECT) permission issues in Business Central cloud migration
ms.author: jswymer 
ms.reviewer: jswymer 
ms.topic: troubleshooting 
ms.date: 04/18/2024
---

# Troubleshoot "The EXECUTE (or SELECT) permission was denied on the object"

## Prerequisites

## Symptom

The symptom can be one of the following:

- **The EXECUTE (or SELECT) permission was denied on the object**
- **User does not have permission to perform this action**

## Cause

The SQL login account used by self-hosted integration runtime to access on-premises database doesn't have the required SQL roles.

## Resolution

Make sure that SQL user that's specified in the Self-hosted Integration Runtime connection string has the following roles on the on-premises database:

- sysadmin server-level role
- db_owner database role

