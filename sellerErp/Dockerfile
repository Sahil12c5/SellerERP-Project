# Stage 1: Build the project with Maven
FROM maven:3.8.5-openjdk-11 AS build
WORKDIR /app

# Copy only pom.xml first to leverage caching
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Now copy the rest of the source code
COPY src ./src

# Package the application (skip tests for faster build)
RUN mvn clean package -DskipTests

# Stage 2: Create the final runnable image with Tomcat
FROM tomcat:9.0-jdk11-temurin
WORKDIR /usr/local/tomcat

# Remove the default Tomcat webapps
RUN rm -rf webapps/*

# Copy built WAR from Stage 1 into Tomcat
COPY --from=build /app/target/*.war webapps/ROOT.war

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
