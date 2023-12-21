---
title: Validations have been restarted in the background because of inconsistent validation data error
description: Provides a resolution for an issue where synchronous save event limitation causes an error message in Dynamics 365 Field Service forms.
ms.author: andreo
author: Andrea-Orimoto
ms.reviewer: mhart
ms.date: 12/21/2023
ms.custom: sap:cant-save-data
---
# "Validations have been restarted in the background because of inconsistent validation data" error

This article helps resolve an issue where a synchronous save event limitation causes an error message in Microsoft Dynamics 365 Field Service forms.

## Symptoms

When certain fields on a form are changed, Dynamics 365 Field Service uses the `AsyncJobTracker` pattern to retrieve and cache related records. The cached records are used for validation during the `OnSave` event. Due to a synchronous save event limitation, the system doesn't wait for asynchronous calls. The Dynamics 365 Field Service form then shows the following error message:

> Validations have been restarted in the background because of inconsistent validation data. Please try again shortly.

## Cause

Dynamics 365 Field Service has validations that require retrieving data from related entities. However, due to the limitation, it can't block the save to wait for all the asynchronous calls to complete.

The `AsyncJobTracker` pattern is only enabled in offline mode to ensure the changed offline records are validated and can be synced back to the server.

If the cached records don't match the current lookup fields, you receive the error message.

## Resolution

Multiple scenarios can cause this issue. The resolutions vary depending on the scenario.

- Scenario 1: The user doesn't have access to the record. For example, if an entity isn't included in the offline profile or the user has no permission to access the record.

  To solve this issue, make sure the entity is added to the offline profile filters and the user is granted a security role with the privileges to access the record.

- Scenario 2: Customizations introduce JavaScript logic to update fields, but these updates don't trigger `OnChange` events.

  To solve this issue, use the [fireOnChange](/powerapps/developer/model-driven-apps/clientapi/reference/attributes/fireonchange) attribute when updating lookup fields using custom JavaScript.

  Optionally, use the `setTimeout` function to delay the call and allow time for validations to complete.

- Scenario 3: In scenarios where the mobile app isn't offline by default, users might open a form in online mode. Then, they go offline while the form is still open. The `AsyncJobTracker` doesn't run and doesn't cache any records when the form is in online mode.

  To solve this issue, go online to save the record.
