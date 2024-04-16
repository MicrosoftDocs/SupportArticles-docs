---
title: View and transfer FSMO roles
description: Describes how to view and transfer FSMO roles.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Active Directory\Active Directory (FSMO), csstroubleshoot
---
# How to view and transfer FSMO roles  

This article describes how to view and transfer FSMO roles.

_Applies to:_ &nbsp; Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012  
_Original KB number:_ &nbsp; 324801

## Summary

This article describes how to transfer Flexible Single Master Operations (FSMO) roles (also known as *operations master* roles) by using the Active Directory snap-in tools in Microsoft Management Console (MMC).

### FSMO Roles

In a forest, there are at least five FSMO roles that are assigned to one or more domain controllers. The five FSMO roles are:

- Schema Master: The schema master domain controller controls all updates and modifications to the schema. To update the schema of a forest, you must have access to the schema master. There can be only one schema master in the whole forest.
- Domain naming master: The domain naming master domain controller controls the addition or removal of domains in the forest. There can be only one domain naming master in the whole forest.
- Infrastructure Master: The infrastructure is responsible for updating references from objects in its domain to objects in other domains. At any one time, there can be only one domain controller acting as the infrastructure master in each domain.
    > [!NOTE]
    > The Infrastructure Master (IM) role isn't often needed anymore, as it has no work to do if the environment uses the recommended configuration. Refer to the articles linked below for details. To summarize, the scenarios are:
    >
    > - All domain controllers in the domain are Global Catalogs.
    > - The forest is configured to use the Recycle Bin.
    > 
    > The IM role should still always be set to a valid domain controller to avoid errors being reported in monitoring systems.
- Relative ID (RID) Master: The RID master is responsible for processing RID pool requests from all domain controllers in a particular domain. At any one time, there can be only one domain controller acting as the RID master in the domain.
- PDC Emulator: The PDC emulator is a domain controller that advertises itself as the primary domain controller (PDC) to workstations, member servers, and domain controllers that are running earlier versions of Windows. For example, if the domain contains computers that are not running Microsoft Windows XP Professional or Microsoft Windows 2000 client software, or if it contains Microsoft Windows NT backup domain controllers, the PDC emulator master acts as a Windows NT PDC. It is also the Domain Master Browser, and it handles password discrepancies. At any one time, there can be only one domain controller acting as the PDC emulator master in each domain in the forest.  

You can transfer FSMO roles by using the Ntdsutil.exe command-line utility or by using an MMC snap-in tool. Depending on the FSMO role that you want to transfer, you can use one of the following three MMC snap-in tools:  
Active Directory Schema snap-in  
Active Directory Domains and Trusts snap-in  
Active Directory Users and Computers snap-in  
If a computer no longer exists, the role must be seized. To seize a role, use the Ntdsutil.exe utility.

For additional information about how to use the Ntdsutil.exe utility to seize FSMO roles, click the article number below to view the article in the Microsoft Knowledge Base:

[255504](https://support.microsoft.com/help/255504) Using Ntdsutil.exe to Seize or Transfer the FSMO Roles to a Domain

Use the Active Directory Schema Master snap-in to transfer the schema master role. Before you can use this snap-in, you must register the Schmmgmt.dll file.

### Register Schmmgmt.dll

1. Click Start, and then click Run.
2. Type regsvr32 schmmgmt.dll in the Open box, and then click OK.
3. Click OK when you receive the message that the operation succeeded.

### Transfer the Schema Master Role

1. Click Start, click Run, type mmc in the Open box, and then click OK.
2. On the File, menu, click **Add/Remove Snap-in**.
3. Click Add.
4. Click Active Directory Schema, click Add, click Close, and then click OK.
5. In the console tree, right-click Active Directory Schema, and then click Change Domain Controller.
6. Click Specify Name, type the name of the domain controller that will be the new role holder, and then click OK.
7. In the console tree, right-click Active Directory Schema, and then click Operations Master.
8. Click Change.
9. Click OK to confirm that you want to transfer the role, and then click Close.

### Transfer the Domain Naming Master Role

1. Click Start, point to Administrative Tools, and then click **Active Directory Domains and Trusts**.
2. Right-click **Active Directory Domains and Trusts**, and then click **Connect to Domain Controller**.

    >[!NOTE]
    >You must perform this step if you are not on the domain controller to which you want to transfer the role. You do not have to perform this step if you are already connected to the domain controller whose role you want to transfer.  

3. Do one of the following actions:

    - In the **Enter the name of another domain controller** box, type the name of the domain controller that will be the new role holder, and then click OK.  
    -or-
    - In the **Or, select an available domain controller** list, click the domain controller that will be the new role holder, and then click OK.
4. In the console tree, right-click **Active Directory Domains and Trusts**, and then click Operations Master.
5. Click Change.
6. Click OK to confirm that you want to transfer the role, and then click Close.

### Transfer the RID Master, PDC Emulator, and Infrastructure Master Roles

1. Click Start, point to Administrative Tools, and then click **Active Directory Users and Computers**.
2. Right-click **Active Directory Users and Computers**, and then click **Connect to Domain Controller**.

    >[!NOTE]
    >You must perform this step if you are not on the domain controller to which you want to transfer the role. You do not have to perform this step if you are already connected to the domain controller whose role you want to transfer.
3. Do one of the following actions:

    - In the **Enter the name of another domain controller** box, type the name of the domain controller that will be the new role holder, and then click OK.  
    -or-
    - In the **Or, select an available domain controller** list, click the domain controller that will be the new role holder, and then click OK.
4. In the console tree, right-click **Active Directory Users and Computers**, point to All Tasks, and then click Operations Master.
5. Click the appropriate tab for the role that you want to transfer (RID, PDC, or Infrastructure), and then click Change.
6. Click OK to confirm that you want to transfer the role, and then click Close.

## References

For more information, see:

- [Active Directory FSMO roles in Windows](fsmo-roles.md)
- [FSMO placement and optimization on Active Directory domain controllers](https://support.microsoft.com/help/223346)
- [Flexible Single Master Operation Transfer and Seizure Process](https://support.microsoft.com/help/223787)
- [HOW TO: Use Ntdsutil to find and clean up duplicate security identifiers](https://support.microsoft.com/help/816099)
- [Troubleshoot DNS Event ID 4013 (The DNS server was unable to load AD integrated DNS zones)](https://support.microsoft.com/help/2001093)
- [DCPROMO demotion fails if unable to contact the DNS infrastructure master](https://support.microsoft.com/help/2694933)
- [FSMO Roles](/openspecs/windows_protocols/ms-adts/2aae4593-66fa-4d89-a921-1625b19af5b7)
- [Perform initial recovery](/windows-server/identity/ad-ds/manage/ad-forest-recovery-perform-initial-recovery)
- [AD Forest Recovery - Seizing an operations master role](/windows-server/identity/ad-ds/manage/ad-forest-recovery-seizing-operations-master-role)
- [Clean up server metadata using the command line](/windows-server/identity/ad-ds/deploy/ad-ds-metadata-cleanup#clean-up-server-metadata-using-the-command-line)
- [Planning Operations Master Role Placement](/windows-server/identity/ad-ds/plan/planning-operations-master-role-placement)
- [Move-ADDirectoryServerOperationMasterRole](/powershell/module/activedirectory/move-addirectoryserveroperationmasterrole)
