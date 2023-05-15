FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app
COPY ./ .
 
RUN dotnet publish --configuration Release --self-contained true

FROM nginx:alpine 

WORKDIR /usr/share/nginx/html
COPY --from=build /app/output/wwwroot .