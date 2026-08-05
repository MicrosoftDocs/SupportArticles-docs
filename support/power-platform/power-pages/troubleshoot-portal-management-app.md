---
title: Troubleshoot Common Portal Management App Issues
description: Fix common Portal Management app and Power Pages Management app issues, including missing sites, script errors, web roles, languages, and translations.
ms.reviewer: nityagi, nenandw
ms.date: 08/04/2026
ms.custom: sap:Site customization or browsing\Portal Management app
ai-usage: ai-assisted
---
# Troubleshoot common Portal Management app issues

## Summary

This article describes common issues that you might encounter when you use the [Portal Management app](/power-pages/configure/portal-management-app) or the Power Pages Management app to configure Power Pages sites. It provides resolutions for a site or app that doesn't appear, script errors and records that are stuck loading, app access and security role problems, web role assignment, and language and translation issues.

> [!IMPORTANT]
> If your site uses the [enhanced data model](/power-pages/admin/enhanced-data-model), the app appears as **Power Pages Management** instead of **Portal Management**. The two apps look and behave the same way, but they act on different Microsoft Dataverse tables. Many of the issues in this article occur because the app that's open doesn't match the data model of the site you're trying to configure.

## Troubleshooting workflow

Most Portal Management app issues fall into one of two buckets: the app you opened doesn't match your site's data model, or your account doesn't have the required permissions. To troubleshoot efficiently, follow these steps:

