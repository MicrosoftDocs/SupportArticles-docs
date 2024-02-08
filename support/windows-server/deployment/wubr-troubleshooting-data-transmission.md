---
title: 'WUBr: Troubleshoot data transmission'
description: Describes how to troubleshoot diagnostic data transmission issues in Windows Update for Business reports.
ms.date: 12/19/2023
manager: dcscontentpm
author: Deland-Han
ms.author: delhan
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.custom: sap:servicing, csstroubleshoot
ms.subservice: deployment
keywords: Windows Update for Business reports, WUBr, diagnostic data, telemetry
---

# Windows Update for Business reports: Troubleshoot diagnostic data transmission

_Applies to:_ &nbsp; Windows Server, all supported versions

This article is designed to help you troubleshoot missing device data from Windows Update for Business reports.
If data is missing from your reports, there are three primary questions that you have to answer:  

- Did Windows Update for Business reports receive the data but not include it in reports?
- Are the devices correctly configured to send diagnostic data, and have they tried to send it?
- Are network connections and permissions correctly configured, including any proxy servers?

## Verify that Windows Update for Business reports is receiving data

After you enroll a device and configure it to share data, wait for 48 hours for data to start appearing in reports. In some cases, data from devices that aren't active much might take up to 14 days to appear in reports.

To verify that the reports service is receiving data from the device, [run a query](/windows/deployment/update/wufb-reports-use#display-windows-update-for-business-reports-data) the [UCClient table](/windows/deployment/update/wufb-reports-schema-ucclient). For example, the following query shows the total enrolled device count per time-generated:  

`UCClient | summarize count() by TimeGenerated`

:::image type="content" source="/windows/deployment/update/media/7760853-wufb-reports-time-generated.png" alt-text="Screenshot of a Kusto (KQL) query for time generated on Windows Update for Business reports data in Log Analytics." lightbox="/windows/deployment/update/media/7760853-wufb-reports-time-generated.png":::

If the table contains data from the device but the data is missing from reports, a problem might exist in the report configuration. For more information, see the following articles:

- [Use Windows Update for Business reports](/windows/deployment/update/wufb-reports-use)
- [Windows Update for Business reports schema](/windows/deployment/update/wufb-reports-schema)

If sufficient time has passed since the device was configured and enrolled, and the table still contains no device data, go to the next section to start troubleshooting the device.

## Check the data transmission prerequisites for devices

> [!NOTE]  
> This section summarizes the data transmission prerequisites. For a full discussion of these requirements and an up-to-date list of endpoints, see [Enable Windows diagnostic data processor configuration](/windows/privacy/configure-windows-diagnostic-data-in-your-organization#enable-windows-diagnostic-data-processor-configuration).

### Requirements for devices

- Use a supported version of Windows 11 or Windows 10
- The following editions are supported:
  - Enterprise
  - Professional
  - Education
- The device must be Microsoft Entra joined (it can be a hybrid Microsoft Entra join).
- The diagnostic data setting on the device should be set to **Required diagnostic data** or a higher value.

### Requirements for internet access

Devices have to be able to connect to the following endpoints. (This list was current at the time of publication.)

- `us-v10c.events.data.microsoft.com` (`eu-v10c.events.data.microsoft.com` for tenants that have billing addresses in the [EU Data Boundary](/privacy/eudb/eu-data-boundary-learn#eu-data-boundary-countries-and-datacenter-locations)).
- `watsonc.events.data.microsoft.com` (`eu-watsonc.events.data.microsoft.com` for tenants that have billing addresses in the [EU Data Boundary](/privacy/eudb/eu-data-boundary-learn#eu-data-boundary-countries-and-datacenter-locations)).
- `settings-win.data.microsoft.com`
- `*.blob.core.windows.net`

  > [!NOTE]  
  > Tenants that have billing addresses in countries or regions in the Middle East or Africa, and European countries or regions that aren't in the EU, also use the `eu-v10c.events.data.microsoft.com` and `eu-watsonc.events.data.microsoft.com` endpoints. Their diagnostic data is processed initially in Europe. However, those tenants aren't considered part of the [EU Data Boundary](/privacy/eudb/eu-data-boundary-learn).

Devices can connect directly or by using a proxy server. If a device has to use a proxy server, the device configuration must meet the requirements that are described in the next section.

## Configure devices to use a proxy connection

If your devices have to use a proxy connection, you can use one of two types:

- A user proxy (WinINET-based)
- A system proxy (WinHTTP-based)

Microsoft recommends that you configure the proxy servers to allow traffic to the diagnostic data endpoints without requiring proxy authentication. This approach is the most comprehensive solution, and it's compatible with all versions of Windows 10 and Windows 11.

On the device, the Windows Universal Telemetry Client (UTC) service is responsible for transmitting diagnostic data. When the UTC service starts to transmit, it first tries to connect directly to the endpoint. If the UTC service can't connect in that manner, it checks the device for a proxy configuration. The UTC service uses either type of proxy configuration, unless Group Policy dictates a specific proxy configuration. For more information about how to use Group Policy to configure the proxy server, see [Configure device proxy and Internet connectivity](/microsoft-365/security/defender-endpoint/configure-proxy-internet#configure-the-proxy-server-manually-using-a-registry-based-static-proxy).

The following table lists the two types of proxy connections and which scenarios each is suitable for.

| Type          | Scenarios |
| - | - |
| User proxy | At least one user account has permissions to access the device console, the proxy server, and the endpoint. |
| System proxy | The device is headless (users don't sign in).<br/><br/>Device users don't have internet permissions.<br/><br/>The proxy servers require authentication, but they don't support Integrated Windows Authentication.<br/><br/>Your infrastructure is integrated with Microsoft Defender for Endpoint. |

> [!IMPORTANT]  
> Before you configure devices to use a proxy server, make sure that the devices have the latest quality updates for a supported version of Windows.

### Configuring a user proxy

When you use the user proxy approach, the UTC service uses the context of the signed-in user to connect to the proxy server and the diagnostic data endpoints. Therefore, make sure that the designated user account has the appropriate permissions.

On the device, in **Network and internet** settings, use the **Proxy** tab to configure the user-level (WinINET) proxy.

> [!NOTE]  
> You can also use the legacy **Internet Options** control panel to configure the proxy settings.

### Configuring a system proxy

#### Configuring the local system account

When you use the system proxy approach, the UTC service uses the local system context to connect to the proxy server (through WinHTTP) and the diagnostic data endpoints. Therefore, make sure that the local system account has the appropriate permissions. To do this, use one of the following methods:

- In a Command Prompt window on the device, run `netsh winhttp set proxy`.
- Use the Web Proxy Auto-Discovery (WPAD) protocol.
- Use a transparent proxy.
- In Group Policy, configure a device-wide WinINET proxy by enabling **[Make proxy settings per-machine (rather than per-user)](https://gpsearch.azurewebsites.net/#683)**.  
- Establish a routed connection.
- Use Network Address Translation (NAT).

#### Configuring the proxy servers

Make sure that the proxy servers use the following configuration:
The proxy servers use Integrated Windows Authentication.
The proxy servers allow Active Directory Domain Services (AD DS) computer accounts to access the diagnostic data endpoints.
