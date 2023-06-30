---
title: An SLA isn't applied to a case
description: Provides a resolution for an issue where an SLA isn't applied to a case.
ms.reviewer: sdas
ms.author: ravimanne
ms.date: 06/30/2023
---
# SLA isn't getting applied to a case

A service-level agreement (SLA) might not get applied to a case. This article explains how to resolve the issue in different scenarios.

## Scenario 1: The SLA KPI Applicable From field value is null

#### Cause

It may fail to set the SLA KPI **Applicable From** field value during the migration to Unified Interface. Or, the SLA KPI **Applicable From** field is set to a custom field that isn't set to any value.

#### Resolution

You should make sure that the SLA KPI **Applicable From** field value isn't set to null. It should be set to some values.

## Scenario 2: The SLA item's Applicable when conditions and entity conditions don't match

#### Cause

The SLA item's **Applicable when** conditions and entity conditions don't match due to one of the following issues:

- The string value doesn't match for attributes.
- Different attributes with the same name are used in the SLA items. 
- The **Option Set** text value is the same, but the GUID is different.

#### Resolution

To solve this issue, check the SLA item's **Applicable when** conditions and entity conditions to make sure the issues mentioned above won't occur.

## Scenario 3: You can't update the SLA item's Applicable when condition during the migration from legacy to Unified Interface

#### Cause

After the migration of SLA from legacy to Unified Interface, it may fail to fill the **Applicable when** condition for an SLA item.

#### Resolution

To solve this issue, make sure that the SLA item's **Applicable when** condition isn't empty after the migration from legacy to Unified Interface.

## Scenario 4: The "SdkMessageProcessing steps must be in active state" error occurs

#### Cause

The `SdkMessageProcessing` steps might be in an inactive state.

#### Resolution

To solve this issue, activate the `SdkMessageProcessing` steps if they're in a draft or inactive state.

- `PreOperationIncidentCreateEntitlement` (6742a23a-7102-e711-8112-00155db32104)
- `PreOperationIncidentUpdateEntitlement` (9e1588ed-62ff-e611-810f-00155db32104)
- `PostOperationIncidentUpdateEntitlement` (a468c44e-c204-e711-80ca-02155dc812c3)
- `PostOperationIncidentCreateEntitlement` (8fbadfbe-c104-e711-80ca-02155dc812c3)

## Scenario 5: The Disable SLAs in the Service Configuration Settings isn't set to No

#### Cause

The **Disable SLAs** setting in the **Service Configuration Settings** might be set to **Yes**.

#### Resolution

To solve this issue, toggle the **Disable SLAs** setting in the **Service Configuration Settings** to **No** in case it's **Yes**.

## Scenario 6: The "Workflow must be in Published state" or "Action must be in published State" error occurs

#### Cause

The Workflow might be in a draft or inactive state.

#### Resolution

To solve this issue, activate the flow for the SLA item if it's in an inactive state. For more information about how to activate a flow, see ["Modern flow is not valid for ExecuteWorkflow" error](sla-modern-flow-not-valid.md).

## Scenario 7: The "Empty Calendar schedule. Check if Working Hours are set properly" error occurs

This issue might occur when a Unified Interface SLA isn't applied for backdated **Applicable From** condition and you receive the "Empty Calendar schedule. Check if Working Hours are set properly" error.

#### Cause

This issue occurs because working hours are available for the specified calendar in an SLA item. You need to check if the SLA item business hours are configured with a web client calendar.

#### Resolution

To solve this issue, create the calendar in Unified Interface and change it in the SLA item. Or, open the same legacy calendar in Unified Interface and then select **Save and Close**. For more information, see [Setting up Calendar](/dynamics365/customer-service/create-customer-service-schedule-define-work-hours).
