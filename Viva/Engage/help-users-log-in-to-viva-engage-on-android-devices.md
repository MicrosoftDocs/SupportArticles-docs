---
title: Users can't sign in to Viva Engage on Android devices
description: Fix issues that users can't sign in to Viva Engage on an Android device.
ms.author: luche
author: helenclu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.service: viva-engage
search.appverid:
 - MET150
ms.date: 12/20/2023
---

# Users can't sign in to Viva Engage on Android devices

If users have a Viva Engage account, but can't sign in on their device, they may need to update Android WebView.
  
On an Android device, make sure you've downloaded the latest version of [Android WebView](https://play.google.com/store/apps/details?id=com.google.android.webview&amp;hl=en). This Chrome component delivers security updates and lets Android apps show your content.

If the issue persists, your organization's security certificate might be outdated. Forward this article to your IT admin so they can resolve the issue.
  
## Troubleshooting for Viva Engage and Microsoft 365 admins

 **Missing or outdated certificates could be preventing login authentication.**
  
Before your users can sign in to Viva Engage, your organization's SSL certificates must pass certain checks—some required by Android, others specific to Active Directory Federation Services (AD FS). It's the safest way to protect your org's networks, user information and internal resources.
  
In fact, your servers must prove their trustworthiness to any client operating system or application whenever someone attempts to sign in to a secure app (like Viva Engage).
  
 **And trust is complicated.**
  
There's also an entire certification hierarchy. Something called the root certification authority certificate sits at the top of it (despite what its name might imply). It issues certificates to "authorize" other, subordinate certificates called intermediate certificates. Together, these certificates form a certification chain.
  
Intermediate certificates in the chain are important, as well--so important that Android requires that they're sent in a specific order:
  
1. First, make sure you've put the root certification authority certificate in the Trusted Root Certification store, which is on your AD FS server(s).
2. Then, put any intermediate certification authority certificates in the Intermediate Certification store on the Local Computer, which you can find on your AD FS and Web Application Proxy (WAP) servers. (Run `certlm.msc` to open the console on a Windows computer.)

:::image type="content" source="./media/help-users-log-in-to-viva-engage-on-android-devices/certificates-local-computer.png" alt-text="Screenshot that shows the certificate hierarchy on Local Computer.":::

To make step 2 easier to understand, you might think of servers as continents:
  
- the Local Computer would be a country/region in those continents
- the certification store would be a state (or province)
- intermediate certificates would be the state population

On a Mac computer, these categories, or folders, vary slightly. Use Spotlight to search for the "keychain access" console. For information on keychain access, see [Keychain Access overview](https://support.apple.com/kb/PH20093) on the Apple Support site.
  
If your organization already has its certification hierarchy squared away, then you could be encountering a small issue on your Security Token Service (STS) server, explained below.
  
 **Downloading additional certificates is a common misstep.**
  
There are a couple of things that could have gone wrong with your SSL certificate(s), but the most common culprit is a server configuration that's missing an intermediate certification authority, the piece that signs your server's certificates with its private key. This triggers an AuthenticationException error when Viva Engage or Microsoft 365 tries to display the sign-in page.
  
Someone might have downloaded other certificates from the authorityInformationAccess field of an SSL certificate, which prevents the server from passing on the entire certificate chain from AD FS. **Android doesn't support additional certificate downloads from this field.**
  
 **Before troubleshooting, here's how you can be sure that this is an issue.**
  
Follow these steps to verify whether you've got an SSL certificate that's missing necessary intermediate certificates:
  
1. Using a non-Android device, go to [https://login.microsoftonline.com](https://login.microsoftonline.com).
1. Sign in with your work or school address as you normally would.
1. After you're redirected, copy the URL that's in your browser's address bar. That's your Security Token Service server's fully qualified domain name (FQDN)—omit the `https://` part.
1. Insert your FQDN in the following URL. Make sure that you replace only the letters *FQDN* without adding any additional characters:

    `https://www.ssllabs.com/ssltest/analyze.html?d=FQDN&hideResults=on&latest`

1. Copy, paste, and go to the URL that you completed in step 4.

You should see a list of SSL certificates. Look for a certificate labeled "extra download." This error signals failed authentication, indicating that AD FS couldn't pass along the entire certificate chain.
  
:::image type="content" source="./media/help-users-log-in-to-viva-engage-on-android-devices/certification-paths.png" alt-text="Screenshot that shows the List of SSL certificates with extra download error.":::
  
Successful authentication is marked as **sent by server**.
  
 **Here's how you fix an extra download.**
  
Follow these steps to configure your Security Token Service (STS) and Web Application Proxy (WAP) servers and send the missing intermediate certificate(s) together with the SSL certificate. First, you need to export the SSL certificate.
  
1. Run `certlm.msc` to open the certificates console. Only an administrator or user who has been given the proper permissions can manage certificates.
2. In the console tree in the store that contains the certificate to export, select **certificates**.
3. In the details pane, select the certificate that you need to export.
4. On the **Action** menu, select **all tasks**, and then select **export**. Select **next**.
5. Select **yes, export the private key,** and select **next**.
6. Select **Personal Information Exchange - PKCS #12 (.PFX),** and accept the default values to include all certificates in the certification path if possible. Also, make sure that the **export all extended properties** check boxes are selected.
7. If required, assign users/groups, and type a password to encrypt the private key that you're exporting. Type the same password again to confirm it, and then select **next**.
8. On the File to Export page, browse the location where you want to put the exported file, and give it a name.
9. Using the same certificates console (`certlm.msc`), import the \*.PFX file into the computer's personal certificate store.
10. Finally, if your organization uses active load balancers to distribute traffic between servers, these servers should also have their local certificate stores updated (or at least verified).

If the above steps didn't work for you, look into these similar issues, or contact [Viva Engage Support](https://support.microsoft.com/office/yammer-help-center-8663922d-8f76-47c2-827a-ee86e8cac00f):
  
- [An external certificate that isn't yet valid](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn383637(v=ws.11))  
- [An external certificate that has expired](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn383649(v=ws.11))
- [An external certificate that doesn't have a private key](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn383656(v=ws.11))
  
These three issues are related to the Web Application Proxy (WAP). For more information about WAP, see [Working with Web Application Proxy](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn584113(v=ws.11)).
