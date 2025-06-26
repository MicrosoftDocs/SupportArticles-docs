---
title: Delay when Outlook retrieves Autodiscover info
description: Describes an issue that triggers a delay or other unexpected behavior when Outlook tries to retrieve Autodiscover information for an Exchange Online mailbox in a hybrid deployment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: andypunt, jmartin, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Delay when Outlook retrieves Autodiscover information for an Exchange Online mailbox in a hybrid environment

_Original KB number:_ &nbsp; 3137323

## Symptoms

When Outlook tries to retrieve Autodiscover information for an Exchange Online mailbox in an Exchange hybrid environment, you may experience a delay or unexpected results.

## Cause

The client is locating one or more service connection point (SCP) objects for the Autodiscover service in the local Active Directory forest.

## Resolution 1 - Disable SCP lookup

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

1. Open Registry Editor.
2. Locate and then select the following registry subkey:

   `HKEY_CURRENT_USER\Software\Microsoft\Office\x.0\Outlook\AutoDiscover`

    > [!NOTE]
    > The **x.0** placeholder corresponds to the version of Outlook (16.0 = Outlook 2016, 15.0 = Outlook 2013).

3. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
4. Type *ExcludeScpLookup*, and then press Enter.
5. Right-click the **ExcludeScpLookup** value that you created, select **Modify**, type *1* in the **Value data** box, and then select **OK**.

To control Outlook Autodiscover by using Group Policy, see [How to control Outlook AutoDiscover by using Group Policy](/outlook/troubleshoot/profiles-and-accounts/how-to-control-autodiscover-via-group-policy).

## Resolution 2 - Remove the Exchange SCP objects

> [!WARNING]
> This procedure requires Active Directory Service Interfaces Editor (ADSI Edit). Using ADSI Edit incorrectly can cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that problems that result from the incorrect use of ADSI Edit can be resolved. Use ADSI Edit at your own risk.

1. Open ADSI Edit.
2. Right-click **ADSI Edit**, select **Connect to**, select **Configuration** in the **Select a well known Naming Context** box, and then select **OK**.
3. Locate the following container:

   CN=Servers,CN=Exchange Administrative Group,CN=Administrative Groups,CN=\<Exchange Org>,CN=Microsoft Exchange,CN=Services,CN=Configuration,DC=\<Domain>,DC=\<com>

4. Expand the server, expand **Protocols**, and then expand **Autodiscover**.
5. Right-click the SCP object (the object is equal to CN=\<ServerName>), and then select **Delete**.
6. Select **Yes** to confirm the deletion.
7. Repeat steps 4-6 for each additional server that's listed in the container in step 3.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
