# Use official Node.js image
FROM node:18

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json ./
RUN npm install

# Copy app files
COPY . .

# Expose port and start the app
EXPOSE 3000
CMD ["node", "index.js"]
