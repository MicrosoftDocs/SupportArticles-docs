---
title: Settings Area Is Missing from the Field Service Mobile App Module
description: Provides a resolution for the missing Settings area in the Dynamics 365 Field Service mobile app.
author: JonBaker007
ms.author: jobaker
ms.reviewer: mhart
ms.date: 12/12/2024
ms.custom: sap:Mobile application\Issues with performance
---
# Settings area is missing in the Field Service Mobile app module navigation

This article provides a resolution for enabling the **Settings** area in the Field Service Mobile app module navigation pane.

## Symptoms

The Field Service Mobile app module doesn't show the **Settings** area, blocking administrators from [enabling the new experience](/dynamics365/field-service/mobile/set-up-field-service-mobile#enable-the-new-mobile-user-experience).

## Cause

The new mobile experience **Settings** toggle is available through a new navigation area that comes with the default Field Service Mobile app module. Users need *write* permissions on the `FieldServiceSetting` entity to access this area. Default security roles like System Admin or Field Service Admin have that permission automatically. However, if customizations are made on the sitemap of the out-of-box Field Service Mobile app module, the **Settings** area might not show in some cases.

## Resolution

First, check whether the sitemap area exists on the default Field Service Mobile solution layer but a customization layer overrides it:

1. Sign in to [Power Apps](https://make.powerapps.com).
1. Change to your environment and open the `fieldservice_patch_update` solution.
1. [View the solution layers](/power-apps/maker/data-platform/solution-layers) for the `msdyn_FSMobileSettingsArea` component in the `fieldservice_patch_update` solution.

If you find that a customization layer on the sitemap is on top and overrides this area, use one of the following options to enable the **Settings** area:

**Option 1**: Remove the sitemap customization layer and manually customize it again

1. [Remove the unmanaged customization layer](/power-apps/maker/data-platform/solution-layers#remove-an-unmanaged-layer).
2. Apply the [sitemap customizations](/power-apps/maker/model-driven-apps/create-site-map-app) again.

**Option 2**: Manually add the **Settings** area and switch to the sitemap

1. Open your customized app in the [app designer](/power-apps/maker/model-driven-apps/app-designer-overview).
1. [Enable areas and create a new area](/power-apps/maker/model-driven-apps/app-navigation#create-an-area) for the Field Service Mobile settings.
1. [Create a new group](/power-apps/maker/model-driven-apps/app-navigation#create-a-group) for the mobile settings.
1. [Add a new page to the group](/power-apps/maker/model-driven-apps/app-navigation#create-a-page). Select **URL** for the content type.
1. Use `/main.aspx?etn=msdyn_fieldservicesetting&pagetype=entityrecord&id=e49c6117-5065-423f-8ab5-fcacfda85a04&formid=ee334fea-0cd5-471c-bb30-829f4511a59f` as the URL input.
1. Add a subarea for new features.

   1. Under **ID**, expand **Advanced settings** and **privileges**.
   1. Select **Add table privilege** > **Field Service Setting**, and then select only the **Write** privilege.

1. Select **Apply** > **Save and Publish**.
