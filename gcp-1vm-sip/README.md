[![Gitpod Ready-to-Code](https://img.shields.io/badge/Gitpod-Ready--to--Code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/boidacarapreta/smu20201)

# gcp-1m-sip

Este modelo define uma máquina virtual no Google Cloud com acesso a SIP (5060/UDP) e STUN (3478/UDP e 3478/TCP) e IPv4 fixo. Para servidor SIP dos tipos _Registrar_ e _Proxy_ foi escolhido o [OpenSiPS](https://opensips.org/), enquanto que o servidor STUN foi o [coturn](https://github.com/coturn/coturn).

Para usar, é preciso criar o arquivo de variáveis do Terraform, no seguinte formato:

```terraform
gcp_sakey = "***"
gce_project = "***"
gce_region = "***"
gce_zone = "***"
gce_ssh_user = "***"
gce_ssh_pub_key = "***"
```

onde:

- `gcp_sakey`: é a [chave de conta de serviço criada na GCP](https://console.cloud.google.com/apis/credentials/serviceaccountkey), em formato JSON.
- `gce_project`: nome do projeto.
- `gce_region`: região onde rodará a máquina virtual.
- `gce_zone`: dependente de `gce_region`, é a zona específica na região.
- `gce_ssh_user`: nome do usuário a ser criado dentro da máquina virtual.
- `gce_ssh_pub_key`: conteúdo do arquivo da chave pública SSH (não o nome do arquivo).

Exemplo de cenário a rodar na zona A de São Paulo:

```ini
gcp_sakey = "gcp.json"
gce_project = "teste-123456"
gce_region = "southamerica-east1"
gce_zone = "southamerica-east1-a"
gce_ssh_user = "boidacarapreta"
gce_ssh_pub_key = "ssh-rsa AAA...xWQ== ederson@boidacarapreta.cc"
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

O retorno será o IPv4 para se conectar via SSH.

Nota importante: A configuração do Terraform, `gcp.tf`, é compatível com [versão 0.12 ou superior](https://www.terraform.io/docs/configuration/).


## Como usar o OpenSIPS

Para controlar o OpenSIPS, uma sugestão é que seja feito via systemd. Primeiro, é preciso ativar o suporte a esse, alterando a seguinte linha no arquivo `/etc/default/opensips` (edição com usuário `root` ou via `sudo`):

```ini
RUN_OPENSIPS=yes
```

Se quiser ativar o serviço por demanda, pode-se deixar o `opensips` desativado por padrão:

```bash
sudo systemctl disable opensips
```

Para ativá-lo por demanda:

```bash
sudo systemctl start opensips
```

E desativá-lo quando terminar os experimentos:

```bash
sudo systemctl stop opensips
```

 Combinado a isso, pode-se também usar a faixa IPv4 do IFSC câmpus São José, `191.36.8.0/21`, na regra de _firewall_ do GCP.

As seguintes linhas foram adicionadas no arquivo `/etc/opensips/opensips.cfg`:

- Suporte a NAT do servidor SIP (onde `<IP externo>` é o valor obtido na saída do `make`/Terraform). Na seção global:

```ini
listen=udp:0.0.0.0:5060
alias="udp:<IP externo>:5060"
advertised_address=<IP externo>
```

## Como usar o coturn

A instalação padrão do coturn já possui suporte nativo ao STUN. Não é necessária qualquer configuração.
