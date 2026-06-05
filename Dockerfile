FROM node:22-alpine AS deps
WORKDIR /app
COPY package*.json ./
RUN npm ci

FROM deps AS build
COPY . .
RUN npm run build

FROM node:22-alpine AS runtime
ENV NODE_ENV=production
WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev && npm cache clean --force
COPY --from=build /app/dist ./dist
COPY --from=build /app/src ./src
COPY --from=build /app/index.html ./index.html
COPY data/db.json ./seed-data/db.json
COPY data/imports ./seed-data/imports
COPY data/audit-logs ./seed-data/audit-logs
COPY scripts/docker-entrypoint.sh ./scripts/docker-entrypoint.sh
RUN addgroup -S app && adduser -S app -G app && mkdir -p /app/data/backups /app/data/imports /app/data/audit-logs && chmod +x /app/scripts/docker-entrypoint.sh && chown -R app:app /app
USER app
EXPOSE 4100
HEALTHCHECK --interval=30s --timeout=5s --start-period=20s --retries=3 CMD wget -qO- http://127.0.0.1:4100/api/health || exit 1
ENTRYPOINT ["/app/scripts/docker-entrypoint.sh"]
CMD ["npm", "run", "start:prod"]
