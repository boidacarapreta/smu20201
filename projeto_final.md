# Projeto Final

O relatório do projeto final da disciplina é, em essência, a análise de um experimento realizado com duas mídias: áudio e vídeo. Uma sugestão é a demonstração simples de áudio e vídeo oferecida pelo Open-EasyRTC. No meu servidor, a URL é esta: [https://webrtc.smu20201.boidacarapreta.cc/demos/demo_audio_video_simple.html](https://webrtc.smu20201.boidacarapreta.cc/demos/demo_audio_video_simple.html).

Assim, todos os itens deste relatório se referem a um único experimento realizado, de forma a relacionar os protocolos e seus valores.

## Estrutura Mínima

O relatório do projeto final deve contemplar os 4 componentes básicos e, como bônus, os 2 adicionais:

1. [Sinalização](#sinalização);
2. [Negociação de mídia](#negociação-de-mídia);
3. [Escolha de caminho](#escolha-de-caminho);
4. [Transporte de Mídia](#transporte-de-mídia);
5. (Opcional) [Qualidade de serviço](#qualidade-de-serviço);
6. (Opcional) [Segurança](#segurança).

## Sinalização

Definir o fluxo de mensagens entre as entidades em rede contendo:

- **Transação de estabelecimento de sessão de mídia(s)**:
  - **Mensagens**: formato completo de cada mensagem, seja essa requisição ou resposta.
    - **Requisições**: nomes das requisições.
    - **Respostas**: nomes/números e formatos das respostas.
    - **Transação**: conjunto de atributos e valores a discriminar esta transação entre duas entidades em rede, com destaque a informações de controle (identificador, número de sequência etc.).
- **Transação de encerramento de sessão de mídia(s)**:
  - **Mensagens**: formato completo de cada mensagem, seja essa requisição ou resposta.
    - **Requisições**: nomes das requisições.
    - **Respostas**: nomes/números e formatos das respostas.
    - **Transação**: conjunto de atributos e valores a discriminar esta transação entre duas entidades em rede, com destaque a informações de controle (identificador, número de sequência etc.).
- **Diálogo**: conjunto de atributos e valores a discriminar este diálogo duas entidades em rede, com destaque a informações de controle do diálogo (identificador etc.).
Para cada componente acima, apresentar um exemplo prático do cenário analisado.

## Negociação de mídia

Para cada entidade em rede, especificar a oferta de mídia(s):

- **Tipos de mídia**: tipos (áudio, vídeo etc.), sentido (unidirecional ou bidirecional) de cada uma delas.
- **Codecs ofertados**: lista de codecs negociada, suas variantes (taxa de quadros por segundo, resolução, quantidade de canais etc).

Uma vez estabelecida a sessão de mídia(s), informar em cada sentido que codec, e suas variantes, foi selecionado.

## Escolha de caminho

Para cada entidade em rede, especificar a oferta de escolha de caminho(s):

- **Protocolos usados**: quais os protocolos usados para escolher o caminho da(s) mídia(s), endereços de rede e de transporte (porta), tipo (local, reflexivo etc.).

Uma vez estabelecida a sessão de mídia(s), informar em cada sentido que caminho foi selecionado.

## Transporte de Mídia

Uma vez estabelecida a sessão de mídia(s), informar em cada sentido:

- **Protocolos usados**: quais os protocolos usados para transportar a mídia.
- **Indicadores de controle e monitoramento de entrega de cada mídia** ao final da transmissão:
  - Latência;
  - Jitter;
  - Porcentagem de descarte de mensagem (*payload* da camada de Aplicação).

## Qualidade de serviço

- **Protocolos usados**: quais os protocolos usados para prover qualidade de serviço, bem como sua camada de atuação na arquitetura TCP/IP.

## Segurança

Para cada item anterior deste relatório (de [Sinalização](#sinalização) até [Qualidade de serviço](#qualidade-de-serviço)), informar:

- **Protocolos usados**: quais os protocolos usados para prover segurança no tráfego de dados, bem como sua camada de atuação na arquitetura TCP/IP.

## Referências

- [High Performance Browser Networking](https://hpbn.co)
- [Awesome WebRTC](https://github.com/openrtc-io/awesome-webrtc)