1. Confirm which app and data model your site uses. See [Identify which app and data model your site uses](#identify-which-app-and-data-model-your-site-uses). This step alone resolves or explains many issues.
1. Confirm that you have the required security role. See [Prerequisites](#prerequisites).
1. Find your symptom in the following table, and go to the matching section.

| If you're seeing this... | Go to |
| --- | --- |
| Your site or the app doesn't appear, or records land in the wrong app | [Your site or the app doesn't appear as expected](#your-site-or-the-app-doesnt-appear-as-expected) |
| A script error, a stuck spinner, or "We can't get that information right now" | [A script error appears, or a record is stuck loading](#a-script-error-appears-or-a-record-is-stuck-loading) |
| You can't give another user access to the app | [You can't share the app with a user](#you-cant-share-the-app-with-a-user) |
| Web roles aren't selectable, or you can't add a contact to a web role | [You can't assign a web role to a contact](#you-cant-assign-a-web-role-to-a-contact) |
| A new language or translations don't appear | [Languages or translations don't appear](#languages-or-translations-dont-appear) |
| Questions about basic forms, multistep forms, or lists | [Configure site components by using the Portal Management app](#configure-site-components-by-using-the-portal-management-app) |

## Prerequisites

To use the Portal Management app, you need the [system administrator](/power-platform/admin/assign-security-roles) role in the same Dataverse environment as your site. Users who have the [system customizer](/power-platform/admin/assign-security-roles) role can also open the app, but they might have limited privileges on certain tables (for example, Notes and attachments related to web files) that prevent them from viewing or updating records that other users created.

## Identify which app and data model your site uses

Before you troubleshoot, confirm which data model your site uses. This single check resolves or explains many of the scenarios in this article.

- **Standard data model**: The app is named **Portal Management**. Configuration is stored in standard tables that have the `adx_` prefix (for example, `adx_website` and `adx_webrole`).
- **Enhanced data model**: The app is named **Power Pages Management**. Configuration is stored in tables that have the `mspp_` prefix (for example, `mspp_website` and `mspp_webrole`).

To determine which data model your site uses, try one of these methods:

- Open the [Power Platform admin center](https://admin.powerplatform.microsoft.com/), go to **Resources** > **Power Pages sites**, select your site, and then select **Manage**. The **Data Model** field in the **Site Details** section shows the data model.
- Open the **Setup** workspace in the Power Pages design studio.
- Open the model-driven app. If the name is **Portal Management**, the site uses the standard data model. If the name is **Power Pages Management**, the site uses the enhanced data model.

The app name appears in the header, next to **Power Apps**. In the **Portal Management** app (standard data model), the header reads *Portal Management*:

:::image type="content" source="media/troubleshoot-portal-management-app/portal-management-app.png" alt-text="Screenshot of the Power Apps header that shows the Portal Management app name, which indicates a standard data model site." lightbox="media/troubleshoot-portal-management-app/portal-management-app.png":::

In the **Power Pages Management** app (enhanced data model), the header reads *Power Pages Management*:

:::image type="content" source="media/troubleshoot-portal-management-app/power-pages-management-app.png" alt-text="Screenshot of the Power Apps header that shows the Power Pages Management app name, which indicates an enhanced data model site." lightbox="media/troubleshoot-portal-management-app/power-pages-management-app.png":::

For more information, see [Enhanced data model](/power-pages/admin/enhanced-data-model).

## Your site or the app doesn't appear as expected

### Symptoms

- Your site isn't listed in the Portal Management app.
- The Portal Management app isn't displayed, or you can't open it.
- When you import or create website records, they go to the Power Pages Management app instead of the Portal Management app (or the reverse).
- You can't select or reuse an existing website record when you configure a site.
- When you create a website, data from an existing website isn't available.

### Cause

The app that's open doesn't match the data model of your site. A site that's built on the enhanced data model is configured through the **Power Pages Management** app and its `mspp_` tables, and it doesn't appear in the **Portal Management** app, which shows only standard `adx_` tables. Website records that you create or import are associated with the data model of the app that you're using.

### Resolution

1. Determine which data model your site uses, as described in [Identify which app and data model your site uses](#identify-which-app-and-data-model-your-site-uses).
1. Open the app that matches the data model:
   - For a standard data model site, use the **Portal Management** app.
   - For an enhanced data model site, use the **Power Pages Management** app.
1. Select the correct website record from the app that matches your site's data model.

After you switch to the matching app, your site and its website record appear, and you can open and edit the configuration.

## A script error appears, or a record is stuck loading

### Symptoms

- When you open a record such as a web page, basic form, list, or multistep form step, you receive an error that resembles the following message: `An error has occurred in one of the scripts for this record. Download the log file for more information.`
- The downloaded log file references an error that resembles `ReferenceError: Web resource method does not exist.`
- A form or setting is stuck on loading, or you receive a message that resembles `We can't get that information right now. Either try again or check our support page to see if there are any known issues.`

### Cause

This behavior often occurs when a browser extension, such as an ad blocker, interferes with the scripts that the app uses. It can also occur when your account doesn't have sufficient privileges in the environment. The log file that you download typically points to a script or web resource that failed to load, which confirms that something blocked the app's scripts.

### Resolution

1. Disable browser extensions such as ad blockers, and then reload the record. Alternatively, open the app in a different browser that doesn't have such extensions enabled.
1. If the problem continues, confirm that your account has the required security role in the environment, as described in [Prerequisites](#prerequisites).
1. Check whether a website package update is available. In the [Power Platform admin center](https://admin.powerplatform.microsoft.com/), select your site, and then select **Websites package(s) details** to review the installed packages and versions. If a higher version is available for your site's package (**CDSBasePortal** for the standard data model, or **PowerPagesCore** for the enhanced data model), upgrade it during off-peak hours, because updating often resolves script errors that are caused by an outdated package. For steps, see [Update the Power Pages solution](/power-pages/admin/update-solution).

The record opens and loads without the script error. If the error persists in a browser that has no extensions and with the correct security role, note the error message, download the log file, and see [Contact Microsoft support](#contact-microsoft-support).

For more information, see the browser considerations in [Portal Management app overview](/power-pages/configure/portal-management-app).

## You can't share the app with a user

### Symptoms

You can't give another user access to the Portal Management app or the Power Pages Management app.

### Cause

Access to the app is granted through Dataverse security roles rather than by sharing the app directly.

### Resolution

Assign the required security role to the user in the same environment as the site, as described in [Prerequisites](#prerequisites). For steps, see [Assign security roles](/power-platform/admin/assign-security-roles).

After the role is assigned, the user can open the app and see the site configuration the next time they sign in.

## You can't assign a web role to a contact

### Symptoms

- You can't select web roles or add a contact to a web role.
- You can't pull contacts into a web role.
- You can't create a relationship between the contact and the `mspp_webrole` table. You can only create a relationship between the contact and the `adx_webrole` table.

### Cause

The cause depends on your site's data model:

- **Enhanced data model**: **Web Role** (`mspp_webrole`) is a virtual table. You can't customize virtual tables, so they don't appear in the list of tables that you can use to create a relationship with another table. As a result, you can't associate a contact with `mspp_webrole` by creating a relationship. Instead, you assign web roles from the enhanced contact form in the Power Pages Management app.
- **Standard data model**: **Web Role** (`adx_webrole`) uses a standard many-to-many relationship with contacts, so there's no virtual-table limitation. You assign web roles directly from the web role's related contacts, as described in the following steps.

### Resolution

Use the method that matches your site's data model.

#### Standard data model (Portal Management app)

1. In the Portal Management app, select **Security** > **Web Roles**, and then select a web role.
1. Select the **Related** tab, and then select **Contacts**.
1. Select **Add Existing Contact**, search for and select the site users, select **Add**, and then select **Save**.

#### Enhanced data model (Power Pages Management app)

1. In the Power Pages Management app, select **Security** > **Contacts**, and then select a contact.
1. Select **Portal Contact (Enhanced Form)**.
1. On the **General** tab, scroll to the **Web Roles** section, and then select **Add Existing Web Role**.
1. Search for and select the web roles, select **Add**, and then select **Save**.

Assign web roles to individual contact (site user) records. There's no built-in way to map a Microsoft Entra ID (Azure AD) group to a web role, so assign the web role to each authenticated user's contact record by using the steps in this section.

After you assign the web role, the contact record lists the web role, and the associated table and page permissions apply the next time the user signs in to the site.

For more information, see [Create and assign web roles](/power-pages/security/create-web-roles).

## Languages or translations don't appear

### Symptoms

- You need to enable a new language for your site.
- Translations don't appear after you add a language.
- You want to set up a multilingual site.

### Cause

Translations don't appear when one of the following conditions applies:

- You didn't enable the language in Dataverse, or the language provisioning process isn't finished. Provisioning a language can take an hour or more.
- You didn't add the website language, or it isn't in a published state.
- You didn't create localized content for the language, so pages fall back to the default language.

### Resolution

1. Enable the language in Dataverse for the environment, and wait for provisioning to finish before you continue. For steps, see [Enable languages](/power-platform/admin/enable-languages).
1. In the Portal Management app, go to **Website** > **Websites**, select your site, and in the **Supported Languages** section, add a **New Website Language**. Set the **Publishing State** to a published state, and optionally set the site's **Default Language**.
1. Create and publish localized content for each language. In the Power Pages design studio, switch to the language and translate the web pages, content snippets, and other components that visitors see.

> [!NOTE]
> To translate Dataverse table and column labels (the field, form, and view names shown in the model-driven app and on forms and lists) after you activate a new language, [import the metadata translations](/power-pages/admin/import-metadata-translation) from the Power Platform admin center. This step updates the solution metadata labels, not your site's page content.

For an end-to-end walkthrough, see [Enable multiple-language website support](/power-pages/configure/enable-multiple-language-support).

After the language is provisioned, added, and published, and localized content exists, visitors can select the language and see the translated content.

## Configure site components by using the Portal Management app

Use the Portal Management app (or the Power Pages Management app for enhanced data model sites) to configure the following site components. If you receive a script error, or a record is stuck loading when you save a component, see [A script error appears, or a record is stuck loading](#a-script-error-appears-or-a-record-is-stuck-loading).

### Basic forms

You can configure basic forms from the Power Pages design studio or the Portal Management app. You can associate basic forms with the site in multiple ways. For more information, see [About basic forms](/power-pages/configure/basic-forms). To configure the metadata that controls how a basic form behaves, see [Configure basic form metadata](/power-pages/configure/configure-basic-form-metadata).

### Multistep forms

A multistep form lets you create a form with multiple steps. Use a multistep form when you want to collect user input through multiple forms that use different components. For more information, see [Multistep forms](/power-pages/getting-started/multistep-forms) and [Define multistep form properties](/power-pages/configure/multistep-form-properties). To configure multistep form metadata, see [Configure multistep form metadata](/power-pages/configure/configure-multistep-form-metadata).

### Lists

A list is a data-driven configuration that you use to add a webpage that renders a list of records without a developer having to surface the grid on the site. By using lists, you can expose Dataverse records for display on a webpage. For more information, see [Lists overview](/power-pages/configure/lists). For configuration details, such as sorting, list views (including grid, map, and calendar views), and custom JavaScript, see [List configuration](/power-pages/configure/list-configuration).

## Best practices

- Always open the app that matches your site's data model. For enhanced data model sites, use the **Power Pages Management** app. For standard data model sites, use the **Portal Management** app.
- Records in the Portal Management app and the Power Pages Management app represent live site configuration. Deleting a configuration record can break references on your site, so change or delete records only when you're sure of the effect.
- Where possible, use the [Power Pages design studio](/power-pages/getting-started/use-design-studio) for common configuration tasks. Reserve the Portal Management app for advanced customization.

## Contact Microsoft support

If the steps in this article don't resolve your issue, contact Microsoft support. To speed up diagnosis, collect the following information before you open a support case:

- The site URL, and the environment name or ID.
- The data model your site uses (standard or enhanced), and the name of the app you're using (**Portal Management** or **Power Pages Management**).
- The exact error message, and the log file if a script error prompts you to download one.
- A screenshot of the issue, and the steps to reproduce it.
- The security role that's assigned to the affected user or contact.

## See also

- [Portal Management app overview](/power-pages/configure/portal-management-app)
- [Enhanced data model](/power-pages/admin/enhanced-data-model)
- [Create and assign web roles](/power-pages/security/create-web-roles)
- [Enable multiple-language website support](/power-pages/configure/enable-multiple-language-support)
- [About basic forms](/power-pages/configure/basic-forms)
- [Configure basic form metadata](/power-pages/configure/configure-basic-form-metadata)
- [Multistep forms](/power-pages/getting-started/multistep-forms)
- [Configure multistep form metadata](/power-pages/configure/configure-multistep-form-metadata)
- [Lists overview](/power-pages/configure/lists)
- [List configuration](/power-pages/configure/list-configuration)
