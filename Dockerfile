FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /app
    
# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore
    
# Copy everything else and build
COPY . ./
RUN dotnet publish --configuration Release --self-contained true -o out
    
# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build-env /app/out .

EXPOSE 80

ENTRYPOINT ["dotnet", "txapo_web.dll"]