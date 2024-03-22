---
title: Can't edit the Update Application Catalog Tables maintenance task
description: Fixes an issue that occurs when you try to edit the Update Application Catalog Tables maintenance task.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Site Server and Roles\Site Maintenance Tasks
---
# Not found error when you try to edit Update Application Catalog Tables

This article helps you work around an issue in which you receive **Not found** error when you try to edit the **Update Application Catalog Tables** maintenance task.

_Original product version:_ &nbsp; Configuration Manager (current branch - version 2002)  
_Original KB number:_ &nbsp; 4569513

## Symptoms

Consider the following scenario:

- You are running Configuration Manager current branch, version 2002.
- You try to edit the **Update Application Catalog Tables** maintenance task by using the following steps:

  1. In the Configuration Manager console, you go to **Administration** > **Site Configuration** > **Sites**.
  2. You select the site that has the maintenance task that you want to set up, and select the **Maintenance Tasks** tab in the details pane.
  3. You right-click the **Update Application Catalog Tables** maintenance task, and then you select **Edit**.

In this scenario, you receive the following error message:

> Not found  
> \-------------------------------  
> Microsoft.ConfigurationManagement.ManagementProvider.WqlQueryEngine.WqlQueryException
Not found , property = DeviceName
>
> Stack Trace:  
&nbsp; &nbsp;at Microsoft.ConfigurationManagement.ManagementProvider.WqlQueryEngine.WqlResultObjectBase.get_Item(String name)  
&nbsp; &nbsp;at Microsoft.ConfigurationManagement.AdminConsole.SiteMaintenance.TaskGeneral.InitializePageControl()  
&nbsp; &nbsp;at Microsoft.ConfigurationManagement.AdminConsole.SmsPropertyPage.OnInitialize()  
> \-------------------------------

## Workaround

To work around this issue, edit the maintenance task by using the following steps instead:

1. In the Configuration Manager console, go to **Administration** > **Site Configuration** > **Sites**.
2. Select the site.
3. On the **Home** tab, in the **Settings** group, select **Site Maintenance**.

   :::image type="content" source="media/not-found-error-editing-maintenance-task/site-maintenance.png" alt-text="Screenshot of Site Maintenance in the Settings group.":::

4. Select the **Update Application Catalog Tables** maintenance task, and then select **Edit**.

For more information about how to configure maintenance tasks, see [Set up maintenance tasks](/mem/configmgr/core/servers/manage/maintenance-tasks#set-up-maintenance-tasks).
