---
title: Your model uses a preview functionality which has expired
description: Provides a resolution for the issue that a model uses a preview functionality which has expired and causes the model to stop functioning.
ms.reviewer: angieandrews
ms.topic: troubleshooting
ms.date: 3/31/2021
ms.subservice: 
ms.author: antrod
author: antrod
---

# Your model uses a preview functionality which has expired

This article provides a resolution for the issue that a model uses a preview functionality which has expired and causes the model to stop functioning.

_Applies to:_ &nbsp; Power Automate, Power Apps, document processing models

## Symptoms

In the model's detail page, a message bar appears indicating that the model uses a preview functionality which has expired.

## Cause

When a model has been created using a preview model template, it could be necessary to retrain the model when the model template becomes generally available.

## Resolution

From the model's detail page, click on **Edit model**. Go through the wizard without necessarily making any changes, and retrain the model. 

Make sure to publish the model after training if you want to use it in a app or a flow.

## Resources

For more information, see:

- [Train a document processing model](/ai-builder/form-processing-train)
