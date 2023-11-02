---
title: Fields couldn't be loaded for this document error in a document processing model
description: Provides a resolution for the error that occurs when fields couldn't be loaded in a document processing model.
ms.reviewer: angieandrews
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: 
ms.author: angieandrews
author: v-aangie
---

# Fields couldn't be loaded for this document error in a document processing model

This article provides a solution to an error that occurs when fields couldn't be loaded for a document in a document processing model.

_Applies to:_ &nbsp; Power Automate, Power Apps

## Symptoms

You receive the following error message while you're creating a model:

> Fields could not be loaded for this document

## Cause 1

This might be a temporary error, like poor internet connectivity.

## Resolution for cause 1

You can try again by selecting **Retry**.

## Cause 2

The document you're trying to select fields from is too large.

## Resolution for cause 2

If it’s a PDF with multiple pages, split the PDF documents with only the pages you need the model to recognize and upload the reduced document that has been split instead. If it’s an image, reduce its dimensions and upload it to your model to replace the previous image uploaded.

## Resources

For more information, see [Requirements and limitations for a document processing model](/ai-builder/form-processing-model-requirements).
