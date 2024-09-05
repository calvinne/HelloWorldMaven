# Step 1: Build the React application , your project requires Node.js 16
FROM node:16-alpine AS build
# Set working directory
WORKDIR /app
# Install dependencies
COPY ["package*.json","./"]
RUN npm install
# Copy the rest of the application code
COPY . .
# Build the React app
RUN npm run build
# Step 2: Serve the application using nginx
FROM nginx:alpine
# Copy the build output to the nginx html directory
COPY --from=build /app/build /usr/share/nginx/html
# Expose port 80
EXPOSE 80
# Start nginx
CMD ["nginx","-g", "daemon off;"]