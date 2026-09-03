---
title: Web API Requests Fail After Wildcard Column Deprecation
description: Power Pages Web API requests fail after the wildcard value (*) is deprecated in the fields site setting. Migrate to an explicit column list.
ms.date: 09/03/2026
ms.reviewer: smurkute, nabha
ms.custom: sap:Site customization or browsing\Data workspace
ai-usage: ai-assisted
---

# Power Pages Web API requests fail after wildcard column configuration is deprecated

## Summary

This article explains how to migrate wildcard column configuration for the Power Pages Web API and how to fix Web API requests that fail after the wildcard value (`*`) is deprecated in the `Webapi/<table-name>/fields` site setting. Starting September 14, 2026, requests to any table that still uses the wildcard fail until the configuration is migrated. To resolve the issue, replace `*` with an explicit list of the column logical names your site uses, configure the columns by using a **Power Pages Web API Columns** system view,
or combine both approaches. The article also covers how to identify affected tables, determine the required columns, test and deploy the change, and use the Power Pages migration tools. Migrating enforces least-privilege access and makes it easier to identify, audit, and maintain the columns exposed through the Power Pages Web API.

> [!IMPORTANT]
>
> - Starting in August 2026, newly created websites can't use the wildcard value.
> - Starting September 14, 2026, the wildcard value isn't supported on any website.

## Symptoms

 You might encounter one or more of the following issues:

- Previously successful Power Pages Web API requests begin to fail.
- Site features that create, read, update, or delete Dataverse records stop working.
- The affected table has a site setting that resembles the following example:

  ```text
  Webapi/account/fields = *
  ```

The change applies to standard and custom Dataverse tables and to requests from anonymous and authenticated users.

## Cause

The wildcard value makes all columns on a table available to Power Pages Web API operations. Wildcard support is being removed to require an intentional allow list of the columns that each site uses.

