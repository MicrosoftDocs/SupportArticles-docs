---
title: Error when uninstalling a managed solution
description: Discusses an issue that occurs when you try to uninstall a managed solution.
ms.reviewer: kenakamu, chanson
ms.topic: troubleshooting
ms.date: 
---
# The object you tried to delete is associated with another object and cannot be deleted error when you try to uninstall a managed solution in Microsoft Dynamics CRM

This article provides a solution to an error that occurs when you try to uninstall a managed solution in Microsoft Dynamics CRM.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2503016

## Symptoms

When you try to uninstall a managed solution in Microsoft Dynamics CRM, you receive the following error message:

> The object you tried to delete is associated with another object and cannot be deleted

However, it's difficult to determine which object is the object to which the error message refers. The CRM Platform Trace log provides no details.

For example, this issue may occur in either of the following scenarios:

- You have a managed solution installed that includes Article Template.
- You have article records in the system that refer to the Article Temple in the managed solution.

## Cause

Article Template in the solution isn't an entity but a record. So the dependency is record level, not entity level. In this case, dependency tracking doesn't work, and a cascading error occurs instead.

By default, Article Template and Article have a 1:N relationship as Restrict for Cascade Delete. Which prevents the deletion of an Article Template record from the system if the template is referred to by any article records.

## Resolution

If you can't uninstall a managed solution because of this error, you should check the record type of the solution components inside the solution and check whether any of your records refer to those components. To resolve the reference, you may have to delete or to modify the record that is associated with the solution component and then try to uninstall the solution again.

## More information

Similar issues will occur with other kinds of solution components, such as the following ones:

- Other template types
- Microsoft Knowledge Base articles
- Web resources
- Process (Child Process)
