---
title: Deploy OMA-URIs to target a CSP through Intune, and a comparison to on-premises
description: This article describes the significance of CSPs, Open Mobile Alliance – Uniform Resources (OMA-URIs), and how custom mobile device management (MDM) policies are delivered to a Windows 10-based device with Microsoft Intune.
ms.date: 12/20/2021
ms.reviewer: kaushika, sausarka
author: helenclu
ms.author: sausarka
search.appverid: MET150
ms.custom: 
- CI 121166
- CSSTroubleshooting
- sap:device configuration
---

# Deploy OMA-URIs to target a CSP through Intune, and a comparison to on-premises

This article describes the significance of Windows Configuration Service Providers (CSPs), Open Mobile Alliance – Uniform Resources (OMA-URIs), and how custom policies are delivered to a Windows 10-based device with Microsoft Intune.

Intune provides a convenient and easy-to-use interface to configure these policies. However, not all settings are necessarily available within the Microsoft Intune admin center. Although  many settings can be potentially configured on a Windows device, it's not feasible to have all of them in the admin center. Also, as advancements are made, it's not unusual to have a certain degree of lag before a new setting gets added. In these scenarios, deploying a custom OMA-URI profile that uses a Windows Configuration Service Provider (CSP) is the answer.

## CSP scope

CSPs are an interface that is used by mobile device management (MDM) providers to read, set, modify, and delete configuration settings on the device. Typically, it is done through keys and values in the Windows Registry. CSP policies have a scope that defines the level at which a policy can be configured. It is similar to the policies that are available in the Microsoft Intune admin center. Some policies can be configured only at the device level. These policies apply regardless of who is logged in to the device. Other policies can be configured at the user level. These policies apply to only that user. The configuration level is dictated by the platform, not by the MDM provider. When you deploy a custom policy, [you can look here](/windows/client-management/mdm/policy-configuration-service-provider) to find the scope of the CSP that you want to use.

The scope of the CSP is important because it will dictate the syntax of the OMA-URI string that you should use. For example:

### User scope

./User/Vendor/MSFT/Policy/Config/AreaName/PolicyName to configure the policy.
./User/Vendor/MSFT/Policy/Result/AreaName/PolicyName to get the result.

### Device scope

./Device/Vendor/MSFT/Policy/Config/AreaName/PolicyName to configure the policy.
./Device/Vendor/MSFT/Policy/Result/AreaName/PolicyName to get the result.

## OMA-URIs

The OMA-URI is a path to a specific configuration setting that is supported by a CSP.

**The OMA-URI**: It is a string that represents custom configuration for a Windows 10-based device. The syntax is determined by the CSPs on the client. You can find [details about each CSP here](/windows/client-management/mdm/policy-configuration-service-provider).

**A custom policy**: It contains the OMA-URIs to deploy. It's configured in Intune.

**Intune**: After a custom policy is created and assigned to client devices, Intune becomes the delivery mechanism that sends the OMA-URIs to those Windows clients. Intune uses the Open Mobile Alliance Device Management (OMA-DM) protocol to do this. It is a pre-defined standard that uses XML-based SyncML to push the information to the client.

**CSPs**: After the OMA-URIs reach the client, the CSP reads them and configures the Windows platform accordingly. Typically, it does this by adding, reading, or changing registry values.

To summarize: The OMA-URI is the payload, the custom policy is the container, Intune is the delivery mechanism for that container, OMA-DM is the protocol that's used for delivery, and the Windows CSP reads and applies the settings that are configured in the OMA-URI payload.

:::image type="content" source="media/deploy-oma-uris-to-target-csp-via-intune/internet-service-to-laptop.png" alt-text="Diagram shows the Windows CSP applies OMA-URI settings." border="false":::

This is the same process that's used by Intune to deliver the standard device configuration policies that are already built into the UI. When OMA-URIs use the Intune UI, they are hidden behind user-friendly configuration interfaces. It makes the process easier and more intuitive for the administrator. Use the built-in policy settings whenever possible, and use custom OMA-URI policies only for options that are otherwise unavailable.

To demonstrate this process, you can use a built-in policy to set the lock screen image on a device. You can also deploy an OMA-URI and target the relevant CSP. Both methods achieve the same result.

### OMA-URIs from the Microsoft Intune admin center

:::image type="content" source="media/deploy-oma-uris-to-target-csp-via-intune/device-restrictions.png" alt-text="Screenshot shows the device restrictions.":::

### Use a custom policy

The same setting can be set directly by using the following OMA-URI:

./Vendor/MSFT/Policy/Config/DeviceLock/EnforceLockScreenAndLogonImage

It is documented in the [Windows CSP reference](/windows/client-management/mdm/policy-csp-devicelock). After you determine the OMA-URI, create a custom policy for it.

