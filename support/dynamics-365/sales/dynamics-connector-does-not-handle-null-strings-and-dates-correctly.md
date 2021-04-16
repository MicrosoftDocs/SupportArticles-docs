---
title: Dynamics connector handles null strings and dates incorrectly
description: This article describes a problem in the default maps for Microsoft Dynamics CRM, Microsoft Dynamics GP, and the Microsoft Dynamics Connector with regards to null strings and null datetimes.
ms.reviewer: clintwa
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Dynamics connector does not handle null strings and dates correctly for Dynamics CRM and Dynamics GP Adapters

This article provides a resolution for the issue that null strings and null datetimes aren't handled correctly by Microsoft Dynamics Connector.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2562687

## Symptoms

When you use the Microsoft Dynamics Connector with the Microsoft Dynamics CRM and Microsoft Dynamics GP adapters, you experience that nullified values in Microsoft Dynamics CRM for integrated records will result in the value not being nullified in Microsoft Dynamics GP.

## Cause

The following default maps don't contain logic to handle nullified values:

- Microsoft Dynamics CRM Account to Microsoft Dynamics GP Customer (Account to Customer)
- Microsoft Dynamics CRM Contact to Microsoft Dynamics GP Customer (Contact to Customer)

In Microsoft Dynamics CRM, a nullified value won't be provided when requesting data through the Microsoft Dynamics CRM Web Services. Since no value is provided for a mapped field, this in turn results in null value being passed to Microsoft Dynamics GP. Microsoft Dynamics GP treats null as not provided so the associated field in Microsoft Dynamics GP won't be changed.

## Resolution

To resolve this problem, you must update the affected maps. You must update each mapped string and datetime field so that it handles the scenario where a mapped field no longer contains data in Microsoft Dynamics CRM. This can be accomplished by introducing a function in the mapped field. The format of the function would look like the following if the field in question in Microsoft Dynamics CRM was All Addresses\Customer Address\Line 3. For other string fields, you would replace the defined field name with your field name.

> =If(IsDefaultValue(All Addresses\Customer Address\Line 3),"", All Addresses\Customer Address\Line 3)

For datetime fields, the format would look like the following:

> =If(IsDefaultValue(Some Date Field), Date(1900, 1, 1), Some Date Field)

## More information

This problem is being considered for resolution in a future release of the Microsoft Dynamics Connector.
