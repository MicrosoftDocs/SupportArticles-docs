---
title: Find Power Pages Environment Differences with Site Comparison
description: Troubleshoot Power Pages sites that behave differently across environments by using Site Comparison in the Power Platform Tools extension for Visual Studio Code.
ms.date: 10/08/2026
ms.reviewer: nityagi, nenandw
ms.custom: sap:Site customization or browsing\Visual Studio Code extension
ai-usage: ai-assisted
---
# Troubleshoot Power Pages site configuration differences between environments

## Summary

This article explains how to use **Site Comparison** in the **Power Platform Tools** extension for Visual Studio Code to investigate why two sites, or the same site in two environments, behave differently. Site Comparison finds the Power Pages website configuration differences between the sites so that you can review them as possible causes. This article covers how to choose a baseline, run a full-site or folder-level comparison, interpret the **Added locally**, **Modified**, and **Deleted locally** results, share the results as an HTML or JSON report, and correct the configuration through your application lifecycle management (ALM) process. It also explains which differences Site Comparison doesn't detect, so you know when to continue with another diagnostic path.

> [!IMPORTANT]
> Site Comparison reports differences between your local workspace and a remote Power Pages site. It doesn't determine whether a difference is intentional, or whether it caused the behavior you're investigating. Treat each difference as an investigation lead, and confirm which version is authoritative before you change anything.
>
> Also check that the base language that the site was created in is enabled in the target environment. Site Comparison compares site configuration only, so it doesn't show which languages are enabled in an environment. If the base language isn't available in the target environment, deployments and migrations might fail, or the site might not work as expected. For more information, see [Regional and language options for your environment](/power-platform/admin/enable-languages) and [Migrate Power Pages website configuration](/power-pages/admin/migrate-site-configuration).

## Symptoms

You might encounter one or more of the following issues:

- A page, form, list, template, or navigation element behaves differently in your development, test, or production environment.
- The same user journey works in one environment but fails or renders differently in another.
- Users have access in one environment but receive an authorization error or missing content in another.
- Custom JavaScript, Liquid, CSS, web templates, web files, or content snippets differ across environments.
- A deployment or migration finished successfully, but the target site doesn't match the source site.
- A recently deployed component is missing from the target environment.
- A component that was removed in the source environment still exists in the target environment.
- Production contains a hotfix or a manual change that isn't present in development or in source control.
- Site settings or other environment-specific configuration were overwritten, or weren't configured after deployment.
- The issue started after a solution import, a Power Platform pipeline deployment, a `pac pages upload` operation, a migration, or a direct edit in the target environment.

## Cause

Two Power Pages sites behave differently when their website configuration or code isn't equivalent. The difference might be intentional, or it might result from one of the following conditions:

- Someone edited the configuration in only one environment.
- A component was omitted from the solution or the deployment artifact.
- A deployment was partial or failed.
- A source-controlled change wasn't promoted to the target.
- A deletion in the source wasn't propagated to the target.
- A production-only hotfix was applied.
- The environments intentionally use different site settings or endpoints.
- The sites use different data models, so their configuration is represented differently.
- The local baseline is stale, or the comparison targets a different site, template, or data-model version than you expect.

