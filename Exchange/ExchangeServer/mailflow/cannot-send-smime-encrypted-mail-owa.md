---
title: Can't send S/MIME encrypted mails from Outlook Web App
description: Provides a resolution for the issue where users can't send S/MIME signed or encrypted mails in Outlook Web APP.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow\Need Help with Configuring Mailflow, Mail routing (Connectors, Domains)
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: djball, wduff, v-six
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Error when sending S/MIME encrypted mails from OWA: Outlook Web Access could not find your digital ID for encryption

_Original KB number:_ &nbsp;2497165

## Symptoms

Users are unable to send Secure/Multipurpose Internet Mail Extensions (S/MIME) signed or encrypted mails in Microsoft Office Outlook Web Access (OWA). A dialog box displays the following error message.

```console
Outlook Web Access could not find your digital ID for encryption. If your digital ID is on a smart card, insert the card in the card reader, and then try to send the message again. You may also try sending the message unencrypted.

If your digital ID is not trusted by the Exchange server, you cannot use it to encrypt messages. For more information, contact technical support for your organization.
```

## Cause

The user certificate's **Subject** or **Subject Alternative Name** fields must contain an SMTP address that's listed on the account used to sign in to OWA.

In a default installation of Exchange Server 2007 or Exchange Server 2010, if the user certificate is issued to an SMTP address that's not listed on the Active Directory account, then OWA won't use the certificate.
> [!NOTE]
> To use the S/MIME features in OWA, you must be running Exchange Server 2007 Service Pack 1 (SP1) or later versions of Exchange.

## Resolution

To resolve this issue, you must obtain a digital ID.

If you have a Digital ID that can be used for S/MIME emails, but the SMTP address doesn't match your Exchange Server mailbox account, the Exchange Administrator can enable the following registry value to allow for the selection of the user certificate. This allows users to select the certificate that will be used to sign outgoing messages. The OWA client will bypass the SMTP name check.

Use the steps below to enable this OWA feature.
> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

1. Click **Start** > **Run**, type *regedit* and press Enter.
2. Expand H**KLM\System\CurrentControlSet\services\MSExchangeOWA\SMIME**.
3. Right-click the SMIME key and click **New** > **DWORD (32-bit)**.
4. Name the new DWORD value **AllowUserChoiceOfSigningCertificate**  
5. Double-click **AllowUserChoiceOfSigningCertificate** and set the value to *1*.
6. Close the registry editor.
7. Click **Start** > **Run**, type *cmd* and click Enter.
8. From the command prompt run `IISReset /noforce`. Or, you can restart the IIS Admin service in Services.msc.

Once you've configured the registry key, the user will see a new option under the **E-Mail security** section in the OWA options. There will be a new section to allow the user to manually pick the signing certificate.

1. Sign in to OWA and click **Options**.  
2. Click **Email security**.  
3. Under the **Select Certificate for Mail Signing** section, change the radio button to **manually pick the certificate**.
4. Click **Choose Signing Certificate...**. A new window will open displaying available user certificates.
5. Select the appropriate certificate and click **OK**.

When the user sends singed mail, it will be signed with the certificate that was selected. The selection process doesn't check the SMTP address included in the Subject or Subject Alternative name extensions of the certificate against the SMTP addresses for the user account in Active Directory.

## More information

With an Outlook client, you can turn off email matching for certificates via a client-side registry key. Complete steps for the Outlook client are documented in [How to turn off e-mail matching for certificates in Outlook](https://support.microsoft.com/kb/276597).

For more information on managing S/MIME settings for OWA, see the following articles from TechNet online.

[How to Manage S/MIME for Outlook Web Access (Exchange Server 2007)](/previous-versions/office/exchange-server-2007/bb738151(v=exchg.80))

[Manage S/MIME for Outlook Web App (Exchange Server 2010)](/previous-versions/office/exchange-server-2010/bb738151(v=exchg.141))
