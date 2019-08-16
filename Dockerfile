FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY WebApiHiHello/WebApiHiHello.csproj WebApiHiHello/
RUN dotnet restore WebApiHiHello/WebApiHiHello.csproj
COPY . .
WORKDIR /src/WebApiHiHello
RUN dotnet build WebApiHiHello.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish WebApiHiHello.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "WebApiHiHello.dll"]
