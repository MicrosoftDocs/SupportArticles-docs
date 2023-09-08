---
title: Dependency Timeout error when using a document processing model in Power Automate
description: Provides a resolution for the dependency timeout error when you use a document processing model.
ms.reviewer: angieandrews
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: 
ms.author: angieandrews
author: v-aangie
---

# Dependency timeout error when using a document processing model in Power Automate

This article provides a solution to a dependency timeout error when using a document processing model in Microsoft Power Automate.

_Applies to:_ &nbsp; Power Automate

## Symptoms

You get the dependency timeout error "408 - Dependency Timeout".

## Cause

When executing a document processing model in Power Automate, the file you're trying to process might have a high number of pages, or the file size is too large.

## Resolution

Here are some actions that can be done to improve this.

- The timeout limit of document processing, invoice, receipt, and identity actions has increased from 90 seconds to 60 minutes in April 2022. The flows that contain these actions created or saved after April 2022 have the extended timeout limit of 60 minutes. If the flow was created before that date, edit and re-save the flow to extend the timeout limit.
- If the file has multiple pages, reduce the document to just the pages you need to process. You can use the **Page range** input in Power Automate to only process the pages you need.

    For more information, go to [page range](/ai-builder/form-processing-model-in-flow#page-range) in Power Automate.

- Reduce the size of the file.
- Retry after some time. You can configure an automatic retry in the flow after failure loop.
- Be sure to leave a certain time delay interval between each execution after a failure.

The following screenshots show an example of how to set up a retry logic in a cloud flow. Make sure you choose the appropriate settings for when your variable should run. To get to the settings, in your variable heading, select (**...**) > **Configure run after**, select when the variable should run, and then select **Done**.  

:::image type="content" source="media/dependency-timeout-error-when-using-a-form-processing-model-in-power-automate/retry-pattern-ai-builder-example-1.png" alt-text="Screenshot of retry logic in a Power Automate cloud flow example 1." border="false":::

:::image type="content" source="media/dependency-timeout-error-when-using-a-form-processing-model-in-power-automate/retry-pattern-ai-builder-example-2.png" alt-text="Screenshot of retry logic in a Power Automate cloud flow example 2." border="false":::

:::image type="content" source="media/dependency-timeout-error-when-using-a-form-processing-model-in-power-automate/retry-pattern-ai-builder-example-3.png" alt-text="Screenshot of retry logic in a Power Automate cloud flow example 3." border="false":::
