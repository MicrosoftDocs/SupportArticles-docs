---
title: Error when you upgrade to Microsoft Dynamics CRM 2011
description: This article provides a resolution for the problem where you receive an error message after you upgrade to Microsoft Dynamics CRM 2011.
ms.topic: troubleshooting
ms.reviewer: chanson, henningp
ms.date: 
---
# "There was an error with this field's customized event" error when you upgrade to Microsoft Dynamics CRM 2011 and then open forms

This article provides a resolution for the problem where you receive an error message after you upgrade to Microsoft Dynamics CRM 2011.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2494575

## Symptoms

After you upgrade to Microsoft Dynamics CRM 2011 and then open forms of certain entities, you receive an error message that resembles the following:

> There was an error with this field's customized event.
>
> Field:window
>
> Event:onload
>
> Error: 'crmForm.all.tab2Tab.style' is null or not an object.

## Cause

This issue can occur if you use unsupported JScript customizations in Microsoft Dynamics CRM 4.0 that break the form loads in Microsoft Dynamics CRM 2011. Unsupported JScript methods include hiding controls, tabs, or menu items.

## Resolution

To resolve this issue, remove these kinds of customizations and instead use supported methods. The Microsoft Dynamics CRM SDK has a list of new capabilities that replace unsupported methods. Refer to the SDK topic **Upgrade Scripts to Microsoft CRM 2011** for more information about how to replace the old, unsupported methods with the new, supported methods.

## More information

To download the Microsoft Dynamics CRM 2011 SDK, see [Microsoft Dynamics CRM 2011 Software Development Kit (SDK)](https://www.microsoft.com/download/details.aspx?id=24004).

To  download the Microsoft Dynamics CRM 2011 SDK on the Microsoft Developer Network (MSDN), see [Development for Microsoft Dynamics CRM 2015 (CRM SDK)](/previous-versions/dynamicscrm-2015/developers-guide/gg309408(v=crm.7)).

Support assistance with unsupported customizations may be considered billable.
