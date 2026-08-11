# homebrew-octapus-db

Tap Homebrew do [**octapus-db**](https://github.com/LKTeloeken/octapus_db) — um cliente
de banco de dados desktop para PostgreSQL, MongoDB e Redis.

## Instalação

```bash
brew tap LKTeloeken/octapus-db
```

```bash
brew install --cask octapus-db
```

E então, **antes da primeira abertura**, libere o app do Gatekeeper:

```bash
xattr -dr com.apple.quarantine /Applications/octapus-db.app
```

Funciona em Apple Silicon (`aarch64`) e Intel (`x64`) — o Homebrew escolhe o binário
certo automaticamente.

### Por que esse segundo comando

O octapus-db é assinado ad-hoc, **sem certificado da Apple e sem notarização**. Todo
arquivo que o macOS considera "baixado da internet" recebe o atributo
`com.apple.quarantine`, e o Gatekeeper barra apps não notarizados que o carregam, com
o aviso *"A Apple não pôde verificar se o item está livre de malware"*.

O Homebrew **também** aplica esse atributo nas casks que instala — a partir do
Homebrew 6.0 não há mais como pedir que ele não aplique (a antiga flag
`--no-quarantine` foi removida, e não existe variável de ambiente equivalente). Por
isso a remoção é um passo separado, feito por você depois da instalação.

Se preferir não rodar o `xattr`, dá para liberar pela interface na primeira abertura:
o macOS mostra o aviso, e você autoriza em **Ajustes do Sistema → Privacidade e
Segurança → Abrir Mesmo Assim**. O efeito é o mesmo.

A cask **não** remove a quarentena por conta própria (não usa `postflight` para isso):
desligar uma verificação de segurança do sistema é decisão de quem instala, não de
quem empacota. Por isso o passo é explícito.

> Quando o app tiver certificado pago e notarização, esse passo deixa de ser
> necessário e esta seção sai do README.

### Se aparecer "untrusted tap"

A partir do Homebrew 6.0, taps de terceiros exigem confiança explícita. Se você vir
`Refusing to load cask ... from untrusted tap`, autorize com:

```bash
brew trust --cask LKTeloeken/octapus-db/octapus-db
```

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
brew uninstall --cask --zap octapus-db
```

O `--zap` manda para o lixo:

- `~/Library/Application Support/com.octapus-db.app` (inclui `app.db` e `vault.key`)
- `~/Library/Caches/com.octapus-db.app`
- `~/Library/WebKit/com.octapus-db.app`

## Manutenção

A cask é atualizada automaticamente pelo workflow
[`bump-cask.yml`](.github/workflows/bump-cask.yml), que a cada 6 horas consulta a
última release de `LKTeloeken/octapus_db`, recalcula os `sha256` dos DMGs e commita a
nova versão. Também dá para rodar sob demanda via `workflow_dispatch`.

O `livecheck` da cask usa um regex explícito, porque o padrão do `github_latest` não
entende o formato de tag daqui (`app-v0.1.0-beta.5`): ele ignoraria o prefixo `app-` e
cortaria o sufixo `-beta.N`, reportando `0.1.0`.
