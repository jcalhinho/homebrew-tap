cask "agent-observer" do
  arch arm: "arm64", intel: "x64"

  version "0.14.0"
  sha256 arm:   "5b2b0b62f8456b29e5f09f3495439befba0f0f794fb18a2d4f240c4b6429a3ac",
         intel: "ca9360e2c5756a3a692c3031fbc2f1c5fd06bdd4e17ee0258bf778f7b0dc2d88"

  url "https://github.com/jcalhinho/agent-observer/releases/download/v#{version}/Agent-Observer_#{version}_macos-#{arch}.dmg"
  name "Agent Observer"
  desc "Local dashboard of what your AI coding agents are doing"
  homepage "https://github.com/jcalhinho/agent-observer"

  depends_on macos: ">= :big_sur"

  app "RepoWatcher Agent Observer.app"

  # The app is not signed with an Apple Developer ID yet: without this, Gatekeeper refuses to
  # open it after a Homebrew install.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/RepoWatcher Agent Observer.app"]
  end

  zap trash: [
    "~/Library/Application Support/dev.repowatcher.agentobserver",
    "~/Library/Caches/dev.repowatcher.agentobserver",
    "~/Library/WebKit/dev.repowatcher.agentobserver",
  ]
end
