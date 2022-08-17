Script para automação da instalação do utilitário de linha de comando arduino-cli

O que este script faz:

- Cria o diretorio $HOME/bin e o insere no $PATH
- Instala o arduino-cli neste diretório
- Inicializa o arquivo de configurações
- Adiciona 3 plataformas em 'Boards Manager'
    * https://downloads.arduino.cc/packages/package_staging_index.json
    * https://dl.espressif.com/dl/package_esp32_index.json
    * https://arduino.esp8266.com/stable/package_esp8266com_index.json
- Atualiza a lista de placas e instala
    * arduino:avr
    * esp32:esp32
    * esp8266:esp8266

