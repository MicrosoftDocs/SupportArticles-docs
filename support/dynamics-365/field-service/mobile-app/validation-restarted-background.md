---
title: Validations have been restarted in the background because of inconsistent validation data
description: Synchronous save event limitation causes error notification in Field Service forms.
ms.author: andreo
author: Andrea-Orimoto
ms.reviewer: mhart
ms.date: 11/20/2023
---

# Validations have been restarted in the background because of inconsistent validation data

Field Service uses the *AsyncJobTracker* pattern to retrieve and cache related records when certain fields are changed on a form. The cached records are used for validation during the *OnSave* event.

## Symptoms

Due to a limitation of a synchronous save event, the system doesn't wait for asynchronous calls. Field Service forms then show the error notification **Validation have been restarted in the background because of inconsistent validation data. Please try again shortly.**

Field Service has validations that require retrieving data from related entities but due to the limitation, it can't block the save to wait for all the asynchronous calls to complete.

The *AsyncJobTracker* pattern is only enabled in offline mode to ensure the changed offline records are validated and can sync back to the server.

If the cached records don't match the current lookup fields, it shows the error message.

## Resolution

There are multiple scenarios that cause this issue to happen. The resolution depends on the scenario.

1. User doesn't have access to the record. For example, if an entity isn't included in the offline profile or the users doesn't have the permission to access the record.

   Make sure the entity is added to the offline profile filters and give the user a security role that has privileges to access the record.

2. Customizations introduce JavaScript logic to update fields but they don't trigger *OnChange* events.

   Use the [fireOnChange](/powerapps/developer/model-driven-apps/clientapi/reference/attributes/fireonchange) attribute when updating lookup fields using custom JavaScript. Optionally, use the setTimeout function to delay the call and allow validations time to complete.

3. In scenarios where the mobile app isn't offline by default, users might be in online mode when they open a form. Then, they go offline while the form is still open. The *AsyncJobTracker* didn't run when the form was in online mode and didn't cache any records. Go online to save the record.