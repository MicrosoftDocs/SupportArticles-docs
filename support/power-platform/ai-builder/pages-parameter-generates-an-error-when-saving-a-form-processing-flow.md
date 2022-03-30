---
title: Pages parameter generates an error when saving a form processing flow
description: 
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
ms.subservice: 
---

# Pages parameter generates an error when saving a form processing flow

This article provides a solution to an error that Pages parameter generates when saving a form processing flow.

_Applies to:_ &nbsp; Power Automate


## Symptoms

"error message “Flow save failed with code 'WorkflowOperationParametersExtraParameter' and message 'The API operation does not contain a definition for parameter 'item/requestv2/pages'.'”"


## Cause

when saving a form processing flow with Pages parameter specified, it means your model needs to be republished. 


## Resolution

To solve that issue, go to your model's page in AI Builder, unpublish and republish your model.

