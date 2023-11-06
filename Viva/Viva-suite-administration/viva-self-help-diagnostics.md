---
title: Self-help diagnostics for Microsoft Viva administrators
description: Lists available self-help diagnostics for Viva administrators and describes how to run these diagnostics in the Microsoft 365 admin center.
manager: dcscontentpm
ms.author: loreenl
ms.reviewer: loreenl
ms.date: 11/06/2023
audience: ITPro
f1.keywords: NOCSH
ms.topic: troubleshooting
search.appverid: MET150
ms.custom: 
  - CSSTroubleshoot
  - CI 183789
  - viva-suite-admin
localization_priority: Normal
ms.service: viva
ms.collection:
  - M365initiative-viva
  - highpri
  - Tier1
---
# Self-help diagnostics for Microsoft Viva administrators

Microsoft 365 self-help diagnostics are a set of tools available in the Microsoft 365 admin center when you're signed in as an administrator. These tools can help you quickly diagnose and resolve common issues. You must be a Microsoft 365 administrator to run diagnostics.

> [!NOTE]
> These diagnostics aren't available for the GCC High or DoD environments, or for Microsoft 365 operated by 21Vianet.

## How to run diagnostics

1. Sign in to the [Microsoft 365 admin center](https://go.microsoft.com/fwlink/p/?linkid=2024339).
1. On the navigation pane, select **Support** > **Help & support**. If you don't see **Support**, select **Show all**.
1. Under **How can we help?**, enter a phrase that describes your issue, and then press Enter.

   :::image type="content" source="media/viva-self-help-diagnostics/viva-diagnostics.png" alt-text="Screenshot that shows how to search for Viva diagnostics.":::
1. If your issue is covered by one of the diagnostics, the **Run diagnostics** section appears.
1. Under **SharePoint Online root URL**, enter the URL of your tenant, and then select **Run Tests**.

## Scenarios covered by diagnostics

The following table lists current diagnostics that cover various scenarios in Microsoft Viva. Each diagnostic is listed together with a brief description of its function, a shortcut link and the related support article.

|Diagnostic|Description|Shortcut Link|Support article|
|----------|-----------|------------|------------|
|Viva Connections Home Site Configuration|Diagnose setup and other related issues with the Home Site. |[Run Tests: Viva Connections Home Site Setup](https://aka.ms/PillarVivaConnectionsHome)|[Create a SharePoint home site for Viva Connections](/viva/connections/create-sharepoint-home-site-for-viva-connections)|
|Viva Connections Desktop Client Error|Diagnose Viva Connections Desktop client errors when custom components are added to Viva Connections.|[Run Tests: Viva Connections Custom Components](https://aka.ms/PillarVivaConnectionsDesktop)|[Error accessing Viva Connections app from Teams desktop client](/viva/troubleshoot/connections/error-accessing-app-from-teams-desktop)|
|Viva Learning Content Integration with SharePoint|Diagnose Viva Learning content integration issues with SharePoint as the content source. |[Run Test: Viva Learning Content Integration with SharePoint](https://aka.ms/PillarVivaLearningSharePointConfig)|[Add SharePoint as a content source for Microsoft Viva Learning](/viva/learning/configure-sharepoint-content-source)|

> [!NOTE]
> If a diagnostic detects an issue, and you've implemented a fix based on the results, consider rerunning the diagnostic to make sure that the issue is completely resolved.  

Still need help? Go to the [Microsoft Community](https://answers.microsoft.com/).