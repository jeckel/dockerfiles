###############################################################################
# NodeJS Dockerfile sample
#
# Do not use as it is, take time to customize it according to your needs
#
###############################################################################
# Step 1 : Builder image
#
FROM node:9-alpine AS builder
LABEL maintainer="Julien MERCIER <devci@j3ck3l.me>"

# Define working directory and copy source
WORKDIR /home/node/app
COPY . .

# Install dependencies and build whatever you have to build 
# (babel, grunt, webpack, etc.)
RUN npm install && \
    npm run build

###############################################################################
# Step 2 : Run image
#
FROM node:9-alpine
ENV NODE_ENV=production
WORKDIR /home/node/app

# Install deps for production only
COPY ./package* ./
RUN npm install && \
    npm cache clean --force

# Copy builded source from the upper builder stage
COPY --from=builder /home/node/app/dist ./dist

# Expose whatever port you need to expose
# And start
CMD npm start