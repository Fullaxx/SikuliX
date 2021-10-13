# ------------------------------------------------------------------------------
# Pull base image
FROM fullaxx/ubuntu-desktop
MAINTAINER Brett Kuskie <fullaxx@gmail.com>

# ------------------------------------------------------------------------------
# Set environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV LANG C
ENV SIKULIXJAR "https://launchpad.net/sikuli/sikulix/2.0.5/+download/sikulixide-2.0.5-lux.jar"

# ------------------------------------------------------------------------------
# Install prerequisites and clean up
RUN apt-get update && \
    apt-get install -y --no-install-recommends openjdk-11-jre wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

# ------------------------------------------------------------------------------
# Install Sikuli
RUN mkdir /opt/sikulix && \
    wget ${SIKULIXJAR} -O /opt/sikulix/sikulix.jar

# ------------------------------------------------------------------------------
# Install startup scripts
COPY scripts/*.sh /app/scripts/
COPY conf/autostart conf/menu.xml /usr/share/ubuntu-desktop/openbox/

# ------------------------------------------------------------------------------
# Expose ports
EXPOSE 5901

# ------------------------------------------------------------------------------
# Define default command
CMD ["/app/app.sh"]
