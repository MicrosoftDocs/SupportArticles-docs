---
title: Error message when you try to modify or to delete an alternate access mapping in Windows SharePoint Services 3.0
description: Describes an issue that occurs after you perform a system recovery in which the configuration database is restored. Provides a resolution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto: 
  - Windows SharePoint Services 3.0
ms.date: 12/17/2023
---

# "An update conflict has occurred, and you must retry this action" when change or delete an alternate access mapping

## Symptoms  

You perform a system recovery in Microsoft Windows SharePoint Services 3.0 in which the configuration database is restored. Then, you try to modify or to delete an alternate access mapping.   

When you do this, you receive an error message that resembles the following error message:

```
An update conflict has occurred, and you must re-try this action. The object SPAlternateUrlCollection Name=WEBAPPLICATION Parent=SPFarm Name=SharePoint_Config is being updated by **DomainName**\**UserName1**, in the w3wp process, on machine **ServerName**. View the tracing log for more information about the conflict.
```

When you view the Unified Logging Service (ULS) log files, you see an entry that resembles the following entry:

```
**Date ****Time** w3wp.exe (0x1620) 0x1988Windows SharePoint Services Topology 8xqzMedium Updating SPPersistedObject SPAlternateUrlCollection Name=WEBAPPLICATION Parent=SPFarm Name=SharePoint_Config. Version: 16449 Ensure: 0, HashCode: 30474330, Id: 609b3309-241a-4193-8289-1bba6a70be50, Stack: at Microsoft.SharePoint.Administration.SPPersistedObject.Update() at Microsoft.SharePoint.Administration.SPAlternateUrlCollection.Update() at Microsoft.SharePoint.ApplicationPages.IncomingUrlPage.BtnSave_Click(Object sender, EventArgs e) at System.Web.UI.WebControls.Button.OnClick(EventArgs e) at System.Web.UI.WebControls.Button.RaisePostBackEvent(String eventArgument) at System.Web.UI.WebControls.Button.System.Web.UI.IPostBackEventHandler.RaisePostBackEvent(String eventArgument) at System.Web.UI.Page.RaisePostBackEvent(IPostBackEventHandler sourceControl, String eventArgument) at System.Web.UI.Page.RaisePostBackEvent(NameValueCollection postData) at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint) at System.Web.UI.Page.ProcessRequest(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint) at System.Web.UI.Page.ProcessRequest() at System.Web.UI.Page.ProcessRequestWithNoAssert(HttpContext context) at System.Web.UI.Page.ProcessRequest(HttpContext context) at ASP._admin_editincomingurl_aspx.ProcessRequest(HttpContext context) at System.Web.HttpApplication.CallHandlerExecutionStep.System.Web.HttpApplication.IExecutionStep.Execute() at System.Web.HttpApplication.ExecuteStep(IExecutionStep step, Boolean& completedSynchronously) at System.Web.HttpApplication.ResumeSteps(Exception error) at System.Web.HttpApplication.System.Web.IHttpAsyncHandler.BeginProcessRequest(HttpContext context, AsyncCallback cb, Object extraData) at System.Web.HttpRuntime.ProcessRequestInternal(HttpWorkerRequest wr) at System.Web.HttpRuntime.ProcessRequestNoDemand(HttpWorkerRequest wr) at System.Web.Hosting.ISAPIRuntime.ProcessRequest(IntPtr ecb, Int32 iWRType) 06/06/2007 14:36:31.51 w3wp.exe (0x1620) 0x1988Windows SharePoint Services Topology 75bdHigh UpdatedConcurrencyException: The object SPAlternateUrlCollection Name=WEBAPPLICATION Parent=SPFarm Name=SharePoint_Config was updated by another user. Determine if these changes will conflict, resolve any differences, and reapply the second change. This error may also indicate a programming error caused by obtaining two copies of the same object in a single thread. Previous update information: User: **DomainName**\**UserName1** Process:w3wp Machine:**ServerName** Time:**Date ****Time** Current update information: User: **DomainName**\**UserName2** Process:w3wp Machine:**ServerName****Date ****Time** w3wp.exe (0x1620) 0x1988Windows SharePoint Services Topology 8xqyHigh ConcurrencyException: Old Version : 16449 New Version : 0  
```

## Cause  

This issue occurs if the contents of the file system cache on the front-end servers are newer than the contents of the configuration database. After you perform a system recovery, you may have to manually clear the file system cache on the local server.  

## Resolution  

To resolve this issue, clear the file system cache on all servers in the server farm on which the Windows SharePoint Services Timer service is running. To do this, follow these steps:   

1. Stop the Timer service. To do this, follow these steps:

  1. Click **Start**, point to **Administrative Tools**, and then click **Services**.

  2. Right-click **Windows SharePoint Services Timer**, and then click **Stop**.    

  3. Close the Services console.     

2. On the computer that is running Microsoft Office SharePoint Server 2007 and on which the Central Administration site is hosted, click **Start**, click **Run**, type explorer, and then press ENTER.   

3. In Windows Explorer, locate and then double-click the following folder: **Drive**: \Documents and Settings\All Users\Application Data\Microsoft\SharePoint\Config\**GUID**

    **Notes**

      - The **Drive** placeholder specifies the letter of the drive on which Windows is installed. By default, Windows is installed on drive C.    

      - The **GUID** placeholder specifies the GUID folder.  

      - The Application Data folder may be hidden. To view the hidden folder, follow these steps:

         1. On the **Tools** menu, click **Folder Options**.   

         2. Click the **View** tab.   

         3. In the **Advanced settings** list, click **Show hidden files and folders** under **Hidden files and folders**, and then click **OK**.   

      - In Windows Server 2008, the configuration cache is in the following location: **Drive**: \ProgramData\Microsoft\SharePoint\Config\*GUID*     

4. Back up the Cache.ini file.    

5. Delete all the XML configuration files in the GUID folder. Do this so that you can verify that the GUID folder is replaced by new XML configuration files when the cache is rebuilt.   

    **Note**  When you empty the configuration cache in the GUID folder, make sure that you do not delete the GUID folder and the Cache.ini file that is located in the GUID folder.  

6. Double-click the Cache.ini file.    

7. On the **Edit** menu, click **Select All**.    

8. On the **Edit** menu, click **Delete**.    

9. Type 1, and then click **Save** on the **File** menu.   

10. On the **File** menu, click **Exit**.   

11. Start the Timer service. To do this, follow these steps:

   1. Click **Start**, point to **Administrative Tools**, and then click **Services**.    

   2. Right-click **Windows SharePoint Services Timer**, and then click **Start**.    

   3. Close the Services console.      

      **Note** The file system cache is re-created after you perform this procedure. Make sure that you perform this procedure on all servers in the server farm.    

12. Make sure that the Cache.ini file has been updated. For example it should no longer be 1 if the cache has been updated.   

13. Click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **SharePoint 3.0 Central Administration**.   

14. Click the **Operations** tab, and then click **Timer job status** under **Global Configuration**.

15. In the list of timer jobs, verify that the status of the **Config Refresh** entry is **Succeeded**.

16. On the **File** menu, click **Close**.     

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
