---
title: Troubleshoot AD replication error 8589
description: Describes how to troubleshoot AD operations failure with Win32 error 8589.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, apurvash, justinha, justintu
ms.custom: sap:Active Directory\User, computer, group, and object management, csstroubleshoot
---
# Troubleshooting AD Replication error 8589: The DS cannot derive a service principal name (SPN)

This article describes symptoms, cause, and resolution steps for cases where AD operations fail with Win32 error 8589.  

> [!NOTE]
> **Home users:** This article is only intended for technical support agents and IT professionals. If you're looking for help with a problem, please [ask the Microsoft Community](https://answers.microsoft.com/en-us).  

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2703028

## Symptoms

> Error 8589: "The DS cannot derive a service principal name (SPN) with which to mutually authenticate the target server because the corresponding server object in the local DS database has no serverReference attribute.  
>
> Symbolic error: ERROR_DS_CANT_DERIVE_SPN_WITHOUT_SERVER_REF

You will see any of the following errors/warning when troubleshooting Active Directory replication.

1. DCDIAG reports that the Active Directory Replications test has failed with error status (8589): The DS cannot derive a service principal name (SPN) ith which to mutually authenticate the target server because the corresponding server object in the local DS database has no serverReference attribute.

    Sample error text from DCDIAG is shown below:  

    > Testing server: \<site>\<DC name>
    >
    > Starting test: Replications
    >
    > \* Replications Check
    >
    > [Replications Check,\<DC name>] A recent replication attempt failed:
    >
    > From \<source DC> to \<destination DC>
    >
    >Naming Context: DC=\<DN path>
    >
    > The replication generated an error (8589):
    >
    > The DS cannot derive a service principal name (SPN) with which to mutually authenticate the target server because the corresponding server object in the local DS database has no serverReference attribute.
    >
    > The failure occurred at \<date> \<time>.
    >
    > The last success occurred at (never)| \<date>.

2. DCDiag.exe shows the following warning:

    > An Warning Event occurred. EventID: 0x80000785
    >
    > Time Generated: *\<DateTime>*
    >
    > Event String: The attempt to establish a replication link for the following writable directory partition failed.  
    Directory partition:  
    DC=ForestDnsZones,DC=contoso,DC=com  
    Source domain controller:  
    CN=NTDS Settings,CN=DCSRV01,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=contosoDC=com  
    Source domain controller address:
    >
    > \<source DC NTDS Settings Obejct GUID>._msdcs.contoso.com  
    Intersite transport (if any):  
    This domain controller will be unable to replicate with the source domain controller until this problem is corrected.  
    >
    > User Action  
    > Verify if the source domain controller is accessible or network connectivity is available.
    >
    > Additional Data  
    > Error value:  
    > 8589
    >
    > The DS cannot derive a service principal name (SPN) with which to mutually authenticate the target server because the corresponding server object in the local DS database has no serverReference attribute.

3. REPADMIN.EXE reports that the last replication attempt has failed with status 8589

    `REPADMIN` commands that commonly cite the 8589 status include but are not limited to:
    - `REPADMIN /SHOWREPL`
    - `REPADMIN /SHOWREPS`
    - `REPADMIN /REPLSUM`
    - `REPADMIN /SYNCALL`

    Repadmin /showrepl returns the following error:

    > Source: \<Site Name>\\\<DC Name>
    >
    > \******* \<n> CONSECUTIVE FAILURES since \<Date & Time>
    >
    > Last error: 8589 (0x218d):
    >
    > The DS cannot derive a service principal name (SPN) with which to mutually authenticate the target server because the corresponding server object in the local DS database has no serverReference attribute.

4. Events in the Directory Services event log that cite the error status 8589

    Events, which commonly cite the 8589 status, include but are not limited to:

    |Event Source and Event ID|Message String|
    |---|---|
    |NTDS Replication / ActiveDirectory_DomainService 1411|Active Directory failed to construct a mutual authentication service principal name (SPN) for the following domain controller.|
    |NTDS Replication 2023|The local domain controller was unable to replicate changes to the following remote domain controller for the following directory partition.|
    |NTDS KCC 1925|The attempt to establish a replication link for the following writable directory partition failed.|

## Cause

The event most commonly occurs on a DC after a replication partner has been forcefully demoted and repromoted prior to allowing end-to-end replication to complete. This can also happen when you rename a domain controller and the serverReference attribute is not updated. The serverReference attribute in this instance is the Server object viewable in the Active Directory Sites and Services MMC (adsiedit.msc). The server object is the parent object of the domain controller's NTDS Settings object.

## Resolution

Verify the serverReference attribute is not missing or set to an incorrect value and update it to the correct value.

