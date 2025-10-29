---
title: Troubleshoot Work Item Integration Issues in Application Insights
description: Provides general recommendations and specific suggestions for issues with work item integration in Application Insights.
ms.date: 10/28/2025
ms.service: azure-monitor
ms.custom: sap:Application Insights portal experiences
---
# Troubleshoot work item integration issues in Application Insights

[Work item integration](/azure/azure-monitor/app/work-item-integration) in Application Insights might not work as expected. This article offers general recommendations and specific troubleshooting steps.

## The "Create work item" option doesn't appear in transaction details

**Cause:** Work item integration isn't enabled or the resource isn't linked to Azure DevOps or GitHub.

**Check:** In Application Insights, go to **Work Items** and confirm that integration settings are configured.

**Fix:** Enable integration and start from the **Create a work item** flow or use a workbook template.

## On-premises Azure DevOps URL rejected

**Cause:** The URL format doesn't meet validation requirements.

**Check:** Ensure the URL uses HTTPS and matches the validation rule in the workbook parameter.

**Fix:** Update the workbook's repository URL parameter and validation rule.

> [!NOTE]
> If using a self-hosted Azure DevOps instance, make sure it is accessible from the Azure portal.

## Authorization prompt doesn't appear or linking fails

**Cause:** Popup blockers or cached tokens may prevent the prompt from appearing.

**Check:** Disable popup blockers, allow third-party cookies, and clear your browser cache.

**Fix:** Retry linking. If using OAuth, confirm that the required scopes are granted.

## Work item creation fails with permission errors

**Cause:** Your account doesn't have sufficient permissions in Azure DevOps or GitHub.

**Check:** Verify account roles:

* Azure DevOps: Needs *Contribute* permission.
* GitHub: Needs *Write* access.

**Fix:** If using a Personal Access Token (PAT), ensure it includes **Work Items (read/write)** scope.

## Template fails to load or save

**Cause:** Region limitations or missing permissions can prevent templates from loading or saving.

**Check:** Confirm that the region supports the *Microsoft.Insights/workbooks* resource type and that the resource provider is registered in your subscription.

**Fix:** Assign the *Microsoft.Insights/workbooks/write* role or try saving the template in a supported region.

## Contextual data is missing from created work items

**Cause:** The Kusto Query Language (KQL) query does not return the expected schema.

**Check:** Run the query in **Logs** and validate the output fields.

**Fix:** Update the query or bindings to match the expected schema.

## Template isn't visible to other users

**Cause:** The template is saved as private or RBAC permissions are insufficient.

**Check:** Ensure the template is stored in a shared resource group and not saved as *My Reports*.

**Fix:** Grant other users at least *Reader* access to the resource.

## Deleting a template doesn't remove existing links

**Cause:** Cached configuration persists after deletion.

**Check:** Refresh the **Work Items** pane in Application Insights or clear your browser cache.

**Fix:** If links persist, manually unlink them in the resource settings.

## GitHub issue or Azure DevOps item opens in the wrong repository or project

**Cause:** Incorrect default parameters or multiple templates override settings.

**Check:** Open the workbook and confirm the default repository or organization URL parameter.

**Fix:** Update defaults or remove conflicting templates.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
