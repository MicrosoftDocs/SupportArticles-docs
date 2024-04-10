---
title: Troubleshoot Internet Explorer Zonemapping failures when processing Group Policy
description: Provides a resolution for Internet Explorer Zonemapping failures when you process Group Policy.
ms.date: 08/21/2023
ms.reviewer: axelr, davean, v-sidong
ms.author: heikom
---
# Troubleshoot "Internet Explorer Zonemapping" failures when processing Group Policy

## Symptoms

When you execute `GPUpdate /force`, you may see the following output:

```output
Windows failed to apply the Internet Explorer Zonemapping settings. Internet Explorer Zonemapping settings might have its own log file. Please click on the "More information" link.
```

When you run `GPRESULT /H GPReport.html` and examine the report, you see the following information under **Component Status**:

```output
Internet Explorer Zonemapping                                        Failed (no data)
Internet Explorer Zonemapping failed due to the error listed below.
The parameter is incorrect.
Additional information may have been logged. Review the Policy Events tab in the console or the application event log for events between [time]
```

The System event log contains an event ID 1085 that indicates a Group Policy processing error related to "Internet Explorer ZoneMapping," like the following one:

```output
Log Name:      System
Source:        Microsoft-Windows-GroupPolicy
Event ID:      1085
Level:         Warning
Description:  Windows failed to apply the Internet Explorer Zonemapping settings. Internet Explorer Zonemapping settings might have its own log file. Please click on the "More information" link.
Event Xml:
<Event xmlns="https://schemas.microsoft.com/win/2004/08/events/event">
<System>
<Provider Name="Microsoft-Windows-GroupPolicy" Guid="{<GUID>}" />
<EventID>1085</EventID>
<Level>3</Level>
</System>
<EventData>
<Data Name="ErrorCode">87</Data>
<Data Name="ErrorDescription">The parameter is incorrect. </Data>
<Data Name="ExtensionName">Internet Explorer Zonemapping</Data>
<Data Name="ExtensionId">{<ExtensionID>}</Data>
</EventData>
</Event> 
```

## Cause

This event can occur if you enter an invalid entry within the **Site To Zone Assignment List** policy in the following paths:

- *Computer Configuration\Administrative Templates\Windows Components\Internet Explorer\Internet Control Panel\Security Page*

- *User Configuration\Administrative Templates\Windows Components\Internet Explorer\Internet Control Panel\Security Page*

## The "Site To Zone Assignment List" policy

The format of the **Site To Zone Assignment List** policy is described within the policy. This policy setting allows you to manage a list of sites that you want to associate with a particular security zone. These zone numbers have associated security settings that apply to all sites in the zone.

Internet Explorer has four security zones, which are used by this policy setting to associate sites with zones. They're numbered `1` to `4` and defined in descending order of most to least trusted:

1. Local Intranet zone  
1. Trusted Sites zone  
1. Internet zone  
1. Restricted Sites zone

The security settings can be set for each of these zones through other policy settings, and their default settings are:

- Trusted Sites zone (Low template)
- Intranet zone (Medium-Low template)
- Internet zone (Medium template)
- Restricted Sites zone (High template)

The Local Machine zone and its locked-down equivalent have special security settings that protect your local computer.

If you enable this policy setting, you can enter a list of sites and their related zone numbers. The association of a site with a zone ensures that the security settings for the specified zone are applied to that site. For each entry that you add to the list, enter the following information:

- `Valuename`: It's used to specify a host for an intranet site, or a fully qualified domain name for other sites. The `valuename` may also include a specific protocol. For example, if you enter *`https://www.contoso.com`* as the `valuename`, other protocols aren't affected. If you just enter *`www.contoso.com`*, all protocols for that site are affected, including http, https, ftp, and so on. The site may also be expressed as an IP address (such as 127.0.0.1) or a range (such as 127.0.0.1-10). To avoid creating conflicting policies, don't include other characters after the domain, such as a trailing slash or URL path. For example, the policy settings for `www.contoso.com` and `www.contoso.com/mail` would be treated as the same policy setting by Internet Explorer, and therefore, conflict.

- `Value`: It's the number of the zone you want to associate the site with security settings. The `Value` of the above Internet Explorer zones is `1` to `4`.

When you enter data in the Group Policy Editor, there's no syntax or logical error checking available. This error checking is performed on the client when the **Internet Explorer Zonemapping** Group Policy Extension converts the registry into the format used by Internet Explorer. During that conversion, the same methods are implemented when you manually add a site to a specific security zone. If an entry is rejected when you add it manually, the conversion also fails if the Group Policy is used and the event 1085 is issued. For example, when you try to add a wildcard entry to a top-level domain (TLD) (like `*.com` or `*.co.uk`) while adding a site, the wildcard entry is rejected. Now, the question is, which entries are treated as TLDs; by default, the following schemes are treated as TLDs in Internet Explorer:

- Flat domains (such as `.com`).
- Two-letter domains in a two-letter TLD (such as `.co.uk`).

The following blog post includes a granular explanation of domains:

[Understanding Domain Names in Internet Explorer](/archive/blogs/ieinternals/understanding-domain-names-in-internet-explorer)

## Resolution

To identify incorrect entries in the policy, download and run the [IEDigest](https://aka.ms/IEDigest) tool. After creating a report and opening it in your web browser, you'll see a **Warnings** section where incorrect entries are named. These entries need to be removed (or corrected) in the Group Policy. Here's an example of how it looks like when trying to add `*.com` to a zone:

> &nbsp;&nbsp;&nbsp;&nbsp;**Warnings**
>
> | Description    |     Key    |     Name    |    Value     |
> |---------|---------|---------|---------|
> |Invalid entry in Site to Zone Assignment List. Click here for [more info](/archive/blogs/askie/description-of-event-id-1085-from-internet-explorer-zonemapping)     |    HKCU\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMapKey     |      *.com is invalid   |         |

## More information

- [Intranet site is identified as an Internet site when you use an FQDN or an IP address](../../../windows-client/networking/intranet-site-identified-as-an-internet-site.md)
- [Security Zones in Microsoft Edge](https://textslashplain.com/2020/01/30/security-zones-in-edge/)

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]