:::image type="content" source="media/deploy-oma-uris-to-target-csp-via-intune/edit-row.png" alt-text="Screenshot of OMA-URI Settings in the Edit Row screen.":::

No matter which method you use, the end result is identical.

:::image type="content" source="media/deploy-oma-uris-to-target-csp-via-intune/sign-in-screen.png" alt-text="Screenshot of the sign-in screen." border="false":::

Here's another example that uses BitLocker.

### Use a custom policy from the Microsoft Intune admin center

:::image type="content" source="media/deploy-oma-uris-to-target-csp-via-intune/endpoint-protection.png" alt-text="Screenshot of the Endpoint protection screen." border="false":::

### Using a custom policy

:::image type="content" source="media/deploy-oma-uris-to-target-csp-via-intune/oma-uri-path-to-csp.png" alt-text="Screenshot of the OMA-URI path to the CSP." border="false":::

## Relate custom OMA-URIs to the on-premises world

You can use your existing Group Policy settings as a reference as you build your MDM policy configuration. If your organization wants to move to MDM to manage devices, we recommend that you prepare by analyzing the current Group Policy settings to see what is required to transition to MDM management.

The MDM Migration Analysis Tool (MMAT) determines which Group Policies have been set for a targeted user or computer. Then, it generates a report that lists the level of support for each policy setting in MDM equivalents.

### Aspects of your Group Policy before and after you migrate to the cloud

The following table shows the different aspects of your Group Policy both before and after you migrate to the cloud using the MMAT.

|On-premises|Cloud|
|---|---|
|Group Policy|MDM|
|Domain Controllers|MDM server (Intune service)|
|Sysvol folder|Intune database/MSUs|
|Client-side Extension to process GPO|CSPs to process the MDM policy|
|SMB protocol used for communication|HTTPS protocol used for communication|
|`.pol` \| `.ini` file (it is usually the input)|SyncML is the input for the devices|

## Important notes on policy behavior

If the policy changes on the MDM server, the updated policy is pushed to the device, and the setting is configured to the new value. However, removing the assignment of the policy from the user or device may not revert the setting to the default value. There are a few profiles that are removed after the assignment is removed or the profile is deleted, such as Wi-Fi profiles, VPN profiles, certificate profiles, and email profiles. Because this behavior is controlled by each CSP, you should try to understand the behavior of the CSP to manage your settings correctly. For more information, see [Windows CSP reference](/windows/client-management/mdm/policy-configuration-service-provider).

## Put it all together

To deploy a custom OMA-URI to target a CSP on a Windows device, create a custom policy. The policy must contain the path to the OMA-URI path together with the value that you want to change in the CSP (enable, disable, modify, or delete).

:::image type="content" source="media/deploy-oma-uris-to-target-csp-via-intune/create-profile.png" alt-text="Screenshot of the Create a profile page. The Custom item is highlighted." border="false":::

:::image type="content" source="media/deploy-oma-uris-to-target-csp-via-intune/custom-policy.png" alt-text="Screenshot shows the name description fields to create a Custom policy.":::

:::image type="content" source="media/deploy-oma-uris-to-target-csp-via-intune/add-configuration.png" alt-text="Screenshot of the Configuration settings and Add Row pages." border="false" lightbox="media/deploy-oma-uris-to-target-csp-via-intune/add-configuration.png":::

After the policy is created, assign it to a security group so that it will take effect.

## Troubleshoot

When you troubleshoot custom policies, you'll find that most problems fit into the following categories:

- The custom policy did not reach the client device.
- The custom policy did reach the client device, but the expected behavior is not observed.

If you have a policy that is not working as expected, verify whether the policy even reached the client. There are two logs to check to verify its delivery.

### MDM diagnostic logs

:::image type="content" source="media/deploy-oma-uris-to-target-csp-via-intune/mdm-diagnostic-logs.png" alt-text="Screenshot of the MDM diagnostic logs." border="false":::

### The Windows event log

:::image type="content" source="media/deploy-oma-uris-to-target-csp-via-intune/windows-event-log.png" alt-text="Screenshot of the Windows Event log." border="false":::

Both logs should contain a reference to the custom policy or OMA-URI setting that you're trying to deploy. If you do not see this reference, it is likely that the policy was not delivered to the device. Verify that the policy is configured correctly and is targeted to the correct group.

If you verify that the policy is reaching the client, check the `DeviceManagement-Enterprise-Diagnostics-Provider > Admin Event log` on the client for errors. You may see an error entry that contains additional information about why the policy did not apply. The causes will vary, but there is frequently a problem in the syntax of the OMA-URI string that's configured in the custom policy. Double-check the CSP reference, and make sure that the syntax is correct.
