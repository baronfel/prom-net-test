# adds in the dotnet sdk to the runtime
FROM mcr.microsoft.com/dotnet/core/runtime:3.0-buster-slim as sdk_base

RUN curl https://download.visualstudio.microsoft.com/download/pr/c624c5d6-0e9c-4dd9-9506-6b197ef44dc8/ad61b332f3abcc7dec3a49434e4766e1/dotnet-sdk-3.0.100-preview7-012821-linux-x64.tar.gz --output dotnet-sdk-3.0.100-preview7-012821-linux-x64.tar.gz \
    && tar zxf dotnet-sdk-3.0.100-preview7-012821-linux-x64.tar.gz -C /usr/share/dotnet

ENV DOTNET_ROOT=$HOME/dotnet
ENV PATH=$PATH:$HOME/dotnet

# adds in the debugging tools using the newly-installed sdk
FROM sdk_base as debug_tools

# lldb version is 7, which is ok
RUN apt update && apt install lldb -y

# install dotnet tools for dump and sos
ENV PATH=$PATH:$HOME/.dotnet/tools
RUN dotnet tool install -g dotnet-symbol
RUN dotnet tool install -g dotnet-sos --version 3.0.0-preview7.19365.2 && dotnet sos install
RUN dotnet tool install -g dotnet-dump --version 3.0.0-preview7.19365.2

FROM debug_tools

COPY src/prometheus-net-example/bin/Release/netcoreapp3.0/debian.10-x64/publish /app

WORKDIR /app

CMD [ "./prometheus-net-example" ]