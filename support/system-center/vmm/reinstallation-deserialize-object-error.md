---
title: Reinstallation of VMM 2012 R2 fails
description: Discusses a problem in which reinstalling System Center 2012 R2 Virtual Machine Manager fails and returns the deserializing the object of type Microsoft.VirtualManager.Utils.ErrorInfo error message. Provides a workaround.
ms.date: 07/17/2020
ms.reviewer: markstan
---
# Deserializing the object of type Microsoft.VirtualManager.Utils.ErrorInfo error when reinstalling VMM 2012 R2

This article helps you work around an issue where you can't reinstall Microsoft System Center 2012 R2 Virtual Machine Manager and receive the **deserializing the object of type Microsoft.VirtualManager.Utils.ErrorInfo** error.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager, Microsoft System Center 2012 R2 Virtual Machine Manager  
_Original KB number:_ &nbsp; 3072393

## Symptoms

Consider the following scenario:

- You have a System Center 2012 R2 Virtual Machine Manager (VMM 2012 R2) environment.
- One or more Library servers use a Storage Area Network (SAN). This is true also for a library server that is a virtual machine (VM) that uses Virtual Fibre Channel (vFC).
- You apply [Update Rollup 6 (UR6)](https://support.microsoft.com/help/3050317) or a later version for VMM 2012 R2.
- You try to reinstall VMM 2012 R2 or add a cluster node that attaches to an existing database. For example, you might do this as a disaster recovery procedure.

In this scenario, the installation fails and you receive the following error message:

> 12:36:22:VMMPostinstallProcessor threw an exception: Threw Exception.Type: System.Runtime.Serialization.SerializationException, Exception.Message: There was an error deserializing the object of type Microsoft.VirtualManager.Utils.ErrorInfo. End element 'code' from namespace 'http://schemas.datacontract.org/2004/07/Microsoft.VirtualManager.Utils' expected. Found element 'EnumValueName' from namespace 'http://schemas.datacontract.org/2004/07/Microsoft.VirtualManager.Utils'.  
> 12:36:22:StackTrace: at System.Runtime.Serialization.XmlObjectSerializer.ReadObjectHandleExceptions(XmlReaderDelegator reader, Boolean verifyObjectName, DataContractResolver dataContractResolver)  
> at System.Runtime.Serialization.XmlObjectSerializer.ReadObject(XmlDictionaryReader reader)  
> at Microsoft.VirtualManager.Utils.SerializationHelper.DeserializeDataContract[T](Byte[] dataBytes)  
> at Microsoft.VirtualManager.DB.Adhc.LibraryServer..ctor(SqlRow row)  
> at Microsoft.VirtualManager.Setup.VirtualMachineManagerHelpers.AddLibrary()  
> at Microsoft.VirtualManager.Setup.InstallItemCustomDelegates.PangaeaServerPostinstallProcessor()  
> 12:36:22:InnerException.Type: System.Xml.XmlException, InnerException.Message: End element 'code' from namespace 'http://schemas.datacontract.org/2004/07/Microsoft.VirtualManager.Utils' expected. Found element 'EnumValueName' from namespace 'http://schemas.datacontract.org/2004/07/Microsoft.VirtualManager.Utils'.  
> 12:36:22:InnerException.StackTrace: at System.Xml.XmlExceptionHelper.ThrowXmlException(XmlDictionaryReader reader, String res, String arg1, String arg2, String arg3)  
> at System.Xml.XmlBaseReader.ReadEndElement()  
> at System.Xml.XmlBaseReader.ReadElementContentAsString()  
> at System.Xml.XmlBinaryReader.ReadElementContentAsString()  
> at System.Runtime.Serialization.EnumDataContract.ReadEnumValue(XmlReaderDelegator reader)  
> at System.Runtime.Serialization.EnumDataContract.ReadXmlValue(XmlReaderDelegator xmlReader, XmlObjectSerializerReadContext context)  
> at System.Runtime.Serialization.XmlObjectSerializerReadContext.InternalDeserialize(XmlReaderDelegator reader, String name, String ns, Type declaredType, DataContract& dataContract)  
> at System.Runtime.Serialization.XmlObjectSerializerReadContext.InternalDeserialize(XmlReaderDelegator xmlReader, Int32 id, RuntimeTypeHandle declaredTypeHandle, String name, String ns)  
> at ReadErrorInfoFromXml(XmlReaderDelegator , XmlObjectSerializerReadContext , XmlDictionaryString[] , XmlDictionaryString[] )  
> at System.Runtime.Serialization.ClassDataContract.ReadXmlValue(XmlReaderDelegator xmlReader, XmlObjectSerializerReadContext context)  
> at System.Runtime.Serialization.XmlObjectSerializerReadContext.InternalDeserialize(XmlReaderDelegator reader, String name, String ns, Type declaredType, DataContract& dataContract)  
> at System.Runtime.Serialization.XmlObjectSerializerReadContext.InternalDeserialize(XmlReaderDelegator xmlReader, Type declaredType, DataContract dataContract, String name, String ns)  
> at System.Runtime.Serialization.DataContractSerializer.InternalReadObject(XmlReaderDelegator xmlReader, Boolean verifyObjectName, DataContractResolver dataContractResolver)  
> at System.Runtime.Serialization.XmlObjectSerializer.ReadObjectHandleExceptions(XmlReaderDelegator reader, Boolean verifyObjectName, DataContractResolver dataContractResolver)  
> 12:36:22:ProcessInstalls: Running the PostProcessDelegate returned false.  
> 12:36:22:ProcessInstalls: Running the PostProcessDelegate for PangaeaServer failed.... This is a fatal item. Setting rollback.

## Cause

This problem occurs when you perform an installation against a database that has had its schema changed by Update Rollup 6 or a later version for VMM 2012 R2. The problem occurs because VMM 2012 R2 UR6 contains the `EnumValueName` element. This is an additional element that was not included in the VMM 2012 R2 initial release code.

## Workaround

To work around this problem, temporarily reset the `FibreChannelSANStatus`, `iscsisanstatus`, and `NPIVFibreChannelSANStatus` values for all your library servers to null. To do this, follow these steps:

1. Make a full backup of the VMM database.
2. Run the following script against the VMM database. In this script, substitute the actual name of the library server for the \<*libraryserver.contoso.com*> placeholder.

    > [!NOTE]
    >  If you have more than one library server, rerun this script for each server.

    ```sql
    update dbo.tbl_ADHC_Library
    set
    FibreChannelSANStatus=null,
    iscsisanstatus=null,
    NPIVFibreChannelSANStatus=null
    where computername ='libraryserver.contoso.com'
    ```

3. After the changes are applied, rerun Setup.

    > [!NOTE]
    > If you deploy a highly available (clustered) VMM installation, repeat this step on every node before you go to step 4.

4. After Setup is completed, install the latest update rollup.

    > [!NOTE]
    > When you install the update rollup, the values that were deleted by the script are updated.
