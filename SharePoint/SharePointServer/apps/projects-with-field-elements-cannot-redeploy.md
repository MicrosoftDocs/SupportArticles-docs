---
title: SharePoint 2010 projects with field elements cannot be redeployed
description: Fixes an issue in which projects with field elements cannot be redeployed.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - SharePoint Server 2010
ms.reviewer: lubomirb
ms.date: 12/17/2023
---
# SharePoint 2010 projects with field elements cannot be redeployed

_Original KB number:_ &nbsp; 2022443

## Symptoms

When you deploy a sandboxed SharePoint solution if the Field IDs in the elements.xml file are modified between project deployments the following error is displayed:

> 'Error occurred in deployment of step 'Activate Features': the field with ID \<New GUID> defined in feature \<FeatureGUID> was found in the current site collection or in a sub site.

## Cause

The root cause of this issue is that Field elements are not properly retracted after their ID (GUID) is changed between deployments. This is also caused if you forgot to enclose the Field ID (GUID) in braces.

## Resolution

> [!NOTE]
> Make sure that your Field IDs (GUIDs) are always enclosed in braces.  

### First resolution

- Retract the Solution/WSP in VS.
- Close VS.
- Reopen VS and deploy the Project.  

### Second resolution

If closing VS after retraction doesn't solve the problem, then a larger workaround is:

- Redeploy the project. This will show an error during feature activation.
- Go to SharePoint UI and Activate and then Deactivate the deployed feature that was showing activation error in VS.
- Retract the Solution/WSP in VS.
- Close VS.
- Reopen VS and deploy the Project.
