---
title: Document management features present script errors
description: This article provides a resolution for the problem that occurs after updating the SharePoint List component for compatibility with the Microsoft Dynamics CRM Online December 2012 Service Update or Update Rollup 12.
ms.reviewer: debrau
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# After updating the SharePoint List component, Microsoft Dynamics CRM document management features are unavailable or present script errors

This article helps you resolve the problem that occurs after updating the SharePoint List component for compatibility with the Microsoft Dynamics CRM Online December 2012 Service Update or Update Rollup 12.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2810528

## Symptoms

After updating the SharePoint List component for compatibility with the Microsoft Dynamics CRM Online December 2012 Service Update or Update Rollup 12, users continue to experience script errors or other issues when attempting to access document management features.

## Cause

The previous SharePoint List component needs to be de-activated before installing the updated SharePoint List component.

## Resolution

To resolve the issue, the previous SharePoint List component needs to be deactivated. Then, the updated SharePoint List component can be installed and activated.

1. In SharePoint, click **Site Actions**, and then click **Site Settings**.

2. In Site Settings, under **Galleries**, click **Solutions**.

3. Select the existing **crmlistcomponent** solution and click **Deactivate** from the ribbon.

4. In the **Deactivate Solution** dialog box, click **Deactivate** and then click **Close**.

5. In the **Ribbon**, select **Upload Solution**.

6. In the **Upload Document** dialog box, click **Browse**, and then select the updated crmlistcomponent.wsp file. Click **Ok** and Close the **Solution Gallery** dialog box.

   > [!NOTE]
   > The Modified time column should now reflect the current time.

7. Select the **crmlistcomponent** and click **Activate** from the ribbon.

8. In the **Activate Solution** dialog box, click **Activate** and then click **Close**.

9. Confirm that the updated List Component now reflects a new Modified time and has a Status of Activated.
