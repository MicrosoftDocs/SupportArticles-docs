---
title: Troubleshoot Work Item Integration Issues in Application Insights
description: Provides general recommendations and specific suggestions for issues with work item integration in Application Insights.
ms.date: 10/28/2025
ms.service: azure-monitor
ms.custom: sap:Application Insights portal experiences
---
# Troubleshoot work item integration issues in Application Insights

[Work item integration](/azure/azure-monitor/app/work-item-integration) in Application Insights might not work as expected. This article offers general recommendations and specific troubleshooting steps.

## Create work item doesn't appear in end-to-end transaction details

First, create a template or start with **Start with a workbook template** from the **Create a work item** flow.

## On-premises Azure DevOps URL is rejected

To match your host, update the workbook's repository URL text parameter and its validation rule (regular expression).

## Authorization prompt doesn't appear or linking fails

Confirm that popup blockers are disabled for the Azure portal and that your browser allows third-party cookies. Then try linking again.

## Work item creation fails with permission errors**

Verify that your Azure DevOps or GitHub account has permission to create issues or work items in the selected repository or project. You might need **Contribute** (DevOps) or **Write** (GitHub) permissions.

## Template fails to load or save

Ensure the selected region supports the `Microsoft.Insights/workbooks` resource type and that your role includes `Microsoft.Insights/workbooks/write`. Try saving in a different region if necessary.

## Contextual data missing from created work items

Check that the Kusto Query Language (KQL) section of the workbook template returns data in the expected schema. If fields were renamed or the resource ID changed, update the query or bindings.

## Template not visible to other users

Workbook-based templates are stored as Azure resources. Ensure the resource is in a shared resource group and that other users have at least **Reader** access to that resource.

## Template deletion doesn't remove existing links

Removing the workbook doesn't automatically clear cached configuration. Refresh the **Work Items** blade in Application Insights or clear your browser cache to update the list.

## GitHub issue or DevOps item opens in wrong repository/project

Open the workbook and confirm the default repository or organization URL parameter is set correctly. If you have multiple templates, check which is currently linked to the resource.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
