cask "octapus-db" do
  arch arm: "aarch64", intel: "x64"

  version "0.2.0-beta.1.0.2"
  sha256 arm:   "601e8dabaa3e381dfb1775b04efd9998bb6d18b3db1cd77e8139cd1f88748f62",
         intel: "1a0bacf54e2c886aa259a2cd25bddc34ff911db530db3390692bd5a6e86e5de8"

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
