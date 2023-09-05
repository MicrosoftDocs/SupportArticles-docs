---
title: Failed to export Business Process
description: Solution export blocked if it contains a business process flow but not its corresponding entity.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# Invalid Export - Business Process Entity Missing

This article provides a solution to an error that occurs when you try to export a solution that contains Business Process Flows but not their corresponding entities.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4337537

## Symptoms

If you try to export a solution that contains Business Process Flows but not their corresponding entities, the export will fail with the following error:

"Failed to export Business Process "\<businessprocessflow_name>" because solution does not include corresponding Business Process entity "\<businessprocessflowentity_name>". If this is a newly created Business Process in Draft state, activate it once to generate the Business Process entity and include it in the solution."

You may also see a reference to error code 80060376.

## Cause

In the December 2016 update for Dynamics 365, Business Process Flow entities were introduced. These entities are backing entities for Business Process Flows and are created when Business Process Flows(BPFs) are first activated. During this entity creation, a dependency is also created between a given BPF and its corresponding entity. It's to enforce that a BPF and its entity are always treated as a pair and there's never a scenario where a BPF can be introduced without its backing entity in to an org. that is on the December 2016 update for Dynamics 365 or above.

The following scenarios typically result in the failure called out above:

### Scenario 1 - BPF in draft state

1. Navigate to **Settings** -> **Processes**
1. Create a BPF and save it. Don't activate it.
1. Add the BPF created in step 1 above to a solution and try to export it. Export will fail.

### Scenario 2 - BPF activated from within solution explorer

1. Navigate **to Settings** -> **Solutions**
1. Create a new solution - SolutionA.
1. From within solution explorer for SolutionA created in step 2. above, create a new BPF from under the Processes node.  
1. Once the BPF is completed, activate it.  
1. Select **Export** to export SolutionA.  
1. Ignore the Missing Dependencies screen you're presented with that will call out the corresponding BPF entity that needs to be added to the solution.  
1. Continue to export SolutionA. Export will fail.

## Resolution

To unblock solution export in the scenarios outlined above, before attempting to export, do the following steps.

### Scenario 1 - BPF in draft state

1. After creating a new BPF, activate it first so that its corresponding entity is generated.

1. Add this BPF to the solution you want to export. Adding the BPF will automatically add its corresponding entity to the solution as a dependency.

1. Export the solution and it should succeed.

### Scenario 2 - BPF activated from solution explorer

1. Manually add the required BPF entity(that is called out explicitly in the Missing Dependencies screen you'll be presented with during solution export) to the solution.
1. Export the solution and it should succeed.
