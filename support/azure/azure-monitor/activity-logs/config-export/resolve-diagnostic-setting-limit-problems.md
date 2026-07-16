---
title: Resolve diagnostic setting limit problems in Azure
description: Learn how to resolve diagnostic setting limit problems in Azure, including ghost settings and log profiles. Use this article to fix the issue.
ms.date: 03/31/2026
ms.author: kaushika
ms.editor: v-gsitser
ms.reviewer: v-ryanberg 
ms.service: azure-monitor
ms.custom: I can't configure export of Activity Logs
---

# Resolve diagnostic setting limit problems in Azure

## Summary

When you try to add a fifth diagnostic setting in Microsoft Azure, you might encounter a problem in which you can't add the setting because of a non-existent (*ghost*) setting. This problem often comes from a log profile that you have to delete.

### Common problems and causes

- **Problem**: You can't add a fifth diagnostic setting because of a ghost setting.
- **Cause**: The ghost setting is actually a log profile that you have to remove.

### Resolve diagnostic setting limit problems

1. **Identify the ghost setting**

    1. Confirm with the customer that the resource ID that's failing has five diagnostic settings.
    1. Determine whether the issue is specific to one resource or occurs across multiple settings.

1. **Verify resource existence**

    1. Use the Azure Resource Explorer to verify the existence of the resource.
    1. In the [Azure portal](https://portal.azure.com), go to the Resource Explorer to check the resource status.

1. **Delete the ghost setting and confirm deletion**
    
    1. Use the Azure API to delete the log profile that's causing the issue. For detailed instructions, see [Azure API Management](/azure/api-management/).
    1. To confirm the deletion, share the **Resource ID** and **Name** columns with the customer.
    1. Make sure that the customer agrees to the removal of the ghost setting.
   
1. **Verify resolution**
 
    1. Check with the customer to learn whether the issue is resolved after the deletion.
    1. If the problem persists, consider filing an Incident Case Management (IcM) item for further investigation.

### References

- [Azure API Management](/azure/api-management)
