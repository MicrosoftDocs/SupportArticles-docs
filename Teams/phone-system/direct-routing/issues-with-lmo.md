---
title: Issues with Local Media Optimization
description: Fixes issues in which Local Media Optimization (LMO) for Direct Routing doesn't work as expected.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Calling (PSTN)\Direct Routing
  - CI-126688
  - CSSTroubleshoot
  - scenario:Direct-Routing-2
ms.reviewer: mikebis
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 10/30/2023
---
# Issues with Local Media Optimization for Direct Routing

You might find that Local Media Optimization (LMO) for Direct Routing doesn't work as expected. For instance, Microsoft Teams doesn't send the `X-Ms-UserLocation` and `X-Ms-MediaPath` headers, or the `X-Ms-UserLocation` header contains the wrong location, or calls fail.

This article provides some resolutions that you can try to fix these issues.

## X-Ms-UserLocation and X-Ms-MediaPath headers are not sent

The `X-Ms-UserLocation` and `X-Ms-MediaPath` headers are required for LMO. One of the most common reasons that these headers are not sent is that the gateway is not configured correctly for LMO.  

To check the gateway configuration, run the following [Get-CsOnlinePSTNGateway](/powershell/module/skype/get-csonlinepstngateway) cmdlet:

```powershell
Get-CSOnlinePSTNGateway | Select Identity, Fqdn, Enabled, MediaBypass, GatewaySiteId, ProxySbc, BypassMode
```

For LMO to be enabled, make sure that all the properties that are selected in this cmdlet are set. This is especially important for `BypassMode`. Here's an example of the output from this cmdlet:

```output
Identity        : VNsbc.contoso.com 
Fqdn            : VNsbc.contoso.com 
Enabled         : True 
MediaBypass     : True 
GatewaySiteId   : Vietnam 
ProxySbc        : proxysbc.contoso.com 
BypassMode      : Always 

Identity        : proxysbc.contoso.com 
Fqdn            : proxysbc.contoso.com 
Enabled         : True 
MediaBypass     : True 
GatewaySiteId   : Singapore 
ProxySbc        :  
BypassMode      : Always 
```

**Note:** The values that are displayed here might be different from what you see.

## Wrong location sent in X-Ms-UserLocation header

If the network location information in the `X-Ms-UserLocation` header is specified as **external**, but you expect to see a value of **internal**, this means that the public IP address of the Teams client doesn't match any entry in the list of trusted IP addresses.  

To fix this issue, identify the client's public IP address that's used by Teams, and then add it to the list.

1. Open [Microsoft Teams log files](/microsoftteams/log-files).
1. Locate the public IP address listed for the client in the *MSTeams Diagnostics Log [Date]__[Time]_calling.txt* file. Here's an example of this file:

   :::image type="content" source="media/issues-with-lmo/txt-file.png" alt-text="Screenshot that shows the public IP address in the txt file.":::

1. Run the [Get-CsTenantTrustedIPAddress](/powershell/module/skype/get-cstenanttrustedipaddress) cmdlet to get the list of trusted IP addresses:

   ```powershell
   Get-CsTenantTrustedIPAddress
   ```

   The output that you see should resemble the following:

   ```output
   Identity      : 192.168.0.0 
   RemoteMachine : WU22A00TAD02.lync2A001.local
   MaskBits      : 24
   Description   : Private IP subnet
   IPAddress     : 192.168.0.0 
   Element       : <TrustedIPAddress IPAddress="192.168.0.0" MaskBits="24" 
   Description="Private IP subnet" 
   xmlns="urn:schema:Microsoft.Rtc.Management.Settings.TenantNetworkConfiguration.2017" />
   ```

   Notice that the client's IP address identified in step 2 is missing from this list.

1. Run the [New-CsTenantTrustedIPAddress](/powershell/module/skype/new-cstenanttrustedipaddress) cmdlet to add the missing IP address to the list:

   ```powershell
   New-CsTenantTrustedIPAddress -IPAddress 123.456.123.0 -MaskBits 29 -Description "Seattle site trusted IP"
   ```

   The output of the cmdlet should resemble the following example:

   :::image type="content" source="media/issues-with-lmo/add-missing-ip-address.png" alt-text="Screenshot that shows adding missing IP address.":::

   You can see that the client's IP address has now been added to the list of trusted IP addresses.

1. Restart the Teams client so that the newly added IP address can be recognized immediately. Otherwise, the list can take up to 30 minutes to be updated.

   After the restart, Teams will find a match for the client's IP address in the list of trusted IP addresses, as shown in the following example:

   :::image type="content" source="media/issues-with-lmo/match-address.png" alt-text="Screenshot of the matched IP address.":::

## Incoming calls fail or go to voicemail if both LMO and LBR are enabled

One of the most likely reasons that this issue occurs is that either the headers or the routing information is not configured correctly on the Session Border Controller (SBC) from which the call is received.

Check that the Session Initiation Protocol (SIP) message headers sent from the SBC contain the following information, and update them if they are incorrect:

- The SIP URI contains the Fully Qualified Domain Name (FQDN) of the regional SBC.
- The Contact header contains the FQDN of the regional SBC.
- The Record-Route contains the FQDN of the proxy SBC.

If a proxy SBC is not defined for the regional SBC, then only the Record-Route is checked. If the Record-Route is missing, then the Contact header is checked.

If the headers are configured correctly, the issue might be caused by a misconfigured routing on the SBC.

Make sure that the SBC has Location-Based Routing (LBR) enabled. The `GatewaySiteLbrEnabled` parameter must be set to **True**.

Also, the SBC must be assigned to the same site as the client that's initiating the call.

**Note:** The proxy SBC doesn't have to be enabled for LBR.

To determine whether the SBC assignment is correct, identify the user site that's registered in the Teams client logs, and compare it with the assignment information for the SBC:

1. Open [Microsoft Teams log files](/microsoftteams/log-files).
1. Identify the user site information that's listed in the *MSTeams Diagnostics Log [Date]__[Time]_calling.txt* file. Here's an example of this file:

    :::image type="content" source="media/issues-with-lmo/networksiteid.png" alt-text="Screenshot of the txt file with the site information.":::

1. Run the [Get-CsOnlinePSTNGateway](/powershell/module/skype/get-csonlinepstngateway) cmdlet to check the configuration of the SBC. The output that you see should resemble the following example:

    :::image type="content" source="media/issues-with-lmo/sbc-configuration.png" alt-text="Screenshot that shows checking S B C configuration.":::

1. In the output from step 2, the value of the `networksiteId` parameter that's listed in the user site information is "Vietnam." However, in the output from step 3, the value of the equivalent `GatewaySiteId` parameter that's listed in the SBC's configuration is "India." This is a mismatch. To update the SBC's configuration, run the [Set-CsOnlinePSTNGateway](/powershell/module/skype/set-csonlinepstngateway) cmdlet, as follows:

   ```powershell
   Set-CSOnlinePSTNGateway -Identity "VNsbc.contoso.com" -GatewaySiteID "Vietnam"
   ```

   Next, run the `Get-CsOnlinePSTNGateway` cmdlet to verify the SBC's updated configuration. The output should now show the correct value for the `GatewaySiteId` parameter.

    :::image type="content" source="media/issues-with-lmo/update-gatewaysiteid.png" alt-text="Screenshot of updating Gateway Site I d.":::

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
