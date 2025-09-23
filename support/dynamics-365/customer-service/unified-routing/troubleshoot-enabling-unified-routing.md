---
title: Troubleshoot Failures When Provisioning Unified Routing in Dynamics 365
description: Learn how to troubleshoot failures when you provision unified routing in Dynamics 365 Customer Service.
author: hbarik
ms.author: hbarik
ms.reviewer: nenellim
ms.topic: troubleshooting-problem-resolution
ms.collection: 
ms.date: 09/22/2025
ms.custom: sap:Routing Setup\Unable to turn on Unified Routing
---

# Troubleshoot failures when provisioning unified routing

This article provides troubleshooting guidance for issues that occur when you provision [unified routing](/dynamics365/customer-service/administer/overview-unified-routing) in Dynamics 365 Customer Service.

## Symptoms

When you try to [enable the unified routing toggle](/dynamics365/customer-service/administer/provision-unified-routing#enable-unified-routing-for-customer-service-only) in Dynamics 365 Customer Service, the feature is not enabled, and you receive one of the following error messages:

- "Unified routing provisioning failed due to issues in configuration..."
- "Unified routing provisioning failed due to an error in deactivation of basic routing rulesets..."
- "Unified routing provisioning failed due to an error in activation of basic routing rulesets..."

## Cause 1: Issues in basic routing rule sets

If you're already using [basic routing](/dynamics365/customer-service/administer/create-rules-automatically-route-cases), conflicts might occur when you activate or deactivate routing rule sets or modify their permissions.

### Solution

1. Check the ownership of all the basic routing rule sets. If the owner of a rule set no longer has access, either reactivate the user or transfer the ownership of the rule set to an active user.
1. Try again to enable unified routing.

For more information about basic routing rule sets, see [Automatically route cases using basic routing rule sets](/dynamics365/customer-service/administer/create-rules-automatically-route-cases).

## Cause 2: Failures because of master entity routing configuration

During provisioning, the system [creates a master entity routing configuration for the Case table](/dynamics365/customer-service/administer/set-up-record-routing#configure-unified-routing-for-records). This step might fail in the following scenarios:

- During a copy operation from an existing organization, the decision contract is added in the target organization, but the related records are missed. Because the records are missing, the system can't create a master entity routing configuration for the Case table during provisioning.
- You manually create a Case master entity record configuration by using the name `new_incidentmasterentityroutingconfiguration` before you trigger provisioning.

### Solution

1. From your Dataverse instance, delete the record of the `msdyn_decisioncontract` type that has the following attributes:
   - `msdyn_name`: `Case decision ruleset`
   - `msdyn_uniquename`: `new_incidentmasterentityroutingconfiguration`
1. Try again to enable unified routing.

For information about how to delete records in Dataverse, see [Delete record](/power-apps/developer/model-driven-apps/clientapi/reference/xrm-webapi/deleterecord).

## Related information

[Manage unified routing in Dynamics 365 Customer Service](/dynamics365/customer-service/administer/provision-unified-routing)
