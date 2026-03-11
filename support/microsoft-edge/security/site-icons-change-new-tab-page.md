---
title: Fix Edge Saved Site Icons Changing on New Tab Page
description: Learn how to troubleshoot unexpected favicon changes on the Microsoft Edge new tab page and restore the correct icons for your saved sites.
ms.date: 03/11/2026
ms.reviewer: dili, Johnny.Xu, v-shaywood
ms.custom: 'sap:Security and Privacy\Profiles and Sync: Caches, Favorites, Autofill, Wallet'
---

# Saved site icons change unexpectedly on the new tab page

This article explains why saved site icons (favicons) on the Microsoft Edge new tab page might change unexpectedly. For example, a website's icon might be replaced by a PDF icon. This behavior comes from how Microsoft Edge looks up and caches favicons. This article describes the favicon lookup process and the conditions under which this problem occurs.

## Symptoms

You experience one or more of the following problems:

- A saved site on the Microsoft Edge new tab page shows an incorrect icon. For example, a PDF icon appears instead of the website's original favicon.
- The favicon for a saved site changes after you visit a different page on the same website.
- A saved site's icon alternates between different icons over time.

## Cause

Microsoft Edge uses the following order to look up favicons for saved sites:

1. **Exact URL cache**: Looks for a favicon cached for the specific page URL.
1. **Host-level cache**: Falls back to a favicon cached for any page on the same host.
1. **Favicon service**: Attempts to download the favicon from an external favicon service.
1. **Default initial**: Uses the first letter of the site name as a placeholder icon.

The problem occurs at the host-level cache step. When Edge can't find a favicon for a specific URL like `https://yourdomain/home.aspx`, it falls back to reusing the favicon that's cached for the same host (`https://yourdomain`).

This behavior is by design. Most websites use a single favicon across all pages, so the host-level fallback works correctly in the majority of cases. But when different pages on the same host use different favicons (for example, a web application that serves both HTML pages and PDF documents), the fallback mechanism can cause the wrong favicon to appear.

### Example scenario

Consider the following situation:

1. You save `https://yourdomain/home.aspx` on your new tab page.
1. You visit `https://yourdomain/a.aspx`, which uses the same favicon as the home page. In this case, everything works as expected because the saved site shows the correct icon.
1. You then visit `https://yourdomain/b.aspx`, which is a PDF document and has a PDF favicon.
1. Edge caches the PDF favicon for the host `https://yourdomain`.
1. The next time Edge looks up a favicon for `https://yourdomain/home.aspx`, the exact URL match fails, so it uses the host-level favicon, which is now the PDF icon.
1. As a result, your saved site on the new tab page displays the PDF icon instead of the original website favicon.

## Solution

There's no direct setting to change the favicon lookup behavior. But you can try the following solutions.

### Revisit the original page

Open the saved site URL (for example, `https://yourdomain/home.aspx`) directly in Microsoft Edge. This action refreshes the favicon cache for that exact URL, which might restore the correct icon.

### Clear the favicon cache

Clearing cached images and files forces Edge to re-fetch favicons:

1. Go to `edge://settings/privacy`.
1. Under **Clear browsing data**, select **Choose what to clear**.
1. Select **Cached images and files**.
1. Select **Clear now**.
1. Revisit the saved site to re-cache the correct favicon.

### Clear the favicon database manually

To clear the favicon database manually, follow these steps:

1. Close Microsoft Edge completely.
1. Open File Explorer and go to the following path: `%LOCALAPPDATA%\Microsoft\Edge\User Data\Default`
1. Delete the *Favicons* and *Favicons-journal* files.
1. Restart Microsoft Edge and revisit your saved sites.

> [!NOTE]
> After you clear the favicon cache or database, Edge re-downloads favicons as you visit websites. The icons on your new tab page might temporarily appear as default letter icons until the correct favicons are re-cached.

## Related content

- [Microsoft Edge browser policies](/deployedge/microsoft-edge-policies)
