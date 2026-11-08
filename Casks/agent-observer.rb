cask "agent-observer" do
  arch arm: "arm64", intel: "x64"

  version "0.15.1"
  sha256 arm:   "ee07387670da9f691da5279410c9e3f9a6f9352be210100046c2331a8a40d40c",
         intel: "4b74207bc72d3d21e2fce78047e0262fc0f0d37710eb842752f057d2679e17de"

  url "https://github.com/jcalhinho/agent-observer/releases/download/v#{version}/Agent-Observer_#{version}_macos-#{arch}.dmg"
  name "Agent Observer"
  desc "Local dashboard of what your AI coding agents are doing"
  homepage "https://github.com/jcalhinho/agent-observer"

  depends_on macos: :big_sur

  app "Agent Observer.app"

  # The app is not signed with an Apple Developer ID yet: without this, Gatekeeper refuses to
  # open it after a Homebrew install. postflight_steps replaces the postflight block in recent
  # Homebrew versions; older ones only have postflight.
  installed_app = "#{appdir}/Agent Observer.app"
  if respond_to?(:postflight_steps)
    postflight_steps do
      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", installed_app]
    end
  else
    postflight do
      system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", installed_app]
    end
  end

  zap trash: [
    "~/Library/Application Support/dev.repowatcher.agentobserver",
    "~/Library/Caches/dev.repowatcher.agentobserver",
    "~/Library/WebKit/dev.repowatcher.agentobserver",
  ]
end
