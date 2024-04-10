---
title: Protect yourself from spoofed Web sites
description: Describes ways that you can help identify and protect your computer from deceptive Web sites and malicious hyperlinks.
ms.date: 10/13/2020
ms.reviewer: ramakoni
---
# Steps to help identify and protect yourself from deceptive (spoofed) Web sites and malicious hyperlinks

[!INCLUDE [](../../../includes/browsers-important.md)]

When you point to a hyperlink in Internet Explorer, Outlook, the address of the Web site typically appears in the Status bar at the bottom of the window. After you select a link that opens in Internet Explorer, the address of the Web site typically appears in the Internet Explorer Address bar, and the title of the Web page typically appears in the Title bar of the window.

However, a malicious user could create a link to a deceptive (spoofed) Web site that displays the address, or URL, to a legitimate Web site in the Status bar, Address bar, and Title bar. This article describes steps that you can take to help mitigate this issue and to help you to identify a deceptive (spoofed) Web site or URL.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 833786

## More information

This article discusses steps you can take to help protect yourself from spoofed Web sites. To summarize, these steps are:

- Verify that there is a lock icon in the address bar r and verify the name of the server that provides the page that you are viewing before you type any personal or sensitive information. If you notice any errors in the address bar, see [Certificate errors: FAQ](https://support.microsoft.com/topic/certificate-errors-faq-402e08c1-bdd6-5d5c-64f2-ccb8f73cea5c).
- Do not select any hyperlinks that you do not trust. Type them in the Address bar yourself.

### Things that you can do to help protect yourself from spoofed Web sites

Make sure that the Web site uses Secure Sockets Layer/Transport Layer Security (SSL/TLS) and check the name of the server before you type any sensitive information.

SSL/TLS is typically used to help protect your information as it travels across the Internet by encrypting it. However, it also serves to prove that you are sending data to the correct server. By checking the name on the digital certificate user for SSL/TLS, you can verify the name of the server that provides the page that you are viewing. To do this, verify that the lock icon appears in the address bar of your browser window.

To verify the name of the server that appears on the digital certificate, select the lock icon, and then check the name that appears next to **Issued to**. If the Web site does not use SSL/TLS, do not send any personal or sensitive information to the site. If the name that appears next to **Issued to** is different from the name of the site that you thought provides the page that you are viewing, close the browser to leave the site. For more information about how to do this, see [Protect yourself from phishing schemes and other forms of online fraud](https://support.microsoft.com/office/protect-yourself-from-phishing-schemes-and-other-forms-of-online-fraud-be0de46a-29cd-4c59-aaaf-136cf177d593).

### Things that you can do to help protect yourself from malicious hyperlinks

The most effective step that you can take to help protect yourself from malicious hyperlinks is not to select them. Rather, type the URL of your intended destination in the address bar yourself. By manually typing the URL in the address bar, you can verify the information that Internet Explorer uses to access the destination Web site. To do so, type the URL in the Address bar, and then press Enter.

#### Some things that you can do to identify spoofed sites when the Web site is not using SSL/TLS

The most effective step that you can take to verify the name of the site that provides the page that you are viewing is to verify the name on a digital certificate using SSL/TLS. But if the site does not use SSL/TLS, you can't conclusively verify the name of the site that provides the page that you are viewing. However, there are some things that you can do that, in some cases, may help you identify spoofed sites.

> [!CAUTION]
> The following information provides general guidelines based on well-known attacks. Because attacks change constantly, malicious users could create spoofed Web sites by using means other than those that are described here. To help protect yourself, type personal or sensitive information on a Web site only if you have verified the name on the digital certificate. Also, if you have any reason to suspect the authenticity of a site, leave it by closing the browser window immediately. Frequently, the quickest way to close the browser window is to press Alt+F4.

#### Try to identify the URL of the current Web page

To try to identify the URL of the current Web site, use the following methods.

##### Use the Internet Explorer History pane to try to identify the actual URL for the current Web site

In the scenarios that Microsoft has tested, you can also use the History Explorer Bar in Internet Explorer to help identify the URL of a Web page. On the **View** menu, point to **Explorer Bar**, and then select **History**. Compare the URL in the Address bar with the URL that appears in the History bar. If they do not match, the Web site is likely misrepresenting itself and you may want to close Internet Explorer.

##### Paste the URL in the Address bar of a new instance of Internet Explorer

You can paste the URL in the Address bar of a new instance of Internet Explorer. By doing so, you may be able to verify the information that Internet Explorer will use to access the destination Web site. In the scenarios that Microsoft has tested, you can copy the URL that appears in the Address bar and paste it in the address bar of a new session of Internet Explorer to verify the information Internet Explorer will actually use to access the destination Web site. This process is similar to the step that is discussed in [Things that you can do to help protect yourself from spoofed Web sites](#things-that-you-can-do-to-help-protect-yourself-from-spoofed-web-sites) section earlier in this article.

> [!CAUTION]
> If you perform this action on some sites, such as on e-commerce sites, the action can potentially cause your current session to be lost. For example, the contents of an online shopping cart may be lost, and you may have to repopulate the cart.

To paste the URL in the Address bar of a new instance of Internet Explorer, follow these steps:

1. Select the text in the Address bar, right-click the text, and then select **Copy**.
2. Close Internet Explorer.
3. Start Internet Explorer.
4. Select in the Address bar, right-click, and then select **Paste**.
5. Press Enter.

##### Some things that you can do to identify malicious hyperlinks

The only way that you can verify the information that Internet Explorer will use to access the destination Web site is by manually typing the URL in the address bar. However, there are some things that you can do that, in some cases, may help you identify a malicious hyperlink.

> [!CAUTION]
> The following information provides general guidelines based on well-known attacks. Because attacks change constantly, malicious users could create spoofed Web sites by using means other than those that are described here. To help protect yourself, type personal or sensitive information on a Web site only if you have verified the name on the digital certificate. Also, if you have any reason to suspect the authenticity of a site, leave it by closing the browser window immediately. Frequently, the quickest way to close the browser window is to press Alt+F4.

##### Try to identify the URL that a hyperlink will use

To try to identify the URL that a hyperlink will use, follow these steps:

1. Right-click the link, and then select **Copy Shortcut**.
2. Select **Start**, and then select **Run**.
3. Type *notepad*, and then select **OK**.
4. On the **Edit** menu in Notepad, select **Paste**.

By doing this, you can see the full URL for any hyperlink and you can examine the address that Internet Explorer will use. The following list shows some of the characters that may appear in a URL that could lead to a spoofed Web site:

- %00
- %01
- @

For example, a URL of the following form will open `http://example.com`, but the URL in the Address bar or the Status bar in Internet Explorer may appear as `http://www.wingtiptoys.com`:

`http://www.wingtiptoys.com%01@example.com`

##### Other steps that you can take

Although these actions do not help you to identify a deceptive (spoofed) Web site or URL, they can help limit the damage from a successful attack from a spoofed Web site or a malicious hyperlink. However, they restrict e-mail messages and Web sites in the Internet zone from running scripts, ActiveX Controls, and other potentially damaging content.

- Use your Web content zones to help prevent Web sites that are in the Internet zone from running scripts, running ActiveX Controls, or running other damaging content on your computer. First, set your Internet zone security level to High in Internet Explorer. To do so, follow these steps:

  1. On the **Tools** menu, select **Internet Options**.
  2. Select the **Security** tab, select **Internet**, and then select **Default level**.
  3. Move the slider to **High**, and then select **OK**.
  
  Next, add the URLs for Web sites that you trust to the Trusted Sites zone. To do so, follow these steps:

  1. On the **Tools** menu, select**Internet Options**.
  2. Select the **Security** tab.
  3. Select **Trusted sites**.
  4. Select **Sites**.
  5. If the sites that you want to add do not require server verification, clear the **Require server verification (https:) for all sites in this zone** check box.
  6. Type the address of the Web site you want to add to the **Trusted sites** list.
  7. Select **Add**.
  8. Repeat steps 6 and 7 for each Web site that you want to add.
  9. Select **OK** two times.

  Read E-mail Messages in Plain Text.

  By reading e-mail in plain text, you can see the full URL of any hyperlink and examine the address that Internet Explorer will use. The following are some of the characters that may appear in a URL that could lead to a spoofed Web site:

  - %00
  - %01
  - @

  For more information on how to do this, see [Read email messages in plain text](https://support.microsoft.com/office/read-email-messages-in-plain-text-16dfe54a-fadc-4261-b2ce-19ad072ed7e3).

- For example, a URL of the following form will open `http://example.com`, but the URL that appears in the text of the email may show `http://www.wingtiptoys.com`:

  `http://www.wingtiptoys.com%01@example.com`

## References

For more information about Uniform Resource Locators (URLs), see [https://www.w3.org/Addressing/URL/url-spec.txt](https://www.w3.org/Addressing/URL/url-spec.txt).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]
