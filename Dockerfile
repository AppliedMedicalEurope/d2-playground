# Build stage
FROM node:18-alpine AS build
WORKDIR /app
COPY . .
RUN npm install && npm run build

# Runtime stage
FROM node:18-alpine
WORKDIR /app
COPY --from=build /app/dist ./dist
COPY --from=build /app/package.json ./
COPY --from=build /app/package-lock.json ./
RUN npm install --production

ENV PORT=9090
EXPOSE 9090

CMD ["node", "dist/main.js"]
