---
title: How to change incoming or outgoing Exchange settings after installation
description: Describes how to change the incoming or outgoing Microsoft Exchange Server settings after the original installation of Microsoft Dynamics CRM is finished.
ms.reviewer: mmaasjo, jstrand
ms.topic: how-to
ms.date: 3/31/2021
---
# How to change incoming or outgoing Exchange Server settings after the original installation is done

This article describes how to change the incoming or outgoing Microsoft Exchange Server settings after the original installation of Microsoft Dynamics CRM is completed.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 906471

## Incoming

The incoming server is the server where the Microsoft Dynamics CRM Exchange Router is installed. To change the incoming Exchange Server setting to a different server, follow these steps:

1. Install the Microsoft Dynamics CRM Exchange E-mail Router on the new Exchange server.
2. Move the Microsoft Dynamics CRM System mailbox from the old server to the new Exchange server.
3. On the domain controller, select **Start**, point to **Programs**, point to **Administrative Tools**, and then select **Active Directory Users and Computers**.
4. Add the new Exchange server's computer account to the PrivUserGroup security group. Remove the old Exchange server's computer account.

## Outgoing

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

The outgoing server is the server where Microsoft Dynamics CRM server is installed. To change the outgoing e-mail server to a different server, follow these steps.

> [!NOTE]
> The `SMTPAuthenticate` key, `SMTPServer` key, `SMTPServerPort` key, and `SMTPUseSSL` key are required to send e-mail from Microsoft Dynamics CRM. The other registry keys are optional.

1. Start Registry Editor. To do this, select **Start**, select **Run**, type *regedit*, and then select **OK**.
2. Locate and then select the registry subkey: `My Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSCRM`.
3. In that subkey, create the following registry entries if they do not exist. Create only the entries for which you want to change the default settings.

   - Registry entry: SMTPServer.

     Type: String.  
     Value description: Outgoing SMTP server name.  
     Value example: ExchangeServer.

     > [!NOTE]
     > You must use the netbios name of the server.

   - Registry entry: SMTPServerPort.

     Type: DWORD.  
     Value description: The port that SMTP will use.  
     Value example: 25.

   - Registry entry: SMTPAuthenticate.

     Type: DWORD.  
     Value description: To see a list of the values, see [CdoProtocolsAuthentication Enum](/previous-versions/exchange-server/exchange-10/ms526961(v=exchg.10)).  
     Value example: 0.

   - Registry entry: SMTPSendUserName.

     Type: String.  
     Value description: Username for Basic Authentication.  
     Value example: CRMAdmin.

   - Registry entry: SMTPSendPassword.

     Type: String.  
     Value description: Encrypted password. Use the Microsoft.Crm.Tools.EncryptPwd.exe tool to encrypt the password. The tool is located in the Microsoft CRM\Tools folder on the Microsoft Dynamics CRM CD.

   - Registry entry: SMTPUseSSL.

     Type: DWORD with a decimal base.  
     Value description: The entry is valid only in clear text authentication mode.  
     Value example: 1=SSL (on) and 0=SSL (off).

4. Make sure that the Simple Mail Transport Protocol (SMTP) service is running on the new server:

   1. Select **Start**, select **Run**, type *services.msc*, and then select **OK**.
   2. Verify that Simple Mail Transport Protocol (SMTP) appears in the list, and verify that SMTP is running. If it is not, follow steps 4c though 4g.
   3. Select **Start**, point to **Control Panel**, and then select **Add or Remove Programs**.
   4. Select **Add/Remove Windows Components**.
   5. Select **Application Server**, select **Details**, select **Internet Information Services (IIS)**, and then select **Details**.
   6. Select to select the **SMTP Service** check box, and then select **OK**.
   7. Select **OK**, select **Next**, and then select **Finish**.
