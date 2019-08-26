ARG publish_path
ARG dll_file

FROM mcr.microsoft.com/dotnet/core/aspnet:2.1 AS build-env
WORKDIR app
COPY $publish_path .
EXPOSE 1112
ENTRYPOINT ["dotnet", "$dll_file"]