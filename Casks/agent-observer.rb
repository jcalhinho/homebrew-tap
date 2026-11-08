cask "agent-observer" do
  arch arm: "arm64", intel: "x64"

  version "0.15.0"
  sha256 arm:   "f658fd225fca153cdfc66e20c7ed89ae3507684eb34601a8e067dc33cbf6f66b",
         intel: "ae57b3e497ee8ae37cd60baf40660f4d98198190aa673e2549e86807d8907f27"

  url "https://github.com/jcalhinho/agent-observer/releases/download/v#{version}/Agent-Observer_#{version}_macos-#{arch}.dmg"
  name "Agent Observer"
  desc "Local dashboard of what your AI coding agents are doing"
  homepage "https://github.com/jcalhinho/agent-observer"

  depends_on macos: ">= :big_sur"

  app "Agent Observer.app"

  # The app is not signed with an Apple Developer ID yet: without this, Gatekeeper refuses to
  # open it after a Homebrew install.
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
