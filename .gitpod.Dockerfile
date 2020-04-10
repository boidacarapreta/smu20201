FROM gitpod/workspace-full
                    
USER gitpod

RUN cd /tmp && \
  curl -LO https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip && \
  unzip terraform_0.12.24_linux_amd64.zip && \
  rm terraform_0.12.24_linux_amd64.zip && \
  chmod 0755 terraform && \
  sudo mv terraform /usr/local/bin && \
  curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && \
  chmod 0755 kubectl && \
  sudo mv kubectl /usr/local/bin && \
  sudo apt-get update && \
  sudo apt-get -y install dnsutils bind9 && \
  sudo apt-get clean && \
  sudo apt-get autoremove
