# Stage 1: Build the project with Maven
FROM maven:3.8.5-openjdk-11 AS build
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Create the final runnable image with Tomcat
FROM tomcat:9.0-jdk11-temurin
# Remove the default Tomcat welcome page
RUN rm -rf /usr/local/tomcat/webapps/*
# Copy the .war file built in Stage 1 into Tomcat's webapps directory
COPY --from=build /target/my-web-app.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080 (the default for Tomcat)
EXPOSE 8080
# Start the Tomcat server
CMD ["catalina.sh", "run"]