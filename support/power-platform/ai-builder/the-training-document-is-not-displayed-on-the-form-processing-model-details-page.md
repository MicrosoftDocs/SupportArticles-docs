---
title: The training document isn't displayed on the form processing model details page
description: 
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
ms.subservice: 
---

# The training document isn't displayed on the form processing model details page

This article provides a resolution about The training document isn't displayed on the form processing model details page issue.

_Applies to:_ &nbsp; Power Automate, Document Processing models


## Symptoms

When you create a form processing model, a preview of one of the training documents appears on the model details page after training is completed. 

## Cause

The training document might not appear if:

You don't have permissions to view training documents.
You aren't the owner of the model.
You imported the model from another environment. 
When you import a form processing model from another environment, the original training data isn't imported with it. Thus, the document preview can't be displayed.



## Resources


- [Limitations](https://docs.microsoft.com/ai-builder/distribute-model#limitations)
- [Roles and Security](https://docs.microsoft.com/ai-builder/security#roles)



