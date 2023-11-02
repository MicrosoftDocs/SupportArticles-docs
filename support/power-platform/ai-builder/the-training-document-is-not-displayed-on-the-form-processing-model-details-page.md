---
title: Training document isn't displayed on the document processing model details page
description: Provides a resolution for the issue that the training document isn't shown on the document processing model details page.
ms.reviewer: angieandrews
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: 
ms.author: angieandrews
author: v-aangie
---

# Training document isn't displayed on the document processing model details page

This article provides a resolution for when the training document isn't displayed on the document processing model details page.

_Applies to:_ &nbsp; Power Automate, document processing models

## Symptoms

When you create a document processing model, a preview of one of the training documents appears on the model details page after training is completed.

## Cause

The training document might not appear in any of the following situations.

- You don't have permissions to view training documents.
- You aren't the owner of the model.
- You imported the model from another environment. When you import a document processing model from another environment, the original training data isn't imported with it. When this happens, the document preview can't be displayed.

## Resolution

Try to resolve this issue by doing the following.

- Make sure you have permissions to view training documents.
- Get co-owner permissions (if allowed).

If your document processing model was imported from another environment, you won't be able to view the original training data.

## Resources

For more information, see:

- [Limitations](/ai-builder/distribute-model#limitations)
- [Roles and security](/ai-builder/security#roles)
