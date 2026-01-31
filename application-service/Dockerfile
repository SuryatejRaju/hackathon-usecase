# Use official Node.js image
FROM node:18-alpine

# Create app directory
WORKDIR /app

# Copy package files first (better caching)
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy source code
COPY src ./src

# Expose application port
EXPOSE 3000

# Start the application
CMD ["node", "src/index.js"]
