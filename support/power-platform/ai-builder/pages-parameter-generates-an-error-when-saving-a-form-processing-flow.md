---
title: Pages parameter generates an error when saving a document processing flow
description: Provides a resolution for the error that occurs when you save a document processing flow together with the Pages parameter.
ms.reviewer: angieandrews
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: 
ms.author: angieandrews
author: v-aangie
---

# Pages parameter generates an error when saving a document processing flow

This article provides a solution to an error that the **Pages** parameter generates when saving a document processing flow.

_Applies to:_ &nbsp; Power Automate

## Symptoms

When you try to save a document processing flow by using the **Pages** parameter, you receive the following error message:

> Flow save failed with code 'WorkflowOperationParametersExtraParameter'  
> The API operation does not contain a definition for parameter 'item/requestv2/pages'

## Cause

When saving a document processing flow with the **Pages** parameter specified, it means your model needs to be republished.

## Resolution

To solve this issue, go to your model's page in AI Builder, unpublish, and republish your model.

## Resources

To learn more, go to [Publish your model in AI Builder](/ai-builder/publish-model).
