---
title: Version 3 (CNG) templates won't appear in certificate web enrollment
description: Fixes an issue where the CNG or 2008 templates don't appear in the Advanced Certificate Request template pulldown menu.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-certificate-services, csstroubleshoot
ms.subservice: active-directory
---
# Version 3 (CNG) templates won't appear in Windows Server 2008 or Windows Server 2008 R2 certificate web enrollment

This article helps fix an issue where the CNG or 2008 templates don't appear in the Advanced Certificate Request template pulldown menu.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2015796

## Symptoms

When using the certificate web enrollment page on a Windows Server 2008 or Windows Server 2008 R2 server, the new Version 3, also known as CNG or 2008 templates, don't appear in the Advanced Certificate Request template pulldown menu. As a result, web enrollment using a CNG template can't take place via the web enrollment method.

When this occurs, certificates can be requested and enrolled in successfully using the same templates but other enrollment methods. In other words, you can successfully request a certificate from that template using the certificates MMC snap-in, script, autoenrollment, or exported request. The issue only occurs with web enrollment not allowing the Version 3 template from being available to select.

Frequent other causes of not being able to blanket request a certificate may be that the server isn't an Enterprise server, or the requestor doesn't have Read Allow and Request Allow permissions on the template in Active Directory.

## Cause

This behavior is by design. Version 3 templates may have additional request requirements that the web enrollment method may not fulfill.

## Resolution

Use a different request method for these certificates. Aside from web enrollment, all other request methods work in this scenario.

## More information

An alternative, which shouldn't be attempted in production for customers without extensive testing in a test environment, is available that will allow the version 3 templates to appear in the web enrollment default pages. The reason it's not recommended is that the web enrollment pages, again, may not contain the code necessary for the certificate to populate all needed data, and so the result may be a problematic certificate. Make sure to keep that in mind when considering doing the steps below. This option is to alter the msPKI-Template-Schema-Version from 3 to 2.

In addition, altering the msPKI-Template-Schema-Version attribute results in a reload of the template cache and CSP cache available.

1. On your domain controller go to **Start**, **Run**, type **AdsiEdit.msc** and press **Enter**.

2. In **AdsiEdit.msc** right-click on the **ADSIEDIT** node in the left-hand pane and select **Connect To** in the menu that appears.

3. In the **Connection Settings** dialog, select **Configuration** in the **Connection Point** section and click **OK**.

4. Expand the nodes in the left-hand pane until you've drilled down to your **Templates** store (CN=Certificate Templates,CN=Public Key Services,CN=Services,CN=Configuration,DC=,DC=).

5. Double-click the Version 3 template you would like to have appear in the web enrollment page.

6. Scroll down and select the **msPKI-Template-Schema-Version** attribute.

7. Double-click the **msPKI-Template-Schema-Version** attribute and change the value from **3** to **2** and click **OK**.

8. Click **Apply**. This updates the template and CSP list. Keep this in mind if you use 3rd-party CSPs in your environment.

9. Go to your web enrollment page (if ran from your CA server) and attempt to enroll the certificate using an advanced request.
