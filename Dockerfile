# Use an official Node runtime as a parent image (you can specify the version you need)
FROM node:21-alpine3.18

# Set the working directory in the container
WORKDIR /app
# Create a non-root user and group
RUN addgroup -g 1001 -S appuser && \
    adduser -u 1001 -S appuser -G appuser

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install app dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Change ownership of the app directory to the non-root user
RUN chown -R appuser:appuser /app

# Switch to the non-root user
USER appuser

# Build the React app (adjust the build command based on your project)
RUN npm run build

# Expose the port your app will run on (the default is 3000)
EXPOSE 3000

# Define the command to start your app
CMD ["node", "index.js"]
