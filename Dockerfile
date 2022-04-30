# Use image from HAProxy Docker LTS
FROM haproxy:lts

USER root
# Install OpenSSH and set the password for root to "Docker!".
RUN echo "root:Docker!" | chpasswd \
     && apt-get update \  
     && apt-get install --yes --no-install-recommends openssh-server

# Copy the sshd_config file to the /etc/ssh/ directory
COPY sshd_config /etc/ssh/

# Copy and configure the ssh_setup file
RUN mkdir -p /tmp
COPY ssh_setup.sh /tmp
RUN chmod +x /tmp/ssh_setup.sh \
   && (sleep 1;/tmp/ssh_setup.sh 2>&1 > /dev/null)

# Open port 2222 for SSH access
EXPOSE 80 2222