1. Find the domain controller that is referenced in the event ID 1411. There are a few options we can use to find this. The simples is to use ping (option A). If ping fails, use PowerShell (option B). If PowerShell is not an option, then you can use ldp.exe (option C). (Note: if your DCs are 2003 and you are not able to install PowerShell on it, you may use PowerShell from a Windows 7 domain joined client or a Windows 2008 or Windows 2008 R2 server)  

    Option A  
    Use NSLookup or ping to find the DC listed in \<source DC NTDS Settings Obejct GUID>._msdcs.contoso.com

    Example:

    Ping 3dab7f9b-92e7-4391-b8db-71df532c1493._msdcs.contoso.com

    ```console
    Pinging DCSRV02.contoso.com [IP] with 32 bytes of data :

    Reply from [IP]: bytes=32 time<1ms TTL=128
    Reply from [IP]: bytes=32 time<1ms TTL=128
    Reply from [IP]: bytes=32 time<1ms TTL=128
    Reply from [IP]: bytes=32 time<1ms TTL=128
    ```

    Option B  
    Use PowerShell to find the DC referenced. There are two PowerShell methods you can use. To do this open the "Active Directory Module for Windows PowerShell"

    Method 1:
    Run the following two PowerShell cmdlets. In the first cmdlet, replace the partition name `CN=Configuration,DC=contoso,DC=com` with the DN of your Configuration partition. Replace the server name `DCSRV01.contoso.com` with the name of your domain controller. In the second cmdlet, replace the GUID _3dab7f9b-92e7-4391-b8db-71df532c1493_ with the GUID in your event ID 1411.

    ```powershell
    $list = Get-ADObject -Filter 'ObjectClass -eq "ntdsdsa"' -SearchBase '*CN=Configuration,DC=contoso,Dc=com*' -Server *DCSRV01.contoso.com*  
    -includedeletedobjects -Properties *

    foreach ($dc in $list) {if ($dc.ObjectGUID -match "*3dab7f9b-92e7-4391-b8db-71df532c1493*") {Echo $dc.DistinguishedName }}  
    ```

    Method 2:
    Another PowerShell option is to run the following and then search the output text file. Replace the `DCSRV01.contoso.com` with a DC in your environment.

    ```powershell
    Get-ADObject -Filter 'ObjectClass -eq "ntdsdsa"' -SearchBase 'CN=Configuration,DC=contoso,Dc=com' -Server DCSRV01.contoso.com -includedeletedobjects > C:\NTDSDSA.txt
    ```

    Then search NTDSA.txt for the GUID referenced in event ID 141

    Option C  

    Use Ldp.exe

    1. Click Start, and then click Run  
    2. Type LDP.exe and then press ENTER.
    3. On the Connections menu, click Bind and click OK.
    4. On the View menu, click Tree.
    5. In BaseDN, click the drop-down list arrow, click the distinguished name of your Configuration partition and click OK.
    6. In the Options menu, click Controls.
    7. In the Controls dialog box, expand the Load Predefined menu, click Return deleted objects and click OK.
         > [!Note]
         > The 1.2.840.113556.1.4.417 control will show in the Active Controls list.
    8. On the Browse menu, click Search  
    9. In the Base DN box, type:
     `CN=Sites, CN=Configuration,DC=contoso,DC=com`
     (Replace contoso and com with the appropriate domain name.)
    10. In the Filter box, type
     (objectClass=ntdsdsa)  
    11. In the Scope box, select Subtree  
    12. In the Attributes box type, an *  (asterisk)
    13. Click Run  
    14. On the right side search for the GUID in objectGUID attribute to find the server it is referencing.

    Option D  

    1. Obtain `repadmin /showrepl` output from the destination DC reporting the 8589 status.  
    2. Using the `repadmin /showrepl` output obtained from the previous step, identify the 8589 replication status within the output and document the date and time-stamp following the Last Attempt message.  
    3. Using the date and timestamp from the previous step, locate the corresponding event ID 1411 in the Directory Services event log on the destination DC. Take note that the DSA object GUID listed in the `repadmin /showrepl` output is different from what is reported in the event ID 1411.(see example scenario below)
    4. Then find the domain controller listed in the event ID 1411, by either checking the NTDS Settings Properties General Tab or by pinging the GUID in the event ID.
    5. Bind to the Source DC using ADSIEDIT or Active Directory Users and Computers and open up the Attribute Editor and copy the value in serverReference. Paste in the value of this attribute on the destination DCs copy of the object. (Step 2)

