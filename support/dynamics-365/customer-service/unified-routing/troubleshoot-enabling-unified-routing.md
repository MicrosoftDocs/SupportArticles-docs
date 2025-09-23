---
title: Troubleshoot Failures When Enabling Unified Routing in Dynamics 365
description: Learn how to troubleshoot failures when enabling unified routing in Dynamics 365 Customer Service.
author: hbarik
ms.author: hbarik
ms.reviewer: nenellim
ms.topic: troubleshooting-problem-resolution
ms.collection: 
ms.date: 09/22/2025
ms.custom: sap:Routing Setup\Unable to turn on Unified Routing
---

# Troubleshoot failures when provisioning unified routing

This article provides troubleshooting guidance for issues encountered when provisioning [unified routing](/dynamics365/customer-service/administer/overview-unified-routing) in Dynamics 365 Customer Service.

## Symptoms

When you try to [enable the unified routing toggle](/dynamics365/customer-service/administer/provision-unified-routing#enable-unified-routing-for-customer-service-only) in Dynamics 365 Customer Service, the feature fails to enable and one of the following error messages appears:

- "Unified routing provisioning failed due to issues in configuration..."
- "Unified routing provisioning failed due to an error in deactivation of basic routing rulesets..."
- "Unified routing provisioning failed due to an error in activation of basic routing rulesets..."

## Cause 1: Issues with basic routing rulesets

If you're already using [basic routing](/dynamics365/customer-service/administer/create-rules-automatically-route-cases), conflicts might occur when you activate or deactivate routing rule sets or modify their permissions.

### Solution

1. Check the ownership of all the basic routing rule sets. If the owner of a rule set no longer has access, either reactivate the user or update the owner of the rule set to an active user.
2. After correcting any ownership or access issues, try enabling unified routing again.

For detailed information about basic routing rule sets, see [Automatically route cases using basic routing rulesets](/dynamics365/customer-service/administer/create-rules-automatically-route-cases).

## Cause 2: Failures due to master entity routing configuration

During provisioning, the system [creates a master entity routing configuration for the Case table](/dynamics365/customer-service/administer/set-up-record-routing#configure-unified-routing-for-records). This step might fail in the following scenarios:

- During a copy from an existing org, the decision contract is added in the target org, but the related records are missed.
  - When the system tries to create a master entity routing configuration for the Case table during provisioning, it fails because of the missing records.
- You manually create a Case master entity record configuration with the name `new_incidentmasterentityroutingconfiguration` before triggering provisioning.

### Solution

1. Delete the record of type `msdyn_decisioncontract` with the following attributes from your Dataverse instance:
   1. `msdyn_name`: `Case decision ruleset`
   1. `msdyn_uniquename`: `new_incidentmasterentityroutingconfiguration`
1. After deleting the record, try enabling unified routing again.

For information on deleting records in Dataverse, see [Delete record](/power-apps/developer/model-driven-apps/clientapi/reference/xrm-webapi/deleterecord).

### Related information

[Enable unified routing in Dynamics 365 Customer Service](/dynamics365/customer-service/administer/provision-unified-routing)
