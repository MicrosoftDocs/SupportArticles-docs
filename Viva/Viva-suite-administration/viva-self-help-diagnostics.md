---
title: Self-help diagnostics for Microsoft Viva administrators
description: Provides a list of available diagnostics for apps in the Viva suite.
manager: dcscontentpm
ms.author: luche
author: helenclu
ms.reviewer: bpeterse, meerak
ms.date: 11/06/2023
audience: ITPro
f1.keywords: NOCSH
ms.topic: troubleshooting
search.appverid: MET150
ms.custom: 
  - CSSTroubleshoot
  - CI 183789
ms.service: viva
ms.collection:
  - M365initiative-viva
  - highpri
  - Tier1
---
# Self-help diagnostics for Microsoft Viva administrators

Microsoft 365 self-help diagnostics are a set of tools available in the Microsoft 365 admin center that can help administrators diagnose and resolve common issues quickly. 

> [!NOTE]
> These diagnostics aren't available for the GCC High or DoD environments, or for Microsoft 365 operated by 21Vianet.

## Run diagnostics

1. Sign in to the [Microsoft 365 admin center](https://go.microsoft.com/fwlink/p/?linkid=2024339).
1. In the navigation pane, select **Support** > **Help & support**. If you don't see **Support**, select **Show all**.
1. Under **How can we help?**, type a phrase that describes your issue, and press Enter.

   :::image type="content" source="media/viva-self-help-diagnostics/viva-diagnostics.png" alt-text="Screenshot of the pane to search for help in the Microsoft 365 admin center.":::

   If your issue is covered by one of the available diagnostics, the **Run diagnostics** section is displayed.
  
1. In the **SharePoint Online root URL** field, enter the URL of your tenant, and then select **Run Tests**.

## Scenarios covered by diagnostics

The following diagnostics are available for various apps in the Viva suite. Each diagnostic is listed with a brief description of its function, a shortcut link and the related support article.

|Diagnostic|Description|Shortcut link|Support article|
|----------|-----------|------------|------------|
|Viva Connections Home Site Configuration|Diagnose setup and other related issues with the Home Site. |[Run Tests: Viva Connections Home Site Setup](https://aka.ms/PillarVivaConnectionsHome)|[Create a SharePoint home site for Viva Connections](/viva/connections/create-sharepoint-home-site-for-viva-connections)|
|Viva Connections Desktop Client Error|Diagnose Viva Connections Desktop client errors when custom components are added to Viva Connections.|[Run Tests: Viva Connections Custom Components](https://aka.ms/PillarVivaConnectionsDesktop)|[Error accessing Viva Connections app from Teams desktop client](/viva/troubleshoot/connections/error-accessing-app-from-teams-desktop)|
|Viva Learning Content Integration with SharePoint|Diagnose Viva Learning content integration issues with SharePoint as the content source. |[Run Test: Viva Learning Content Integration with SharePoint](https://aka.ms/PillarVivaLearningSharePointConfig)|[Add SharePoint as a content source for Microsoft Viva Learning](/viva/learning/configure-sharepoint-content-source)|

**Note**:
After you implement a fix based on the results of a diagnostic, you can rerun the diagnostic to make sure that the issue is completely resolved.  

Still need help? Go to the [Microsoft Community](https://answers.microsoft.com/).
