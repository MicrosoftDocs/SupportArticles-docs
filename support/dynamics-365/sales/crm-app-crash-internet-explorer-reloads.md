---
title: CRM app may crash and Internet Explorer reloads
description: This article provides a workaround for the problem that occurs when you open or close Microsoft Dynamics CRM 2011 records.
ms.topic: troubleshooting
ms.reviewer: 
ms.date: 3/31/2021
---
# When you use Microsoft Dynamics CRM 2011, Internet Explorer 9 may reload and cause CRM to crash

This article helps you work around the problem that occurs when you open or close Microsoft Dynamics CRM 2011 records.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2698959

## Symptoms

When you open or close Microsoft Dynamics CRM 2011 records, the CRM application may crash and Internet Explorer reloads. A script error may also occur, similar to below:

- > \<Message>Object doesn't support this property or method</Message>
- > \<Message>'lookupstyle' is null or not an object</Message>

See the "More information" section for additional script detail.

## Cause

This is caused by the Internet Explorer 9 Hang Resistance Feature. The Hang Resistance feature is enabled by default in Windows Internet Explorer 9. Setting the HangRecovery value to 0 disables this feature; setting it to 1 enables it.

## Workaround

As a workaround, use the steps below to disable this feature:

1. Point to the **Start** menu, click **Run**, and then type *regedit*.
2. Navigate to `HKEY_Current_User\Software\Microsoft\Internet Explorer\Main`.
3. Right-click **Main,** and then select new **DWORD (32-bit) Value**.
4. Enter *HangRecovery* as the name.
5. The default value will be **0**.

## Did this fix the problem

Check whether the problem is fixed. If the problem is fixed, you are finished with this section. If the problem is not fixed, you can [contact support](https://support.microsoft.com/contactus).

## More information

[A web page may fail to get focus in Internet Explorer 9](/troubleshoot/browsers/webpage-fails-to-get-focus-ie-9)

- ```xml
  <CrmScriptErrorReport>
  <ReportVersion>1.0</ReportVersion>
  <ScriptErrorDetails>
  <Message>Object doesn't support this property or method</Message>
  <Line>53</Line>
  <URL>/_static/_forms/controls/form.crm.htc?ver=1272624968</URL>
  <PageURL>/userdefined/edit.aspx?_gridType=1&etc=1&id=%7b882F4C68-14EE-E011-BDA0-00155D9D3D22%7d&pagemode=iframe&rskey=759356843&sitemappath=Workplace%7cMyWork%7cnav_dashboards</PageURL>
  <Function>BuildXml(bValidate,bClose,bBuildFullXml,bValidateForWorkflow,bIsDirtyCheck)</Function>
  <CallStack>
  <Function>BuildXml(bValidate,bClose,bBuildFullXml,bValidateForWorkflow,bIsDirtyCheck)</Function>
  <Function>IsReadyToClose()</Function>
  <Function>Close(oEvent)</Function>
  </CallStack>
  ```

- ```xml
  <CrmScriptErrorReport>
  <ReportVersion>1.0</ReportVersion>
  <ScriptErrorDetails>
  <Message>'lookupstyle' is null or not an object</Message>
  <Line>73</Line>
  <URL>/_static/_forms/controls/img.lu.htc?ver=1272624968</URL>
  <PageURL>/userdefined/edit.aspx?_gridType=1&etc=1&id=%7b882F4C68-14EE-E011-BDA0-00155D9D3D22%7d&pagemode=iframe&rskey=759356843&sitemappath=Workplace%7cMyWork%7cnav_dashboards</PageURL>
  <Function>getDataXml(sAttributeName)</Function>
  <CallStack>
  <Function>getDataXml(sAttributeName)</Function>
  <Function>BuildXml(bValidate,bClose,bBuildFullXml,bValidateForWorkflow,bIsDirtyCheck)</Function>
  <Function>IsReadyToClose()</Function>
  <Function>Close(oEvent)</Function>
  </CallStack>
  ```
