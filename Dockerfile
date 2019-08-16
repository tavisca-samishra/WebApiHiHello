FROM mcr.microsoft.com/dotnet/core/aspnet:2.1
WORKDIR app
COPY WebApiHiHello/Publish .
EXPOSE 1112
ENTRYPOINT ["dotnet", "WebApiHiHello.dll"]