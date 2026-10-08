---
title: Microsoft Edge Webpage Translation Missing or Not Working
description: Troubleshoot webpage translation issues in Microsoft Edge, such as missing translate icon, failed translations, language settings and Group Policy.
ms.date: 09/17/2026
ms.reviewer: yejxu,luden,wshao
ms.custom: 'sap:Experiences and Services\Language Services: Read Aloud, Spellcheck, Translation'
ai-usage: ai-assisted
---

# Microsoft Edge doesn't offer or complete webpage translation

## Summary

This article helps you troubleshoot issues in which [webpage translation](https://support.microsoft.com/en-us/edge/use-microsoft-translator-in-microsoft-edge-browser) doesn't work as expected in Microsoft Edge. Either Edge doesn't offer to translate a page, the translation fails after you select **Translate**, or Edge translates a page that you wanted to read in its original language. Follow the methods in this article in the order given to identify and resolve the issue.

## Symptoms

You experience one or more of the following issues:

- The translate icon doesn't appear in the address bar when you open a page that's in a language you don't read.
- The translate panel doesn't appear automatically, or the translate option is unavailable on the right-click menu.
- You select **Translate**, but the page text doesn't change, or the translation fails.
- Translation works on most sites but fails for one specific site, one source language, one profile, or only on a managed device.

## Cause

Microsoft Edge shows the automatic translate panel only when all of the following conditions are true:

- The built-in translate feature is enabled, both in your settings and by policy.
- Edge detects a page language that isn't in your **Preferred languages** list.
- You haven't selected **Never translate \[Language\]** for that language.
- Edge can reach the Microsoft translation service.

Conversely, if you selected **Always translate from \[Language\]**, Edge translates matching pages automatically without prompting you.

## Check language settings and exceptions

Translation behaves unexpectedly if the automatic offer is turned off, or if the page language is already in your **Preferred languages** list. Follow these steps:

1. Open Microsoft Edge, and go to `edge://settings/languages`.
1. Turn on **Offer to translate pages that aren't in a language I read**.
1. Review the **Preferred languages** list. If the page language is in this list, Edge treats it as a language you read and doesn't offer to translate the page. Remove the language only if it was added by mistake.
1. Remove applicable **Never translate** language or site exceptions.

> [!CAUTION]
> Don't remove all your preferred languages as a general reset. Microsoft Edge also uses this list for the browser display language, spell check, and the default translation target language.

## Determine whether the issue is page-specific

Isolating the scope tells you whether to investigate the site, your profile, or a device-wide setting. Follow these steps:

1. Open a different page that's in the same source language. If that page translates, the problem is specific to the affected site.
1. Open the affected page in a different Microsoft Edge profile. If the page translates there, the problem is specific to your original profile settings.
1. Press F12 to open Microsoft Edge DevTools, run `document.documentElement.lang`, and record the result for the site owner. Incorrect or missing markup can affect language handling, but Edge can also use content detection.
1. Review the Edge DevTools **Console** and **Network** panels for page script failures or blocked requests.

## Check extensions, policy, and network access

A third-party extension, a managed policy, or a blocked network path can disable translation for every site. Follow these steps:

1. Go to `edge://extensions`, turn off any third-party translation extensions, and then retest the page.
1. Go to `edge://policy`, and check the [TranslateEnabled](/deployedge/microsoft-edge-policies/translateenabled) policy:

   - If the policy isn't listed, it isn't configured, and the translate features are enabled by default.
   - If the value is `false` or **Disabled**, all built-in translate features are turned off. Ask your IT administrator to set the policy to **Enabled** or leave it not configured.

1. Select **Reload policies** on the `edge://policy` page, and then restart Microsoft Edge so that any policy change takes effect.
1. If translation fails for every site on one network only, ask your network administrator to review the proxy or firewall logs for blocked requests while you reproduce the failure. Don't add broad firewall exclusions as a workaround. For general Microsoft Edge connectivity requirements, see [Allow list for Microsoft Edge endpoints](/deployedge/microsoft-edge-security-endpoints).

## Collect data before contacting Microsoft Support

If you have to contact Microsoft Support for more help, collect the following information and include it with your support request:

- **Microsoft Edge version**: Go to `edge://settings/help`, and note the full version number.
- **Affected content**: The URL, the source language, and the target language.
- **Scope**: Whether a different page in the same source language translates, and whether the affected page translates in a different profile.
- **Active policies**: Go to `edge://policy`, and export the policy list.
- **Errors**: Relevant entries from the DevTools **Console** and **Network** tabs, and any proxy or firewall logs that show blocked requests.

Remove any sensitive or personal information from the data before you share it.

## Related content

- [Use Microsoft Translator in Microsoft Edge browser](https://support.microsoft.com/topic/use-microsoft-translator-in-microsoft-edge-browser-4ad1c6cb-01a4-4227-be9d-a81e127fcb0b)
- [User data and privacy in Microsoft Edge](/legal/microsoft-edge/privacy#translate)
- [Microsoft Edge policy reference](/deployedge/microsoft-edge-policies)
- [Configure Microsoft Edge policy settings](/deployedge/configure-microsoft-edge)