FROM openjdk:8-jre-alpine
# Descarga la imagen de alpine
RUN apk add --no-cache bash
#ejecuta comandos (imagenes)
WORKDIR /opt
#establece el area de trabajo
COPY payroll/server/target/links-0.0.1-SNAPSHOT.jar .
#copia los ejecutables
ENV PORT=8080
#defino el entorno en donde lo voy a correr, ubicado en el 8080
EXPOSE 8080
#Indica los puertos en los que va a escuchar la imagen. doy permiso de que este en ese puerto
CMD ["java", "-Xms32m", "-Xmx128m", "-jar", "-Dserver.port=${PORT}", "links-0.0.1-SNAPSHOT.jar"]
#lo que se ejecuta en a terminal. comando que se ejecutan en ese workdir