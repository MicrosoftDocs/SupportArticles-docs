---
title: Troubleshoot user personalization can't be started
description: Learn how to troubleshoot issues with user personalization.
author: SusanneWindfeldPedersen
ms.author: solsen
ms.reviewer: solsen
ms.topic: troubleshooting
ms.date: 02/26/2024
ms.custom: bap-template
---

# Troubleshoot user personalization can't be started

When there are issues preventing the user personalization in Business Central, the user will get an error message, and not be able to start user personalization.

## Prerequisites

You need tenant administrator permissions in Business Central.

## Symptoms

The user sees the following error message "Sorry, something went wrong and personalization could not be started. Please try again later, or contact your system administrator."

## Resolution

Do the following to mitigate the issue. 

> [!NOTE]  
> The following steps will delete records with compilation errors and the specific user personalizations will be deleted. It's recommended to take a screenshot of any personalizations done, before deleting them.

1. In Business Central, in the **Tell Me** box, enter **Personalized Pages**, and then choose the related link.
2. On the **Personalized Pages** page, use the filter pane to show records that belong to the impacted user.
3. Select the **Troubleshoot** button.  
  You'll now get a list of all records that contain errors. These records must be removed to unblock the user from starting user personalization.  
4. Select the **Manage** action to delete the user personalizations with errors.