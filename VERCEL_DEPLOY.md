# Deploy do Graphite na Vercel

## Problema Identificado

O erro `wasm-pack: command not found` ocorre porque a Vercel não tem o Rust e o `wasm-pack` instalados por padrão no ambiente de build. O projeto Graphite é um editor gráfico complexo que usa Rust com WebAssembly.

## Solução Implementada

### Arquivos Criados

1. **`vercel.json`** - Configuração principal da Vercel
2. **`build.sh`** - Script de build completo
3. **`build-simple.sh`** - Script de build simplificado (alternativa)
4. **`.vercelignore`** - Arquivos a serem ignorados no deploy

### Como Funciona

O script de build:
1. Instala o Rust (versão 1.88.0)
2. Instala o wasm-pack
3. Configura as variáveis de ambiente
4. Executa o build do WASM
5. Executa o build do frontend

### Configurações da Vercel

- **Build Command**: `chmod +x build.sh && ./build.sh`
- **Output Directory**: `frontend/dist`
- **Framework**: None (customizado)
- **Runtime**: Node.js 18.x

## Instruções para Deploy

### Opção 1: Usar os arquivos criados

1. Faça commit dos arquivos criados:
   ```bash
   git add vercel.json build.sh .vercelignore
   git commit -m "Add Vercel configuration for Rust/WASM build"
   git push
   ```

2. Conecte o repositório na Vercel
3. A Vercel detectará automaticamente o `vercel.json`

### Opção 2: Configuração manual na Vercel

Se preferir configurar manualmente:

1. **Build Command**: `chmod +x build.sh && ./build.sh`
2. **Output Directory**: `frontend/dist`
3. **Install Command**: Deixe vazio ou `echo 'Dependencies installed by build script'`
4. **Framework**: None

### Opção 3: Script simplificado

Se o script completo der problemas, use o `build-simple.sh`:

1. Renomeie `build-simple.sh` para `build.sh`
2. Atualize o `vercel.json` se necessário

## Variáveis de Ambiente

As seguintes variáveis são configuradas automaticamente:
- `RUST_VERSION`: 1.88.0
- `CARGO_HOME`: /tmp/cargo
- `RUSTUP_HOME`: /tmp/rustup

## Troubleshooting

### Se o build ainda falhar:

1. **Verifique os logs** na Vercel para erros específicos
2. **Teste localmente** executando `./build.sh` no seu ambiente
3. **Verifique as permissões** do script (deve ser executável)
4. **Considere usar GitHub Actions** como alternativa

### Alternativa: GitHub Actions + Vercel

Se a Vercel continuar com problemas, considere usar GitHub Actions para o build e depois fazer deploy do resultado na Vercel:

1. Crie `.github/workflows/build.yml`
2. Configure o build com Rust/wasm-pack
3. Faça upload dos artefatos
4. Configure a Vercel para usar os artefatos pré-construídos

## Estrutura do Projeto

```
├── vercel.json          # Configuração da Vercel
├── build.sh             # Script de build principal
├── build-simple.sh      # Script de build alternativo
├── .vercelignore        # Arquivos ignorados
├── frontend/            # Frontend do projeto
│   ├── package.json     # Dependências Node.js
│   ├── wasm/           # Código Rust/WASM
│   └── dist/           # Build output (gerado)
└── ...                 # Outros arquivos do projeto
```

## Notas Importantes

- O build pode demorar alguns minutos devido à instalação do Rust
- Certifique-se de que o projeto tem todas as dependências necessárias
- O diretório `frontend/dist` será criado automaticamente
- Verifique se o `package.json` do frontend tem os scripts corretos
