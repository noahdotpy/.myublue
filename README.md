# noahdotpy/myfedora

> **Warning**: This repository is solely intended for only my purpose and may bring breaking changes without warning.

This is a constantly updating repository which hosts my personalised Fedora Atomic images - [built with container technology](https://containers.github.io/bootable/).
GitHub will build this image, and then host it on [ghcr.io](https://github.com/features/packages).
The users can then tell the computer to boot off of that image.
GitHub keeps 90 days worth of image backups for us, thanks Microsoft!

For info on how to create your own, check out the [BlueBuild website](https://blue-build.org).

## Table of contents

- [noahdotpy/myfedora](#noahdotpymyfedora)
  - [Table of contents](#table-of-contents)
  - [Images](#images)
    - [Tags](#tags)
  - [Installation](#installation)
    - [ISO (recommended)](#iso-recommended)
    - [Switching from a Fedora Atomic image](#switching-from-a-fedora-atomic-image)

## Images

The images are built weekly (or daily with `-git-daily` tag), or on other conditions specified by the tag (an example being: on git pushes). The builds are scheduled to be built at 4:30AM every Sunday for the weekly tags, or everyday for the daily tags (timezone is UTC).

| Desktop Environment | Base Image           | Image Name |
| ------------------- | -------------------- | ---------- |
| KDE Plasma          | Kinoite by Fedora    | Plasma    |
| GNOME               | Silverblue by Fedora | Gnome |
| Hyprland            | Hyprland by Wayblue  | Hyprland   |

### Tags

| Example tag         | Build on git pushes? | Build Frequency | Uses rechunk? (see below at *) |
| ------------------- | -------------------- | --------------- | ------------------------------ |
| `41`                | ❌                    | Weekly          | ✔️                             |
| `41-git`            | ✔️                   | Weekly          | ✔️                             |
| `41-git-daily`      | ✔️                   | Daily           | ❌                              |

Tags always start with the Fedora version you want to use (eg: `41` for Fedora 41). You then add the tag suffix provided from the above table (eg: `41-git`), or leave it with just the version to only get builds every week (eg: `41`).

\* If rechunk is used to build the image then the resulting image upgrade size for the user will be substantially smaller, but the build time will be massively increased.

## Installation

The image reference format for any image in this repo is `ghcr.io/noahdotpy/myfedora/{image}:{tag}`.

For example, if you want Gnome Fedora 41 and image builds weekly or on git pushes then you would want the following tag:
`ghcr.io/noahdotpy/myfedora/gnome:41-git`.

### ISO (recommended)

This repository includes a justfile recipe to build ISOs locally from the GHCR registry.

Below is an example of building an ISO for gnome:41-git

```bash
just build-iso-ghcr gnome:41-git
```

### Switching from a Fedora Atomic image

Below is an example of switching to gnome:41-git

1. `bootc switch ghcr.io/noahdotpy/myfedora/gnome:41-git`

2. Reboot computer
