FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src

COPY . sms-mes-planning-pss-api
WORKDIR /src/sms-mes-planning-pss-api
RUN dotnet restore "sms-mes-planning-pss-api.csproj"
RUN dotnet build "sms-mes-planning-pss-api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "sms-mes-planning-pss-api.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
RUN mkdir /Temp
RUN apt-get update
RUN apt-get -y install curl gnupg
RUN curl -sL https://deb.nodesource.com/setup_14.x  | bash -
RUN apt-get -y install nodejs
RUN npm i -g typescript
ENTRYPOINT ["dotnet", "sms-mes-planning-pss-api.dll"]