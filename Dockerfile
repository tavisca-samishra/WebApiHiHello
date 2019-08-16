FROM mcr.microsoft.com/dotnet/core/aspnet:2.1 AS runtime
WORKDIR /app
COPY ./WebApiHiHello/publish ./
ENTRYPOINT ["dotnet", "WebApiHiHello.dll"]