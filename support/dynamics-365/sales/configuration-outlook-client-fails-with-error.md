---
title: Configuration of Outlook client fails with an error
description: This article provides three resolutions for the problem where The server address (URL) is not valid occurs. 
ms.reviewer: ehagen, debrau
ms.topic: troubleshooting
ms.date: 
---
# Configuration of the Microsoft Dynamics CRM 2011 Outlook client fails with the error: The server address (URL) is not valid

This article provides three resolutions for the problem where **The server address (URL) is not valid** occurs.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2548802

## Symptoms

When configuring the Microsoft Dynamics CRM 2011 Outlook Client, the following error occurs:

> The server address (URL) is not valid

## Cause

This issue can occur due to the following reasons:

- Anonymous Access is disabled on the CRM web site.
- The Web Address URLs specified in Deployment Manager do not match the URL entered in the Configuration Wizard.
- The CRM website has multiple bindings in IIS.

## Resolution

- Resolution 1:

    1. Open Internet Information Services Manager on the Microsoft Dynamics CRM 2011 Server. To do this, click **Start**, click **Administrative Tools**, and select **Internet Information Services (IIS) Manager**.
    2. In the navigation pane, expand the server name, and then expand sites.
    3. Select the Microsoft Dynamics CRM web site, and then in the **Features View**, double-click **Authentication**.
    4. Select **Anonymous Authentication**, and then in the **Actions** menu, click **Enable**.
    5. Perform an IISRESET. To do this, click **Start**, click **Run**, and enter *iisreset* without quotations in the **Run** dialog box, and click **Ok**.

- Resolution 2:

    1. Open the CRM Deployment Manager. To do this, click **Start**, click **All Programs**, click **Microsoft Dynamics CRM 2011**, and click **Deployment Manager**.
    2. Right-click **Microsoft Dynamics CRM**, click **Properties**, and select the **Web Address** tab.
    3. Verify that the URL that is being used to configure the client is the same as the URL that is set for the Web Address values.

- Resolution 3:

    1. Click **Start**, Click **Run**, and Type *in inetmgr*.
    2. Expand **Sites** and click on the Microsoft Dynamics CRM website.
    3. In the **Actions Pane**, click on **Bindings**.
    4. In the **Site Bindings** window, ensure that there is only one http or one https binding type.

    > [!NOTE]
    > The binding that should remain is the binding that is defined in the Deployment Manager. To check for the correct URL, open Deployment Manager, right-click on Microsoft Dynamics CRM, click Properties, and click the Web Address tab. If IFD is used, the certificate matching your IFD settings should be kept.
