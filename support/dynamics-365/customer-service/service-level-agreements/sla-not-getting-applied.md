---
title: SLA doesn't get applied to a case.
description: Provides a resolution for the issue where SLA doesn't get applied to the case.
ms.reviewer: sdas
ms.author: ravimanne
ms.date: 06/27/2023
---
# SLA doesn't get applied to the case

This article provides a resolution for the issue where SLA doesn't get applied to a case.

## Symptoms

SLA might not be getting applied to a case due the following reasons:
- SLA KPI **Applicable From** field value is null.
- SLA Item **Applicable when** conditions and entity conditions aren't matching.
- If the migration tool fails to update the SLA Item's **Applicable when** condition during migration from legacy to UCI.
- “SdkMessageProcessing steps must be in active state” error.
- The **Disable SLAs** setting in the **Service Configuration Settings** must be set to **No**.
- “Workflow must be in Published state” error or "Action must be in published State" error.
- Unified Interface SLA isn't being applied for backdated **Applicable from** condition and shows the "Empty Calendar schedule. Check if Working Hours are set properly" error.

## Cause

Causes for above mentioned cases, respectively.
- Thw migration tool may fail to set SLA KPI **Applicable From** field value during migration to Unified iNterface (or) if SLA KPI **Applicable From** field is set to some custom field that isn't set to any value.
- SLA Item's **Applicable when** conditions and entity conditions don't match because:
	- String value doesn't match attributes.
	- Different attributes with same name was used in the SLA Items.
	- Option Set values text value is same, but the GUID is different.
- After migration of SLA from legacy to Unified Interface, it may fail to fill the **Applicable when** condition for teh SLA Item.
- SdkMessageProcessing steps might be in **Inactive** state.
- The **Disable SLAs** setting in the **Service Configuration Settings** might be set to **Yes**.
- Workflow might be in **Draft** or **Inactive** state.
- This issue occurs since working hours are available for the specified calendar in SLA Item. If SLA Item Business Hours is configured with a WebClient Calendar.

## Resolution

Steps to resolve the cases, respectively.

- Make sure that SLA KPI **Applicable From** field value isn't set to null. It should set to some value.
- Check SLA Item ** Applicable when** entity conditions and make sure that the follwoing cases don't happen.
	- String value doesn't match attributes.
	- Different attribute with same name was used in SLA Items.
	- Option Set values text value is same, but the GUID is different.
- Make sure that the SLA Item **Applicable when** condition isn't empty after migration from legacy to Unified Interface.
- Activate SdkMessageProcessing steps if they are in **draft or inactive** state.
	- PreOperationIncidentCreateEntitlement (6742a23a-7102-e711-8112-00155db32104)
	- PreOperationIncidentUpdateEntitlement (9e1588ed-62ff-e611-810f-00155db32104)
	- PostOperationIncidentUpdateEntitlement (a468c44e-c204-e711-80ca-02155dc812c3)
	- PostOperationIncidentCreateEntitlement (8fbadfbe-c104-e711-80ca-02155dc812c3)
- Toggle the **Disable SLAs** setting in the **Service Configuration Settings** to **No** in case it's **Yes**.
- Activate the flow for the SLA Item if it's in **Inactive** state. Refer (/sla-modern-flow-not-valid.md) to activate the flow.
- Either create the calendar in UCI and change that in SLA Item, or open the same legacy calendar in Unified Interface and select **Save and Close**.
	[Setting up Calendar](/dynamics365/customer-service/create-customer-service-schedule-define-work-hours)
