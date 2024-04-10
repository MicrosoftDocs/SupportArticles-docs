---
title: Cookies for WebOC application lost
description: This article describes that Internet Explorer selects button of Delete browsing history on exit, then the application's cookies will not be retained.
ms.date: 06/09/2020
ms.reviewer: 
---
# Permanent cookies for WebOC application lost when user closes Internet Explorer

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides a solution for applications that rely on permanent cookies. You can choose to keep the website's cookies and temporary Internet files in Internet Explorer favorites.

_Original product version:_ &nbsp; Internet Explorer 11, Internet Explorer 9  
_Original KB number:_ &nbsp; 2777993

## Summary

If you are developing or using an application based on the Web Browser Control, you may notice that the application may stop working correctly as soon as a user closes the last instance of Internet Explorer. This may happen if the **Delete browsing history on exit** button is checked on the General tab of the **Internet Options** dialog, and your application is relying on permanent cookies. If you want the application to be able to access permanent cookies in this case, you need to add the sites for which the cookies need to be set in your Favorites folder.

## More information

While the ability to delete browsing history is not new to Internet Explorer, the feature has been enhanced in several ways for Internet Explorer 8. Now when deleting browsing history, you can choose to preserve cookies and temporary Internet files for sites in your Favorites folder. This helps to protect your information and privacy while preserving your data on your trusted favorite sites.
