# ==============================================================================
# Frontend Dockerfile (Nginx)
# ==============================================================================

# Use Nginx Alpine image to serve static files
FROM nginx:alpine

# Create a dummy index.html directly during the build process
RUN echo "<h1>MERN Frontend is running!</h1>" > /usr/share/nginx/html/index.html

# Expose port 80 for web traffic
EXPOSE 80
