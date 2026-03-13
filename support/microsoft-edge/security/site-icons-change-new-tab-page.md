---
title: Fix Edge Saved Site Icons Changing on New Tab Page
description: Learn how to troubleshoot unexpected favicon changes on the Microsoft Edge new tab page and restore the correct icons for your saved sites.
ms.date: 03/11/2026
ms.reviewer: dili, Johnny.Xu, v-shaywood
ms.custom: 'sap:Security and Privacy\Profiles and Sync: Caches, Favorites, Autofill, Wallet'
---

# Saved site icons change unexpectedly on the new tab page

This article explains why saved site icons (favicons) on the Microsoft Edge new tab page might change unexpectedly. For example, a website's icon might be replaced by a PDF icon. This behavior occurs because of how Edge looks up and caches favicons. This article discusses the favicon lookup process and the conditions under which this problem occurs.

## Symptoms

You experience one or more of the following problems:

- A saved site on the Edge new tab page shows an incorrect icon. For example, a PDF icon appears instead of the website's original favicon.
- The favicon for a saved site changes after you visit a different page on the same website.
- A saved site's icon alternates between different icons over time.

## Cause

Edge uses the following order to look up favicons for saved sites:

1. **Exact URL cache**: Looks for a favicon cached for the specific page URL.
1. **Host-level cache**: Falls back to a favicon cached for any page on the same host.
1. **Favicon service**: Tries to download the favicon from an external favicon service.
1. **Default initial**: Uses the first letter of the site name as a placeholder icon.

The problem occurs at the host-level cache step. If Edge can't find a favicon for a specific URL, such as  `https://yourdomain/home.aspx`, it falls back to reusing the favicon that's cached for the same host (`https://yourdomain`).

This behavior is by design. Most websites use a single favicon across all pages, so the host-level fallback works correctly in most cases. However, if different pages on the same host use different favicons (for example, a web application that serves both HTML pages and PDF documents), the fallback mechanism can cause the wrong favicon to appear.

### Example scenario

Consider the following situation:

- You save `https://yourdomain/home.aspx` on your new tab page.
- You visit `https://yourdomain/a.aspx`. This site uses the same favicon as the home page. In this case, everything works as expected because the saved site shows the correct icon.
- You visit `https://yourdomain/b.aspx`. This site contains a PDF document and has a PDF favicon.
- Edge caches the PDF favicon for the host `https://yourdomain`.
- The next time that Edge looks up a favicon for `https://yourdomain/home.aspx`, the exact URL match fails. Therefore, Edge uses the host-level favicon. That icon is now the PDF icon.
- Your saved site on the new tab page now displays the PDF icon instead of the original website favicon.

## Solution

No direct setting exists to change the favicon lookup behavior. However, you can try the following solutions.

### Revisit the original page

Open the saved site URL (for example, `https://yourdomain/home.aspx`) directly in Edge. This action refreshes the favicon cache for that exact URL. This action might restore the correct icon.

### Clear the favicon cache

If you clear cached images and files forces, this action forces Edge to re-fetch favicons:

1. Go to `edge://settings/privacy`.
1. Under **Clear browsing data**, select **Choose what to clear**.
1. Select **Cached images and files**.
1. Select **Clear now**.
1. Revisit the saved site to recache the correct favicon.

### Clear the favicon database manually

To clear the favicon database manually, follow these steps:

1. Close Edge completely.
1. Open File Explorer, enter `%LOCALAPPDATA%\Microsoft\Edge\User Data\Default` in the Address bar, and then press Enter.
1. Delete the *Favicons* and *Favicons-journal* files.
1. Restart Edge, and revisit your saved sites.

> [!NOTE]
> After you clear the favicon cache or database, Edge downloads favicons again as you visit websites. The icons on your new tab page might temporarily appear as default letter icons until the correct favicons are recached.

## Related content

- [Microsoft Edge browser policies](/deployedge/microsoft-edge-policies)
