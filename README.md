# android-posix-debloater 📱

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![POSIX Compliant](https://img.shields.io/badge/Shell-POSIX--compliant-brightgreen.svg)](https://en.wikipedia.org/wiki/POSIX)

Script minimalista e robusto para gerenciamento de pacotes (debloat) no Android. Desenvolvido com foco em **Zero-Bashisms**, garantindo compatibilidade total com Android 16, ambientes Toybox, Busybox e shells restritos.

---

## 🚀 Funcionalidades

* **Remoção Inteligente (`off`):** Limpa os dados do aplicativo (`pm clear`) antes da desinstalação para o usuário 0, garantindo a liberação real de espaço.
* **Restauração Simples (`on`):** Reinstala rapidamente qualquer app removido da lista.
* **Totalmente POSIX:** Sem sintaxes exclusivas de Bash/Zsh. Roda no `sh` puro.
* **Segurança:** Não requer Root. Atua apenas no escopo do usuário atual.

---

## 📦 Pré-requisitos

1.  **Lista de Pacotes:** Crie um arquivo chamado `apps_removidos.txt` na pasta `Download` do seu Android.
2.  **Acesso Shell:**
    * **aShell You** (via ADB Wireless)
    * **Termux** (via Shizuku/rish)

---

## 🛠️ Como Usar

### Usando no [aShell You][1] (ADB)
Como o armazenamento interno é montado com restrição de execução, chame o interpretador explicitamente:

```sh
# Para remover os apps da lista
sh /storage/emulated/0/Download/android-posix-debloater.sh off

# Para restaurar os apps da lista
sh /storage/emulated/0/Download/android-posix-debloater.sh on
```

### Usando no Termux (via rish)

Utilize o `cat` para injetar o script no ambiente do Shizuku:

```sh
# Para remover os apps da lista
cat ~/storage/downloads/android-posix-debloater.sh | rish -c "sh -s -- off"

# Para restaurar os apps da lista
cat ~/storage/downloads/android-posix-debloater.sh | rish -c "sh -s -- on"
```

### ⚠️ Disclaimer (Aviso Legal)

  **Aviso:** Este script é uma ferramenta poderosa. Remover pacotes críticos do sistema (como SystemUI ou Frameworks da Samsung) pode causar loops de inicialização (bootloops). Use com cautela e sempre mantenha um backup dos seus dados. O uso deste script é de sua inteira responsabilidade.

[1]: https://f-droid.org/pt_BR/packages/in.hridayan.ashell/
