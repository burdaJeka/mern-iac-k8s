# ==============================================================================
# Backend Dockerfile (Node.js API)
# ==============================================================================

# Use a lightweight Alpine image for security and size
FROM node:20-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json (our dummy file)
COPY package*.json ./

# Install dependencies (will succeed even if the file is empty)
RUN npm install

# Copy the rest of the application files
COPY . .

# BEST PRACTICE: Run as a non-root user for security purposes
USER node

# Expose port 80 for internal communication
EXPOSE 80

# Dummy start command (since there is no real Node.js server yet, 
# this keeps the container running in the background)
CMD ["tail", "-f", "/dev/null"]
