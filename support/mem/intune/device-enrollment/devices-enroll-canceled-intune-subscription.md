---
title: Troubleshoot when devices try to enroll in a canceled Intune subscription
description: Fixes an issue in which devices keep trying to enroll in an Intune subscription that has been canceled.
ms.date: 12/05/2023
search.appverid: MET150
ms.reviewer: kaushika
---
# Devices continue to try to enroll in a canceled Intune subscription

This article fixes an issue in which devices keep trying to enroll in an Intune subscription that has been canceled.

## Symptoms

Consider the following scenario:

- A user's Intune subscription was canceled, and the Intune admin console can no longer be accessed.
- A different MDM provider was selected. The MDM authority for the tenant is still set to Intune, Office 365, or Configuration Manager.

In this scenario, the user's devices continue trying to enroll in Intune.

## Cause

This issue occurs if the CNAMEs that were set as prerequisites for device enrollment are still present. As long as these CNAMEs are still present, automatic enrollment of devices without specification of an enrollment server is redirected to the Microsoft Intune servers. This behavior is by design. If the customer sets up CNAME forwarding with their domain name provider to point towards the Intune service, their devices will try to enroll in Intune. To fix this behavior, the customer should modify their CNAME records with their domain name provider.

The MDM authority has no effect on another provider's MDM solution as long as devices are not redirected to Intune enrollment servers with old CNAMEs that may still be present. After the MDM authority is configured, it will remain that way unless a customer opts to change to another structure within the possible MDM configurations&mdash;for example, from Intune or Office 365 to Configuration Manager, or vice versa.

## Solution

If you switched your MDM provider from Microsoft Intune to another company, or if you don't want to switch to the Office 365 built-in MDM, check whether there are existing CNAMEs that were set as prerequisites for device enrollment.

If these CNAMEs remain present, your devices will continue trying to enroll in Intune MDM servers, because the enrollment and registration requests are being redirected to the Microsoft servers instead of to your new provider by the old CNAMEs' entries. To prevent this behavior while the CNAMEs are still set to Microsoft-based enrollment servers, you must override the enrollment server information in the device itself, assuming that option is available in the enrollment interface on the unit.

> [!NOTE]
> Verify that **none** of your domains have CNAMEs pointing to either `manage.microsoft.com` or `EnterpriseRegistration.windows.net`. If there are existing CNAMEs, you must delete these entries from your domain registrar's site and then set new CNAMEs specified by your new provider.

### Example

Assume that you have an Office 365 tenant for *contoso.onmicrosoft.com* and have verified the *contoso-1.com*, *contoso-2.com*, *contoso-3.net* domains. In this situation, you must check all possible CNAMEs for these domains. To check CNAMEs, open a command prompt, and then enter the following command:

```console
nslookup -type=cname enterpriseenrollment.<domain>.<com>
```

If a CNAME is set, the reply will resemble the following:

> Non-authoritative answer:  
> enterpriseenrollment.\<domain>.\<com> canonical name = manage.microsoft.com

Now, enter the following command at a command prompt:

```console
nslookup -type=cname enterpriseregistration.<domain>.<com>
```

If a CNAME is set, the reply will resemble the following:

> Non-authoritative answer:  
> enterpriseenrollment.\<domain>.\<com> canonical name = EnterpriseRegistration.windows.net

Additionally, you can check any available online tool from several entities for a simplified webpage guided lookup procedure. This procedure also lets you check different DNS hierarchy branches by using tool providers in different regions to make sure that all changes that were submitted at your domain registrar have percolated through the hierarchy. Remember that DNS changes may take as long as several days in some cases.

> [!IMPORTANT]
> In the preceding example, you must check whether you have CNAMEs set for any of the following entries and if so, what they point to:
>
> - enterpriseenrollment.contoso-1.com
> - enterpriseregistration.contoso-1.com
> - enterpriseenrollment.contoso-2.com
> - enterpriseregistration.contoso-2.com
> - enterpriseenrollment.contoso-3.net
> - enterpriseregistration.contoso-3.net

If you find any entries that point to either `manage.microsoft.com` or `EnterpriseRegistration.windows.net`, you must delete these entries from your domain registrar's site and then set the new CNAMEs that are specified by your new provider.
