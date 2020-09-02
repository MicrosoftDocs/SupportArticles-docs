---
title: Site Component Manager logs error status messages
description: Describes how to grant permissions to Systems Management Server 2003 or Configuration Manager 2007 to create or change the System Management container in Active Directory.
ms.date: 08/20/2020
ms.prod-support-area-path:
ms.reviewer: clintk, v-jomcc
---
# Site Component Manager may log error status messages after installing SMS 2003 or Configuration Manager 2007

This article helps you fix an issue in which Site Component Manager may log status messages 4909, 4912, 4913, and 4915 after you install Systems Management Server 2003 or System Center Configuration Manager 2007.

_Original product version:_ &nbsp; Microsoft System Center Configuration Manager 2007, System Center Configuration Manager 2007 R2, Microsoft System Center Configuration Manager 2007 R3  
_Original KB number:_ &nbsp; 830022

## Symptoms

After you install Microsoft Systems Management Server (SMS) 2003 or Microsoft System Center Configuration Manager 2007, the Site Component Manager component may log the following status messages:

> MessageID=4909  
> Severity=Error  
> Facility=Application  
> SymbolicName=SRVMSG_SITECOMP_CANNOT_FIND_SMS_AD_CONTAINER  
> Language=English  
> SMS Systems Management Server could not locate the "System Management" container in Active Directory. Nor could it create a default container. This will prevent Site Component Manager from updating or adding any objects to Active Directory. Possible cause: This site's SMS Service account or the site server's machine account might not have the correct rights to update active directory.
>
> Solution: Either give the Service Account rights to update the domain's System Container, or manually create the "System Management" container in this domain's Active Directory system container, and give the Service Account full rights to that container (and all children objects).

> MessageID=4912
>
> Systems Management Server cannot update the already existing object "System Management" in Active Directory.

> MessageID=4913
>
> Systems Management Server cannot create the object "System Management" in Active Directory.

> MessageID=4915
>
> Systems Management Server cannot delete the object "System Management" in Active Directory.

Additionally, the following entries may appear in the Hman.log file:

> System Management container exists.  
> Searching for SMS-Site-123 Site Object.  
> SMS-Site-123 doesn't exist, creating it.  
> SMS-Site-123 could not be created, error code = 8202

If you use the ExtADsch.exe tool, the following entries may appear in the ExtADsch.log file:

> Failed to create class cn=MS-SMS-Management-Point. Error code = 8202.  
> Failed to create class cn=MS-SMS-Server-Locator-Point. Error code = 8202.  
> Failed to create class cn=MS-SMS-Site. Error code = 8202.  
> Failed to create class cn=MS-SMS-Roaming-Boundary-Range. Error code = 8202.  
> Failed to extend the Active Directory schema.

## Cause

This problem may occur when Site Component Manager cannot locate or doesn't have the correct permission to manage the System Management container in Active Directory.

## Resolution

SMS 2003 and Configuration Manager 2007 must have permissions to create or to change the System Management container in Active Directory. To resolve this problem, use one of the following methods:

- If the SMS or Configuration Manager site uses Advanced Security, grant the site server account **Full Control** permissions to the Active Directory System container and to all its child objects.
- If the SMS or Configuration Manager site uses Standard Security, grant the site server SMS or Configuration Manager service account **Full Control** permissions to the Active Directory System container and to all its child objects.

To grant the appropriate permissions to the System container, follow these steps:

1. Click **Start**, point to **Administrative Tools**, and then select **Active Directory Users and Computers**.
2. On the **View** menu, select **Advanced Features**.
3. Expand your domain tree, right-click the **System** container, and then select **Properties**.
4. On the **Security** tab, select **Add**.

5. Select **Object Types**. If SMS 2003 or Configuration Manager 2007 is configured to use Advanced Security, make sure that the **Computers** check box is selected. If SMS 2003 or Configuration Manager 2007 is configured to use Standard Security, make sure that the **Groups** and **Users** check boxes are selected. Click **OK**.

6. If Advanced Security is turned on, type the name of the site server's machine account, select **Check Names**, and then click **OK**. If Standard Security is turned on, type the name of the SMS or Configuration Manager service account, select **Check Names**, and then click **OK**.

7. In **Group or user names**, select the account that you added in step 6.

8. In **Permissions for Enterprise Admins**, select the **Full Control** check box, and then click **OK**.

Restart the Site Component Manager service to start updating Active Directory. You can monitor the Sitecomp.log file to see the status of the update.

You can use the ADSIEdit.exe utility to manually create the System Management container in the Active Directory System container. However, SMS or Configuration Manager must have permissions to manage the objects in the container.

If you manually create the container, you must make sure that the site server machine account (if you use Advanced Security) or the SMS or Configuration Manager service account (if you use Standard Security) has Full Control permissions to the System Management container and to all its child objects.

If you manually create the System Management container, follow these steps to grant the appropriate permissions:

1. Click **Start**, point to **Administrative Tools**, and then select **Active Directory Users and Computers**.
2. On the **View** menu, select **Advanced Features**.
3. Expand your domain tree, expand **System**, right-click the System Management container, and then select **Delegate Control**.
4. Select **Next**, and then select **Add**.

5. Select **Object Types**. If SMS 2003 or Configuration Manager 2007 is configured to use Advanced Security, make sure that the **Computers** check box is selected. If SMS 2003 or Configuration Manager 2007 is configured to use Standard Security, make sure that the **Groups** and **Users** check boxes are selected. Click **OK**.

6. If Advanced Security is turned on, type the name of the site server's machine account, select **Check Names**, and then click **OK**. If Standard Security is turned on, type the name of the SMS or Configuration Manager service account, select **Check Names**, and then click **OK**.

7. Select **Next**, select **Create a custom task to delegate**, and then select **Next**.

8. Select **This folder, existing objects in this folder, and creation of new objects in this folder**, and then select **Next**.
9. Select the **Full Control** check box, and then select **Next**.
10. Make sure that the information is correct, and then click **Finish**.

## More information

Before SMS or Configuration Manager can publish to Active Directory, the Active Directory schema must be extended. You can extend the Active Directory schema when you install SMS 2003 or Configuration Manager 2007, or you can manually extend the schema by using the ExtADsch.exe utility. The ExtADsch.exe utility is located in the SMSSETUP\BIN\i386 folder on the SMS 2003 CD. For more information about how to extend the Active Directory schema for SMS 2003, see part 3, chapter 10 and part 4, chapter 15 of the [SMS 2003 online Concepts, Planning and Deployment Guide](/previous-versions/system-center/configuration-manager-2003/cc179958(v=technet.10)). The status message details for SMS Site Component Manager may offer additional solutions.

For more information about the Active Directory schema, see the following articles:

- [Active Directory services and Windows 2000 or Windows Server 2003 domains (part 1)](https://support.microsoft.com/help/310996)
- [Active Directory services and Windows 2000 or Windows Server 2003 domains (part 2)](https://support.microsoft.com/help/310997)
