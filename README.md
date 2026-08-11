# homebrew-octapus-db

Tap Homebrew do [**octapus-db**](https://github.com/LKTeloeken/octapus_db) — um cliente
de banco de dados desktop para PostgreSQL, MongoDB e Redis.

## Instalação

```bash
brew tap LKTeloeken/octapus-db
brew install --cask octapus-db
```

Ou em um comando só:

```bash
brew install --cask LKTeloeken/octapus-db/octapus-db
```

Funciona em Apple Silicon (`aarch64`) e Intel (`x64`) — o Homebrew escolhe o binário
certo automaticamente.

## Por que instalar pelo Homebrew

O octapus-db é assinado ad-hoc, sem certificado da Apple e sem notarização. Quem baixa
o `.dmg` pelo navegador esbarra no aviso do Gatekeeper ("A Apple não pôde verificar se
o item está livre de malware") e precisa liberar o app manualmente em **Ajustes do
Sistema → Privacidade e Segurança → Abrir Mesmo Assim**.

O `brew install --cask` remove o atributo de quarentena durante a instalação, então por
este canal **o app abre direto, sem aviso nenhum**. É por isso que o Homebrew é o
caminho recomendado no macOS enquanto não houver certificado pago.

## Atualizações

O app tem **auto-update embutido** (plugin updater do Tauri): ele mesmo busca e instala
novas versões. Você **não** precisa rodar `brew upgrade` para receber atualizações.

Por conta disso a cask declara `auto_updates true`, e é normal que a versão instalada
fique à frente da versão registrada aqui — o Homebrew não vai tratar isso como
instalação desatualizada.

## Desinstalação

```bash
brew uninstall --cask octapus-db
```

Para remover também os dados locais (banco de conexões, cache e chave do cofre):

```bash
brew zap --cask octapus-db
```

O `zap` apaga:

- `~/Library/Application Support/com.octapus-db.app` (inclui `app.db` e `vault.key`)
- `~/Library/Caches/com.octapus-db.app`
- `~/Library/WebKit/com.octapus-db.app`

## Manutenção

A cask é atualizada automaticamente pelo workflow
[`bump-cask.yml`](.github/workflows/bump-cask.yml), que a cada 6 horas consulta a
última release de `LKTeloeken/octapus_db`, recalcula os `sha256` dos DMGs e commita a
nova versão. Também dá para rodar sob demanda via `workflow_dispatch`.
