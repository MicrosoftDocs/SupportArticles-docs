---
title: You are not authorized to view this page error when accessing Dynamics CRM Web site 
description: Describes a problem that occurs when the IIS authentication for the Microsoft Dynamics CRM Web site is not configured to use Kerberos authentication. A resolution is provided.
ms.reviewer: snulph
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# You are not authorized to view this page error when you try to access the Microsoft Dynamics CRM Web site

This article provides a resolution for the issue that you may receive the **You are not authorized to view this page** error that occurs when you try to access the Microsoft Dynamics CRM Web site.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 917818

## Symptoms

When you try to access the Microsoft Dynamics CRM Web site, you are prompted for domain credentials three times. Then, you receive the following error message:

> You are not authorized to view this page.
>
> HTTP Error 401.1 - Unauthorized: Access is denied due to invalid credentials.

## Cause

This problem may occur when either of the following conditions is true:

- The Microsoft Internet Information Services (IIS) authentication for the Microsoft Dynamics CRM Web site is not configured to use Kerberos authentication.
- The Microsoft Dynamics CRM Web site is configured to use host headers.

## Resolution

To resolve this problem, follow these steps.

### Determine the identifier that the Microsoft Dynamics CRM Web site uses

1. On the Microsoft Dynamics CRM server, select **Start**, select **Administrative Tools**, and then select **Internet Information Services (IIS) Manager**.
2. Expand the Microsoft Dynamics CRM computer name, and then select **Web Sites**.

3. Select the Microsoft Dynamics CRM Web site, and then note the value in the **Identifier** column.

    > [!NOTE]
    > If you installed Microsoft Dynamics CRM on the default Web site, this value is **1**.
4. Verify the Microsoft Dynamics CRM Web site identifier. To do this, follow these steps:
   1. Select **Start**, select **Run**, type *regedit*, and then select **OK**.
   2. Locate the following registry subkey:

      `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSCRM`

   3. Select **website**, and then note the value in the **Value data** field.

        > [!NOTE]
        > The value resembles /LM/W3SVC/1. The last number is supposed to be the same as the Web site identifier that you noted in step 3.

### Configure IIS to use Kerberos authentication for the Microsoft Dynamics CRM Web site

1. Select **Start**, select **Run**, type *cmd*, and then select **OK**.
2. At the command prompt, type the following command, and then press Enter:

   `C:\Inetpub\AdminScripts\adsutil.vbs get w3svc/1/NTAuthenticationProviders`

    > [!NOTE]
    > In this command, **1** represents the value that you determined in the [Determine the identifier that the Microsoft Dynamics CRM Web site uses](#determine-the-identifier-that-the-microsoft-dynamics-crm-web-site-uses) section.

    The result states that the authentication is not set at this level or that the authentication is set to **NTAuthenticationProviders: (STRING)"NTLM."** Therefore, you have to set Kerberos authentication.

3. At the command prompt, type the following command, and then press Enter:

   `C:\Inetpub\AdminScripts\adsutil.vbs set w3svc/1/NTAuthenticationProviders "Negotiate,NTLM"`

    > [!NOTE]
    > In this command, **1** represents the value that you determined in the [Determine the identifier that the Microsoft Dynamics CRM Web site uses](#determine-the-identifier-that-the-microsoft-dynamics-crm-web-site-uses) section.

4. To verify that Kerberos authentication is set correctly, type the following command at the command prompt, and then press Enter:

    `C:\Inetpub\AdminScripts\adsutil.vbs get w3svc/1/NTAuthenticationProviders`

    > [!NOTE]
    > In this command, **1** represents the value that you determined in the [Determine the identifier that the Microsoft Dynamics CRM Web site uses](#determine-the-identifier-that-the-microsoft-dynamics-crm-web-site-uses) section.

    The result is as follows:

    ```console
    NTAuthenticationProviders: (STRING)"Negotiate,NTLM"
    ```

5. Restart the Microsoft Dynamics CRM server.

> [!NOTE]
> You can use a host header to access the Microsoft Dynamics CRM Web site. If you do this, you must also follow the instructions in this article to resolve the problem.
