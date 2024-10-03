---
title: Unable to view photos on custom contact and lead forms in Unified Interface
description: Learn how to troubleshoot and resolve issues related to unable to view photos on custom contact and lead forms in Unified Interface.
author: udaykirang
ms.author: udag
ms.reviewer: udag
ms.topic: troubleshooting
ms.collection: 
ms.date: 10/03/2024
ms.custom: bap-template 
---

# Unable to view photos on custom contact and lead forms in Unified Interface

This article provides a resolution for the issue where you are unable to view photos on custom contact and lead forms in Unified Interface.

## Symptom

By default, the photos from LinkedIn are displayed on the out-of-the-box Contact and Lead forms. For custom forms, you can't have the photos displayed by default.

## Resolution

To resolve this issue, add the **msdyn_linkedinintegrationcommon.js** library and the **LinkedInIntegration.LinkedInIntegrationCommon.Instance.Form_OnLoad** function handler to your custom forms. Follow these steps:  

1. Sign in to your Dynamics 365 app.  
1. Go to **Advanced Settings** > **Customizations** > **Customize the System**.  
1. From the **Entities** site map, select the entity and then custom form for which you want to display the photo.  

    >[!NOTE]
    >In this procedure, we are using contact custom form.  

1. Select the **Form Properties** option.  

    The **Form Properties** dialog opens.  

    :::image type="content" source="media/linkedin/ts-linkedin-contact-form-properties.png" alt-text="Screenshot of the Form properties dialog box.":::

1. In the **Form Libraries** section, search and add the **msdyn_linkedinintegrationcommon.js** library to the form.  
1. In the **Event Handlers** section, search and add the **LinkedInIntegration.LinkedInIntegrationCommon.Instance.Form_OnLoad** function to the form.  

    :::image type="content" source="media/linkedin/ts-linkedin-contact-form-properties-added.png" alt-text="Screenshot of adding LinkedIn library and function to the form.":::

1. Save and publish the form.  
