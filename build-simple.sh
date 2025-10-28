#!/bin/bash

# Script de build simplificado para Vercel
set -e

echo "🚀 Iniciando build do Graphite..."

# Instalar Rust
echo "📦 Instalando Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain 1.88.0
source $HOME/.cargo/env

# Instalar wasm-pack
echo "📦 Instalando wasm-pack..."
curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh

# Configurar PATH
export PATH="$HOME/.cargo/bin:$PATH"

# Verificar instalações
rustc --version
wasm-pack --version

# Build
cd frontend
npm ci
npm run build

echo "✅ Build concluído!"
