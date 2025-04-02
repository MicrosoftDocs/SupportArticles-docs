---
title: Error Code 2147812097 Invalid License When Accessing App Module
description: Provides a solution to an error that occurs when you try to access an app module in a Microsoft Dynamics 365 business application.
ms.reviewer: 
ms.date: 04/02/2021
ms.custom: sap:Microsoft Dataverse\Environment and app access issues
---
# "Error Code 2147812097 Invalid License: This application requires a license" error when accessing an app module

This article provides a solution to the error code **2147812097** that occurs when trying to access an app module (business application) in Microsoft Dynamics 365 without an appropriate license assigned.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4548022

## Symptoms

When you try to access an app module that requires an appropriate license in a Dynamics 365 business application and the license isn't assigned, you receive the following error message:

> Invalid License
>
> This app requires a license and you don't have the appropriate license to access this app. Please contact your administrator to get the appropriate license assigned, as per details provided.

:::image type="content" source="media/error-when-accessing-app-module/invalid-license.png" alt-text="Screenshot of the Dynamics team member license error.":::

The required license name and the application names are shown in the error details that resemble the following:

> User does not have a license to access this app module uniqueName=< unique name> with Id=\<Id> from publisher=\<publisher name>. A license is required with one of the service plans: \<Service Plan name>: \<Service Plan Id>. Please refer to the article \<link to this KB> for more details.

## Cause

This issue occurs because the application requires a license, but the administrator hasn't assigned the appropriate license to the user of the application.

For example, if a user with a Team Member license attempts to access the [Customer Service Hub application](/dynamics365/customer-service/implement/customer-service-hub-user-guide-basics), they receive the following error message:

> This app requires a license and you don't have the appropriate license to access this app. Please contact your administrator to get the appropriate license assigned, as per details provided.  
>
> Technical Details
>
> User does not have any license to access this app module uniqueName= Customerservicehub from publisher= dynamics365customerengagement. A license is required with one of the service plans: 'Dynamics 365 for Customer Service: \<GUID>

## Resolution

To solve this issue, contact the administrator and request the appropriate license to be assigned.

## More information

For access to custom apps (canvas or model-driven app), you need to be assigned a Dynamics 365 Enterprise or Professional license, and Power Apps per user plan. The environment needs to be given [Power Apps per app plans (also known as app passes)](/power-platform/admin/about-powerapps-perapp).
