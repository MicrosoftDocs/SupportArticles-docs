---
title: "Troubleshooting HTTP 502.2 Bad Gateway error in CGI applications"
author: apurvajo
description: "Tracing module on IIS 7.X ETW Tracing on IIS 6.0 Microsoft Network Monitor 3.4 This material is provided for informational purposes only. Microsoft makes no..."
ms.date: 04/09/2012
ms.assetid: 863de5df-e94e-458e-bc47-693426917508
msc.legacyurl: /learn/troubleshoot/diagnosing-http-errors/troubleshooting-http-5022-bad-gateway-error-in-cgi-applications
msc.type: authoredcontent
---
# Troubleshooting HTTP 502.2 Bad Gateway error in CGI applications

by [Apurva Joshi](https://github.com/apurvajo)

#### Tools Used in this Troubleshooter:

- Tracing module on IIS 7.X
- ETW Tracing on IIS 6.0
- Microsoft Network Monitor 3.4

This material is provided for informational purposes only. Microsoft makes no warranties, express or implied.

## Overview

You have a Web site that is hosted on Internet Information Services (IIS) 7.0. When you visit the Web site in a Web browser, you may receive an error message that resembles the following:

[!code-console[Main](troubleshooting-http-5022-bad-gateway-error-in-cgi-applications/samples/sample1.cmd)]

This problem occurs because the CGI process terminates unexpectedly before the CGI process sends a response back to IIS 7.0

## Troubleshooting

Scenario: When sending a request to a CGI application running via IIS, the user is presented with the following error instead of the expected response:

[!code-console[Main](troubleshooting-http-5022-bad-gateway-error-in-cgi-applications/samples/sample2.cmd)]

Capturing a Netmon trace shows this sort of information:

[!code-html[Main](troubleshooting-http-5022-bad-gateway-error-in-cgi-applications/samples/sample3.html)]

Capture FREB log for the HTTP error message and locate which module is throwing this error message.

Troubleshoot the CGI process executable file to determine why the CGI process terminates unexpectedly. You may have to generate a memory dump file of the CGI process when the access violation occurs.[https://support.microsoft.com/?id=150835](https://support.microsoft.com/?id=150835)

This problem occurs when the CGI application does exactly what the error suggests: inserts invalid data into the HTTP Header value(s) that is sends to IIS as part of its response. In IIS 6 with Windows 2003 SP1 installed, you can use Enterprise Tracing for Windows (ETW Tracing) to see exactly what the CGI is returning.

**Capturing a Trace file using ETW Tracing**

1. Copy the ETWSetup.zip file attached to this email to the IIS6 Server. 

    [ETWSetup](troubleshooting-http-5022-bad-gateway-error-in-cgi-applications/_static/troubleshooting-http-5022-bad-gateway-error-in-cgi-applications-1116-etwsetup1.zip)
2. Extract it on the server.
3. Open this folder from the command prompt.
4. Type iis6trace-start.cmd to start the tracing.
5. Reproduce the issue.
6. Type iis6trace-stop.cmd to stop the tracing.
7. At this point, we should have an iistrace\_etl.etl file in that folder.
8. Please zip up that file and send it to Microsoft Support Engineer.
9. Support engineer can help you convert ETL file into XML.
10. Here is an example trace file from this sort of CGI problem:

The request to the CGI starts at line 391:

[!code-xml[Main](troubleshooting-http-5022-bad-gateway-error-in-cgi-applications/samples/sample4.xml)]

[!code-xml[Main](troubleshooting-http-5022-bad-gateway-error-in-cgi-applications/samples/sample5.xml)]

Line 441 shows the problem in the CGI:

[!code-xml[Main](troubleshooting-http-5022-bad-gateway-error-in-cgi-applications/samples/sample6.xml)]

Line 446 then shows the 502 that is sent to the client. It is in fact a 502.2 (substatus of 2):

[!code-xml[Main](troubleshooting-http-5022-bad-gateway-error-in-cgi-applications/samples/sample7.xml)]

The request is processed by IIS, we see it is for a CGI, and we pass it along to the CGI. The CGI starts its processing at line 405:

### Other Resources

- Error message when you visit a Web site that is hosted on IIS 7.0: "HTTP Error 502.2 – Bad Gateway" (`https://support.microsoft.com/kb/942057`)
- [You receive a "The specified CGI application misbehaved" error message](https://support.microsoft.com/?id=145661)
- [Troubleshooting CGI Error](https://support.microsoft.com/?id=150835)
