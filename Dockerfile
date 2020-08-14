FROM microsoft/aspnet

# Next, this Dockerfile creates a directory for your application
RUN mkdir C:\randomanswers

RUN dism /online /enable-feature /featurename:IIS-NetFxExtensibility45 \
                                 /featurename:IIS-WebServerManagementTools \
                                 /featurename:IIS-IIS6ManagementCompatibility \
                                 /featurename:IIS-Metabase \
                                 /featurename:IIS-HostableWebCore \
                                 /featurename:IIS-WebSockets \
                                 /featurename:IIS-ApplicationInit \
                                 /featurename:IIS-ASPNET45 \
                                 /featurename:IIS-ASP \
                                 /featurename:IIS-ISAPIExtensions \
                                 /featurename:IIS-ISAPIFilter \
                                 /featurename:IIS-ServerSideIncludes \
                                 /featurename:IIS-ManagementConsole

# configure the new site in IIS.
# RUN powershell -NoProfile -Command \
#     Import-module IISAdministration; \
#     New-IISSite -Name "ASPNET" -PhysicalPath C:\randomanswers -BindingInformation "*:8000:"

# The final instruction copies the site you published earlier into the container.

RUN powershell -NoProfile -Command \
    Import-module WebAdministration; \
    New-WebSite -Name ASPNET -Port 8000 -PhysicalPath C:\randomanswers -ApplicationPool PowerPMS

# This instruction tells the container to listen on port 8000. 
EXPOSE 8000

ENTRYPOINT ["powershell", "C:\ServiceMonitor.exe w3svc"]
