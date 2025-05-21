---
title: Error when uninstalling Portals solutions
description: Provides a solution to a dependency error attempting to uninstall Portals solutions from Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.custom: sap:Working with Solutions
---
# Dependency error when you try to uninstall Portals solutions from Microsoft Dynamics 365

This article provides a solution to a dependency error that occurs when you try to uninstall Portals solutions from Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4500989

## Symptoms

Uninstalling a portals solution such as MicrosoftCrmPortalBase or MicrosoftCrmPortalDependency fails with the following error:

> "Solution [Solution Name] cannot be deleted due to dependencies from other components in the system. Remove all dependencies to allow for solution deletion.
>
> Error code 8004f01f."

## Cause

When installing portal capabilities for Dynamics 365, multiple solutions are installed. Some of the solutions include core portal features and others include specific functionality (that is, Customer Portal or Employee Self Service). When installing the solutions, the core solutions gets installed first and then the specific ones. Once installed, you may also have done customizations to the portal solution(s).

## Resolution

To uninstall the portals solutions successfully, you need to follow the steps in reverse order.

1. Undo customizations of portal entities (if applicable).
2. Uninstall solutions in reverse order of how they were installed. Refer to the table below for each package Un-installation sequence (top to bottom).

    |BasePortal|CommunityPortal|CustomerPortal|ESSPortal|StarterPortal|
    |---|---|---|---|---|
    |BasePortal|CommunityPortal|CustomerPortal|ESSPortal|StarterPortal|
    |BaseHtmlContentDesigner|BaseHtmlContentDesigner|BaseHtmlContentDesigner|BaseHtmlContentDesigner|BaseHtmlContentDesigner|
    |MicrosoftAzureStorage|MicrosoftAzureStorage|MicrosoftAzureStorage|MicrosoftAzureStorage|PortalTimeline|
    |MicrosoftBadges|MicrosoftBadges|KnowledgeManagement|KnowledgeManagement|MicrosoftAzureStorage|
    |KnowledgeManagement|KnowledgeManagement|CustomerService|CustomerService|Feedback|
    |CustomerService|CustomerService|PortalTimeline|PortalTimeline|MicrosoftWebForms|
    |PortalTimeline|PortalTimeline|MicrosoftForumsWorkflows|MicrosoftForumsWorkflows|MicrosoftIdentityWorkflows|
    |MicrosoftIdeasWorkflows|MicrosoftIdeasWorkflows|MicrosoftForums|MicrosoftForums|MicrosoftIdentitySystemWorkflows|
    |MicrosoftIdeas|MicrosoftIdeas|Feedback|Feedback|MicrosoftIdentity|
    |MicrosoftForumsWorkflows|MicrosoftForumsWorkflows|MicrosoftWebForms|MicrosoftWebForms|WebNotification|
    |MicrosoftForums|MicrosoftForums|MicrosoftIdentityWorkflows|MicrosoftIdentityWorkflows|MicrosoftCrmPortalBaseWorkflows|
    |MicrosoftBlogs|MicrosoftBlogs|MicrosoftIdentitySystemWorkflows|MicrosoftIdentitySystemWorkflows|MicrosoftCrmPortalBaseSystemWorkflows|
    |Feedback|Feedback|MicrosoftIdentity|MicrosoftIdentity|MicrosoftCrmPortalBase|
    |MicrosoftWebForms|MicrosoftWebForms|WebNotification|WebNotification|msdynce_PortalPrivacyExtensions|
    |MicrosoftIdentityWorkflows|MicrosoftIdentityWorkflows|MicrosoftCrmPortalBaseWorkflows|MicrosoftCrmPortalBaseWorkflows|MicrosoftCrmPortalDependencies|
    |MicrosoftIdentitySystemWorkflows|MicrosoftIdentitySystemWorkflows|MicrosoftCrmPortalBaseSystemWorkflows|MicrosoftCrmPortalBaseSystemWorkflows||
    |MicrosoftIdentity|MicrosoftIdentity|MicrosoftCrmPortalBase|MicrosoftCrmPortalBase||
    |WebNotification|WebNotification|msdynce_PortalPrivacyExtensions|msdynce_PortalPrivacyExtensions||
    |MicrosoftCrmPortalBaseWorkflows|MicrosoftCrmPortalBaseWorkflows|MicrosoftCrmPortalDependencies|MicrosoftCrmPortalDependencies||
    |MicrosoftCrmPortalBaseSystemWorkflows|MicrosoftCrmPortalBaseSystemWorkflows|MicrosoftBingMapsHelper|MicrosoftBingMapsHelper||
    |MicrosoftCrmPortalBase|MicrosoftCrmPortalBase|MicrosoftGetRecordIDWorkflowHelper|MicrosoftGetRecordIDWorkflowHelper||
    |msdynce_PortalPrivacyExtensions|msdynce_PortalPrivacyExtensions||||
    |MicrosoftCrmPortalDependencies|MicrosoftCrmPortalDependencies||||
    |MicrosoftBingMapsHelper|MicrosoftBingMapsHelper||||
    |MicrosoftGetRecordIDWorkflowHelper|MicrosoftGetRecordIDWorkflowHelper||||
