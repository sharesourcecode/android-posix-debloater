#!/bin/sh

# --- Configurações de Caminho ---
# Caminho absoluto para a lista de pacotes no armazenamento interno
LISTA="/storage/emulated/0/Download/apps_removidos.txt"

# --- Validação Inicial ---
# Verifica se o arquivo de lista existe antes de tentar ler
if [ ! -f "$LISTA" ]; then
    printf "Erro: Lista não encontrada em %s\n" "$LISTA"
    exit 1
fi

case "$1" in
    "on")
        printf "Iniciando restauração de pacotes...\n"
        count=0
        # Loop para processar cada pacote da lista
        for pkg in $(cat "$LISTA"); do
            # Verifica se a linha não está vazia
            if [ -n "$pkg" ]; then
                # pm install-existing reativa o app que foi removido via --user 0
                if pm install-existing --user 0 "$pkg" > /dev/null 2>&1; then
                    printf "[OK] Restaurado: %s\n" "$pkg"
                else
                    printf "[FALHA] Não foi possível restaurar: %s\n" "$pkg"
                fi
                count=$((count + 1))
            fi
        done
        
        # Resumo final da operação
        printf "\n--- EXECUÇÃO FINALIZADA ---\n"
        printf "Total de pacotes processados: %d\n" "$count"
        ;;

    "off")
        printf "Iniciando remoção e limpeza de pacotes...\n"
        count=0
        for pkg in $(cat "$LISTA"); do
            if [ -n "$pkg" ]; then
                # 1. Limpa o cache e dados do app (libera espaço em /data)
                pm clear "$pkg" > /dev/null 2>&1
            
                # 2. Desinstala o app para o usuário 0 (padrão Canta/ADB)
                if pm uninstall --user 0 "$pkg" > /dev/null 2>&1; then
                    printf "[OK] Removido: %s\n" "$pkg"
                else
                    # Exibe o aviso de retenção sem códigos de cores para evitar sujeira no log
                    printf "[!] Retido: %s (App crítico ou já removido)\n" "$pkg"
                fi
                count=$((count + 1))
            fi
        done
        
        # Resumo final da operação
        printf "\n--- EXECUÇÃO FINALIZADA ---\n"
        printf "Total de pacotes processados: %d\n" "$count"
        ;;

    *)
        # Exibe instrução de uso caso o argumento seja inválido ou ausente
        printf "Uso: sh %s {on|off}\n" "$0"
        exit 1
        ;;
esac
