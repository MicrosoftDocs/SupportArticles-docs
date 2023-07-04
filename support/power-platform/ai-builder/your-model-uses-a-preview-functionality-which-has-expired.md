---
title: Your model that uses a preview functionality has expired
description: Provides a resolution for an issue where a model that uses a preview functionality has expired, and the issue causes the model to stop functioning.
ms.reviewer: angieandrews
ms.date: 07/04/2023
ms.subservice: 
ms.author: antrod
author: Antrodfr
---
# Your model that uses a preview functionality has expired

This article provides a resolution for an issue where a model that uses a preview functionality has expired, which causes the model to stop working.

_Applies to:_ &nbsp; Power Automate, Power Apps, document processing models

## Symptoms

On the model's detail page, a message bar indicates that the model that uses a preview functionality has expired.

## Cause

When a model has been created using a preview model template, it could be necessary to retrain the model when the model template becomes generally available.

## Resolution

1. To solve this issue, select **Edit model** on the model's detail page.

1. Go through the wizard without necessarily making any changes, and retrain the model. 

1. If you want to use the model in an app or a flow, publish it after training.

## Resources

For more information, go to [Train a document processing model](/ai-builder/form-processing-train).
