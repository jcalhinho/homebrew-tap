cask "agent-observer" do
  arch arm: "arm64", intel: "x64"

  version "0.17.0"
  sha256 arm:   "0f345829da10d5512b7215f3f279dc62c5e6618c7ee1ecae94fe1b87266293a2",
         intel: "84a86c05dbebdb71c228ffe8b80d5ebfa954c84cd6a9b0a1ba5eaed5c7309dc6"

  url "https://github.com/jcalhinho/agent-observer/releases/download/v#{version}/Agent-Observer_#{version}_macos-#{arch}.dmg"
  name "Agent Observer"
  desc "Local dashboard of what your AI coding agents are doing"
  homepage "https://github.com/jcalhinho/agent-observer"

  # A bare symbol means "this version or later" only in Homebrew versions that also have
  # postflight_steps; older ones may read it as "exactly", so they get the former spelling.
  depends_on macos: respond_to?(:postflight_steps) ? :big_sur : ">= :big_sur"

  app "Agent Observer.app"

  # The app is not signed with an Apple Developer ID yet: without this, Gatekeeper refuses to
  # open it after a Homebrew install. The classic postflight block is kept on purpose: recent
  # Homebrew versions warn that it is deprecated but still run it, while postflight_steps runs
  # its commands in a sandbox that needs every written path declared.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Agent Observer.app"]
  end

  zap trash: [
    "~/Library/Application Support/dev.repowatcher.agentobserver",
    "~/Library/Caches/dev.repowatcher.agentobserver",
    "~/Library/WebKit/dev.repowatcher.agentobserver",
  ]
end
