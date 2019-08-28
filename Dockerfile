FROM mcr.microsoft.com/dotnet/core/aspnet:2.1
ARG publish_path
COPY $publish_path .
ENV SOLUTION_DLL="WebApiHiHello.dll"
ENTRYPOINT dotnet ${SOLUTION_DLL}
