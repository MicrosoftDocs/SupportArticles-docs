---
title: Actionable message doesn't automatically refresh in the Outlook reading pane
description: Provides a resolution for an issue in which an actionable message doesn't automatically refresh in the Outlook reading pane.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
  - CI 174591
ms.reviewer: michael.green, gbratton, meerak, v-trisshores
appliesto: 
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---

# Actionable message doesn't automatically refresh in the Outlook reading pane

## Symptoms

Consider the following scenario:

1. A recipient of an actionable message in Outlook for Microsoft 365 opens the message in a pop-out window.

2. The recipient performs an action on the actionable message in the pop-out window that causes the message to update. For example, a recipient selects an **Approve** button in the message, and the following text then appears next to the button: "Your request is approved".

In this scenario, although the user action updates the actionable message in the pop-out window, the reading pane view of the message doesn't automatically refresh to reflect the latest state of the message.

## Cause

Outlook refreshes the reading pane view of an actionable message based on a combination of:

- Whether the [adaptive card](/outlook/actionable-messages/adaptive-card#additional-properties-on-the-adaptivecard-type) payload in the message defines the [autoInvokeAction](/outlook/actionable-messages/auto-invoke#using-autoinvokeaction) property

- A user procedure in Outlook that triggers a refresh.

Outside the specific combinations that are described in the "More information" section of this article, the reading pane might not refresh.

## Resolution

If the actionable message defines the [autoInvokeAction](/outlook/actionable-messages/auto-invoke#using-autoinvokeaction) property, recipients can resolve this issue by saving the pop-out window view of an actionable message. That procedure triggers an automatic refresh of the Outlook reading pane view, as described in "Scenario A" in the "More information" section of this article.

> [!NOTE]
> You can use the [Actionable messages debugger for Outlook](https://appsource.microsoft.com/product/office/WA104381686) add-in to check whether an actionable message defines the `autoInvokeAction` property. Developers of actionable messages can use the Microsoft [Actionable Message Designer](https://amdesigner.azurewebsites.net) to define the `autoInvokeAction` property.

## Workaround

If the actionable message doesn't define the [autoInvokeAction](/outlook/actionable-messages/auto-invoke#using-autoinvokeaction) property, recipients can work around this issue by manually refreshing the Outlook reading pane view. Refer to "Scenario B" in the "More information" section of this article.

## More information

After a recipient updates an actionable message in a pop-out window, Outlook refreshes the reading pane view of the message in the following scenarios.

### Scenario A: Actionable message defines the autoInvokeAction property

In this scenario, the [adaptive card](/outlook/actionable-messages/adaptive-card#additional-properties-on-the-adaptivecard-type) payload in the actionable message defines the [autoInvokeAction](/outlook/actionable-messages/auto-invoke#using-autoinvokeaction) property, and the recipient performs either of the following procedures:

- Saves the pop-out window view of the actionable message.

- Reopens the actionable message in the reading pane. For example, by opening a different message in the reading pane and then switching back to the actionable message.

> [!NOTE]
> The `autoInvokeAction` property provides an HTTP service endpoint for Outlook to retrieve an up-to-date actionable message. Depending on your organization's implementation of the HTTP service, the provided actionable message might have a state that's based on the cumulative actions of all recipients.

### Scenario B: Actionable message doesn't define the autoInvokeAction property

In this scenario, the [adaptive card](/outlook/actionable-messages/adaptive-card#additional-properties-on-the-adaptivecard-type) payload in the actionable message doesn't define the [autoInvokeAction](/outlook/actionable-messages/auto-invoke#using-autoinvokeaction) property, and the recipient performs either of the following procedures:

- Closes the pop-out window, opens a different message in the reading pane, and then reopens the actionable message in the reading pane.

- Restarts Outlook, and then reopens the actionable message in the reading pane.

> [!NOTE]
> If the adaptive card doesn't define the `autoInvokeAction` property, Outlook refreshes the reading pane view by displaying the latest actionable message that the recipient previously opened in Outlook.
