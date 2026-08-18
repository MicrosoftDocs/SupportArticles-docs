---
title: Troubleshoot Personalization in Customer Insights - Journeys
description: Find out why personalization placeholders render empty or journey conditions fail in Dynamics 365 Customer Insights - Journeys, and how to fix the causes.
ms.date: 08/17/2026
ms.reviewer: alfergus, v-shaywood
ms.custom: sap:Real-time journeys emails, templates, content blocks - personalization, survey
ai-usage: ai-assisted
search.audienceType: 
  - admin
  - customizer
  - enduser
---

# Troubleshoot personalization issues in Customer Insights - Journeys

## Summary

This article explains why personalization in Dynamics 365 Customer Insights - Journeys can produce unexpected results, such as dynamic text that renders as an empty placeholder or a journey condition that evaluates differently than you expect. It covers the identities that run personalization queries during preview and live journey execution, and the most common causes: business unit scoping, field-level security, data that isn't available when the query runs, and Dataverse customizations registered for `Retrieve` and `RetrieveMultiple`. It also gives steps to diagnose the issue and to add default values so that messages stay complete.

## Personalization scope and data retrieval

This guidance applies wherever you use personalization, including:

- **Dynamic text** in messages, such as emails, text messages, and push notifications, and in forms.
- **Message conditions** used for inline or conditional content in messages.
- **Journey conditions**, such as attribute branches and if/then steps.
- **Journey filters**, including trigger attribute conditions that determine whether an audience member enters or continues in a journey.
- **Record and task creation** actions that use data bindings to populate values in new records.

Each personalization placeholder uses a **Dataverse query** to retrieve data. During preview or journey execution, Customer Insights - Journeys runs the query and reads the referenced table row. The query might also follow one or more table relationships to find the value. If a required row doesn't exist or can't be read when the query runs, the placeholder appears empty. A condition treats the value as missing, so it typically evaluates to *false* or follows the *else* branch.

> [!TIP]
> Most empty placeholders and unexpected branches come down to one question: **When the placeholder was evaluated, could the identity running the query read the required data?** The rest of this article helps you answer that question.

## Identities used for preview and live journey execution

Personalization queries for emails and other message content run under different identities during preview and live journey execution:

- **Preview uses the identity of the signed-in user.** When you preview a message, the query runs as *you* and returns only the data that you have permission to access.
- **Live journey execution uses the `Cxp Dataverse Datasource Services User`.** When a published journey sends a message, the query runs under this service account rather than your account or the journey creator's account. The service account has the `Service Reader` role, which lets it read records regardless of ownership. However, the journey's business unit scope and field-level security can still restrict access.

Because preview and live execution use different identities, personalized content might appear correctly in preview but be empty in the delivered message, or the reverse. If preview and live results differ, first check whether the two identities have different access to the required data.

Journey conditions and filters are evaluated only at run time. They don't have a "preview as me" option. If they produce an unexpected result, check the journey's business unit scope rather than your own access permissions.

## Common causes of personalization issues

The following sections describe the most common causes, in roughly the order you should check them.

### Business unit scope prevents access to records

For organizations that use business unit scoping, this issue is the most common cause of personalization issues. The referenced data exists, but the journey can't access it because the record belongs to a different business unit.

When business unit scoping is enabled, a query returns a record only when its owner or business unit exactly matches the journey's business unit. The platform's parent-child business unit hierarchy doesn't apply: records in child business units aren't included. This scope applies only to journeys. Records that a journey creates, such as tasks, inherit ownership from the journey and remain accessible to it.

This filtering applies to *every related record* that the query follows. A query can therefore fail even when its starting and destination records are accessible if an intermediate record isn't accessible.

For more information about ownership models, access levels, business units, and related records, see [How record ownership and business units affect personalization](/dynamics365/customer-insights/journeys/personalization-ownership-business-units).

### Field-level security prevents access to columns

If a placeholder references a column protected by **field-level security (FLS)**, the query returns *null* unless the identity running the query has access through the appropriate field security profile.

