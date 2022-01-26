---
title: Known issues in BizTalk Server 2013
description: Describes the known issues in BizTalk Server 2013.
ms.date: 03/06/2020
ms.custom: sap:Performance
ms.reviewer: niklase, chiragpa
---
# Known issues in BizTalk Server 2013

This article lists the known issues when you use Microsoft BizTalk Server 2013.

_Original product version:_ &nbsp; BizTalk Server 2013  
_Original KB number:_ &nbsp; 2954101

## Known Issues in XSLCompiledTransform

BizTalk Server 2013 uses the .NET `XslCompiledTransform` class for better transform performance. There are some differences in behavior between the `XslCompiledTransform` class and the previously used `XslTransform` class. The following are some known issues related to this difference and the recommended solutions:

- Change in scripting `functoid` Boolean parameter

  **Symptom**

  When the input XML node contains any value that is false or the input XML node is empty, Boolean parameter in a scripting `functoid` is true.

- Private functions are not supported

  **Symptom**

  When you use private function in a `functoid`, the map fails and you receive the following error message:
  
  > Method 'MyPrivateFunct' of extension object 'http://schemas.microsoft.com/BizTalk/2003/userCSharp' cannot be called because it is not public.

  The `XslCompiledTransform` class only supports calling public methods. This limitation is documented at [Migrating From the XslTransform Class](https://msdn.microsoft.com/library/66f54faw.aspx).

  **Resolution**

  Declare the function as public instead of private.

- Returning null is not supported

  **Symptom**

  When you return a null value from a `functoid`, the map fails and you receive the following generic error message:
  
  > ExceptionType: Microsoft.XLANGs.Core.XTransformationFailureException
  >
  > Exception: Error encountered while executing the transform My.Map. Error:Transformation failed.

  When you test the same map in Visual Studio, it provides a more descriptive error message:
  
  > Exception has been thrown by the target of an invocation. Extension functions cannot return null values.

  The XslCompiledTransform class doesn't support returning null values from functions that are called within the transform.

  **Resolution**

  Return `String.Empty` or some other alternative value to represent the null scenario. If it is needed, use a global variable to make the null value available across multiple functions.

- Change in scripting functoid `XPathNodeIteraton` parameter

  **Symptom**

  An `XPathNodeIterator` parameter in a scripting functoid uses the `XPathArrayIterator` type. In earlier BizTalk Server versions, it used the `XPathSelectionIterator` type. Because of this change, the node.MoveNext() call has to be added, as in the following code, in order to avoid the following error message:  
  > Enumeration has not started. Call MoveNext.
  
  ```csharp
  public static bool WriteNode(XPathNodeIterator node)
  {
    node.MoveNext(); //needs to be added in BizTalk Server 2013 to avoid error
    XPathNavigator xpn = node.Current;
    XmlDocument xdoc = new XmlDocument();
    xdoc.LoadXml(xpn.OuterXml);
    return true;
  }
  ```

  **Resolution**

  Call the `MoveNext()` function.

- Function overloads are differentiated by number of parameters instead of by types.

  **Symptom**

  The following function overloads contain parameters of different types:

  ```csharp
  public short MyOverloadedFunction(int testvalue)
  public short MyOverloadedFunction(string testvalue)
  ```

  Because these function overloads both have the same count of parameters, if they are used in a transform, the map fails and you receive the following error message:
  
  > Ambiguous method call. Extension object 'http://schemas.microsoft.com/BizTalk/2003/ScriptNS0' contains multiple 'MyOverloadedFunction' methods that have 1 parameter(s).

  The `XslCompiledTransform` class only differentiates between functions based on the number of arguments. This limitation is documented at [Migrating From the XslTransform Class](https://msdn.microsoft.com/library/66f54faw.aspx).

  **Resolution**

  Make sure all function overloads contain a different number of parameters.

- Falling Back to the `XslTransform` Class

    You can configure the BizTalk Server 2013 transform engine to use the older `XslTransform` class. We do not recommend this approach because the environment will lose the many performance and memory usage improvements provided by the `XslCompiledTransform` class. Also, the .NET `XslTransform` class is deprecated. Therefore, no new updates or fixes will be released for it.

If you can't update the map by using the solutions mentioned earlier, this change can be made by adding a DWORD `UseXslTransform` with value of 1 at the following locations:

- For 64-bit BizTalk host instances:  
  `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\BizTalk Server\3.0\Configuration`

- For 32-bit BizTalk host instances and Visual Studio's Test Map functionality:  
  `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\BizTalk Server\3.0\Configuration`

## Known Issues in Enterprise Single Sign-On (SSO)

The followings are some known issues that are specific to SSO on BizTalk Server 2013:

- Upgrade to BizTalk Server 2013 does not upgrade SSO

  **Symptom**

  An in-place upgrade from BizTalk Server 2009 or BizTalk Server 2010 to BizTalk Server 2013 may not upgrade SSO on the same computer. If this issue results in the SSO Master Secret Server not being upgraded, when you try to upgrade other BizTalk servers in the group, you receive the following error message:
  
  > Please upgrade your master secret server

  Any component of BizTalk Server that references Microsoft.BizTalk.Interop.SSOClient.dll fails, and you receive the following error message:
  
  > Could not load file or assembly 'Microsoft.BizTalk.Interop.SSOClient, Version=7.0.2300.0'

  **Resolution**

  This issue is resolved in later releases of the BizTalk Server 2013 media. Therefore, make sure that you upgrade by using the latest available media.

- Can't load `Microsoft.BizTalk.Interop.SSOClient.dll` version 5.0.1.0

  **Symptom**

  You may receive the following error message in following scenarios:
  
  > Could not load file or assembly 'Microsoft.BizTalk.Interop.SSOClient.dll, Version=5.0.1.0'

  - The error is thrown by a WCF receive location or WCF send port after an in-place upgrade from BizTalk Server 2009 or BizTalk Server 2010. This occurs because the `Microsoft.BizTalk.Adapter.Wcf.Runtime.dll` file is not upgraded to version 3.10.229.0 correctly.

    **Resolution**

     If the version of `Microsoft.BizTalk.Adapter.Wcf.Runtime.dll` is earlier than 3.10.229.0, copy the correct version of the file from the BizTalk Server 2013 installation media (located in `<DVD-Drive>\BizTalk Server\MSI\Program Files`), put it in the BizTalk Server installation folder, and then install it into the Global Assembly Cache (GAC). You can install the .dll file into the GAC by using the gacutil.exe tool as following:

     ```console
     gacutil.exe /if Microsoft.BizTalk.Adapter.Wcf.Runtime.dll
     ```

  - The error is thrown by custom code that is previously used in BizTalk Server 2009 or BizTalk Server 2010. This is because BizTalk Server 2009 and BizTalk Server 2010 have .NET version 5.0.1.0 of the `Microsoft.BizTalk.Interop.SSClient.dll` file. However, BizTalk Server 2013 uses .NET version 7.0.2300.0 of the file.

    **Resolution**

    Update and rebuild the custom code to reference the BizTalk Server 2013 version (7.0.2300.0) of the `Microsoft.BizTalk.Interop.SSClient.dll` file. If rebuilding is not an option, redirect to version 7.0.2300.0 by making the following modification to the `<runtime>/<assemblyBinding>` section of the appropriate configuration file:

    ```xml
    <dependentAssembly>
        <assemblyIdentity name="Microsoft.BizTalk.Interop.SSOClient" publicKeyToken="31bf3856ad364e35" culture="neutral" />
        <bindingRedirect oldVersion="5.0.1.0" newVersion="7.0.2300.0"/>
    </dependentAssembly>
    ```

  - The error is thrown by Microsoft BizTalk Enterprise Service Bus (ESB) because of an incorrect file dependency.

    **Resolution**

    This issue is fixed in BizTalk Server 2013 Cumulative Update 2 (CU2) and later versions.

    For more information about this issue, see [FIX: Could not load file or assembly Microsoft.BizTalk.Interop.SSOClient Version=5.0.1.0 error when you use the ESB configuration tool in BizTalk Server 2013](https://support.microsoft.com/help/2848425).

    For how to obtain the latest cumulative update to resolve it, see [Service Pack and cumulative update list for BizTalk Server](https://support.microsoft.com/help/2555976).

- Failed to load *SSOPSServer.dll*

  **Symptom**

  You may receive the following error message that is logged in the event logs:
  
  > Failed to load \Program Files\Common Files\Enterprise Single Sign-On\SSOPSServer.dll Error code: 0x8007007E, The specified module could not be found.

  **Resolution**

  This error is harmless and can be ignored. In order to prevent this error from continuing to occur, copy the *SSOPSServer.dll* file from the original installation media into the `\Program Files\Common Files\Enterprise Single Sign-On` folder on the computer. For 64-bit installations of SSO, use the *SSOPSServer.dll* file from `\Platforms\SSO64\Files` on the installation media. For 32-bit installations of SSO, use the file from `\Platforms\SSO\Files`.

- BizTalk SSO Master Secret cannot be used by Host Integration Server 2013 SSO

  **Symptom**

  When a Host Integration Server 2013 SSO service tries to access a BizTalk Server 2013 SSO Master Secret service, the following error message is thrown:
  
  > Failed to retrieve master secrets. Verify that the master secret server name is correct and that it is available. Secret Server Name: BTSSSOSERVER Error Code: 0x00000057, The parameter is incorrect.

  **Resolution**

  Host Integration Server 2013 includes version 9.0.2096.0 of SSO. However, BizTalk Server 2013 includes version 9.0.1865.0. Because of this, in a mixed environment in which SSO services on both Host Integration Server and BizTalk servers access a shared Master Secret Server, the server must run the Host Integration Server 2013 SSO service. Be aware that installing Host Integration Server on a BizTalk server will upgrade the existing SSO service to version 9.0.2096.0, and will require that the remote Master Secret SSO server also be upgraded to 9.0.2096.0.

## Other known issues

- Upgrade to BizTalk Server 2013 doesn't deploy new `Microsoft.BizTalk.GlobalPropertySchemas.dll`

  **Symptom**

  An in-place upgrade from BizTalk Server 2009 or BizTalk Server 2010 to BizTalk Server 2013 does not correctly deploy the new `Microsoft.BizTalk.GlobalPropertySchemas.dll` file into the `BizTalkMgmtDb` database. This can result in errors when any of the new global properties are accessed by BizTalk. This can occur when you use `WCF.HttpHeaders`, any property associated with the `SB-Messaging Adapter`, or any other new property. The error messages that the `SB-Messaging Adapter` fails together with are following:
  
  > The adapter "SB-Messaging" raised an error message. Details "System.Runtime.InteropServices.COMException (0xC0C01620): Exception from HRESULT: 0xC0C01620  
  > at Microsoft.BizTalk.TransportProxy.Interop.IBTTransportBatch.MoveToSuspendQ(IBaseMessage msg)  
  > at Microsoft.BizTalk.Adapter.Wcf.Runtime.Batch2.MoveToSuspendQ(IBaseMessage message, Object userData)  
  > at Microsoft.BizTalk.Adapter.Wcf.Runtime.BizTalkReceiveBatch.SuspendMessageIfNeeded(IBaseMessage message, StreamAndUserData streamAndUserData, Int32 messageStatus)".  
  > The adapter "SB-Messaging" raised an error message. Details "System.Exception: Loading property information list by namespace failed or property not found in the list. Verify that the schema is deployed properly.  
  > at Microsoft.BizTalk.Adapter.Wcf.Runtime.BizTalkServiceInstance.EndOperation(IAsyncResult result)  
  > at AsyncInvokeEndEndTwoWayMethod(Object , Object[] , IAsyncResult)  
  > at System.ServiceModel.Dispatcher.AsyncMethodInvoker.InvokeEnd(Object instance, Object[]& outputs, IAsyncResult result)  
  > at System.ServiceModel.Dispatcher.DispatchOperationRuntime.InvokeEnd(MessageRpc& rpc)  
  > at System.ServiceModel.Dispatcher.ImmutableDispatchRuntime.ProcessMessage7(MessageRpc& rpc)  
  > at System.ServiceModel.Dispatcher.MessageRpc.Process(Boolean isOperationContextSet)"
  
  **Resolution**

  Use the AddGlobalPropertySchemas.exe tool to manually deploy the .dll file after the upgrade. Download the tool from [AddGlobalPropertySchemas.exe](https://download.microsoft.com/download/d/7/f/d7f6de2d-39cc-47d5-a31d-0958b51b0002/globalpropschema/addglobalpropertyschemas.exe). You must pass in the BizTalk Management database server name and the database name as follows:

  ```console
  AddGlobalPropertySchemas.exe /server:MyServer /database:BizTalkMgmtDb
  ```

  > [!NOTE]
  > If the database is located on a named instance of SQL Server, specify MyServer\MyInstance instead of just MyServer.

- The ESB 2.2 config file causes ESB failures

  **Symptom**

  ESB Toolkit 2.2 uses Unity 2.0 that requires modifications to the default esb.config file. Without these modifications, the following issues can occur:

  - ESB 2.2 configuration fails, and you receive the following error message:
  
    > Exception calling "PushAllConfiguration" with "6" argument(s): "Unrecognized element 'typeConfig'. (C:\Program Files (x86)\Microsoft BizTalk ESB Toolkit\esb.config line 151)

  - When the `ItinerarySelectReceiveXML` receive pipeline is used to call the Business Rules Engine to dynamically select an itinerary (by using the ESB BRI Resolver), the following error is thrown:
  
    > Exception has been thrown by the target of an invocation.  
    > Source: Microsoft.Practices.ESB.Resolver.ResolverMgr  
    > Method: System.Collections.Generic.Dictionary`2[System.String,System.String] Resolve(Microsoft.Practices.ESB.Resolver.ResolverInfo, Microsoft.BizTalk.Message.Interop.IBaseMessage, Microsoft.BizTalk.Component.Interop.IPipelineContext)  
    > Error Source: mscorlib  
    > Error TargetSite: System.Object InvokeMethod(System.Object, System.Object[], System.Signature, Boolean)  
    > Error StackTrace: at System.RuntimeMethodHandle.InvokeMethod(Object target, Object[] arguments, Signature sig, Boolean constructor)  
    > at System.Reflection.RuntimeConstructorInfo.Invoke(BindingFlags invokeAttr, Binder binder, Object[] parameters, CultureInfo culture)  
    > at System.RuntimeType.CreateInstanceImpl(BindingFlags bindingAttr, Binder binder, Object[] args, CultureInfo culture, Object[] activationAttributes, StackCrawlMark& stackMark)  
    > at System.Activator.CreateInstance(Type type, BindingFlags bindingAttr, Binder binder, Object[] args, CultureInfo culture, Object[] activationAttributes)  
    > at System.Activator.CreateInstance(Type type, Object[] args)  
    > at Microsoft.Practices.ESB.Resolver.ResolverFactory.Create(String key)  
    > at Microsoft.Practices.ESB.Resolver.ResolverMgr.GetResolver(ResolverInfo info)  
    > at Microsoft.Practices.ESB.Resolver.ResolverMgr.Resolve(ResolverInfo info, IBaseMessage message, IPipelineContext pipelineContext)

  **Resolution**

  For more information about this issue and instructions on how to modify the esb.config file to resolve it, see [ESB Toolkit BRE Itinerary Resolver Fails with Exception](https://support.microsoft.com/help/2887594) and [ESB Configuration fails with Unrecognized element 'typeConfig'](https://support.microsoft.com/help/2887942).

- `EDIFACT` message that has UNB 3.3 segment is suspended

    **Symptom**

    After the upgrade to BizTalk Server 2013, an `EDIFACT` message that contains a UNB 3.3 segment fails, and you receive the following error message. This same `EDIFACT` message processed without issue in BizTalk Server 2010:

    > Loading property information list by namespace failed or property not found in the list. Verify that the schema is deployed properly.

    **Resolution**

    Restart the relevant host instance by using the following steps:

  - In BizTalk Server Administration Console, navigate to **BizTalk Group** > **Applications** > **BizTalk EDI Applications** > **Resources**.
  - Right-click **Resources**, and then click **Add** > **BizTalk Assemblies**.
  - In the **Add Resources** window, click **Add**, select the Microsoft.BizTalk.Edi.BaseArtifacts.dll file (the default location is `C:\Program Files (x86)\Microsoft BizTalk Server 2013`), and then click **Open**.
  - Select the **Overwrite all** check box.
  - Select the **Add to the global assembly cache on add resource** check box, and then click **OK**.
