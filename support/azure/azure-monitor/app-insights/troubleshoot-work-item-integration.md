---
title: Troubleshoot Work Item Integration Issues in Application Insights
description: Provides general recommendations and specific suggestions for issues with work item integration in Application Insights.
author: JarrettRenshaw
ms.author: jarrettr
manager: dcscontentpm
ms.topic: troubleshooting
ms.date: 10/28/2025
ms.service: azure-monitor
ms.custom: sap:Application Insights portal experiences
ms.reviewer: v-ryanberg, v-gsitser
---
# Troubleshoot work item integration issues in Application Insights

[Work item integration](/azure/azure-monitor/app/work-item-integration) in Application Insights allows you to create and link work items directly from telemetry data. If this feature isn't working as expected, the following guidance helps you diagnose and resolve common issues.

## The "Create work item" option doesn't appear in transaction details

If you don't see the option to create a work item, it usually means that integration hasn't been enabled or the resource isn't linked to Azure DevOps or GitHub.

**What to do:**

1. In Application Insights, navigate to **Work Items** and confirm that integration settings are configured.
1. Start the process from the **Create a work item** flow or use a workbook template.

## On-premises Azure DevOps URL rejected

This issue occurs when the URL format doesn't meet validation requirements.

**What to do:**

* Make sure the URL uses HTTPS and matches the validation rule in the workbook parameter.
* If you're using a self-hosted Azure DevOps instance, ensure it's accessible from the Azure portal.

## Authorization prompt doesn't appear or linking fails

If you don't see the authorization prompt or linking fails, it can be caused by popup blockers or cached tokens.

**What to do:**

* Disable popup blockers and allow third-party cookies in your browser.
* Clear your browser cache and try linking again.
* If you're using OAuth, verify that the required scopes are granted.

## Work item creation fails with permission errors

Permission errors usually mean your account doesn't have sufficient rights in Azure DevOps or GitHub.

**What to do:**

* For Azure DevOps, ensure you have *Contribute* permissions.
* For GitHub, confirm you have *Write* access to the repository.
* If you're using a Personal Access Token (PAT), make sure it includes the *Work Items (read/write)* scope.

## Template fails to load or save

This problem often occurs due to region limitations or missing permissions.

**What to do:**

* Verify that the region supports the *Microsoft.Insights/workbooks* resource type.
* Check that the resource provider is registered in your subscription.
* Assign the *Microsoft.Insights/workbooks/write* role or try saving the template in a supported region.

## Contextual data is missing from created work items

If the work item doesn't include expected data, the Kusto Query Language (KQL) query might not return the correct schema.

**What to do:**

* Run the query in **Logs** to confirm the output fields.
* Update the query or bindings to match the expected schema.

## Template isn't visible to other users

This usually happens when the template is saved as private or role-based access control (RBAC) permissions are insufficient.

**What to do:**

* Ensure the template is stored in a shared resource group and not saved as *My Reports*.
* Grant other users at least *Reader* access to the resource.

## Deleting a template doesn't remove existing links

Removing a workbook doesn't automatically clear cached configuration.

**What to do:**

* Refresh the **Work Items** pane in Application Insights or clear your browser cache.
* If links persist, manually unlink them in the resource settings.

## GitHub issue or Azure DevOps item opens in the wrong repository or project

This happens when the default repository or organization URL is incorrect or multiple templates override settings.

**What to do:**

* Open the workbook and confirm the default repository or organization URL parameter.
* Remove or update conflicting templates.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
