---
title: Troubleshoot "Internet Explorer Zonemapping" failures when processing Group Policy
description: Provides resolution for "Internet Explorer Zonemapping" failures when you process Group Policy.
ms.date: 08/03/2023
ms.technology: internet-explorer-development-website
ms.reviewer: v-sidong
ms.author: heikom
---
# Troubleshoot "Internet Explorer Zonemapping" failures when processing Group Policy

## Symptom

When you execute `GPUpdate /force`, you may see the following output:

```output
Windows failed to apply the Internet Explorer Zonemapping settings. Internet Explorer Zonemapping settings might have its own log file. Please click on the "More information" link.
```

When you run `GPRESULT /H GPReport.html` and examines the report, you see the following information under Component Status:

```output
Internet Explorer Zonemapping                                        Failed (no data)
Internet Explorer Zonemapping failed due to the error listed below.
The parameter is incorrect.
Additional information may have been logged. Review the Policy Events tab in the console or the application event log for events between [time]
```

The System-Eventlog contains an Event ID 1085 from **Internet Explorer Zonemapping** like the following one:

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

This event can occur if you enter one of the following invalid entries within the **Site To Zone Assignment List** policy:

- [Computer Configuration\Administrative Templates\Windows Components\Internet Explorer\Internet Control Panel\Security Page]

- [User Configuration\Administrative Templates\Windows Components\Internet Explorer\Internet Control Panel\Security Page]

The format of the **Site To Zone Assignment List** policy has been described within the policy itself:

This policy setting allows you to manage a list of sites that you want to associate with a particular security zone. These zone numbers have associated security settings that apply to all of the sites in the zone.

Internet Explorer has four security zones, numbered 1-4, and these are used by this policy setting to associate sites to zones. They are:

`1` - Intranet zone
`2` - Trusted Sites zone
`3` - Internet zone
`4` - Restricted Sites zone

Security settings can be set for each of these zones through other policy settings, and their default settings are:

- Trusted Sites zone (Low template)
- Intranet zone (Medium-Low template)
- Internet zone (Medium template)
- Restricted Sites zone (High template)

(The Local Machine zone and its locked down equivalent have special security settings that protect your local computer.)

If you enable this policy setting, you can enter a list of sites and their related zone numbers. The association of a site with a zone ensures that the security settings for the specified zone are applied to the site. For each entry that you add to the list, enter the following information:

`Valuename` - A host for an intranet site, or a fully qualified domain name for other sites. The `valuename` may also include a specific protocol. For example, if you enter *`https://www.contoso.com`* as the `valuename`, other protocols aren't affected. If you enter just *`www.contoso.com`*, all protocols are affected for that site, including http, https, ftp, and so on. The site may also be expressed as an IP address (for example, 127.0.0.1) or range (for example, 127.0.0.1-10). To avoid creating conflicting policies, don't include other characters after the domain such as trailing slashes or URL path. For example, policy settings for `www.contoso.com` and `www.contoso.com/mail` would be treated as the same policy setting by Internet Explorer, and would therefore be in conflict.

`Value` - A number indicating the zone with which this site should be associated for security settings. The Internet Explorer zones described above are `1` to `4`.

When entering data in the Group Policy Editor, there's no syntax nor logical error-checking available. This is then performed on the client itself, when the **Internet Explorer Zonemapping** Group Policy Extension will convert the registry into the format which Internet Explorer uses itself. During that conversion the same methods are implemented which are used which Internet Explorer uses when adding a site manually to a specific security zone. In case an entry would be rejected when adding manually, the conversion would also fail if the Group Policy is used and the event 1085 would be issued. Wildcard-entries to Top-Level-Domains (TLD) One scenario, which is rejected when adding sites is the addition of a wildcard to a TLD (like `*.com` or `*.co.uk`). Now, the question is, which entries are treated as TLD; the following schemes were by default treated as TLD in Internet Explorer:

- Flat Domains (example: `.com`)
- Two-Letter-Domains in a two-Letter TLD (example: `.co.uk`).

The following blog-post includes a granular explanation concerning domains:

[Understanding Domain Names in Internet Explorer](/archive/blogs/ieinternals/understanding-domain-names-in-internet-explorer)

## Resolution

In order to identify incorrect entries in the policy, download and run the tool [IEDigest](https://aka.ms/IEDigest). After creating the report and opening it in your web browser, you see a section **Warnings** in which incorrect entries are named. These entries then need to be removed (or corrected) in the Group Policy. Here's an example about how it looks like when trying to add "*.com" to a zone:

> [!WARNING]
> Description                                                                      Key Name Value
Invalid entry in Site to Zone Assignment List. Click here for more info	HKCU\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMapKey *.com is invalid

## More information

[Intranet site is identified as an Internet site when you use an FQDN or an IP address](../../../windows-client/networking/intranet-site-identified-as-an-internet-site.md)

[Security Zones in Edge - text/plain](https://textslashplain.com/2020/01/30/security-zones-in-edge/)
