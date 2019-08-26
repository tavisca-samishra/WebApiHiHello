
FROM mcr.microsoft.com/dotnet/core/aspnet:2.1 AS build-env
WORKDIR app
ARG publish_path
ARG dll_file
COPY $publish_path .
EXPOSE 1112
ENTRYPOINT ["dotnet", "$dll_file"]