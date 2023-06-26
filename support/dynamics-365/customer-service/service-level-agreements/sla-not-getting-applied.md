---
title: SLA is not getting applied to the Case.
description: Provides a resolution for the issue where SLA is not getting applied to the Case.
ms.reviewer: sdas
ms.author: ravimanne
ms.date: 06/23/2023
---
# SLA is not getting applied to the Case

This article provides a resolution for the issue where SLA is not getting applied to the Case.

## Symptoms

SLA might not get applied to the Case due to multiple reasons, following are few possible cases:
1.	SLAKPI’s applicable from field value is null
2.	SLA Item applicable when conditions and entity conditions not matching.
3.	If it's failed to update the SLA Item's applicable when condition during migration from legacy to UCI.
4.	“SdkMessageProcessing steps must be in active state” error.
5.	The "Disable SLAs" setting in the 'Service Configuration Settings' must be set to No.
6.	“Workflow must be in Published state” error or "Action must be in published State." error.
7.	UCI SLA is not getting applied for backdated applicable from condition and giving error "Empty Calendar schedule. Please check if Working Hours are set properly".


## Cause

Below are the causes for above mentioned cases respectively.
1.	It may fail to set SLAKPI’s applicable from field value after migration from legacy to UCI (or) if SLAKPI’s applicable from field is set to some custom field which is not set to any value.
2.	SLA Item's applicable when conditions and entity conditions are not matching due to
	•	String value not matching for attributes.
	•	Different attribute with same name was used in SLA Items.
	•	Option Set values text value is same, but GUID is different.
3.	After migration of SLA from legacy to UCI, it may fail to fill the applicable when condition for SLA Item.
4.	SdkMessageProcessing steps might be in inactive state.
5.	The "Disable SLAs" setting in the 'Service Configuration Settings' might be set to Yes.
6.	Workflow might be in draft or inactive state.
7.	This issues occurs since working hours are available for the specified calendar in SLA Item. If SLA Item Business Hours is configured with a WebClient Calendar.


## Resolution

To solve this issue, below are steps for resolving above mentioned cases respectively.
1.	Make sure that SLAKPI’s applicable from field value is not set to null, it should set to some value.
2.	Check SLA Item’s applicable when entity conditions and make sure that below cases should not happen.
	•	String value not matching for attributes.
	•	Different attribute with same name was used in SLA Items.
	•	Option Set values text value is same, but GUID is different.
3.	Make sure that SLA Item’s applicable when condition is not empty after migration from legacy to UCI.
4.	Activate below SdkMessageProcessing steps if they are in draft or inactive state
	•	PreOperationIncidentCreateEntitlement (6742a23a-7102-e711-8112-00155db32104)
	•	PreOperationIncidentUpdateEntitlement (9e1588ed-62ff-e611-810f-00155db32104)
	•	PostOperationIncidentUpdateEntitlement (a468c44e-c204-e711-80ca-02155dc812c3)
	•	PostOperationIncidentCreateEntitlement (8fbadfbe-c104-e711-80ca-02155dc812c3)
5.	Toggle the "Disable SLAs" setting in the 'Service Configuration Settings' to No in case it is Yes.
6.	Activate the flow for the SLA Item if it is in inactive state. Please refer (/sla-modern-flow-not-valid.md) to activate the flow.
7.	Either create the calendar in UCI and change that in SLA Item.
	(Or) 
	Open the same legacy calendar in UCI interface and "Save and Close".
	Setting up Calendar: https://docs.microsoft.com/dynamics365/customer-service/create-customer-service-schedule-define-work-hours
	Change Business Hours in SLA Item: https://docs.microsoft.com/dynamics365/customer-service/create-customer-service-schedule-define-work-hours