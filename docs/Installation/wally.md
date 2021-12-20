---
title: "Wally Installation"
sidebar_position: 2
---

# Wally Installation

To install Portal through Wally you must first [install & setup Wally](https://wally.run/install). Once you have installed Wally, you will need to create a new file in the root of your project (top-level) called `wally.toml`, then add the `shanebutt/portal@ver` to your `[dependencies]`. It should look something like this:

```toml title="wally.toml" {2}
[dependencies]
Portal = "shanebutt/portal@0.2.0-beta"
```

Once you have done this, you can run:
`wally install`

This will finally add Portal as a dependency located in the `Packages` folder created in the root of your directory.