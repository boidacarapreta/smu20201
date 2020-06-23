[![Gitpod Ready-to-Code](https://img.shields.io/badge/Gitpod-Ready--to--Code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/boidacarapreta/smu20201)

Este modelo define uma máquina virtual no Google Cloud com acesso a HTTPS (443/TCP e 443/UDP) e STUN (3478/UDP e 3478/TCP) sobre IPv4 fixo com registro DNS próprio.

Para usar, é preciso criar o arquivo de variáveis do Terraform, no seguinte formato:

```terraform
gcp_sakey = "***"
gce_project = "***"
gce_region = "***"
gce_zone = "***"
gce_ssh_user = "***"
gce_ssh_pub_key = "***"
gce_dns_zone_name = "***"
gce_dns_zone = "***"
```

onde:

- `gcp_sakey`: é a [chave de conta de serviço criada na GCP](https://console.cloud.google.com/apis/credentials/serviceaccountkey), em formato JSON.
- `gce_project`: nome do projeto.
- `gce_region`: região onde rodará a máquina virtual.
- `gce_zone`: dependente de `gce_region`, é a zona específica na região.
- `gce_ssh_user`: nome do usuário a ser criado dentro da máquina virtual.
- `gce_ssh_pub_key`: conteúdo do arquivo da chave pública SSH (não o nome do arquivo).
- `gce_dns_zone_name`: nome da zona registrada no GCP.
- `gce_dns_zone`: nome da zona DNS. Deve obrigatoriamente terminar com `.` (ponto final).

Exemplo de cenário a rodar na zona A de São Paulo:

```ini
gcp_sakey = "gcp.json"
gce_project = "teste-123456"
gce_region = "southamerica-east1"
gce_zone = "southamerica-east1-a"
gce_ssh_user = "boidacarapreta"
gce_ssh_pub_key = "ssh-rsa AAA...xWQ== ederson@boidacarapreta.cc"
gce_dns_zone_name = "smu20201"
gce_dns_zone = "smu20201.boidacarapreta.cc."
```

## Como usar o Terraform

Para facilitar o dia a dia, há o arquivo `Makefile`, que pode criar todo o ambiente:

```bash
make create
```

ou destrui-lo:

```bash
make destroy
```

Será criado o registro A no DNS: `webrtc.smu20201.boidacarapreta.cc.`

Nota importante: A configuração do Terraform, `gcp.tf`, é compatível com [versão 0.12 ou superior](https://www.terraform.io/docs/configuration/).
