import Config

config :git_ops,
  mix_project: ScrollexEcto.MixProject,
  changelog_file: "CHANGELOG.md",
  repository_url: "https://github.com/yatender-oktalk/scrollex_ecto",
  types: [
    # These types are copied from https://keepachangelog.com/en/1.0.0/
    major: [:breaking],
    minor: [:add, :remove, :change, :deprecate],
    patch: [:fix, :security, :performance, :improvement, :docs, :test]
  ],
  manage_mix_version?: true,
  manage_readme_version: ["README.md"],
  version_tag_prefix: "v"

import_config "#{Mix.env()}.exs"
