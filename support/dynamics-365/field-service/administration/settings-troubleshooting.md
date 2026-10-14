---
title: Troubleshoot Dynamics 365 Field Service Settings Issues
description: Field Service settings issues can block plug-ins, auto-numbering, and saved changes. Learn how to fix common Dynamics 365 Field Service settings errors.
ms.reviewer: jasonshotts, v-wesmith
ms.date: 08/25/2026
ms.custom: sap:Administration\Issues with Field Service settings
ai-usage: ai-assisted
---
# Troubleshoot issues with Dynamics 365 Field Service settings

## Summary

This article helps administrators fix common problems with Field Service settings in Microsoft Dynamics 365 Field Service, including the "Field Service database version is out of date" error, settings that don't seem to take effect, auto-numbering and prefix problems, and a Field Service Settings record that can't be changed or deleted.

## Symptoms

You experience one or more of the following issues when you work with Field Service settings:

- Plug-ins and system jobs fail after a solution update, and you see an error similar to:

  > The Field Service database version is out of date.

- You change a value on the [**Field Service Settings** page](/dynamics365/field-service/configure-default-settings), but the new value doesn't seem to apply.

- Work orders, agreements, purchase orders, return merchandise authorizations (RMAs), or return to vendor (RTVs) aren't getting the number format or prefix that you configured.

- You can't turn off the [auto-numbering option](/dynamics365/field-service/configure-default-settings#auto-numbering-settings) after you turn it on.

- You can't delete the Field Service Settings record.

- Tax is calculated differently between two environments even though the configuration looks the same.

## The Field Service database version is out of date

Field Service stores a database version on the settings record. When the server-side code runs and finds that this version is older than the version the installed solution expects, it blocks the operation and reports that the database is out of date. This condition usually happens when a solution update is partially applied or an upgrade job hasn't finished.

### Update the Field Service database version

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/), select your environment, and go to **Resources** > **Dynamics 365 apps**.

1. Confirm that the Field Service solution update finished installing. If an update is pending or failed, apply it again.

1. After the update finishes, open the Dynamics 365 Field Service app and confirm that plug-ins and jobs run without the database-version error.

## The behavior isn't controlled by the setting you changed

The server reads Field Service settings fresh each time a plug-in runs, so a saved change applies to the next operation immediately. There's no server-side cache to clear and no need to restart a session. If a change doesn't appear to take effect, the behavior you're observing is often controlled somewhere other than the settings record, or the change is a sitemap or app change that requires publishing.

### Confirm where the behavior is controlled

1. In the Dynamics 365 Field Service app, select **Settings** > **Field Service Settings** and confirm the value you changed is saved.

1. Because settings apply immediately server-side, retest the operation right after saving. If it still doesn't change, the behavior isn't governed by that setting.

1. If your change affects the sitemap or an app module (for example, showing or hiding an area), publish your customizations, and then refresh the app.

## Auto-numbering isn't set up, or the entity isn't auto-numbered

Field Service auto-numbering applies to work orders, agreements, inventory adjustments, inventory transfers, purchase orders, RMAs, and RTVs. Bookings aren't auto-numbered. The prefix and number length come from fields on the settings record. If those fields aren't set, the default prefix and length are used.

### Set up auto-numbering correctly

1. In the Dynamics 365 Field Service app, select **Settings** > **Field Service Settings**.

1. On the **Work Order / Booking** and related tabs, set the prefix and number length fields for each entity you want to auto-number (work order, agreement, inventory adjustment, inventory transfer, purchase order, RMA, RTV).

1. Save your changes and create a test record to confirm the new format.

## The auto-numbering opt-in is already turned on

The switch that opts an environment into platform auto-numbering is one-way. After you enable it, you can't turn it off.

### Plan around the one-way auto-numbering opt-in

1. Treat enabling the auto-numbering opt-in as permanent for that environment.

1. Validate the number format in a non-production environment before you enable it in production.

## You don't have the required privileges, or the record is protected

Reading and editing Field Service settings require specific privileges. The settings record is also protected so that you can't delete it.

### Grant the correct privileges

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/), select your environment, and go to **Settings** > **Users + permissions** > **Security roles**.

1. Ensure the user's role grants read and write privileges on the Field Service Settings table.

1. Don't attempt to delete the Field Service Settings record. It's protected and is meant to exist as a single record per environment.

## Related content

- [Configure default settings in Field Service](/dynamics365/field-service/configure-default-settings)
- [Field Service settings table reference](/dynamics365/field-service/developer/reference/entities/msdyn_fieldservicesetting)
