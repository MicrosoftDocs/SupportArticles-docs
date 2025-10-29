---
title: Troubleshoot Work Item Integration Issues in Application Insights
description: Provides general recommendations and specific suggestions for issues with work item integration in Application Insights.
ms.date: 10/28/2025
ms.service: azure-monitor
ms.custom: sap:Application Insights portal experiences
---
# Troubleshoot work item integration issues in Application Insights

[Work item integration](/azure/azure-monitor/app/work-item-integration) in Application Insights might not work as expected. This article offers general recommendations and specific troubleshooting steps.

## Create work item option missing in transaction details

**Cause:** Integration not enabled or resource not linked to Azure DevOps/GitHub.
**Check:** In Application Insights, go to **Work Items** and confirm integration settings.
**Fix:** Enable integration and ensure you start from **Create a work item** or a workbook template.

## On-premises Azure DevOps URL rejected

**Cause:** URL validation fails due to unsupported format.
**Check:** Ensure the URL uses HTTPS and matches the regex (regular expressions) in the workbook parameter.
**Fix:** Update the workbook's repository URL parameter and validation rule.

> [!NOTE]
> Self-hosted DevOps must be publicly accessible.

## Authorization prompt missing or linking fails

**Cause:** Popup blockers or stale tokens.
**Check:** Disable popup blockers, allow third-party cookies, and clear browser cache.
**Fix:** Retry linking. If using OAuth, confirm required scopes are granted.

## Work item creation fails with permission errors

**Cause:** Insufficient permissions in Azure DevOps or GitHub.
**Check:** Verify account roles:

* Azure DevOps: Needs *Contribute* permission.
* GitHub: Needs *Write* access.

**Fix:** If using PAT (Personal Access Token), ensure it includes **Work Items** (read/write) scope.

## Template fails to load or save

**Cause:** Region or RBAC issues.
**Check:** Confirm region supports *Microsoft.Insights/workbooks* and resource provider is registered.
**Fix:** Assign *Microsoft.Insights/workbooks/write* role or try saving in a supported region.

## Contextual data missing from created work items

**Cause:** KQL query returns unexpected schema.
**Check:** Run the query in **Logs** and validate output fields.
**Fix:** Update bindings or query to match expected schema.

## Template not visible to other users

**Cause:** Workbook saved as private or RBAC restrictions.
**Check:** Ensure template is in a shared resource group and not saved as *My Reports*.
**Fix:** Grant at least *Reader* access to the resource.

## Template deletion doesn't remove existing links

**Cause:** Cached configuration persists.
**Fix:** Refresh the **Work Items** pane or clear browser cache. For persistent links, manually unlink in resource settings.

## GitHub issue or DevOps item opens in wrong repository/project

**Cause:** Incorrect default parameter or multiple templates.
**Check:** Open the workbook and confirm repository/organization URL.
**Fix:** Update defaults or remove conflicting templates.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
