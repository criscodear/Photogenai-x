#!/bin/bash

# Script de build para Vercel com Rust e wasm-pack
set -e

echo "🚀 Iniciando build do Graphite na Vercel..."

# Instalar Rust se não estiver instalado
if ! command -v rustc &> /dev/null; then
    echo "📦 Instalando Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain 1.88.0
    source $HOME/.cargo/env
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# Instalar wasm-pack se não estiver instalado
if ! command -v wasm-pack &> /dev/null; then
    echo "📦 Instalando wasm-pack..."
    curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# Verificar instalações
echo "✅ Verificando instalações..."
rustc --version
wasm-pack --version

# Navegar para o diretório frontend
cd frontend

# Instalar dependências Node.js
echo "📦 Instalando dependências Node.js..."
npm ci

# Build do WASM
echo "🔨 Construindo WASM..."
npm run wasm:build-production

# Build do frontend
echo "🔨 Construindo frontend..."
npm run build

echo "✅ Build concluído com sucesso!"
