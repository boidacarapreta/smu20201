FROM gitpod/workspace-full

USER gitpod

RUN cd /tmp && \
  curl -LO https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip && \
  unzip terraform_0.12.24_linux_amd64.zip && \
  rm terraform_0.12.24_linux_amd64.zip && \
  chmod 0755 terraform && \
  sudo mv terraform /usr/local/bin
