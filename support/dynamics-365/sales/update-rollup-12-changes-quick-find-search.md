---
title: Update Rollup 12 changes quick find search behavior
description: This article provides a resolution for the problem that occurs after applying Update Rollup 12 to the Microsoft Dynamics CRM 2011 Outlook client. 
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Update Rollup 12 changes quick find search behavior in the Microsoft Dynamics CRM Outlook client

This article helps you resolve the problem that occurs after applying Update Rollup 12 to the Microsoft Dynamics CRM 2011 Outlook client.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2822860

## Symptoms

After applying Update Rollup 12 to the Microsoft Dynamics CRM 2011 Outlook client, the following issues occur when performing a quick find search:

- The filters of the current view are being ignored after performing the search.
- The columns that are displayed in the view are changing after performing the search.

## Cause

1. The quick find search is using the filters from the quick find view as opposed to the current view.
1. The quick find search is using the view columns from the quick find view as opposed to the current view.

## Resolution

This is by design and was introduced with Update Rollup 12.

1. In order to retrieve filtered quick find results, modify the Filter Criteria of the entity's quick find view.
    1. To do this, click on **Settings**, point to **Customizations**, and click **Customize the System**.
    1. Select and expand the entity from the Entities expansion list and click **Views**.
    1. Open the **Quick Find View** for that entity and select **Edit Filter Criteria**.
    1. Once the changes have been made, click **OK** and then **Publish Customizations**.
2. To specify what columns are displayed by the quick find search, modify the View Columns of the entity's quick find view.
    1. To do this, click on **Settings**, point to **Customizations**, and click **Customize the System**.
    1. Select and expand the entity from the Entities expansion list and click **Views**.
    1. Open the **Quick Find View** for that entity and select **Add Find Columns**.
    1. Once the changes have been made, click **OK** and then **Publish Customizations**.
