---
title: Pages parameter generates an error when saving a form processing flow
description: Cause and resolution for an error that occurs when saving a form processing flow with the pages parameter.
ms.reviewer: angieandrews
ms.topic: troubleshooting
ms.date: 3/31/2021
ms.subservice: 
---

# Pages parameter generates an error when saving a form processing flow

This article provides a solution to an error that the **Pages** parameter generates when saving a form processing flow.

_Applies to:_ &nbsp; Power Automate

## Symptoms

"error message “Flow save failed with code 'WorkflowOperationParametersExtraParameter' and message 'The API operation does not contain a definition for parameter 'item/requestv2/pages'.'”"
<!--Is this all one message? Let's make bold the exact message(s). Start with "You get the message,...-->

## Cause

When saving a form processing flow with the **Pages** parameter specified, it means your model needs to be republished.

## Resolution

To solve this issue, go to your model's page in AI Builder, unpublish, and republish your model. To learn more, go to [Publish your model in AI Builder](/ai-builder/publish-model).