Preview runs the query as *you*, but live execution uses the `Cxp Dataverse Datasource Services User`. As a result, a placeholder might work in preview but fail during live execution. To use FLS-protected attributes in personalization, journey branching, or segmentation, enable the override and add the required service users to the appropriate field security profiles. For instructions, see [Override field-level security attributes](/dynamics365/customer-insights/journeys/overriding-fls-attributes).

> [!IMPORTANT]
> If you skip adding the service users to the field security profiles, FLS-protected fields are evaluated as *null* during internal system evaluations. This condition can cause empty content and failed conditions that are difficult to diagnose.

### Data isn't available when the query runs

The required data might not exist when personalization is evaluated. For example, a plugin, Power Automate flow, integration, or earlier process might still be updating the data when the journey tries to read it.

If an external system starts a journey and then populates data that the journey uses, raise the trigger only after all required data is available in Dataverse.

To identify a race condition, enable **Dataverse auditing** for the relevant tables and columns. Compare the audit timestamps with the time the journey ran. If a value was written after the journey tried to read it, the issue is timing rather than permissions.

To learn more about Dataverse auditing, see [Manage Dataverse auditing](/power-platform/admin/manage-dataverse-auditing).

To avoid this issue, use one or more of the following options:

- Add a short wait or timer before the personalization step.
- Start the journey from a later signal that is sent only after the data is ready.
- Add a **default value** to the personalized element so that the message remains complete when data is missing.

### Customizations or plugins change query results

Personalization reads data by using the standard Dataverse `Retrieve` and `RetrieveMultiple` requests. A synchronous customization registered for either request can change the data returned to personalization. For example, a plugin step might filter rows, clear or change attribute values, add `LinkEntity` conditions, or produce an error when it runs under the service user's identity. The record might look correct in the app even though the customization changes what the personalization query returns.

To investigate:

- Review the plugin steps registered for `Retrieve` and `RetrieveMultiple` on every table in the binding, including related tables in a multistep binding.
- Check whether any step behaves differently based on the calling user. In a nonproduction environment, test with the relevant steps temporarily disabled.
- Confirm that the customization doesn't depend on data or context available only to interactive users and not to the `Cxp Dataverse Datasource Services User`.

## Diagnose personalization issues

If a placeholder is empty or a condition produces an unexpected result, follow these steps:

1. **Compare preview and live results.** Preview runs as the signed-in user, while a live journey runs as the `Cxp Dataverse Datasource Services User`. If the results differ, check whether business unit scoping, field-level security, or a customization gives these identities different access to the data.
1. **Verify record ownership and business units.** Check the referenced record and every related record that the query follows. Each record must be accessible within the journey's business unit scope. For more information, see [How record ownership and business units affect personalization](/dynamics365/customer-insights/journeys/personalization-ownership-business-units).
1. **Review field-level security.** Check whether the referenced columns are protected and whether the identity running the query has access to them. For instructions, see [Override field-level security attributes](/dynamics365/customer-insights/journeys/overriding-fls-attributes).
1. **Confirm that the data was available in time.** Use Dataverse auditing to compare when the data was created or updated with when the journey tried to read it.
1. **Review Dataverse customizations.** Check the plugin steps registered for `Retrieve` and `RetrieveMultiple` on every table in the binding.
1. **Provide a fallback for missing data.** Add default values to personalized elements so that messages remain complete when data is unavailable.

## See also

- [How record ownership and business units affect personalization](/dynamics365/customer-insights/journeys/personalization-ownership-business-units)
- [Override field-level security attributes](/dynamics365/customer-insights/journeys/overriding-fls-attributes)
- [Personalize content](/dynamics365/customer-insights/journeys/real-time-marketing-personalization)
- [Business unit support in real-time journeys](/dynamics365/customer-insights/journeys/real-time-marketing-business-units)
- [Customer Insights - Journeys service users](/dynamics365/customer-insights/journeys/admin-users-licenses-roles#customer-insights---journeys-service-users)
- [Manage Dataverse auditing](/power-platform/admin/manage-dataverse-auditing)
