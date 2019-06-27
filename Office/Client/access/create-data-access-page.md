---
title: An error when you create a data access page in Access
author: simonxjx
manager: willchen
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# You receive errors when you create a data access page in Access

## Symptoms

When you try to create a data access page in Microsoft Office Access 2003 or Microsoft Access 2002, you may receive the following message:

```asciidoc
Content within this application coming from the Web site listed below is being blocked by Internet Explorer Enhanced Security Configuration.

accdp://4534800/
```

If you trust this Web site, you can lower security settings for the site by adding it to the Trusted sites zone. If you know this Web site is on your local intranet, review help for instructions on adding the site to the local intranet zone instead.

> [!IMPORTANT]
> Adding this Web site to the Trusted sites zone will lower the security settings for all content from this Web site for all applications, including Internet Explorer.

If you click **Add**, click **Add** two times, and then click **Close**, you can create the data access page. However, when you next start Access and create a data access page, you receive this message again.

If you click **Close**, you receive the following message:

```asciidoc
Your current security settings prohibit running ActiveX controls on this page. As a result, the page may not display correctly.
```

When you click **OK**, you receive the following error message:

```asciidoc
The data definition of this data access page has been corrupted and can't be repaired. You must recreate the page. Save has been disabled.
```

## Cause

This issue occurs because of the increased security introduced in Microsoft Windows Server 2003. The data access page must load ActiveX controls to function. However, it cannot load these controls if your Internet Explorer **Internet** zone security settings are set to **High**.

After you click **Add** on the message described in the Symptoms section of this article, and then click **Add** to add the accdp protocol to the list of trusted sites, you are prompted again to add this protocol the next time that you create a data access page because the number that follows **accdp://** changes each time you create a data access page. 

## Workaround

To work around this issue, change your **Internet** zone settings in Microsoft Internet Explorer to allow ActiveX controls and plug-ins. To do this, follow these steps: 

1. Start Internet Explorer.
2. If you receive a message stating that Microsoft Internet Explorer's Enhanced Security Configuration is currently enabled, click **OK**.
3. On the **Tools** menu, click **Internet Options**.
4. Click the **Security** tab, click **Internet**, and then click **Custom Level**.
5. Under **Run ActiveX controls and plug-ins**, click **Enable**.
6. Click **OK**, click **Yes** to confirm that you want to change the security settings for this zone, click **Apply**, and then click **OK**.

## More information

For additional information about how to configure the security settings in Internet Explorer, type **res://shdoclc.dll/IESecHelp.htm#addinternetsites** in the Internet Explorer **Address** bar, and then click **Go**.
