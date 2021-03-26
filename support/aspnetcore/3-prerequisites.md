**Prerequisites**

Like the chapter that preceded it, this part is structured to place more emphasis on the theory and principals to follow when starting to troubleshoot. It does not have any prerequisites, but you should have following set up at the moment if you followed all the steps of this training so far:

- Nginx has two web sites:
  - The first web site listening for requests with the **myfirstwebsite** host header (`http://myfirstwebsite`) and routing the requests to the demo ASP.NET Core application, which is listening on port 5000.
  - The second web site listening for requests with host header **buggyamb** (`http://buggyamb`) and routing the requests to the second ASP.NET Core sample buggy application, which is listening on port 5001.
- Both ASP.NET Core applications should be running as services, which restart automatically when the server is rebooted, or the applications stops or crashes.
- Linux local firewall is enabled and configured to allow SSH and HTTP traffic.
