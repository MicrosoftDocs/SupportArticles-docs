---
title: Site slowness because of SharePoint STS certificate CRL checking
description: Provides workarounds for an issue in which SharePoint STS certificate CRL checking causes a site to be slow.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administration\Farm Administration
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Foundation 2010
  - SharePoint Server 2010
ms.date: 12/17/2023
---

# Site slowness because of SharePoint STS certificate CRL checking  

## Symptoms  

Assume that you have a web application that uses claims-based authentication in SharePoint Foundation 2010 or SharePoint Server 2010. The SharePoint server does not have access to the Internet, or the server is protected by a firewall that has limited ports open. In this situation, users intermittently experience long delays when they perform certain operations, such as logging in to the site or performing a search. Users may also encounter HTTP timeouts when they perform these operations.   

## Cause  

SharePoint uses certificates to sign security tokens that are issued by the Security Token Service (STS). Like all certificates, the validity of the STS certificate has to be verified periodically to make sure that the certificate has not been revoked. By default, the root certificate in the chain is not added to the Trusted Root Certificate Authorities store of the SharePoint servers. Because of this, the certificate revocation list (CRL) check for the certificate is performed over the Internet. If the online CRL server cannot be reached from the SharePoint server for some reason, the operation times out after 15 seconds by default. Even if the CRL validation fails after 15 seconds, the SharePoint page may still be rendered after the delay.  

Certificate validation failures can be tracked by enabling the CAPI2 event logging on the SharePoint server. When CAPI2 event logging is enabled and Internet certificate validation is failing, you will frequently see the following error messages in the CAPI2 event log:  

- Build Chain Error   

  Event ID: 11  
  Task Category: Build Chain  
  subjectName (taken from event details): SharePoint Security Token Service  
- Retrieve Object from Network Error   

  Event ID: 53  
  Task Category: Retrieve Object from Network  

  URL (taken from event details): `https://www.download.windowsupdate.com/msdownload/update/v3/static/trustedr/en/authrootstl.cab`

Please refer to the "More Information" section for information about how to enable CAPI2 logging.  

## Resolution  

To resolve this issue, perform one of the following workarounds:   

### Workaround 1  

Install the SharePoint Root Authority  certificate in the Trusted Root Certification Authorities  store. After the root certificate is added to the local certificate store, the certificate validation is no longer performed over the Internet. The below steps will cause the BuildChain  to succeed by finding the certificate in the local store, therefore eliminating the need for the retrieval of an object from the network. The following steps have to be completed on each SharePoint server in the farm to add the root certificate to the local certificate store:   

1. Export the SharePoint Root Authority  certificate as a physical (.cer) file. Start the SharePoint 2010 Management Shell as an Administrator, and then run the following Windows PowerShell commands:

   ```
   $rootCert = (Get-SPCertificateAuthority).RootCertificate   
   $rootCert.Export("Cert") | Set-Content C:\SharePointRootAuthority.cer -Encoding byte
   ```

   **Note**  This will export the internal root certificate (.cer file) for SharePoint to Drive C. You can copy and use this file on all servers in the farm for importing without having to run the PowerShell commands again.  

2. Import the SharePoint Root Authority certificate to the Trusted Root Certification Authorities  store. To add the SharePoint Root Authority  certificate to the Trusted Root Certification Authorities  store, follow these steps:   

   **Note** "Administrators" is the minimum required group membership to complete these steps.  

   1. Tap or click **Start**, type mmc  in **Start search**, and then press Enter.  
   2. On the **File** menu, click **Add/Remove Snap-in**.  
   3. Under **Available snap-ins**, click **Certificates**, and then click **Add**.  
   4. Under **This snap-in will always manage certificates for**, select **Computer account**, and then click **Next**.   
   5. Select Local computer, and then click **Finish**.  
   6. If you have no more snap-ins to add to the console, click **OK**.  
   7. In the console tree, double-click **Certificates**.  
   8. Right-click the Trusted Root Certification Authorities store.   
   9. Click **All Tasks**, click **Import** to import the certificate, and then follow the steps in the Certificate Import Wizard.  

### Workaround 2  

Disable the automatic update of root certificates on the SharePoint Servers. To do this, follow these steps:  

1. Under the Computer Configuration node in the Local Group Policy Editor, double-click **Policies**.   
2. Double-click **Windows Settings**, double-click **Security Settings**, and then double-click **Public Key Policies**.   
3. In the Details pane, double-click **Certificate Path Validation Settings**.   
4. Click the **Network Retrieval** tab, select the **Define these policy settings** check box, and then clear the **Automatically update certificates in the Microsoft Root Certificate Program (recommended)** check box.   
5. Click **OK**, and then close the Local Group Policy Editor.   
6. Run gpupdate/force to make the policy take effect immediately.     

**Note** With auto-update disabled, you may have to monitor for new releases, and then manually update the certificate trust as required.   

Implications of disabling automatic root certificate updates  

There should not be specific implications to SharePoint because we are using self-signed certificates and manage them ourselves. The SharePoint certificates do have an expiry, but there is a health rule that watches for this and then warns the administrator to update or re-roll them.   

The main aspect to consider is for other certificates that are used on the computer (such as SSL certificates, certificates to trust download packages or for SAFER policy, and so on) which are issued from certificates chained to those in the Trusted Root Certification Authorities  store.  

## More Information  

### Enable and save the CAPI2 log from the Event Viewer UI   

1. Open Event Viewer. To open Event Viewer, click **Start**, click **Control Panel**, double-click **Administrative Tools**, and then double-click **Event Viewer**.   
2. If the **User Account Control** dialog box appears, confirm that the displayed action is what you want to perform, and then click **Continue**.   
3. In the Console pane, expand **Event Viewer**, expand **Applications and Services Logs**, expand **Microsoft**, expand **Windows**, and then expand **CAPI2**.   
4. You can now perform the following actions:
   - To enable CAPI2 logging, right-click **Operational**, and then select **Enable Log**.   
   - To save the log to a file, right-click **Operational**, and then select **Save Events as**. You can save the log file in the EVTX format (which can be opened through the Event Viewer) or in the XML format.   
   - To disable CAPI2 logging, right-click **Operational**, and then select **Disable Log**.   
   - If there is data present in the log before you try to reproduce the problem, we recommend that you clear the log. This allows for only the data relevant to the problem scenario to be collected from the saved log. To clear the log, right-click **Operational**, and then select **Clear Log**.   
   - For CAPI2 Diagnostics, the log can grow in size quickly, and we recommend that you increase the log size to at least 4 megabytes (MB) to capture relevant events. To increase the log size, right-click **Operational**, and then select **Properties**. In the log properties, increase the maximum log size.  

     **Note** The default size for the event log is 1 MB.     

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