Beginning September 14, 2026, requests for a table configured with `Webapi/<table-name>/fields = *` fail until the configuration is migrated. For more information, see [Wildcard value (*) in Web API field configuration](/power-pages/important-changes-deprecations#wildcard-value--in-web-api-field-configuration).

## Solution

You can migrate from the wildcard (`*`) configuration in either of the following ways:

- [Migrate manually](#option-1-migrate-manually): Follow the steps in this section to identify affected tables, determine the columns your site requires, update the configuration, and test and deploy the changes.
- [Use migration tools](#option-2-use-migration-tools): Use the available Power Pages tools to help identify the required columns and accelerate the migration. You should still review the recommendations and complete the testing and validation steps.

### Option 1: Migrate manually

#### 1. Identify affected tables

In the Portal Management app or Power Pages Management app, review the site settings for the website. Identify every setting that meets both of the following conditions:

- Its name uses the format `Webapi/<table-name>/fields`.
- Its value is `*`.

For example:

```text
Webapi/account/fields = *
Webapi/contact/fields = *
Webapi/new_customtable/fields = *
```

Use the Dataverse table logical name, such as `account`, in the site-setting name. Don't use the entity set name, such as `accounts`.

#### 2. Determine which columns the site requires

Review the client-side code and other site components that call the Power Pages Web API. Common call patterns include:

```javascript
$.ajax(...)
fetch(...)
webapi.safeAjax(...)
$pages.webAPI.retrieveRecord(...)
$pages.webAPI.retrieveMultipleRecords(...)
```

Look for the logical names of columns in all parts of each request and in the code that processes its response.

| Location | Example | Column to allow |
| --- | --- | --- |
| Response property | `result.fullname` | `fullname` |
| Create or update payload | `{ emailaddress1: value }` | `emailaddress1` |
| `$select` | `$select=fullname,mobilephone` | `fullname`, `mobilephone` |
| `$filter` | `$filter=statuscode eq 1` | `statuscode` |
| `$orderby` | `$orderby=createdon desc` | `createdon` |
| `$expand` | `$expand=primarycontactid($select=fullname)` | Columns required by the relationship and nested query |

Include only columns that the application requires. Don't add every table column as a replacement for the wildcard.

#### 3. Configure the column allow list

Choose one of the following options.

##### Use an explicit column list

Replace `*` with a comma-separated list of column logical names.

For example:

```text
Webapi/contact/fields = fullname,emailaddress1,mobilephone
```

This option is appropriate when the required columns are stable and you want to manage the allow list directly in site settings.

##### Use a system view

> [!IMPORTANT]
> The `Webapi/<table-name>/UseFieldsFromView` site setting is available in Power Pages site version 9.8.8.x and later.

Create a public system view named **Power Pages Web API Columns** for the table, add the required columns to the view, and configure:

```text
Webapi/<table-name>/UseFieldsFromView = True
```

You can use this setting with or without an explicit value in `Webapi/<table-name>/fields`. If both settings are configured, the Web API combines the columns listed in `Webapi/<table-name>/fields` with eligible columns from the **Power Pages Web API Columns** system view for that table. Duplicate column names are included only once.

For configuration steps and limitations, see [Overview of the Power Pages portals Web API](/power-pages/configure/web-api-overview#configure-web-api-columns-by-using-a-system-view).

#### 4. Test the updated configuration

Test the change in a nonproduction environment before you deploy it to production.

1. Exercise every site feature that calls the affected Web API table.
1. Test create, read, update, and delete operations that the site supports.
1. Test with each relevant web role and with anonymous access, if the site supports anonymous users.
1. Use the browser developer tools to inspect failed network requests and identify any required columns that are missing from the allow list.
1. Confirm that table permissions and column permissions still provide the intended access.

If a request fails because a required column isn't available, add only that column to the explicit list or system view, and then test again.

#### 5. Deploy and validate

Deploy the updated site settings and, if applicable, the **Power Pages Web API Columns** system views to each affected environment. Then repeat the application tests against the deployed site.

Changes to a system view can take up to five minutes to become available to the Web API.

### Option 2: Use migration tools

The following tools can help you identify the columns your site needs and speed up migration from Web API `*`.

> [!NOTE]
> These tools are available starting September 2, 2026.

- **Security Agent:** Available in the Security workspace in Power Pages design studio. Use the **Data Security** starter prompt to review your Web API configuration and get recommendations for the specific columns to use instead of `*`.

- **Power Pages plugin:** Use the `/migrate-webapi-selectall` skill to analyze your site's source code, identify the columns used by each Web API call, and replace `Webapi/<table-name>/fields = *` with explicit column lists. It supports both traditional sites and SPA frameworks including React, Vue, Angular, and Astro.

Review the recommendations from these tools before applying them. You should still complete the [Test the updated configuration](#4-test-the-updated-configuration) and [Deploy and validate](#5-deploy-and-validate) steps in the previous section to confirm that the migrated configuration works as expected.

## Troubleshoot Web API failures after migration

If requests continue to fail after you remove the wildcard, check the following items:

1. Confirm that no affected `Webapi/<table-name>/fields` setting still uses the value `*`.
1. Verify that each site-setting name uses the table logical name, not the entity set name.
1. Verify that the allow list contains column logical names.
1. Confirm that the allow list includes every column used in request payloads, response processing, `$select`, `$filter`, `$orderby`, and `$expand`.
1. Confirm that `Webapi/<table-name>/enabled` is set to `True`.
1. Verify that the user has the required table permissions, web role, and column permissions.
1. If you use `UseFieldsFromView`, also confirm that:
   - The site is on version 9.8.8.x or later.
   - The setting value is `True`.
   - The public system view is named **Power Pages Web API Columns**.
   - Required primary-table columns are displayed in the view.
   - You waited up to five minutes after publishing view changes.

> [!NOTE]
> `UseFieldsFromView` doesn't include columns from related tables. It also excludes columns used only for filtering or sorting in the system view unless those columns are displayed in the view. For lookup columns, use the OData property name `_<column-logical-name>_value`.

If the issue persists after you verify the configuration, capture the failed request and response, affected table, relevant site settings, and steps to reproduce the issue.

## Frequently asked questions

### Can I continue using the wildcard value?

No. Replace it with an explicit column list, a **Power Pages Web API Columns** system view, or a combination of both.

### Does the change apply to custom tables?

Yes. It applies to both standard and custom Dataverse tables.

### Does the change apply to authenticated users?

Yes. It applies to Web API requests from both anonymous and authenticated users.

### Should I add every column to prevent application failures?

No. Add only the columns that the application requires. This approach preserves least-privilege access and keeps the configuration easier to audit and maintain.

### How do I identify all required columns?

Review each Web API request and the code that processes its response. Check request payloads, response properties, and OData query options such as `$select`, `$filter`, `$orderby`, and `$expand`. Then validate the resulting allow list in a nonproduction environment.

### What if I can't finish migrating before the enforcement date?

Migrate as soon as possible. The wildcard value is deprecated, so it isn't a long-term option. If you can't update your sites before the enforcement date, an admin can request a one-time, short-term extension on the **Manage exemptions** page in the Power Platform admin center. An extension delays enforcement, but it doesn't remove the migration requirement. For more information, see [Manage exemptions for Power Pages sites](/power-pages/admin/manage-exemptions).

## Related content

- [Overview of the Power Pages portals Web API](/power-pages/configure/web-api-overview)
- [Overview of Power Pages Client APIs](/power-pages/configure/client-api)
- [Important upcoming changes and deprecations in Power Pages](/power-pages/important-changes-deprecations#wildcard-value--in-web-api-field-configuration)
- [Configure site settings for Power Pages sites](/power-pages/configure/configure-site-settings)
