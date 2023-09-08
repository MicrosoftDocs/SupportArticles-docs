---
title: Fields training failed and the model can't be used in a document processing model
description: Provides a resolution for the error that occurs when training failed and the model can't be used in a document processing model.
ms.reviewer: angieandrews
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: 
ms.author: angieandrews
author: v-aangie
---

# Training failed and the model can't be used in a document processing model

This article provides a solution to an error that occurs when training failed and the model can't be used in a document processing model.

_Applies to:_ &nbsp; Power Automate

## Symptoms

You receive the following error message in document processing after you've trained your document processing model:

> Training failed and the model cannot be used

## Cause 1

This is a temporary error.

## Resolution for cause 1

Retry by retraining your model again by selecting **Edit model**.

## Cause 2

The documents that you uploaded for training don’t meet the document processing model requirements.

## Resolution for cause 2

Make sure your document meets the [document processing model requirements](/ai-builder/form-processing-model-requirements).
