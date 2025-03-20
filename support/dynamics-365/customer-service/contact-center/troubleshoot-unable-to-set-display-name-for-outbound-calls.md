---
author: Sreenivasa Yerragovula
ms.author: srreddy
ms.service: azure-advisor
ms.topic: troubleshooting-general
ms.date: 03/19/2025
title: Troubleshoot unable to set display name for outbound calls
description: Caller ID in Dynamics 365 shows phone numbers, not custom names.
---
# Troubleshoot unable to set display name for outbound calls

This article addresses the issue where customers cannot configure a display name (such as their company name) to be shown as the caller ID for outbound calls in Dynamics 365 Customer Service.

## Prerequisites

- Ensure Dynamics 365 Customer Service is properly configured and updated to the latest version.
- Verify access to the outbound profile settings in the Dynamics 365 Customer Service admin center.

## Potential quick workarounds

### Workaround: Use the toll-free number as the caller ID

1. Configure the outbound profile to display the toll-free phone number as the caller ID.
2. Inform your customers that the toll-free number represents your organization.

## Troubleshooting checklist

### Troubleshooting step

- Confirm that the outbound profile is configured correctly in Dynamics 365 Customer Service.
- Ensure you have reviewed the Microsoft documentation on configuring outbound and inbound profiles.

## Cause: Display name limitation in outbound profiles

The ability to display a company name or custom text as the caller ID for outbound calls is currently not supported in Dynamics 365 Customer Service. The "Number label" field in the outbound profile is used solely in the agent dialer interface and does not appear to the customer receiving the call.

## Solution: Use a phone number for caller ID

1. Configure the outbound profile to display a specific phone number (e.g., a toll-free number) as the Caller ID Number.
2. Refer to [Configure outbound and inbound profiles | Microsoft Learn](/dynamics365/customer-service/administer/configure-outbound-inbound-profiles) for detailed instructions on setting up outbound profiles.

## Advanced troubleshooting and data collection

If further assistance is required, consider collecting the following information before contacting Microsoft Support:

- Details of the outbound profile configuration.
- Screenshots of the settings in Dynamics 365 Customer Service.
- A description of the issue, including any error messages encountered.

For more information, consult the official documentation link provided above.