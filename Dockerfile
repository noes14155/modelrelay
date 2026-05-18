FROM node:24-alpine

# Install dependencies
RUN apk add --no-cache ca-certificates

# Set working directory
WORKDIR /app

# Copy local files
COPY package.json package-lock.json ./
COPY bin/ ./bin/
COPY lib/ ./lib/
COPY public/ ./public/
COPY sources.js scores.js README.md LICENSE ./

# Install npm dependencies
RUN npm install --production

# Create a directory for configuration (home directory for user)
RUN mkdir -p /root && chmod 700 /root

# Make the CLI executable
RUN chmod +x /app/bin/modelrelay.js

# Link the local package globally for easy command execution
RUN npm link

# Expose the correct local router port
EXPOSE 7352

# Entrypoint: handles commands passed to the container
ENTRYPOINT ["modelrelay"]
CMD ["start"]