2. Once you have located the server being referenced using one of the above methods, do the following:

    1. Click Start, and then click Run  
    2. Type ADSIEDIT.msc and press ENTER
    3. Right-click " ADSI Edit " and select " Connect to... "
    4. In " Connection Point " under " Select a well known Naming Context: " select " Configuration " and click OK.
    5. On left pane, expand " Configuration "
    6. Next expand " CN=Configuration,DC=contoso,DC=com "
    7. Next expand " CN=Sites "
    8. Under CN=Sites, expand the _site_ in which the server is located.
     Example: Default-First-Site-Name
    9. Under that site expand CN=Servers.
     Example: If DCSRV02 is in the Default-First-Site-Name site in Contoso.com, you should be in:
     CN=DCSRV02, CN=Servers, CN=Default-First-Site-Name, CN=Sites, CN=Configuration, DC=contoso, DC=com
    10. Right click on the domain controller (found using Option A, B, or C) and select Properties.
    11. In the " Attribute Editor " tab scroll down to serverReference attribute.
    12. The serverReference should be similar to
     CN=DCSRV02,OU=Domain Controllers,DC=Contoso,DC=com
     If it's missing or incorrect then change it to the correct value.
    13. Close ADSIEDIT.msc

## More information

Example Scenario  

1. Obtain repadmin /showrepl output from the destination DC reporting the 8589 status.  
2. Using the repadmin /showrepl output obtained from the previous step, identify the 8589 replication status within the output and document the date and time-stamp following the Last Attempt message.  

    `Repadmin /showrepl` output:

    > Liverpool\LIVCONTOSODCDSA Options: IS_GC  
    Site Options: (none)  
    DSA object GUID: *\<GUID>*
    >
    > DSA invocationID: *\<InvocationID>*
    >
    > ==== INBOUND NEIGHBORS ======================================
    >
    > DC=Contoso,DC=com
    >
    > Charlotte\CONTOSOROOTDC1 via RPC
    >
    > DSA object GUID: *\<GUID>*
    >
    > Last attempt @ *\<DateTime>* was successful.
    >
    > CN=Configuration,DC=Contoso,DC=com
    >
    > Houston\5THWARDCORPDC via RPC
    >
    > DSA object GUID: *\<GUID>*
    >
    > Last attempt @ *\<DateTime>* failed, result 8589 (0x218d):
    >
    > The DS cannot derive a service principal name (SPN) with which to mutually authenticate the target server because the corresponding server object in the local DS database has no serverReference attribute.
    >
    > 1700 consecutive failure(s).
    >
    > Last success @ (never).

Using the date and timestamp from the previous step, locate the corresponding event ID 1411 in the Directory Services event log on the destination DC. Take note that the DSA object GUID listed in the repadmin /showrepl output is different from what is reported in the event ID 1411.

Directory Services Event Log:

> Log Name: Directory Service  
Source: Microsoft-Windows-ActiveDirectory_DomainService  
Date: *\<DateTime>*  
Event ID: 1411  
Task Category: DS RPC Client  
Level: Error  
Keywords: Classic  
User: ANONYMOUS LOGON  
Computer: LIVCONTOSODC.Contoso.com  
Description:  
Active Directory Domain Services failed to construct a mutual authentication service principal name (SPN) for the following directory service.  
>
> Directory service:
*\<GUID>*._msdcs.Contoso.com  
>
> The call was denied. Communication with this directory service might be affected.
>
> Additional Data  
Error value:  
8589 The DS cannot derive a service principal name (SPN) with which to mutually authenticate the target server because the corresponding server object in the local DS database has no serverReference attribute.

:::image type="content" source="media/replication-error-8589/ntds-settings-properties.png" alt-text="Screenshot of the Active Directory Sites and Services window with the NTDS Settings Properties window opened.":::

Click Cancel and then view the properties for the server object (5thWardCorpDC in this example) select the Attribute Editor tab (Server 2008 and later) or use ADSIEDIT to edit the object on Server 2003

Notice that the serverReference attribute is not set in the following image

:::image type="content" source="media/replication-error-8589/serverreference-attribute-not-set.png" alt-text="Screenshot of the 5THWARDCORPDC Properties window with the serverReference attribute selected.":::

Bind to the Source DC using ADSIEDIT or Active Directory Users and Computers and open up the Attribute Editor and copy the value in serverReference. Paste in the value of this attribute on the destination DCs copy of the object.

:::image type="content" source="media/replication-error-8589/set-server-reference-attribute.png" alt-text="Screenshot of the Active Directory Sites and Services window with the 5THWARDCORPDC Properties window opened, and a String Attribute Editor window is opened for editing the value.":::

After the serverReference attribute is set correctly for the domain controller is shows as follows:

:::image type="content" source="media/replication-error-8589/check-serverreference-attribute.png" alt-text="Screenshot of the Active Directory Sites and Services window with the 5THWARDCORPDC Properties window opened, and the serverReference attribute is selected.":::
