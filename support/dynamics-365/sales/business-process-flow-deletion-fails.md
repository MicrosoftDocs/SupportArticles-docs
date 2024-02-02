---
title: Business Process Flow deletion fails
description: Provides a solution to an issue where Business Process Flow deletion fails because of dependency.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-other-functionality
---
# Business Process Flow deletion fails because of an unknown dependency

This article provides a solution to an issue where Business Process Flow deletion fails because of dependency.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4527365

## Symptoms

When trying to delete a business process flow, sometimes the operation fails because of dependency. However, when end user selects the dependency list, it shows no entry.

## Cause

For each business process flow, there's a backend bpf entity. When business process flow gets deleted, the bpf entity would be deleted as well.

It's possible for dependencies to exist between the BPF entity and other components in the system(for example, a lookup field on Account refers to the BPF entity). In such cases, an attempt to delete a BPF will fail because of such dependencies blocking the delete operation.

## Resolution

End user can check whether such dependency exists for the bpf entity. If so the dependency needs to be resolved before deleting the BPF.
Steps:

1. Navigate to **Settings** -> **Customization**, and then to the BPF entity. Try deleting the BPF entity. The deletion will fail as expected, but at this point, you'll be presented with a list of dependencies that need to be resolved before deletion is allowed.
2. Resolve these dependencies.
3. Try to delete the business process flow again.
