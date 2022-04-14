---
title: Fields couldn't be loaded for this document error in a form processing model
description: Causes and resolutions for an error that fields could not be loaded in a form processing model.
ms.reviewer: angieandrews
ms.topic: troubleshooting
ms.date: 3/31/2021
ms.subservice: 
---

# Fields couldn't be loaded for this document error in a form processing model

This article provides a solution to an error that occurs when fields couldn't be loaded for a document in a form processing model.

_Applies to:_ &nbsp; Power Automate

## Symptoms

You get the error message, **Fields could not be loaded for this document** while you are creating a model.

## Cause 1

This might be a temporary error, like poor internet connectivity.

## Resolution for cause 1

You can try again by selecting **Retry**.

## Cause 2

The document you're trying to select fields from is too large.

## Resolution for cause 2

If it’s a PDF with multiple pages, split the PDF documents with only the pages you need the model to recognize and upload the reduced document that has been split instead. If it’s an image, reduce its dimensions and upload it to your model to replace the previous image uploaded.

## Resources
[Requirements and limitations for a form processing model](https://docs.microsoft.com/ai-builder/form-processing-model-requirements)