Not every behavioral difference is caused by website configuration drift. Confirm the difference before you act on it, and see [When Site Comparison isn't enough](#when-site-comparison-isnt-enough) if the configurations match.

## Prerequisites

Set up Visual Studio Code and the extension as described in [Use the Visual Studio Code extension](/power-pages/configure/vs-code-extension) and [Install the Power Platform Tools Visual Studio Code extension](/power-platform/developer/howto/install-vs-code-extension). Then confirm the following items:

- You're using Visual Studio Code Desktop, and the **Power Platform Tools** extension is installed.
- Node.js is installed on the same workstation as Visual Studio Code.
- Only **Power Platform Tools** is installed, not both **Power Platform Tools** and **Power Platform Tools [PREVIEW]**. For more information, see [known issues](/power-pages/known-issues#visual-studio-code-extension-for-power-pages).
- Your environment and workstation are configured for Power Pages command-line support. For more information, see [Power Platform CLI support for Power Pages](/power-pages/configure/power-platform-cli) and [Tutorial: Use Power Platform CLI with Power Pages](/power-pages/configure/power-platform-cli-tutorial).
- The account you sign in with can access both environments and both sites that you want to compare.
- The correct environment is selected in **Power Pages Actions**. For more information, see [Power Pages Actions](/power-pages/configure/vs-code-extension#power-pages-actions).
- You downloaded the site that serves as your local baseline, and the sites you compare use the data model you expect.

> [!NOTE]
> Visual Studio Code for the Web provides a limited Power Pages editing experience and no Power Platform CLI support. Use Visual Studio Code Desktop for the procedures in this article.

## Compare site configuration between environments

Site Comparison always compares your **local workspace** with a **remote site** in a selected environment. To investigate a difference between two environments, use one environment as the local baseline, and then compare it against the site in the other environment.

### Step 1: Identify the baseline and the target

Before you compare anything, decide the following points:

- **Baseline**: the known-good, source, or expected site configuration. You download this site to your local workspace.
- **Target**: the site in the environment where the behavior is different.
- **Scope**: the complete site, or a specific component area such as `web-pages`.

Download the baseline site to your local workspace, and open that folder in Visual Studio Code.

### Step 2: Compare the complete site

Use this method when you don't yet know which component area causes the symptom.

1. In Visual Studio Code, in the Explorer sidebar, expand the **Power Pages Actions** pane.
1. Select **Change Environment**, and then select the environment that contains the target site.
1. Under **Active Sites** or **Inactive Sites**, right-click the target site. For a cross-environment investigation, this site is different from the one that's open locally.
1. Select **Compare with Local**.
1. Review the results in the **Site Comparison** section under **Tools**.

For more information, see [Compare site configuration](/power-pages/configure/vs-code-extension#compare-site-configuration).

### Step 3: Compare a specific folder

Use this method to reduce noise when you already know which component area is affected.

1. In your local workspace, right-click the relevant folder, such as `web-pages`.
1. Select **Power Pages** > **Compare with Environment**.
1. Select the environment that contains the target site.
1. Select the site to compare against.

If you select a site that's different from the site in your local workspace, you're asked to confirm the comparison.

> [!NOTE]
> The environment list doesn't include the environment that's currently selected in **Power Pages Actions**. If the target site is in that environment, either use the complete-site comparison in Step 2, or select **Change Environment** in **Power Pages Actions** to switch to a different environment first.

For more information, see [Compare site configuration](/power-pages/configure/vs-code-extension#compare-site-configuration).

### Step 4: Interpret the results

The **Site Comparison** section lists each file that differs. The comparison is named for both sides, in the form `<RemoteSiteName> (<EnvironmentName>)` and `<LocalSiteName> (Local)`, together with the number of changed files. Use this label to confirm which environment supplied your baseline before you interpret anything else.

Each result is expressed relative to your local workspace:

| State | Marker | Meaning |
| --- | --- | --- |
| **Added locally** | `A` | The file exists in the local workspace but not in the remote environment. |
| **Modified** | `M` | The code or metadata differs between the local and remote versions. |
| **Deleted locally** | `D` | The file doesn't exist in the local workspace but still exists in the remote environment. These files are also shown in red. |

The HTML report uses the same labels.

> [!NOTE]
> The direction matters. If you downloaded the production site as your baseline and compared it against development, a file marked **Added locally** exists in production and is missing from development. Reversing the baseline reverses the result.

### Step 5: Inspect the differences

- Select **Open All Diffs** to open the Visual Studio Code diff editor for every changed file.
- Open an individual file to examine the exact field, code, or metadata difference.
- Select **Refresh Comparison** after the baseline or the remote site changes.

Review the differences that relate most closely to the symptom first. Use the following table to decide where to look.

| Symptom | Compare first | Then validate |
| --- | --- | --- |
| A page is missing or different | `web-pages`, page templates, web templates, content snippets, web files | Parent page, publishing state, language, and related Dataverse data |
| The header, footer, or navigation differs | Web templates, content snippets, web link sets, web links | Website language and cache |
| A basic form differs | Basic forms, basic form metadata, and the related web page and template | Dataverse form, table and column configuration, table permissions |
| A multistep form differs | Multistep forms, steps, multistep form metadata | Dataverse forms and the referenced tables |
| A list differs | Lists, list metadata, and the related web page and templates | Dataverse views and table permissions |
| Access behavior differs | Web roles, page permissions, table permissions, site settings | Contact-to-web-role association, identity provider, and target data |
| JavaScript, Liquid, CSS, or a static asset differs | Web templates, web pages, web files, form and list JavaScript, content snippets | Browser console output and Power Pages DevTools |
| Authentication differs | Authentication-related site settings and content snippets | Environment-specific identity provider configuration and secrets |
| The target behaves differently after a deployment | The **Added locally**, **Modified**, and **Deleted locally** results across the complete site | Deployment history, solution contents, and target site reactivation |
| Changes aren't visible after a correction | The relevant metadata folders | Power Pages server-side cache behavior and site preview |
| A site setting differs by environment | Site settings | Environment variables and the intended environment-specific value |

### Step 6: Export and share the comparison results

Right-click the comparison to use the following actions.

| Action | Use |
| --- | --- |
| **Open All Diffs** | Review every detected file difference in the Visual Studio Code diff editor. |
| **Refresh Comparison** | Re-scan the local workspace and the remote environment. |
| **Export as HTML Report** | Create a shareable report for engineering or support review. |
| **Export as JSON** | Share, automate, or preserve the comparison result. |
| **Import Comparison** | Load a JSON comparison that another team member shared. |
| **Discard All Local Changes** | Revert the local workspace to the remote configuration. Use this action only when the remote configuration is authoritative. |
| **Remove Comparison** | Close the comparison session and clear the results. |

Sharing a JSON export lets your team collaborate on a difference without everyone connecting to the same environment.

> [!IMPORTANT]
> Exports contain site content, not just a list of changed files. A JSON export embeds the contents of the compared files, and an HTML report embeds the line-by-line differences. Site settings, web templates, and other components can contain credentials, keys, endpoints, personal data, or customer content. Before you share an export, review it and remove sensitive information. Share it only through secure, access-controlled channels, and don't post it in public forums.

> [!TIP]
> Save HTML and JSON exports outside your site workspace folder. If you save an export inside the site folder, it appears as an **Added locally** file the next time you run a comparison.

For more information, see [Manage comparison results](/power-pages/configure/vs-code-extension#manage-comparison-results).

> [!CAUTION]
> Don't select **Discard All Local Changes**, upload files, or overwrite the target configuration until you review the differences and confirm which version is authoritative. Ensure you have a backup or a source-controlled version first.

### Step 7: Decide whether each difference is expected

For each relevant difference, determine the following points:

- Is the difference intentional and environment-specific?
- Is it represented in source control or in the deployment artifact?
- Was it included in the solution or in the Power Pages metadata upload?
- Was it created manually after the deployment?
- Does its timing align with when the issue started?
- Does the target legitimately require a different value, such as an endpoint, client ID, or site setting?
- Is the component supported by the ALM method and data model you use?

### Step 8: Correct the configuration through your ALM process

Correct the source configuration first when source control or a development environment is authoritative, and then promote the change through your supported ALM process. Choose the path that matches your site and process:

- [Overview of Power Pages ALM](/power-pages/configure/portals-alm)
- [Use solutions with Power Pages](/power-pages/configure/power-pages-solutions)
- [Use Power Platform pipelines with Power Pages](/power-pages/configure/power-pages-pipelines)
- [Migrate Power Pages website configuration](/power-pages/admin/migrate-site-configuration)
- [Power Platform CLI support for Power Pages](/power-pages/configure/power-platform-cli)

### Step 9: Verify the correction

After the deployment finishes, select **Refresh Comparison**, or run a new comparison against the target site. Confirm that the differences you intended to resolve no longer appear, and that the differences you intended to keep are still present. Then retest the original symptom on the site.

If the reported files no longer differ but the behavior is unchanged, the cause is outside the website configuration. See [When Site Comparison isn't enough](#when-site-comparison-isnt-enough).

## Common scenarios

### A deployment completed, but the target site differs

Compare the baseline site with the target site, and focus on the components reported as **Added locally**, **Modified**, or **Deleted locally**. Then confirm that the ALM path you used carries those components. For more information, see [Overview of Power Pages ALM](/power-pages/configure/portals-alm) and [Migrate Power Pages website configuration](/power-pages/admin/migrate-site-configuration).

### A component wasn't added to the solution

New website components aren't automatically added to the solution that contains the site. If a component appears in the baseline but not in the target, verify the solution contents before you investigate anything else. For more information, see [Use solutions with Power Pages](/power-pages/configure/power-pages-solutions).

### An environment-specific site setting is different

This difference is often expected. Don't overwrite a target-specific value before you review its intended configuration. Where it's appropriate, use environment variables so that the value can differ by environment without manual edits. For more information, see [Configure site settings for Power Pages sites](/power-pages/configure/configure-site-settings) and [Use environment variables with site settings](/power-pages/configure/environment-variables-for-site-settings).

### A page, form, list, or permission behaves differently

Run a targeted folder comparison, inspect the exact metadata difference, and then confirm the expected configuration in the component documentation, such as [Lists overview](/power-pages/configure/lists), [Configure basic form metadata](/power-pages/configure/configure-basic-form-metadata), [Configure multistep form metadata](/power-pages/configure/configure-multistep-form-metadata), or [Power Pages security best practices](/power-pages/security/security-best-practices).

### Code or styling differs

Compare web templates, web pages, web files, content snippets, and component JavaScript. If the files match but the behavior still differs, continue with runtime diagnostics. For more information, see [Debug your Power Pages site with the DevTools extension](/power-pages/configure/devtools-addon) and [How server-side caching works in Power Pages](/power-pages/admin/clear-server-side-cache).

### The sites use different data models

You can compare a standard data model site with an enhanced data model site, but the comparison reports many more differences because the two data models represent configuration differently. That extra noise makes it harder to find the customizations that actually differ. Confirm the data model of both sites before you interpret the file layout or the results. For more information, see [Enhanced data model](/power-pages/admin/enhanced-data-model) and [Migrate standard data model sites to enhanced data model](/power-pages/admin/migrate-enhanced-data-model).

### The target still differs after the configuration is aligned

Site Comparison covers Power Pages website configuration, not every environment resource. Continue with the checks in the next section.

## When Site Comparison isn't enough

Site Comparison doesn't detect every difference between two environments. Investigate further when any of the following conditions apply:

- The site configurations match, but the Dataverse data differs.
- The issue depends on a Dataverse form, view, column, plug-in, cloud flow, connector, connection reference, or environment variable.
- The environments use different Power Pages package or website versions. For more information, see [Update the Power Pages solution](/power-pages/admin/update-solution).
- The symptom is caused by authentication secrets, certificates, endpoints, or app registrations.
- The behavior depends on licenses, capacity, networking, site lifecycle state, or environment type.
- The issue is a known product limitation or a service incident. For more information, see [Known issues for Power Pages](/power-pages/known-issues).

## Contact Microsoft support

If the steps in this article don't resolve your issue, contact Microsoft support. To speed up diagnosis, collect the following information before you open a support case:

- The source and target environment IDs.
- The source and target website IDs and URLs.
- The data model that each site uses, standard or enhanced.
- The Power Platform Tools extension version, and the Power Platform CLI version if you used the CLI to deploy.
- The exact symptom and the steps to reproduce it.
- The date and method of the last deployment or migration, and any relevant solution import or pipeline run details.
- The Site Comparison HTML report and the JSON export, after you review them and remove sensitive information. Share them only through the secure file-sharing method that your support engineer provides.
- The names of the most relevant **Added locally**, **Modified**, or **Deleted locally** files, and whether you expect each difference to be environment-specific.
- Browser errors, Power Pages errors, or DevTools output, if the issue involves runtime code.

## Related content

- [Use the Visual Studio Code extension](/power-pages/configure/vs-code-extension)
- [Compare site configuration](/power-pages/configure/vs-code-extension#compare-site-configuration)
- [Manage comparison results](/power-pages/configure/vs-code-extension#manage-comparison-results)
- [Install the Power Platform Tools Visual Studio Code extension](/power-platform/developer/howto/install-vs-code-extension)
- [Power Platform CLI support for Power Pages](/power-pages/configure/power-platform-cli)
- [Tutorial: Use Power Platform CLI with Power Pages](/power-pages/configure/power-platform-cli-tutorial)
- [Overview of Power Pages ALM](/power-pages/configure/portals-alm)
- [Use solutions with Power Pages](/power-pages/configure/power-pages-solutions)
- [Use Power Platform pipelines with Power Pages](/power-pages/configure/power-pages-pipelines)
- [Migrate Power Pages website configuration](/power-pages/admin/migrate-site-configuration)
- [Enhanced data model](/power-pages/admin/enhanced-data-model)
- [Use environment variables with site settings](/power-pages/configure/environment-variables-for-site-settings)
- [Debug your Power Pages site with the DevTools extension](/power-pages/configure/devtools-addon)
- [How server-side caching works in Power Pages](/power-pages/admin/clear-server-side-cache)
- [Known issues for Power Pages](/power-pages/known-issues)
- [Power Pages documentation](/power-pages/)
