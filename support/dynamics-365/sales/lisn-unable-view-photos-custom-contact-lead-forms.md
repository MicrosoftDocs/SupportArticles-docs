---
title: Can't view photos on custom contact and lead forms in Unified Interface
description: Resolves an issue where you can't view photos in custom contact and lead forms in Unified Interface in Microsoft Dynamics 365 Sales.
author: udaykirang
ms.author: udag
ms.reviewer: sagarwwal
ms.date: 10/18/2024
ms.custom: sap:LinkedIn Sales Navigator\LinkedIn Sales Navigator integration errors
---
# Can't view photos in custom contact and lead forms in Unified Interface

This article provides a resolution for an issue where you can't view photos in custom contact and lead forms in Unified Interface in Microsoft Dynamics 365 Sales.

## Cause

By default, photos from LinkedIn are displayed in the out-of-the-box contact and lead forms. However, for custom forms, these photos aren't displayed by default.

## Resolution

To resolve this issue, add the `msdyn_linkedinintegrationcommon.js` library and the `LinkedInIntegration.LinkedInIntegrationCommon.Instance.Form_OnLoad` function handler to your custom forms. Follow these steps:

1. Sign in to your Dynamics 365 app.
1. Go to **Advanced Settings** > **Customizations** > **Customize the System**.

1. From the **Entities** site map, select the entity, and then select the custom form (for example, a contact custom form) where you want to display the photo.

1. Select the **Form Properties** option to open the **Form Properties** dialog.

    :::image type="content" source="media/lisn-unable-view-photos-custom-contact-lead-forms/ts-linkedin-contact-form-properties.png" alt-text="Screenshot of the Form Properties dialog.":::

1. In the **Form Libraries** section, search for and add the `msdyn_linkedinintegrationcommon.js` library to the form.
1. In the **Event Handlers** section, search for and add the `LinkedInIntegration.LinkedInIntegrationCommon.Instance.Form_OnLoad` function to the form.

    :::image type="content" source="media/lisn-unable-view-photos-custom-contact-lead-forms/ts-linkedin-contact-form-properties-added.png" alt-text="Screenshot of adding the LinkedIn library and function to the form.":::

1. Save and publish the form.
