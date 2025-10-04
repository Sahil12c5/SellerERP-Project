# Stage 1: Build the application using Maven with Java 11
FROM maven:3.8.5-openjdk-11 AS build

# Set the working directory inside the container
WORKDIR /app

# CORRECTED: Copy pom.xml from the 'sellerErp' subdirectory
COPY sellerErp/pom.xml .
RUN mvn dependency:go-offline

# CORRECTED: Copy the source code from the 'sellerErp/src' subdirectory
COPY sellerErp/src ./src

# Build the .war file. This runs 'mvn clean package'
RUN mvn clean package


# Stage 2: Create the final, runnable image with the correct Tomcat version
FROM tomcat:10.0.27-jdk11

# Remove the default Tomcat welcome pages
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the .war file that was created in the 'build' stage
# It's copied into Tomcat's deployment directory (webapps) as ROOT.war
COPY --from=build /app/target/ROOT.war /usr/local/tomcat/webapps/ROOT.war

# Tell Docker that the container listens on port 8080
EXPOSE 8080

# The command to start the Tomcat server when the container runs
CMD ["catalina.sh", "run"]