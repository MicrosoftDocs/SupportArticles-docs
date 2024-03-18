---
title: Online users can't present content in on-premises hosted meetings
description: Describes an issue that blocks online users from presenting content in on-premises hosted meetings in a Skype for Business Hybrid deployment. This is a DNS issue, and a resolution is provided.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Skype for Business Server
  - Skype for Business Online
ms.date: 03/31/2022
---

# Online users can't present content in on-premises hosted meetings in a Skype for Business hybrid deployment

## Symptoms

Online hosted users report that they receive the following error message when they try to present or view meeting content that's hosted in an on-premises Skype for Business meeting when they're connected to an internal corporate network:

:::image type="content" source="./media/present-content-on-premises-meeting/error.png" alt-text="Screenshot that shows the network error.":::

> [!NOTE]
> When users are connected externally, they can share content.

## Cause

This issue occurs because the user's Skype for Business client can't resolve the DNS entry for the Edge server's web conferencing service FQDN. This issue typically occurs because a split DNS has been configured for the sip domain, and there is no entry in the internal DNS zone for the Edge server's external DNS A records for the web conferencing service. 

## Resolution

Add DNS A records for the Edge server's web conferencing service for all Skype for Business Edge servers. For example, add the DNS A host record for webcon.**contoso.com** so that it resolves to the external edge IP address for this service. Make sure that you add one record for each Edge server. 

### Technical information

Users who are homed online will connect to meeting content through the Edge proxy service. If the DNS record can't be resolved, these users will be unable to connect. In this situation, the Skype for Business local tracing log will display the following error in the diagnostic header in the Service out message error report for the failed connection attempt: 

```adoc
54503;reason="Connection to the Web Conferencing Server could not be established due to client DNS configuration"
```

If DNS A records exist but resolve to the wrong IP address, the client UI will display the following diagnostics:

![error message](./media/present-content-on-premises-meeting/error-message.png)

Additionally, the tracing log will display the following error, together with an explanation that the probe was completed but did not succeed:

```adoc
54000;reason="Connection to the Web Conferencing Server could not be established" 
```

## More Information

For more information, see [Plan your hybrid deployment for Skype for Business Server 2015](/skypeforbusiness/hybrid/plan-hybrid-connectivity?bc=%2fSkypeForBusiness%2fbreadcrumb%2ftoc.json&toc=%2fSkypeForBusiness%2ftoc.json).