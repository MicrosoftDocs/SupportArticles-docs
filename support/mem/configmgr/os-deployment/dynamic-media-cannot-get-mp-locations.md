---
title: Dynamic Media can't get management point locations
description: Fixes an issue in which Dynamic Media in Configuration Manager cannot get management point locations when the Task Sequence Wizard runs in Windows PE.
ms.date: 12/05/2023
ms.reviewer: kaushika, frankroj
---
# Dynamic Media can't get management point locations when Task Sequence Wizard runs in Windows PE

This article fixes an issue in which Dynamic Media in Configuration Manager cannot get management point locations when the Task Sequence Wizard runs in Microsoft Windows Preinstallation Environment (Windows PE).

_Original product version:_ &nbsp; Configuration Manager (current branch), Microsoft System Center 2012 R2 Configuration Manager  
_Original KB number:_ &nbsp; 4471115

## Symptoms

You use Dynamic Media in Configuration Manager. When the Task Sequence Wizard first starts in Windows PE, the initial communication to the management point to sync the time settings is successful, as shown in the following SMSTS.log entry:

> TSMBootstrap Getting MP time information  
> TSMBootstrap Set authenticator in transport  
> TSMBootstrap Requesting client identity  
> TSMBootstrap Setting message signatures.  
> TSMBootstrap Setting the authenticator.  
> TSMBootstrap CLibSMSMessageWinHttpTransport::Send: URL:MP_ServerCCM_POST /ccm_system/request  
> TSMBootstrap Request was successful.

However, the later request to the management point to get location information fails, as shown in the following SMSTS.log entry:

> TSMBootstrap IP: *192.168.0.100* *192.168.0.0*  
> TSMBootstrap CLibSMSMessageWinHttpTransport::Send: URL: *MP_Server* GET /SMS_MP/.sms_aut?MPLOCATION&ir=192.168.0.100&ip=192.168.0.0  
> TSMBootstrap Error. Status code 500 returned  
> TSMBootstrap XML parsing error at line 1 char 11: DTD is prohibited.  
> \<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">  
> TSMBootstrap bSuccess == ((VARIANT_BOOL)-1), HRESULT=80004005 (e:\CM1706_RTM\sms\common\inc\ccmxml.h,1151)  
> TSMBootstrap oXMLDoc.loadFromXML( sReply.c_str()), HRESULT=80004005 (e:\cm1706_rtm\sms\framework\osdmessaging\libsmsmessaging.cpp,5767)  
> TSMBootstrap Error loading from XML  
> TSMBootstrap CCM::SMSMessaging::CLibSMSMPLocation::RequestMPLocation failed; 0x80004005  
> TSMBootstrap MPLocation.RequestMPLocation (szTrustedRootKey, sIPSubnets.c_str(), sIPAddresses.c_str(), httpS, http), HRESULT=80004005 (e:\cm1706_rtm\sms\framework\osdmessaging\libsmsmessaging.cpp,10164)  
> TSMBootstrap CCM::SMSMessaging::GetMPLocations failed; 0x80004005  
> TSMBootstrap Failed to query *MP_Server* for MP location

> [!NOTE]
> The IP addresses in the first line of this log entry are the IP addresses of the client computer and its subnet.

If multiple management points are defined in the Dynamic Media, the same failure occurs regardless of which management point Configuration Manager tries to communicate with. If you try to use the same URL in a browser, as in the following example, this also causes a **500** error:

***http://MP_Server/SMS_MP/.sms_aut?MPLOCATION&ir=192.168.15.100&ip=192.168.0.0***

The Internet Information Services (IIS) logs on the management point do not reveal a matching **500** error entry. Instead, a **200** success entry is displayed. If you enable **Failed Request Tracing** in IIS for the **500** error message, you find the following error message:

> CALL_ISAPI_EXTENSION DllName="*MP_Install_Directory*\getauth.dll"  
> MODULE_SET_RESPONSE_ERROR_STATUS  
> Warning ModuleName="IsapiModule", Notification="EXECUTE_REQUEST_HANDLER", HttpStatus="500", HttpReason="Internal Server Error", HttpSubStatus="0", ErrorCode="The operation completed successfully.  
> (0x0)", ConfigExceptionInfo=""

For more information about how to enable failed request tracing in IIS for **500** error messages, see the [Troubleshooting Failed Requests Using Tracing in IIS 8.5](/iis/troubleshoot/using-failed-request-tracing/troubleshooting-failed-requests-using-tracing-in-iis-85).

