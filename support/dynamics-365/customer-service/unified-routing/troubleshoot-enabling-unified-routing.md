---
title: Troubleshoot failures in enabling of unified routing
description: Learn how to troubleshoot when enabling of unified routing fails in Dynamics 365 Customer Service.
author: hbarik
ms.author: hbarik
ms.reviewer: nenellim
ms.topic: troubleshooting
ms.collection: 
ms.date: 09/22/2025
ms.custom: bap-template
---

# Troubleshoot failures in enabling of unified routing

This article provides a resolution for the issue where provisioning of unified routing fails and displays an error message. The failure might be due to various causes, and we provide a set of guidelines for you to troubleshoot this error. 

## Symptoms

When you attempt to turn on the unified routing toggle, one of the following error messages appears:

- "Unified routing provisioning failed due to issues in configuration..."
- "Unified routing provisioning failed due to an error in deactivation of basic routing rulesets..."
- "Unified routing provisioning failed due to an error in activation of basic routing rulesets..."

## Cause 1

If you're already using basic routing, issues might occur when you activate or deactivate a routing rule set or modify permissions on them. 

## Resolution 1

- Check the owner of all the basic routing rulesets. If the owner user doesn't have access, then enable the user or update the owner of the basic routing rule set to an active user.  

  Learn more in [Automatically route cases using basic routing rulesets](/dynamics365/customer-service/administer/create-rules-automatically-route-cases).

## Cause 2

One of the following issues can cause a failure in enabling unified routing.

- During a copy from an existing org, the decision contract is added in the target org but the related records are missed. When the system tries to [create a master entity routing configuration for the Case table](/dynamics365/customer-service/administer/set-up-record-routing#configure-unified-routing-for-records) during provisioning, it fails because of the missing related records.
- When you create the Case master entity record configuration with the same name (new_incidentmasterentityroutingconfiguration) before triggering the provisioning.

## Resolution 2

1. Delete the record of type msdyn_decisioncontract with the following attributes from your Dataverse instance.

   - **msdyn_name**: Case decision ruleset
   - **msdyn_uniquename**: new_incidentmasterentityroutingconfiguration

1. Try to provision again.

  Learn more in [Delete record](/power-apps/developer/model-driven-apps/clientapi/reference/xrm-webapi/deleterecord).

### Related information

[Enable unified routing in Dynamics 365 Customer Service](/dynamics365/customer-service/administer/provision-unified-routing)  
