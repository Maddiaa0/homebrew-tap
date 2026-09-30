# homebrew-tap

Personal Homebrew tap for Maddiaa0's tools.

## Install

```sh
brew tap maddiaa0/tap
brew install <formula>
```

Or in one step: `brew install maddiaa0/tap/<formula>`.

## Layout

- `Formula/` holds formulae (`Formula/<name>.rb`), usually for CLI tools built from source or release binaries.
- `Casks/` holds casks (`Casks/<name>.rb`) for macOS apps.

## Adding a formula

```sh
brew create --tap maddiaa0/tap <release-tarball-url>
brew audit --strict --new maddiaa0/tap/<name>
brew install --build-from-source maddiaa0/tap/<name>
brew test maddiaa0/tap/<name>
```
