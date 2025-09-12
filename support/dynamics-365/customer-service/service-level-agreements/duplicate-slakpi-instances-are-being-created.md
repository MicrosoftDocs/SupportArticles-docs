---
title: Duplicate SLA KPI Instances are Created
description: Resolves duplicate SLA KPI instances caused by custom logic, privilege issues, or SLA items ordering in Microsoft Dynamics 365 Customer Service.
ms.reviewer: sdas, ghoshsoham
ms.author: v-heenaattar
ms.date: 03/26/2025
ms.custom: sap:Service Level Agreements
---
# Duplicate SLA KPI instances are created

This article explains how to troubleshoot and resolve the issue of duplicate service-level agreement (SLA) KPI instances in Dynamics 365 Customer Service.

## Symptoms

Duplicate SLA KPI instances might be created in the following scenarios:

- During an [update of the status of SLA KPI instances](/dynamics365/customer-service/use/customer-service-hub-user-guide-case-sla#know-the-status-of-an-sla-kpi-instance-record), multiple SLA KPI instances might be unintentionally created.
- Multiple SLA KPI instances are created simultaneously for the same SLA item, which might occur due to overlapping triggers or misconfigured workflows.

For example, when [an SLA is applied to a record, such as a case](/dynamics365/customer-service/administer/apply-slas), and the SLA includes an SLA item created for the **Resolve By KPI**, only one SLA KPI instance for the **Resolve By KPI** should be created when the conditions defined on the case are met. However, in some scenarios, duplicate SLA KPI instances are created for the **Resolve By KPI**.

## Cause

This issue might be caused by custom logic implemented through plugins, workflows, flows, or actions.

## Resolution

By default, out-of-the-box (OOB) functionality automatically creates SLA KPI instances based on the SLA configuration and conditions defined in the SLA item. To identify the root cause and resolve issues with duplicate SLA KPI instances, check the following customizations and configurations:

- Analyze existing customizations on OOB flows

   1. Review the custom logic implemented in the SLA monitoring flow and SLA item flow.
   1. Identify redundant triggers that might cause duplicate SLA KPI instances.

- Validate custom plugins and workflows

   1. Temporarily disable custom plugins and workflows to see if the issue persists.
   1. If the issue is resolved after disabling custom plugins, revisit and rectify the custom plugin logic that causes the duplication.

- Verify user privilege configuration

  Ensure that user privileges meet the [prerequisites](/dynamics365/customer-service/administer/define-service-level-agreements#prerequisites).

- Verify ordering sequence of SLA items

   1. Review the ordering sequence of SLA items in the SLA configuration.
   1. If duplicate SLA KPI instances are caused by SLA item ordering, reorder the SLA items that cause duplicate SLA KPI instances by moving them to the top of the sequence in the SLA configuration.
