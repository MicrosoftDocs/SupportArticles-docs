---
title: Cannot sign in to Visual Studio Team Services
description: Describes an issue that prevents you from signing in to Visual Studio Team Services through Internet Explorer or Microsoft Edge.
ms.date: 03/26/2020
ms.reviewer: delhan
---
# Can't sign in to Visual Studio Team Services through Internet Explorer or Microsoft Edge

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides the workaround to solve the issue that you cannot sign in to Visual Studio Team Services by using Microsoft Edge, Internet Explorer 11, Internet Explorer 10, or Internet Explorer 9.

_Original product version:_ &nbsp; Microsoft Edge, Internet Explorer 11, Internet Explorer 10, Internet Explorer 9  
_Original KB number:_ &nbsp; 4013279

## Symptoms

When you use Internet Explorer or Microsoft Edge to sign in to Visual Studio Team Services, you are blocked. This issue frequently occurs as an infinite loop of the browser redirects.

## Workaround

To work around this issue, add `https://*.visualstudio.com` as a trusted site under **Internet Options**. To do this, follow these steps:

1. Navigate to **Internet Options**:

   - In Internet Explorer, click **Tool**, click **Internet Options**, and then click the **Security** tab.
   - For Microsoft Edge, search for **Internet Options** on the Windows **Start** menu, and then click the result.

2. In the **Select a Web content zone to specify its current security setting** box, click **Trusted Site**, and then click **Site**.

3. In the **Add this Web site to the zone** box, type `https://*.visualstudio.com`, and then click **Add**.

4. Click **Close** to close the **Trusted Site** dialog box, and then click **OK** to accept the changes and close the **Internet Properties** dialog box.
  
> [!NOTE]
> This issue is specific to Internet Explorer and Microsoft Edge. It doesn't occur in Chrome or Firefox.
