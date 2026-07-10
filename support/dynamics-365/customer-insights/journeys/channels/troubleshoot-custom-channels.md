---
title: Troubleshoot Custom Channels in Customer Insights - Journeys
description: Troubleshoot custom channels in Customer Insights - Journeys. Learn to fix SMS provider setup, message submission failures, and analytics issues today.
ms.date: 07/06/2026
ms.reviewer: alfergus, v-shaywood
ms.custom: "sap:Real-time journeys channels: text messages, push notifications, more"
search.audienceType: 
  - admin
  - customizer
  - enduser
---

# Troubleshoot custom channels in Customer Insights - Journeys

## Summary

This article helps you diagnose and fix common issues with custom channels in Dynamics 365 Customer Insights - Journeys. It covers problems that occur when you set up an SMS provider or custom channel. It also addresses message submission failures, such as an `InternalChannelFailure` error or a `Not sent` status. In addition, it explains analytics that don't match what you expect, such as a plugin that runs more than once when it exceeds the channel execution timeout. For each symptom, you learn what to check in your channel configuration and custom channel plugin, including how to use plugin trace logs to find the root cause and restore channel reliability.

## Can't save an SMS provider or custom channel

You can't save a new SMS provider or custom channel in the setup wizard. This problem usually means the associated custom channel solution is missing a required component. Check the following components of the solution:

1. Check that there's an entity that represents a channel sending instance (sender) extended configuration. For custom SMS channels, there should also be an entity that represents a channel sending instance account (SMS provider) extended configuration. These entities shouldn't have any lookups that point to the `msdyn_channelinstance` or `msdyn_channelinstanceaccount` tables.

    > [!IMPORTANT]
    > The logical name and physical name of both entities should use lowerCamelCase.

1. The sender extended configuration table should have a relationship from the `msdyn_channelinstance.extendedentityid` polymorphic lookup attribute to the sender extended configuration table that you created in the custom channel. For a custom SMS channel, create a similar relationship from `msdyn_channelinstanceaccount.extendedentityid` to the provider extended configuration table.

For setup examples, see the [sample solutions](/dynamics365/customer-insights/journeys/real-time-marketing-extend-outreach-custom-channels#sample-solutions).

## Message submission failures

### Message submission fails with an `InternalChannelFailure` error

This error appears in the analytics details only when Customer Insights - Journeys receives an error from the triggered custom channel plugin. It means there's a problem with the plugin implementation that the plugin developer needs to investigate. The developer should turn on [plugin trace logs](/power-apps/developer/data-platform/logging-tracing), reproduce the failure, and review the plugin logs to find the root cause.

### A message returns a `Not sent` status without details

A `Not sent` status with no details means the custom channel plugin didn't return more information to Customer Insights - Journeys. Ask the plugin developer to extend the plugin response to include the `Details` object that's described in [Outbound custom API](/dynamics365/customer-insights/journeys/real-time-marketing-custom-channel-custom-API#outbound-custom-api).

### A plugin runs twice for a single recipient but analytics show one execution

Your plugin runs more than once for the same recipient, but analytics record only a single execution. Custom channels enforce a maximum execution timeout of 20 seconds. If your plugin doesn't finish within that limit, the custom channel request times out. When this timeout occurs, the system treats the attempt as failed and starts another attempt to run the plugin. Because your plugin might still be running after the custom channel times out, the same recipient can trigger multiple plugin runs.

To resolve this issue, use one of the following methods:

- Improve the plugin's performance. You can enhance the plugin itself by following [Best practices and guidance regarding plug-in and workflow development for Microsoft Dataverse](/power-apps/developer/data-platform/best-practices/business-logic/), or you can improve the performance of the external service that the plugin calls.

- Use the [plugin request](/dynamics365/customer-insights/journeys/real-time-marketing-custom-channel-custom-API#outbound-custom-api) payload's `IdempotencyId` field, which keeps the same value between retries. You can skip the plugin run if `IdempotencyId` already has a value from a past submission.

## Missing delivery statistics in analytics

The custom channel runs successfully, but delivery statistics remain empty. Custom channels require a separate setup to collect delivery reports. To let Customer Insights - Journeys know the delivery status and generate the correct analytics, your environment should run [the delivery report custom API](/dynamics365/customer-insights/journeys/real-time-marketing-custom-channel-custom-API#delivery-report-custom-api).

## Related content

- [Create custom channels in Customer Insights - Journeys](/dynamics365/customer-insights/journeys/real-time-marketing-create-custom-channels)
- [Define an extended configuration entity for the channel instance](/dynamics365/customer-insights/journeys/real-time-marketing-define-custom-channel-instance)
- [Debug plug-ins (Microsoft Dataverse)](/power-apps/developer/data-platform/debug-plug-in)
