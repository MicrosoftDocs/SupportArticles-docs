---
title: "Microsoft 365 access has been enabled, but users get a permission error"
description: Troubleshooting article for Microsoft 365 permission error in Business Central.
ms.author: mikebc
ms.reviewer: jswymer
ms.topic: troubleshooting 
ms.date: 04/24/2024
---

# "Microsoft 365 access has been enabled, but users get a permission error"

This article helps you troubleshoot the error message "Microsoft 365 access has been enabled, but users get a permission error" in Business Central.

## Symptoms

Access with Microsoft 365 has been enabled in Business Central admin center, but users get a permission error when accessing any record.

## Cause

If you enable access in the Business Central admin center, but don't assign permissions in the **License Configuration** page, anyone that attempts to access Business Central records in Teams will have their user record provisioned without permission to any objects. Business Central is secure by design: administrators must first configure what data can be accessed in Teams. 

## Resolution

Customizing permissions in the License Configuration page will only affect newly created users. You must also assign the missing permissions to users that have already been created through the Users list page. 