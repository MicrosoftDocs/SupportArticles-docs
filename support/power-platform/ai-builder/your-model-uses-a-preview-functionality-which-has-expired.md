---
title: Your model that uses a preview functionality has expired
description: Provides a resolution for an issue where a model that uses a preview functionality has expired, and the issue causes the model to stop functioning.
ms.reviewer: angieandrews
ms.date: 07/03/2023
ms.subservice: 
ms.author: antrod
author: Antrodfr
---
# Your model that uses a preview functionality has expired

Provides a resolution for an issue where a model that uses a preview functionality has expired, which causes the model to stop working.

_Applies to:_ &nbsp; Power Automate, Power Apps, document processing models

## Symptoms

On the model's detail page, a message bar shows indicating that the model that uses a preview functionality has expired.

## Cause

When a model has been created using a preview model template, it could be necessary to retrain the model when the model template becomes generally available.

## Resolution

To solve this issue, select **Edit model** on the model's detail page. Go through the wizard without necessarily making any changes, and retrain the model. 

Make sure to publish the model after training if you want to use it in an app or a flow.

## Resources

For more information, see [Train a document processing model](/ai-builder/form-processing-train).
