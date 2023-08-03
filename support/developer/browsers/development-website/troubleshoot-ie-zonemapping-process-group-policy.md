---
title: Troubleshoot "Internet Explorer Zonemapping" failures when processing Group Policy
description: Provides a resolution for "Internet Explorer Zonemapping" failures when you process Group Policy.
ms.date: 08/03/2023
ms.technology: internet-explorer-development-website
ms.reviewer: v-sidong
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

The System-Eventlog contains an Event ID 1085 that indicates a Group Policy processing error related to "Internet Explorer ZoneMapping" like the following one:

```output
Log Name:      System
Source:        Microsoft-Windows-GroupPolicy
Event ID:      1085
Level:         Warning
Description:  Windows failed to apply the Internet Explorer Zonemapping settings. Internet Explorer Zonemapping settings might have its own log file. Please click on the "More information" link.
Event Xml:
<Event xmlns="https://schemas.microsoft.com/win/2004/08/events/event">
<System>
<Provider Name="Microsoft-Windows-GroupPolicy" Guid="{AEA1B4FA-97D1-45F2-A64C-4D69FFFD92C9}" />
<EventID>1085</EventID>
<Level>3</Level>
</System>
<EventData>
<Data Name="ErrorCode">87</Data>
<Data Name="ErrorDescription">The parameter is incorrect. </Data>
<Data Name="ExtensionName">Internet Explorer Zonemapping</Data>
<Data Name="ExtensionId">{4CFB60C1-FAA6-47f1-89AA-0B18730C9FD3}</Data>
</EventData>
</Event> 
```

## Cause

This event can occur if you enter an invalid entry within the **Site To Zone Assignment List** policy in the following paths:

- *Computer Configuration\Administrative Templates\Windows Components\Internet Explorer\Internet Control Panel\Security Page*

- *User Configuration\Administrative Templates\Windows Components\Internet Explorer\Internet Control Panel\Security Page*

## The "Site To Zone Assignment List" policy

The format of the **Site To Zone Assignment List** policy is described within the policy itself. This policy setting allows you to manage a list of sites that you want to associate with a particular security zone. These zone numbers have associated security settings that apply to all of the sites in the zone.

Internet Explorer has four security zones and these zones are used by this policy setting to associate sites to zones. They're numbered `1` to `4` and defined in descending order of most to least trusted:

1. Local Intranet zone  
1. Trusted Sites zone  
1. Internet zone  
1. Restricted Sites zone

The security settings can be set for each of these zones through other policy settings and their default settings are:

- Trusted Sites zone (Low template)
- Intranet zone (Medium-Low template)
- Internet zone (Medium template)
- Restricted Sites zone (High template)

The Local Machine zone and its locked down equivalent have special security settings that protect your local computer.

If you enable this policy setting, you can enter a list of sites and their related zone numbers. The association of a site with a zone ensures that the security settings for the specified zone are applied to the site. For each entry that you add to the list, enter the following information:

- `Valuename` It's used to specify a host for an intranet site or a fully qualified domain name for other sites. The `valuename` may also include a specific protocol. For example, if you enter *`https://www.contoso.com`* as the `valuename`, other protocols aren't affected. If you just enter *`www.contoso.com`*, all protocols are affected for that site, including http, https, ftp, and so on. The site may also be expressed as an IP address (for example, 127.0.0.1) or range (for example, 127.0.0.1-10). To avoid creating conflicting policies, don't include other characters after the domain such as trailing slashes or URL path. For example, the policy settings for `www.contoso.com` and `www.contoso.com/mail` would be treated as the same policy setting by Internet Explorer and would therefore be in conflict.

- `Value` It's the number of the zone with which you want to associate the site for security settings. The Internet Explorer zones described above are `1` to `4`.

When you enter data in the Group Policy Editor, there's no syntax nor logical error-checking available. This error-checking is then performed on the client itself when the **Internet Explorer Zonemapping** Group Policy Extension converts the registry into the format which Internet Explorer uses itself. During that conversion, the same methods are implemented when you add a site manually to a specific security zone. If an entry is rejected when you add it manually, the conversion also fails if the Group Policy is used and the event 1085 is issued. One scenario in which a wildcard-entry to top-level domains (TLD) is rejected when you add a site is to add a wildcard to a TLD (like `*.com` or `*.co.uk`). Now, the question is, which entries are treated as TLD; by default, the following schemes are treated as TLD in Internet Explorer:

- Flat domains (for example, `.com`).
- Two-letter-domains in a two-letter TLD (for example, `.co.uk`).

The following blog-post includes a granular explanation concerning domains:

[Understanding Domain Names in Internet Explorer](/archive/blogs/ieinternals/understanding-domain-names-in-internet-explorer)

## Resolution

In order to identify incorrect entries in the policy, download and run the tool [IEDigest](https://aka.ms/IEDigest). After creating the report and opening it in your web browser, you see a section **Warnings** where incorrect entries are named. These entries then need to be removed (or corrected) in the Group Policy. Here's an example about how it looks like when trying to add `*.com` to a zone:

|Warnings||||
|-|-|-|-|
|**Description**|**Key**|**Name**|**Value**|
|Invalid entry in Site to Zone Assignment List. Click here for [more info](/archive/blogs/askie/description-of-event-id-1085-from-internet-explorer-zonemapping)|HKCU\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMapKey|*.com is invalid||

## More information

- [Intranet site is identified as an Internet site when you use an FQDN or an IP address](../../../windows-client/networking/intranet-site-identified-as-an-internet-site.md)
- [Security Zones in Edge - text/plain](https://textslashplain.com/2020/01/30/security-zones-in-edge/)
