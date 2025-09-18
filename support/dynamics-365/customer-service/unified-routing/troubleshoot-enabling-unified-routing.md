---
title: Troubleshoot failures in enabling of unified routing
description: Learn how to troubleshoot when enabling of unified routing fails in Dynamics 365 Customer Service.
author: hbarik
ms.author: hbarik
ms.reviewer: nenellim
ms.topic: troubleshooting
ms.collection: 
ms.date: 09/17/2025
ms.custom: bap-template
---

# Troubleshoot failures in enabling of unified routing

This article provides a resolution for the issue where provisioning of unified routing fails and displays an error message. The failure might be due to various causes, and we provide a set of guidelines for you to troubleshoot this error. 

## Symptoms

When you attempt to turn on the unified routing toggle, an error message appears. 

## Cause 1

If you're already using basic routing, issues might occur when you activate or deactivate a routing rule set or modify permissions on them. 

## Resolution 1

- Check whether the routing ruleset belongs to a user who no longer has access.

- Check the owner of all the basic routing rulesets. If the owner user doesn't have access, then enable the user or update the owner of the basic routing rule set to an active user.  

  More information: [Automatically route cases using basic routing rulesets](/dynamics365/customer-service/administer/create-rules-automatically-route-cases)

## Cause 2

The system creates a master entity routing configuration for the Case table as part of provisioning that might fail in copied orgs due to missing related records, or when the customer creates the Case master entity record configuration with the same name before triggering provisioning.

## Resolution 2

- Delete the record and try to provision again.

- Delete the record of type msdyn_decisioncontract with the following attributes from your Dataverse instance to complete the provisioning of unified routing successfully.

  - **msdyn_name**: Case decision ruleset
  - **msdyn_uniquename**: new_incidentmasterentityroutingconfiguration

  Learn more in [Delete record](/power-apps/developer/model-driven-apps/clientapi/reference/xrm-webapi/deleterecord).

### Related information

[Enable unified routing in Dynamics 365 Customer Service](/dynamics365/customer-service/administer/provision-unified-routing)  