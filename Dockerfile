FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app
COPY ./ .
 
RUN dotnet publish -c Release -o output

FROM nginx:alpine 
WORKDIR /usr/share/nginx/html
COPY --from=build /app/output/wwwroot .