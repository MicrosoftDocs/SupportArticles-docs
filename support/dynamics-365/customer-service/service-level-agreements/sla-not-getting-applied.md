---
title: An SLA isn't applied to a case in Dynamics 365 Customer Service
description: Provides a resolution for an issue where an SLA isn't applied to a case in Microsoft Dynamics 365 Customer Service.
ms.date: 08/18/2023
ms.reviewer: sdas, ankugupta
ms.author: sdas
---
# SLA isn't getting applied to a case

This article explains the different scenarios in which a service-level agreement (SLA) might not get applied to a case, and steps to resolve them.

## Scenario 1: Default SLA isn't set

#### Cause

SLAs won't get applied to a case if no default SLA is set.

#### Resolution

Make sure that you set an SLA as the default SLA by taking the following steps:

1. In Customer Service admin center, go to **Service Level Agreements**.
2. Select **Service terms** in **Operations**. The Service terms page appears.
3. In the **Service-level agreements (SLAs)** section, select **Manage**.
4. Select the required SLA and then select the **Set As Default** option from the ribbon.

## Scenario 2: The SLA KPI "Applicable From" field value is null

#### Cause

Migration tool may fail to set the SLA KPI **Applicable From** field value during the [migration to Unified Interface](/dynamics365/customer-service/migrate-automatic-record-creation-and-sla-agreements#migrate-automatic-record-creation-rules-and-service-level-agreements). Or, the SLA KPI **Applicable From** field is set to a custom field that isn't set to any value.

#### Resolution

Make sure that the SLA KPI **Applicable From** field value isn't set to null. It should be set to some values.

## Scenario 3: The SLA item's "Applicable when" conditions and entity conditions don't match

#### Cause

The SLA item's **Applicable when** conditions and entity conditions don't match due to one of the following issues:

- The string value doesn't match for attributes.
- Different attributes with the same name are used in the SLA items.
- The **Option Set** text value is the same, but the GUID is different.

#### Resolution

To solve this issue, check the SLA item's **Applicable when** conditions and entity conditions to make sure the issues mentioned above won't occur.

## Scenario 4: You can't update the SLA item's "Applicable when" condition during the migration from legacy to Unified Interface

#### Cause

After the migration of SLA from legacy to Unified Interface, it may fail to fill the **Applicable when** condition for an SLA item.

#### Resolution

To solve this issue, make sure that the SLA item's **Applicable when** condition isn't empty after the migration from legacy to Unified Interface.

## Scenario 5: The "SdkMessageProcessing steps must be in active state" error occurs

#### Cause

The `SdkMessageProcessing` steps might be in an inactive state.

#### Resolution

To solve this issue, activate the following `SdkMessageProcessing` steps if they're in a draft or inactive state.

- `PreOperationIncidentCreateEntitlement` (6742a23a-7102-e711-8112-00155db32104)
- `PreOperationIncidentUpdateEntitlement` (9e1588ed-62ff-e611-810f-00155db32104)
- `PostOperationIncidentUpdateEntitlement` (a468c44e-c204-e711-80ca-02155dc812c3)
- `PostOperationIncidentCreateEntitlement` (8fbadfbe-c104-e711-80ca-02155dc812c3)

To search for the `SdkMessageProcessing` steps,

1. Navigate to **Customizations**.
2. Select **Customize the System** > **SDK Message Processing Steps**.
3. Search for the `SdkMessageProcessing` steps mentioned above.
4. Select the **Activate** button if the steps are in **Deactivated** state.

## Scenario 6: The "Disable SLAs" in the "Service Configuration Settings" isn't set to "No"

#### Cause

The **Disable SLAs** setting in the **Service Configuration Settings** might be set to **Yes**.

#### Resolution

Check the **Disable SLAs** setting in the **Service Configuration Settings**. If it's set to **Yes** toggle it to **No**. For more information, see [Service Configuration Settings](/power-platform/admin/system-settings-dialog-box-service-tab).

## Scenario 7: The "Workflow must be in Published state" or "Action must be in published State" error occurs

#### Cause

The Workflow might be in a draft or inactive state.

#### Resolution

To solve this issue, activate the flow for the SLA item if it's in an inactive state. For more information about how to activate a flow, see ["Modern flow is not valid for ExecuteWorkflow" error](sla-modern-flow-not-valid.md).

## Scenario 8: The "Empty Calendar schedule. Check if Working Hours are set properly" error occurs

#### Cause

This issue occurs because the SLA item's working hours are associated with a calendar that's configured to use a legacy web client calendar interface. As a result, the SLA isn't applied to the backdated **Applicable From** condition in Unified Interface. You need to check if the SLA item's working hours are configured with a legacy web client calendar.

#### Resolution

To solve this issue, create a calendar in Unified Interface and change it in the SLA item. Or, open the legacy calendar in Unified Interface and then select **Save and Close**. For more information, see [Setting up Calendar](/dynamics365/customer-service/create-customer-service-schedule-define-work-hours).
