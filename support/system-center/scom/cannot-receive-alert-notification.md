---
title: Can't receive alert notifications
description: Fixes an issue in which notifications of Operations Manager alerts may not be received.
ms.date: 04/15/2024
ms.reviewer: rpesenko
---
# Notification of Operations Manager alerts may not be received

This article helps you resolve an issue where recipients of alert subscriptions may not receive email notifications in System Center 2012 Operations Manager.

_Original product version:_ &nbsp; System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 2709639

## Cause

System Center Operations Manager can send email notifications for new alerts or alerts that have a change in resolution state. Email notifications are sent to all recipients who subscribe to the alert as long as the alert meets the defined criteria for the subscription and that all other prerequisites are met. If the alert doesn't meet all criteria, or if notification is configured incorrectly, intended recipients will not receive email notifications.

## Verify that notification prerequisites are met

The process for configuring System Center Operations Manager to send email notifications through SMTP server is described in [Configuring Notification](/previous-versions/system-center/operations-manager-2007-r2/dd440890(v=technet.10)).

The notification channel has to be configured by using the correct FQDN and port of the SMTP server. The address and port should be available from all management servers that are part of the notifications resource pool in System Center 2012 Operations Manager. If the address or port is blocked by firewall rules or anti-malware software, exclusions for the resource pool servers should be created.

The channel can be configured for anonymous authentication or Windows authentication. If anonymous authentication is selected, the SMTP server should either allow for anonymous connections or be configured to use an exclusion for the IP address of the notification resource pool management servers. If Windows authentication is selected, a Run As account will have to be created and associated with the notification account Run As profile. This account will have to have permission to send email messages through the SMTP server. For more information, see [Create and Configure a Notification Action Account](/previous-versions//dd440886(v=technet.10))

## Verify subscriber configuration

Each subscriber can have a schedule that specifies the time during which notifications will be sent to them. This is a general setting that affects all addresses that are configured for that subscriber. Each address that is defined for a subscriber can also have a schedule that specifies when that address is available to have notifications sent to it. This allows for lots of flexibilities with notifications.

For example, a subscriber could have general notification availability from 8 am to 5 pm every day of the week. However, this subscriber could have two addresses that have different notification times. For example, the subscriber could have a work address that is configured for Monday through Thursday and an alternative address that is configured for Friday through Sunday. If the subscriber is not receiving email notifications, the general subscriber availability and specific address availability must both be set before the notification can be sent.

The address to which the notification is sent should also be verified as a valid address. The SMTP server and email client of the subscriber should not have any filtering rules that are blocking email messages from the Operations Manager server or the domain name. The Reply-To address that's defined in the notification channel can be added as an exemption to any filtering rules on the SMTP server or client if this is necessary.

## Verify subscription applicability

Subscriptions can have multiple criteria that must be met for a notification to be sent. If any of the criteria are not met, no notification is sent.

In Operations Manager 2007 R2, the first two available criteria are for the alert to be raised by an instance that is a member of a specific group and for the alert to be raised by an instance of a specific class. In these two criteria, the instance that raised the alert should be listed in the source field of the alert. The alert will list only the name of the instance, not the class. If the class of which the instance is a member is not clear, the **Actions** menu will list the available actions for that class when the alert is highlighted in an Alert view. If class is a criterion, the class should be included in the subscription. Or the specific instance should be a member of any group for which the subscription is defined.

In System Center 2012 Operations Manager, several additional conditions were added as possible criteria for alert notification. Multiple conditions can be specified in a single subscription. But all conditions must be met for the notification to be sent. The rules that apply to class and group membership are the same rules that apply in Operations Manager 2007 R2.

In some cases, an alert may be raised by a watcher node or replication partner on behalf of an instance. In this situation, the source of the alert would be the watcher node or replication partner. Therefore, alert subscriptions that do not include the watcher node or replication partner as a source would not send an email notification. The most common instance of this would be missing agent heartbeat alerts in which the source is the instance of health service watcher for that health service.

Subscriptions can be created for specific rules and monitors. A specific alert can be highlighted in an Alert view, and a notification subscription can be created for that alert from the **Actions** menu or by right-clicking the alert and selecting the **Notifications** submenu. If multiple alerts have to be included in a subscription, the **Created by rules or monitors** criterion can be selected in the new subscription wizard, and multiple rules and monitors can be selected at one time.

By default, subscriptions will send notifications for all alert severity and priority levels unless other behavior is specified. Rules and monitors that create alerts of specific severity and priority will usually expose overrides to change the severity and priority of these alerts. Overrides of these alert properties can be useful to include in existing subscriptions alerts that are raised by these rules and monitors or to exclude such alerts from existing subscriptions.

In System Center 2012 Operations Manager, the alert notification will be sent when the alert first meets all criteria, regardless of resolution state, unless resolution state itself is a criterion. If alert suppression is enabled for the rule or monitor that raises an alert, only one notification will be sent when the subscription criteria are first met. No additional notifications will be sent until the alert is closed and a new alert is raised that meets all subscription criteria.

Criteria that look for specific text in the name or in custom fields can also prevent some alert notifications from being sent. Any criteria that allow for wildcard text may prevent notification if the wildcard values that are specified do not match the alert field that is specified. As a test, use a simpler wildcard value, or eliminate the criteria during testing to verify that the alert notification is sent.

## Notification delay

Alert subscriptions can be configured to send a notification only after the alert criteria remain unchanged for a while. For example, a subscription that is configured to send an email message after 20 minutes will not send a message if any of the alert properties change in less than 20 minutes so that they no longer meet the notification criteria. If the alert properties change to again meet the subscription criteria and remain for 20 minutes or more, the notification will be sent.

Properties that could change before notification is sent might be severity, priority, resolution state, or custom field properties. If the alert is generated by a monitor and configured to have the alert severity match the monitor state, a monitor state change before the delay interval expires could change the alert severity and prevent notification by a subscription that uses certain severity as a notification criterion.

If the notification resource pool management servers are experiencing periods of high resource utilization or workloads, alert notification could be delayed. Notification workflows are performed by the System Center Management service. Therefore, if this service is unavailable or is under load, notifications may not be received or may be delayed, even though other management functions and data processing seem to be occurring as usual.