The MP_GetAuth.log file on the management point shows the following error entry that was logged when the client made the request that's recorded in the SMSTS.log:

> MP_GetAuth_ISAPI MP GA Number of MPs in the Site = \<Number_Of_MPs_At_Site>  
> MP_GetAuth_ISAPI MP GA: Actual Auth Reply Body :  
> \<MPList>\<XML_List_Of_MPs_At_Site>\</MPList>  
> MP_GetAuth_ISAPI MP GA: GetAuthSendResponseHeaders: Sending response 200 OK  
> MP_GetAuth_ISAPI MP GA: GetAuthDoneWithSession: ServerSupportFunction() returned 0x0  
> MP_GetAuth_ISAPI MP GA: HttpExtensionProc:GetAuthProcessRequest() returned 1  
> MP_GetAuth_ISAPI MP GA: Query String Before Decode : MPLOCATION&ir= 192.168.0.100&ip=192.168.0.0  
> MP_GetAuth_ISAPI MP GA: Query String After Decode : MPLOCATION&ir= 192.168.0.100&ip=192.168.0.0  
> MP_GetAuth_ISAPI MP GA: Auth Request Type is MPLOCATION&ir= 192.168.0.100&ip=192.168.0.0  
> MP_GetAuth_ISAPI No more rows.  
> MP_GetAuth_ISAPI No more rows.  
> MP_GetAuth_ISAPI Formatted string exceeded max buffer size. Result is truncated.  
> MP_GetAuth_ISAPI m_docReply.LoadFromString (String (bstrMPLocationXML), false), HRESULT=8000ffff (e:\nts_sccm_release\sms\mp\isapi\getauth\getauth.cpp,994)  
> MP_GetAuth_ISAPI hr, HRESULT=8000ffff (e:\nts_sccm_release\sms\mp\isapi\getauth\getauth.cpp,2124)  
> MP_GetAuth_ISAPI AuthRequest.ProcessGETRequest(), HRESULT=8000ffff (e:\nts_sccm_release\sms\mp\isapi\getauth\getauth.cpp,98)  
> MP_GetAuth_ISAPI MP GA: GetAuthSendResponseHeaders: Sending response 500 Internal Server Error  
> MP_GetAuth_ISAPI MP GA: GetAuthDoneWithSession: ServerSupportFunction() returned 0x0  
> MP_GetAuth_ISAPI MP GA: HttpExtensionProc:GetAuthProcessRequest() returned 4  

The issue doesn't occur for site-based media or the Preboot Execution Environment (PXE) through Configuration Manager. However, the issue can occur if you use third-party PXE solutions that can use Dynamic Media.

## Cause

This issue occurs because there are multiple Unknown Computer objects for a specific website, and that site has several management points. This causes many results to be returned when `MPLOCATION` is called and the `GetMPLocationForIPSubnet` stored procedure runs.

To run `GetMPLocationForIPSubnet` manually on the server that's running SQL Server through SQL Management Studio, run the following query:

```sql
exec GetMPLocationForIPSubnet N'192.168.0.0'
```

In this scenario. this command returns several hundred rows. This large number of rows exceeds the maximum buffer size. This, in turn, causes the **500** error message and also causes `MPLOCATION` to fail.

## Resolution

All sites should have only one Unknown Computer object per architecture. For example, there should be only one x64 object that's labeled **x64 Unknown Computer** and only one x86 object that's labeled **x86 Unknown Computer**. If a site has more than one Unknown Computer object per architecture, the extra Unknown Computer objects should be deleted. Deleting extra Unknown Computer objects can be done only from the SQL Server database. It cannot be done from the Configuration Manager console.

> [!NOTE]
> Creating extra Unknown Computer objects to prevent the client computers from stealing the GUID of the Unknown Computer objects is not the correct method to fix this issue. For the correct method, see [A client computer can steal the Configuration Manager GUID of an Unknown Computer object during imaging](unknown-computer-object-guid-stolen.md).

To delete the extra Unknown Computer objects, follow these steps:

1. Make sure you have a current and valid backup of the Configuration Manager site by using the built-in **Backup maintenance** task.

2. Open the Configuration Manager console. If there are multiple primary sites, we recommend that you open a Configuration Manager console that's connected to the central administration site.

3. In the Configuration Manager console, go to **Assets and Compliance** > **Overview** > **Device Collections**.

