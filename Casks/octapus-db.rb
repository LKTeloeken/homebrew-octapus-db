cask "octapus-db" do
  arch arm: "aarch64", intel: "x64"

  version "0.1.0-beta.12"
  sha256 arm:   "b38816a8bf708f09942dac71a3b140659a32f8640c4475441071b7dd1e7d8fb7",
         intel: "419261970c43318c71c2bafdee207084e9cd126a65874ed28882a8cc1cae69ab"

  url "https://github.com/LKTeloeken/octapus_db/releases/download/app-v#{version}/octapus-db_#{version}_#{arch}.dmg"
  name "octapus-db"
  desc "Cliente de banco de dados desktop para PostgreSQL, MongoDB e Redis"
  homepage "https://github.com/LKTeloeken/octapus_db"

  # O app se atualiza sozinho pelo updater do Tauri. Sem isto, o Homebrew
  # tentaria reinstalar por cima e brigaria com o auto-update.
  auto_updates true

  # O regex padrão do github_latest (/v?(\d+(?:\.\d+)+)/i) não dá conta do
  # formato de tag daqui: ignora o prefixo "app-" e corta o sufixo "-beta.N",
  # reportando 0.1.0 em vez de 0.1.0-beta.5. Daí o regex explícito.
  livecheck do
    url :url
    regex(/^app[._-]v?(\d+(?:\.\d+)+(?:-[a-z]+(?:\.\d+)?)?)$/i)
    strategy :github_latest
  end

  # Nota: o app é assinado ad-hoc, sem notarização, então o Gatekeeper o barra
  # enquanto ele carregar o atributo com.apple.quarantine — que o Homebrew aplica
  # por padrão. A remoção NÃO é feita aqui de propósito: um `postflight` com
  # `xattr -dr` desligaria uma verificação de segurança do sistema sem o usuário
  # pedir. Quem instala roda o `xattr` conscientemente (ver README). A flag
  # `--no-quarantine` do brew não é alternativa: foi removida no Homebrew 6.0.
  app "octapus-db.app"

  zap trash: [
    "~/Library/Application Support/com.octapus-db.app",
    "~/Library/Caches/com.octapus-db.app",
    "~/Library/WebKit/com.octapus-db.app",
  ]
end
