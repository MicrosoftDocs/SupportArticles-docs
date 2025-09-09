---
title: Messages in Teams and Viva Engage unexpectedly deleted by retention policies
description: Explains why messages are unexpectedly deleted from the Teams or Viva Engage apps in some scenarios if retention policies are used in your organization. 
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Security and Compliance (Retention, etc)\Retention
  - CI 164175
  - CSSTroubleshoot
ms.reviewer: kyrachurney, cabailey, lifreda
appliesto: 
  - Microsoft Teams
  - Viva Engage
search.appverid: 
  - MET150
ms.date: 10/30/2023
---
# Messages in the Teams and Viva Engage apps are unexpectedly deleted by retention policies

## Symptoms

Messages are unexpectedly deleted from Microsoft Teams or Viva Engage by retention policies in scenarios such as the following:

- Your organization has a retention policy that's configured to exclude the location or apply to only other locations.
- Your organization has a retention policy that's configured to apply to the location but for a longer specified retention period.
- Your organization doesn't use retention policies. However, another organization that hosts conversations that your users participate in does use retention policies.

## Cause

When the back-end service receives a delete command because of a retention policy, the corresponding message in the Teams or Viva Engage app is deleted for all users in the conversation. Some of these users might be from another organization, have a retention policy that has a longer retention period, or have no retention policy assigned to them. For these users, copies of the messages are still stored in their mailboxes and remain searchable for eDiscovery until the messages are permanently deleted.

Messages that are visible in the Teams and Viva Engage apps aren't the compliance copies. Their visibility in the apps doesn't reflect whether the messages are retained or permanently deleted for compliance requirements.

## More information

For more information about how retention policies work together with Teams and Viva Engage, see the following articles:

- [How retention works with Microsoft Teams](/microsoft-365/compliance/retention-policies-teams?view=o365-worldwide#how-retention-works-with-microsoft-teams&preserve-view=true)
- [How retention works with Viva Engage](/microsoft-365/compliance/retention-policies-yammer?view=o365-worldwide#how-retention-works-with-yammer&preserve-view=true)
