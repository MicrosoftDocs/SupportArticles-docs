---
title: Troubleshoot Event Management in Customer Insights - Journeys
description: Fix event management issues in Dynamics 365 Customer Insights - Journeys, including session registrations, registration form errors, waitlists, and check-ins.
ms.date: 07/06/2026
ms.reviewer: alfergus, v-shaywood
ms.custom: sap:Real-time journeys Event Management
search.audienceType: 
  - admin
  - customizer
  - enduser
---

# Troubleshoot event management issues in Customer Insights - Journeys

## Summary

This article helps you troubleshoot event management problems in Dynamics 365 Customer Insights - Journeys. It covers sessions that don't accept registrations, registration form errors, missing confirmation emails, waitlists that don't promote, and check-ins that don't record. Find the symptom that matches your problem to identify the cause and the fix.

For problems with the Microsoft Teams integration, such as webinar streaming, authentication, and attendance tracking, see [Troubleshoot Teams integration issues for event management in Customer Insights - Journeys](troubleshoot-teams-integration.md).

## A session isn't accepting registrations even though the event is published

Sessions have their own publish state, separate from the parent event. The most common cause is that the event is **Live** but the session is still in **Draft**. Open the session record and check its status. It must be **Live** for registrations to go through. To publish the session, use the **Go-Live** action.

If the event and session are both **Live** and registrations still fail, the error message provides more information. For details, see [The registration form returns an error](#the-registration-form-returns-an-error).

## The registration form returns an error

The error text usually indicates the cause:

- **Required field + \<FieldName>**: A required custom registration field wasn't filled in. Fill in the required field or have an admin make the field optional.
- **Event is not live or in Draft**: The event isn't published. Publish it by using the **Go-Live** action.
- **No capacity or Event is full**: Registrations are at capacity. If you expected the waitlist to handle this condition, the waitlist isn't turned on.
- **Duplicate or anything contact-related**: Duplicate-detection rules blocked the contact from being created. An admin needs to review the rules or merge existing contacts.

If you have access to the **Plug-in Trace Log**, the log entry is more detailed than the form error. An admin can open the log by using **Advanced Find**. The admin must first turn on plug-in tracing under **System Settings** > **Customization** and change the setting to **Exception or All**. Otherwise, nothing is captured.

## Registration looks successful but no confirmation email was received

Work through these steps in order:

1. Check that the registration record exists and isn't canceled.
1. Check that the contact has a valid email address.
1. Check where the email is supposed to come from, either directly from the registration confirmation or from a journey.

## A cancellation happened but the waitlist didn't promote anyone

First, make sure capacity is below the limit after the cancellation. Sometimes other registrations come in and take the slot, which is intended behavior for the waitlist.

For more information, see [Set up and manage an event waitlist](/dynamics365/customer-insights/journeys/set-up-and-manage-waitlist).

## The event check-in URL doesn't record an attendee as checked in

To create a check-in record (`msevtmgt_eventcheckin`), the attendee's response must reach the `/eventmanagement/checkin/stream` endpoint. A check-in URL looks like the following example:

```url
/api/v1.0/orgs/<orgId>/eventmanagement/checkin/stream?eventRegistrationId=ER%20<registrationCode>&redirectUri=<redirectUri>
```

Two common problems can occur with the URL:

- **\<orgId>**: Might have the wrong value. A known problem is under investigation in which some emails include an org ID that doesn't match the environment where the registration was created.
- **\<registrationCode>**: Might be empty. The Customer Insights - Journeys email designer normally substitutes a personalized `ER` value here, but **Test send** and **Preview** emails skip this substitution. The value can also be missing if the underlying event or session registration is deleted after the email went out. This case is covered in more detail later in this section.

You can embed this URL in the email in only one way. The **Join** button in the Customer Insights - Journeys email must use **Link to: Teams meeting** in the email designer's **Insert link** menu. Plain URLs, generic **Page** links, or any other link type still open the meeting correctly, but the response never reaches `/eventmanagement/checkin/stream` and no check-in record is created.

To confirm the link, follow these steps:

1. Open the email in the designer.
1. Select the **Join** button or link.
1. Check the **Link to** value in the link editor. It must read **Teams meeting**.

> [!NOTE]
> The **Add-to-Calendar Join** link also produces a check-in.

If the link is configured correctly but no check-in record is created, one of the following causes usually applies:

1. **The attendee joined from somewhere else**: Teams calendars, Outlook calendars, Teams meeting notifications, and raw Teams links shared by the organizer all bypass the check-in flow. Only the **Join** button in the Customer Insights - Journeys email or the **Add-to-Calendar Join** link produce check-ins.
1. **The registration code in the URL is empty or unresolved**: This value is the `ER` value the URL includes, not the Dataverse `eventregistrationid` GUID. Two common reasons it ends up empty:

   - The email was sent through **Test send** or **Preview**, which doesn't substitute a real registration code for that placeholder.
   - The event or session registration was deleted from the environment after the email went out.

   In both cases, the response still reaches `/eventmanagement/checkin/stream`, but there's no registration to attach a check-in to, so nothing is recorded.

For missing entries in the Teams attendance report, which follow a different data path than individual `msevtmgt_eventcheckin` records, see [Teams attendance check-ins are missing from the attendance report](troubleshoot-teams-integration.md#teams-attendance-check-ins-are-missing-from-the-attendance-report).

For more information on the event check-in flow, see [Make the most of your event check-in flow](/dynamics365/customer-insights/journeys/optimize-check-in).

## Related content

- [Event planning and management](/dynamics365/customer-insights/journeys/event-management)
- [Set up an event](/dynamics365/customer-insights/journeys/set-up-event)