4. Double-click the **All Unknown Computers** collection.

5. In the results pane, sort the objects in the **All Unknown Computers** collection by selecting the **Site Code** column.

6. Note whether there are multiple **x64 Unknown Computer** objects or **x86 Unknown Computer** objects for any individual site.

7. If there are multiple **x64 Unknown Computer** objects or **x86 Unknown Computer** objects for any individual site, right-click the columns in the results pane, and add **Resource ID** to the list of columns.

8. Determine the lowest **Resource ID**  value for each **x64 Unknown Computer** object or each **x86 Unknown Computer** object for any one site. In most cases, for the first Primary site in an environment, the resource IDs for the original Unknown Computer objects for the sites will be **2046820352** (**x86 Unknown Computer**) and **2046820353** (**x64 Unknown Computer**).

9. After you determine the lowest **Resource ID**, all other **x64 Unknown Computer** objects or **x86 Unknown Computer** objects for any site can be deleted. Note all the Resource IDs that can be deleted and which site they belong to.

10. Open **SQL Server Management Studio**, and then connect to the database for the site that hosts the extra Unknown Computer objects.

11. Expand the **Databases** node, and select the Configuration Manager database (usually **CM_Site_Code**).

12. On the toolbar, select **New Query**.

13. Make sure that the correct database is selected in the drop-down menu to the left of the **Execute** button on the toolbar.

14. In the query pane, run the following SQL query:

    ```sql
    SELECT C.CollectionID, C.SiteID, C.CollectionName, CM.MachineID, CM.Name FROM Collections C
    JOIN CollectionMembers CM ON C.SiteID = CM.SiteID
    JOIN UnknownSystem_DISC USD ON USD.ItemKey = CM.MachineID
    ```

    This query displays all the Collections that all the Unknown Computer objects belong to. Use this query to determine which collections the Unknown Computer objects that are being kept have to be added to. This should be based on the memberships of the Unknown Computer objects that are being deleted. The **Resource ID** is listed in the **MachineID** column.

15. In the query pane, run the following SQL query:

    ```sql
    SELECT * FROM UnknownSystem_DISC WHERE ItemKey IN ('Extra_Resource_ID_1','Extra_Resource_ID_2', 'Extra_Resource_ID_3')
    ```

    In this query, *Extra_Resource_ID_x* is the Resource ID of each of the extra Unknown Computer objects, as determined in step 9. For example, if the extra Resource IDs are **2046820354** and **2046820355**, the query would be as follows:

    ```sql
    SELECT * FROM UnknownSystem_DISC WHERE ItemKey IN ('2046820354','2046820355 ')
    ```

16. Verify that the records that are returned by the query in step 15 are correct. If they are, then run the following query to delete the records:

    ```sql
    DELETE FROM UnknownSystem_DISC WHERE ItemKey IN ('Extra_Resource_ID_1','Extra_Resource_ID_2', 'Extra_Resource_ID_3')
    ```

    In this query, *Extra_Resource_ID_x* is the Resource ID of each of the extra Unknown Computer objects, as determined in step 9. For example, if the extra Resource IDs are **2046820354** and **2046820355**, the delete query would be as follows:

    ```sql
    DELETE FROM UnknownSystem_DISC WHERE ItemKey IN ('2046820354', '2046820355')
    ```

17. Wait a few minutes, return to the Configuration Manager console, and then go to **Assets and Compliance** > **Overview** > **Device Collections**.

18. Right-click the **All Unknown Computers** collection, and then select **Update Membership**.
19. Wait a few minutes, and then select **Refresh**. Verify that only one **x 64 Unknown Computer** object or **x86 Unknown Computer** object exists for each site.

20. Repeat steps 10-19 for all additional primary sites, as necessary.

## Recreate Unknown Computer objects in case of accidental deletion

For whatever reason, if all Unknown Computer objects are accidentally deleted for any one site that uses this process, they can be re-created by using the following steps. These steps should be taken only if there are no Unknown Computer objects for a site. If only one of the two Unknown Computer objects exist at a site, delete the one remaining Unknown Computer object by using the steps in [Resolution](#resolution), and then follow the steps in [Recreate Unknown Computer objects in case of accidental deletion](unknown-computer-object-guid-stolen.md#recreate-unknown-computer-objects-in-case-of-accidental-deletion).

The Unknown Computer objects should be automatically re-created soon. You can check the progress of this process in the DDM.log on the primary site server.
