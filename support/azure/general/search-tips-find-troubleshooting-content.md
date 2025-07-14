---
title: Advanced search tips for finding Microsoft troubleshooting content
description: Find out how to search for Microsoft support and troubleshooting articles using search best practices.
ms.date: 7/12/2024
ms.service: azure-common-issues-support
ms.author: jarrettr
author: JarrettRenshaw
ms.reviewer: 
---
# Advanced search tips for finding Microsoft troubleshooting content

_Original product version:_ &nbsp; Azure  
_Original KB number:_ &nbsp; 4550049

## Summary

Microsoft publishes thousands of useful articles for IT Professionals seeking help with solving problems. Searching the web for that one useful article can be a daunting task. The answer is probably out there, but how do we find it among the thousands of support articles published by Microsoft?

This article covers some advanced search tips and tricks that will improve your odds of finding the right self-help content using a web search.

## Browser tips

Don't let your browsing history and preferences affect your search. Use **InPrivate (Bing)** or **Incognito (Chrome)** mode in your browser.

:::image type="content" source="./media/search-tips-find-troubleshooting-content/search-tips.gif" alt-text="InPrivate Browsing":::

## Gather and review log files

Check the System, Application and operational event logs for items related to the problem, and search using the error messages. Some errors are generic, such as **MSI install** errors or permissions errors **(Error 5)**, go back through the log and look for a more specific error before the generic one.

## Keywords

Use quotes around events, errors, and strings after removing any machine-specific information.

For example: **"a user account is required"**  

:::image type="content" source="media/search-tips-find-troubleshooting-content/user-account-required.png" alt-text="Screenshot of search box, where a user account is required is typed.":::

If the error is in a log, add the log name.

For example: **System log AND "a user account is required"**  

:::image type="content" source="media/search-tips-find-troubleshooting-content/log-name.png" alt-text="Screenshot of search box, where System log AND a user account is required is typed.":::

Add the product name (for Windows 10 you can narrow to a version by adding the version number to your search string. Use assets like the [Wikipedia Windows 10 version history](https://en.wikipedia.org/wiki/Windows_10_version_history) to understand the different naming conventions for a given product and use that in your query. For example: **"domain join" AND 1903**

:::image type="content" source="media/search-tips-find-troubleshooting-content/domain-join.png" alt-text="Screenshot of search box, where Domain join and 1903 is typed.":::

If searching for a specific KB article by number, try adding 'KB' to the number.

For example:

**KB12345678** or **KB 12345678**  

(Exercise: Try finding this article using both methods - **KB4550049** or **KB 4550049**)

:::image type="content" source="media/search-tips-find-troubleshooting-content/KB12345678.png" alt-text="Screenshot of search box, where KB12345678 is typed. ":::

:::image type="content" source="media/search-tips-find-troubleshooting-content/KB-12345678.png" alt-text="Screenshot of search box, where KB 12345678 is typed.":::

## Site search

### Scope searches to well-known domains using the "site:" operand

The search string **"a user account is required" site:Microsoft.com** targets only the **microsoft.com** domain:

:::image type="content" source="media/search-tips-find-troubleshooting-content/site-microsoft.png" alt-text="Screenshot of Microsoft search results." border="false":::

The search string **"a user account is required" site:reddit.com** targets just the **reddit.com** domain:

:::image type="content" source="media/search-tips-find-troubleshooting-content/site-reddit.png" alt-text="Screenshot of Reddit search results." border="false":::

### Scope searches starting with the most relevant to the least relevant sites

This excludes answers.microsoft.com and social.microsoft.com:"a user account is required" site:Microsoft.com -answers -social

> [!TIP]
> Start searches narrow then increase the scope of the search if you fail to find relevant content.

## Trusted sites

Build a list of trusted sites to use during your investigation.

| **Asset**| **Comments** |
|---|---|
|`support.microsoft.com`|# 1 site for break / fix content for Microsoft on-prem products.|
|`learn.microsoft.com`|For most IT Pro content for cloud-based products, includes break-fix content.|
|[Windows Health Release Dashboard](/windows/release-health/)<br/>|OS version specific information describing friction ranging from intentional hardening changes to unintended regressions introduced by quality updates and sometimes feature updates.<br/><br/>Also describes interop issues with 1<sup>st</sup> party / 3<sup>rd</sup> party hardware / software that may be caused by Windows updates or 1<sup>st</sup> party / 3<sup>rd</sup> party hardware / software.|
|Known issue and release note text in the header Monthly Windows Update KB articles<br/><br/>See KB [4534310](https://support.microsoft.com/help/4534310/windows-7-update-kb4534310) as a recent example|Known issue text identifies friction including interop issues or regressions introduced by a given Windows update.<br/><br/>Release notes identify fixes resolved in that months update.<br/><br/>A fix that resolves an issue will generally use the same "known issue" or "release note" text across all affected OS versions.|
  
## Other sites

Don't overlook these valuable resources! Visit these sites and search using their own search engines.

**Forums**:

- [TechNet forums](https://social.technet.microsoft.com/Forums/en-US/home)
- [Microsoft Q&A](/answers/index.html)
- [Consumer or end-user forum](https://answers.microsoft.com/)

**Blogs**:

- [Microsoft Tech Community](https://techcommunity.microsoft.com/)

## Microsoft Support Portals (An overlooked resource for troubleshooting)

You don't have to open a support ticket just yet! The Microsoft support portals offer a wealth of troubleshooting assistance before you open a support case. Just begin the support experience, describe your issue as accurately as possible, and you will be presented with troubleshooting steps and recommended self-help articles. Here is an example from the Azure portal. If the recommended steps or articles enable you to resolve your issue, there is no need to proceed with opening a support request.

- [Azure Support](https://ms.portal.azure.com/)
- [Office 365 Support](/Office365/Admin/contact-support-for-business-products)

:::image type="content" source="media/search-tips-find-troubleshooting-content/support-portal.png" alt-text="Screenshot of Azure portal." border="false":::

## Open a support case

If you want your case resolved as quickly as possible, follow this tips to avoid delays:

| **Action**| **Examples**| **Comments** |
|---|---|---|
|Use the appropriate severity||The severity should accurately reflect the impact of the problem. Sev-A should be restricted to problems that completely block a user or service frequently and have no workarounds.|
|Provide a meaningful title|**Bad examples**<br/>1. Operation X <br/>2. OS version Y <br/>3. Error message Z <br/>4. Operation X on Windows 10<br/><br/> **Better**<br/>1. Operation X fails on major / minor version Y with Error Z <br/>2. Operation W intermittently fails on major / minor version X with error Y due to triggering configuration Z |Remove ambiguity, and try to capture "what", "who" "how" and "when" context in your title.<br/><br/>Microsoft has released 10 versions of Windows 10 to date. Each version contains new capabilities and behavior changes and bug fixes.|
|Provide a meaningful problem description and repro steps that allow Microsoft to understand the problem and reproduce it in-house if the customer is unable to collect data||The single biggest contributors to slow root cause determination are poor problem description and lack of steps to reproduce the issue.<br/>Having the right data often enables Microsoft to identify root cause within hours or days for many type of issues. Some issues (memory or kernel related, for example) may take longer.<br/>Include "IS \| DOES" and "IS \| DOES NOT" context in your problem statement|

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
