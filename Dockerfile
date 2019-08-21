FROM mcr.microsoft.com/dotnet/core/sdk:3.0 as debug_tools

# lldb version is 7, which is ok
RUN apt update && apt install lldb -y

ENV TOOL_VERSION=3.0.0-preview8.19412.1

# install dotnet tools for dump and sos
ENV PATH=$PATH:$HOME/.dotnet/tools
RUN dotnet tool install -g dotnet-symbol
RUN dotnet tool install -g dotnet-sos --version ${TOOL_VERSION} && ~/.dotnet/tools/dotnet-sos install
RUN dotnet tool install -g dotnet-dump --version ${TOOL_VERSION}
RUN dotnet tool install -g dotnet-trace --version ${TOOL_VERSION}

FROM debug_tools

COPY src/prometheus-net-example/bin/Release/netcoreapp3.0/debian.10-x64/publish /app

WORKDIR /app

CMD [ "./prometheus-net-example" ]